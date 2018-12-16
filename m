Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7624DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422F1217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbeLPHce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 02:32:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35898 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeLPHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 02:32:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E204714E908D5;
        Sat, 15 Dec 2018 23:32:32 -0800 (PST)
Date:   Sat, 15 Dec 2018 23:28:59 -0800 (PST)
Message-Id: <20181215.232859.365899686560746192.davem@davemloft.net>
To:     semen.protsenko@linaro.org
Cc:     jchapman@katalix.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, g.nault@alphalink.fr
Subject: Re: [PATCH] l2tp: Add protocol field decompression
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181214175921.6859-1-semen.protsenko@linaro.org>
References: <20181214175921.6859-1-semen.protsenko@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 23:32:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 14 Dec 2018 19:59:21 +0200

> When Protocol Field Compression (PFC) is enabled, the "Protocol" field
> in PPP packet will be received without leading 0x00. See section 6.5 in
> RFC 1661 for details. So let's decompress protocol field if needed, the
> same way it's done in drivers/net/ppp/pptp.c.
> 
> In case when "nopcomp" pppd option is not enabled, PFC (pcomp) can be
> negotiated during LCP handshake, and L2TP driver in kernel will receive
> PPP packets with compressed Protocol field, which in turn leads to next
> error:
> 
>     Protocol Rejected (unsupported protocol 0x2145)
> 
> because instead of Protocol=0x0021 in PPP packet there will be
> Protocol=0x21. This patch unwraps it back to 0x0021, which fixes the
> issue.
> 
> Sending the compressed Protocol field will be implemented in subsequent
> patch, this one is self-sufficient.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Applied, thanks.
