Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0197C65BB9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28021473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C28021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeJFArr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:47:47 -0400
Received: from www62.your-server.de ([213.133.104.62]:57006 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFArr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:47:47 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1g8UCk-00033a-TT; Fri, 05 Oct 2018 19:47:58 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g8UCk-000X0M-OY; Fri, 05 Oct 2018 19:47:58 +0200
Subject: Re: [PATCH] bpf: 32-bit RSH verification must truncate input before
 the ALU op
To:     Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
        netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20181005161759.177992-1-jannh@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a4523e67-ba1a-32ed-f5ac-fd8f9b712693@iogearbox.net>
Date:   Fri, 5 Oct 2018 19:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181005161759.177992-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/25009/Fri Oct  5 14:48:12 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2018 06:17 PM, Jann Horn wrote:
> When I wrote commit 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification"), I
> assumed that, in order to emulate 64-bit arithmetic with 32-bit logic, it
> is sufficient to just truncate the output to 32 bits; and so I just moved
> the register size coercion that used to be at the start of the function to
> the end of the function.
> 
> That assumption is true for almost every op, but not for 32-bit right
> shifts, because those can propagate information towards the least
> significant bit. Fix it by always truncating inputs for 32-bit ops to 32
> bits.
> 
> Also get rid of the coerce_reg_to_size() after the ALU op, since that has
> no effect.
> 
> Fixes: 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification")
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Jann Horn <jannh@google.com>

Applied to bpf, thanks Jann!
