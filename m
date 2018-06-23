Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5055C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E9E24B7F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E9E24B7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeFWJYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 05:24:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:40754 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeFWJYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 05:24:31 -0400
Received: from [109.168.64.67] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fWemO-0005We-6i; Sat, 23 Jun 2018 11:24:24 +0200
Subject: Re: arm64 regression bisected to "bpf: reject any prog that failed
 read-only lock"
To:     dann frazier <dannf@dannf.org>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180622230943.GA27737@xps13.dannf>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7a9317b3-b602-1faa-1734-59ea14e301be@iogearbox.net>
Date:   Sat, 23 Jun 2018 11:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180622230943.GA27737@xps13.dannf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24688/Sat Jun 23 06:41:54 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/2018 01:09 AM, dann frazier wrote:
> fyi, I'm seeing a regression that I've bisected down to:
>   9facc336876f bpf: reject any prog that failed read-only lock
> 
> A snippet of the boot messages are below. I'll be out of pocket until
> Monday, so apologies in advance for delays in responding to follow-ups.

Sorry about that, fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=9262478220eac908ae6e168c3df2c453c87e2da3
