Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70009C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E102175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBGBQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 20:16:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39008 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBGBQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 20:16:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 963031404973D;
        Wed,  6 Feb 2019 17:16:58 -0800 (PST)
Date:   Wed, 06 Feb 2019 17:16:57 -0800 (PST)
Message-Id: <20190206.171657.1823157800327376584.davem@davemloft.net>
To:     miquel.raynal@bootlin.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Prevent suspend to RAM
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190205110728.11451-1-miquel.raynal@bootlin.com>
References: <20190205110728.11451-1-miquel.raynal@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Feb 2019 17:16:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue,  5 Feb 2019 12:07:28 +0100

> On one hand, the mv88e6xxx driver has a work queue called in loop
> which will attempt register accesses after MDIO bus suspension, that
> entirely freezes the platform during suspend.
> 
> On the other hand, the DSA core is not ready yet to support suspend to
> RAM operation because so far there is no way to recover reliably the
> switch configuration.
> 
> To avoid the kernel to freeze when suspending with a switch driven by
> the mv88e6xxx driver, we choose to prevent the driver suspension and
> in the same way, the whole platform.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to net-next, thanks.
