Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A87DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B812133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbeLQPtK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:49:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59712 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387609AbeLQPtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:49:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D151D20733; Mon, 17 Dec 2018 16:49:07 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6E48A20726;
        Mon, 17 Dec 2018 16:48:57 +0100 (CET)
Date:   Mon, 17 Dec 2018 16:48:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Evan Wang <xswang@marvell.com>
Subject: Re: [PATCH v4 3/7] phy: add A3700 COMPHY support
Message-ID: <20181217164857.68df3f84@xps13>
In-Reply-To: <20181213083908.14180-4-miquel.raynal@bootlin.com>
References: <20181213083908.14180-1-miquel.raynal@bootlin.com>
        <20181213083908.14180-4-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[...]

> +
> +static int mvebu_a3700_comphy_smc(unsigned long function, unsigned long lane,
> +				  unsigned long mode)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(function, lane, mode, 0, 0, 0, 0, 0, &res);

I received the following bug report because I added a dependency on
COMPILE_TEST in Kconfig:

        config: i386-allmodconfig (attached as .config) compiler:
        gcc-7 (Debian 7.3.0-1) 7.3.0 reproduce:
                # save the attached .config to linux build tree
                make ARCH=i386 

        All errors (new ones prefixed by >>):

        >> ERROR: "__arm_smccc_smc" [drivers/phy/marvell/phy-mvebu-a3700-comphy.ko] undefined!  

Unless someone complains, I will drop the dependency on COMPILE_TEST in
Kconfig.

> +
> +	return res.a0;
> +}


Thanks,
Miquèl
