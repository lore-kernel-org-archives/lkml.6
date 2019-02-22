Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A87C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE225206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfBVUpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:45:40 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55677 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:45:40 -0500
X-Originating-IP: 86.201.231.99
Received: from bootlin.com (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr [86.201.231.99])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C1B2B1BF208;
        Fri, 22 Feb 2019 20:45:33 +0000 (UTC)
Date:   Fri, 22 Feb 2019 21:45:32 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/7] net: phy: marvell10g: Use get_features to
 get the PHY abilities
Message-ID: <20190222214532.2a2cc880@bootlin.com>
In-Reply-To: <a69da540-fe5c-e9a7-d848-2f2c61011f21@gmail.com>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
        <20190221095128.28188-2-maxime.chevallier@bootlin.com>
        <a69da540-fe5c-e9a7-d848-2f2c61011f21@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 19:42:29 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

>After my just submitted patch to include the aneg capability checking in
>genphy_c45_pma_read_abilities() function mv3310_get_features() isn't
>needed any longer and can be replaced with the generic one.

I'll still need it to handle the 2.5G/5G abilities that aren't
correctly reported on 3310. I'll be able to use the generic
function for the 2110 though, which is nice.

>But we can make this change afterwards, then you don't have to
>rework your series.
>
>Also I'm not sure whether there will be a 5.0-rc8 or whether beginning
>of next week we'll see 5.0. In the latter case we're a little bit in a
>hurry because the merge window will start very soon.

OK, I'll re-spin the series quickly with the small cleanup needed if
everything's OK to you regarding the rest of it.

Thanks,

Maxime
