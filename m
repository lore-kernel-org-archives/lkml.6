Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF55ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F802084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F802084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeGTH66 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:58:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36231 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbeGTH66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:58:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D5C51207A8; Fri, 20 Jul 2018 09:12:08 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 40F982069C;
        Fri, 20 Jul 2018 09:12:08 +0200 (CEST)
Date:   Fri, 20 Jul 2018 09:12:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 01/33] mtd: rawnand: brcmnand: convert driver to
 nand_scan()
Message-ID: <20180720091207.7828147d@xps13>
In-Reply-To: <20180720011719.7545fbb9@bbrezillon>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
        <20180719230026.8741-2-miquel.raynal@bootlin.com>
        <20180720011719.7545fbb9@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Fri, 20 Jul 2018
01:17:19 +0200:

> On Fri, 20 Jul 2018 00:59:54 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > +
> > +static struct nand_controller_ops brcmnand_controller_ops = {  
> 
> static const ...

Mmmh right, I'll constify every controller_ops definition.

> 
> The same comment applies to all patches of this series.
> 
> > +	.attach_chip = brcmnand_attach_chip,
> > +};  
> 


Miquèl
