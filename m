Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8709420652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfBWV2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:28:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42626 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfBWV2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:28:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D5A6414BEE20F;
        Sat, 23 Feb 2019 13:28:34 -0800 (PST)
Date:   Sat, 23 Feb 2019 13:28:34 -0800 (PST)
Message-Id: <20190223.132834.658153280215105502.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net] net: phy: marvell10g: Fix Multi-G advertisement to
 only advertise 10G
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190221165411.9739-1-maxime.chevallier@bootlin.com>
References: <20190221165411.9739-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Feb 2019 13:28:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Thu, 21 Feb 2019 17:54:11 +0100

> Some Marvell Alaska PHYs support 2.5G, 5G and 10G BaseT links. Their
> default behaviour is to advertise all of these modes, but at the moment,
> only 10GBaseT is supported. To prevent link partners from establishing
> link at that speed, clear these modes upon configuring aneg parameters.
> 
> Fixes: 20b2af32ff3f ("net: phy: add Marvell Alaska X 88X3310 10Gigabit PHY support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reported-by: Russell King <linux@armlinux.org.uk>
> ---
> 
> Dave,
> 
> This patch will conflict when merging net into net-next, and is actually
> not needed there. In net-next, this issue is fixed by the recent work
> done by Andrew and Heiner, that introduce more generic ways to handle aneg
> configuration for C45 PHYs.
> 
> The commit fixing this would be :
> 3de97f3c6308 ("net: phy: marvell10g: use genphy_c45_an_config_aneg")
> 
> However this fix should be backported, hence why it was implemented in a
> small standalone patch here.
> 
> Please tell me if you have any issue with this.

Understood, this is fine.

Applied and queued up for -stable.

Thanks.
