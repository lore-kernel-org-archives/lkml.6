Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AF3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8300220833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8300220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeGYSLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:11:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:38379 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbeGYSLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:11:23 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiN7Y-0006JL-NZ; Wed, 25 Jul 2018 18:58:40 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiN7Y-0009hd-D0; Wed, 25 Jul 2018 18:58:40 +0200
Subject: Re: [PATCH] bpf, x32: Fix regression caused by commit 24dea04767e6
To:     Wang YanQing <udknight@gmail.com>, ast@kernel.org,
        davem@davemloft.net, illusionist.neo@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, mroos@linux.ee
References: <20180725164611.GA12441@udknight>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <177600c2-92cf-b352-2e48-52dcb3f12283@iogearbox.net>
Date:   Wed, 25 Jul 2018 18:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180725164611.GA12441@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24781/Wed Jul 25 10:48:26 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 06:46 PM, Wang YanQing wrote:
> Commit 24dea04767e6 ("bpf, x32: remove ld_abs/ld_ind")
> removed the 4 /* Extra space for skb_copy_bits buffer */
> from _STACK_SIZE, but it didn't fix the concerned code
> in emit_prologue and emit_epilogue, and this error will
> bring very strange kernel runtime errors.
> 
> This patch fix it.
> 
> Fixes: 24dea04767e6 ("bpf, x32: remove ld_abs/ld_ind")
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Applied, thanks Wang!
