Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1AFC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F3920874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F3920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbeKXRW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 12:22:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbeKXRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 12:22:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9ADAD14E89267;
        Fri, 23 Nov 2018 22:35:10 -0800 (PST)
Date:   Fri, 23 Nov 2018 22:35:10 -0800 (PST)
Message-Id: <20181123.223510.1953898467509008988.davem@davemloft.net>
To:     quentin.schulz@bootlin.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH net v3] net: phy: mscc: fix deadlock in
 vsc85xx_default_config
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181123180151.14183-1-quentin.schulz@bootlin.com>
References: <20181123180151.14183-1-quentin.schulz@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 22:35:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>
Date: Fri, 23 Nov 2018 19:01:51 +0100

> The vsc85xx_default_config function called in the vsc85xx_config_init
> function which is used by VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
> mistakenly calls phy_read and phy_write in-between phy_select_page and
> phy_restore_page.
> 
> phy_select_page and phy_restore_page actually take and release the MDIO
> bus lock and phy_write and phy_read take and release the lock to write
> or read to a PHY register.
> 
> Let's fix this deadlock by using phy_modify_paged which handles
> correctly a read followed by a write in a non-standard page.
> 
> Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_page functions")
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Applied.
