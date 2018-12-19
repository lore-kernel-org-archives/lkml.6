Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C203CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B190218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeLSFtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:49:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49420 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSFtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:49:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D39614B9B6E8;
        Tue, 18 Dec 2018 21:49:05 -0800 (PST)
Date:   Tue, 18 Dec 2018 21:49:04 -0800 (PST)
Message-Id: <20181218.214904.2030959667534757581.davem@davemloft.net>
To:     hayashi.kunihiko@socionext.com
Cc:     hkallweit1@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Fix the issue that netif always links up
 after resuming
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1545119824-30380-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1545119824-30380-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 21:49:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 18 Dec 2018 16:57:04 +0900

> Even though the link is down before entering hibernation,
> there is an issue that the network interface always links up after resuming
> from hibernation.
> 
> If the link is still down before enabling the network interface,
> and after resuming from hibernation, the phydev->state is forcibly set
> to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
> 
> In suspend sequence, only if the PHY is attached, mdio_bus_phy_suspend()
> calls phy_stop_machine(), and mdio_bus_phy_resume() calls
> phy_start_machine().
> In resume sequence, it's enough to do the same as mdio_bus_phy_resume()
> because the state has been preserved.
> 
> This patch fixes the issue by calling phy_start_machine() in
> mdio_bus_phy_restore() in the same way as mdio_bus_phy_resume().
> 
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied and queued up for -stable.
