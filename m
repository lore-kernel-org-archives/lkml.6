Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB15C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9892133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbeLQP4Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:56:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60142 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387847AbeLQP4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:56:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7E03A20733; Mon, 17 Dec 2018 16:56:13 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0DA1C20726;
        Mon, 17 Dec 2018 16:56:03 +0100 (CET)
Date:   Mon, 17 Dec 2018 16:56:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Evan Wang <xswang@marvell.com>
Subject: Re: [PATCH v4 3/7] phy: add A3700 COMPHY support
Message-ID: <20181217165603.602a7a42@xps13>
In-Reply-To: <20181217165223.6f98b8a4@windsurf>
References: <20181213083908.14180-1-miquel.raynal@bootlin.com>
        <20181213083908.14180-4-miquel.raynal@bootlin.com>
        <20181217164857.68df3f84@xps13>
        <20181217165223.6f98b8a4@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote on Mon, 17 Dec
2018 16:52:23 +0100:

> Hello,
> 
> On Mon, 17 Dec 2018 16:48:57 +0100, Miquel Raynal wrote:
> 
> > I received the following bug report because I added a dependency on
> > COMPILE_TEST in Kconfig:
> > 
> >         config: i386-allmodconfig (attached as .config) compiler:
> >         gcc-7 (Debian 7.3.0-1) 7.3.0 reproduce:
> >                 # save the attached .config to linux build tree
> >                 make ARCH=i386 
> > 
> >         All errors (new ones prefixed by >>):
> >   
> >         >> ERROR: "__arm_smccc_smc" [drivers/phy/marvell/phy-mvebu-a3700-comphy.ko] undefined!      
> > 
> > Unless someone complains, I will drop the dependency on COMPILE_TEST in
> > Kconfig.  
> 
> Keep COMPILE_TEST, and add:
> 
> 	depends on HAVE_ARM_SMCCC
> 
> perhaps ?

Oh that's a cool Kconfig entry. Forgot about it, thanks for the
pointer!


Thanks,
Miquèl
