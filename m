Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeE3OYo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:24:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44680 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbeE3OYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:24:42 -0400
Date: Wed, 30 May 2018 16:24:39 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Message-ID: <20180530162439.7b5eec2b@bbrezillon>
In-Reply-To: <DB6PR0402MB2838F1DE06025F231537DD68996C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB2838F1DE06025F231537DD68996C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Wed, 30 May 2018 13:50:51 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Frieder,
> 
> Thanks for migrating the fsl-quadspi.c driver on the new SPI
> framework. This patch is using dynamic LUT approach to create the LUT
> at run time instead of fixed static LUT as being used in current
> driver present at mtd/spi-nor/fsl-quadspi.c. I have pushed the
> changes for dynamic LUT on mtd/spi-nor/fsl-quadspi.c and v10 has been
> in review stage.
> 
> Request you to please add 'signed-off' mentioned in those patches in
> this patch, patchwork link is
> https://patchwork.ozlabs.org/patch/896534/

First, I'd like to state that this work has not been based on your
dynamic LUT code, and I actually asked you to adapt your code to match
the way we were handling it in the new driver (which at that time was
still under development). Then, even if you want to be cited as one of
the author of the new code, SoB tag is not the right way to do it (see
[1] for an explanation on when SoB should be added). Instead, you
should add your name in the copyright header and maybe be add a
MODULE_AUTHOR():

/*
 * Copyright ...
 * ...
 * Authors:
 *	...
 *	Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
 */

...

MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");

Regards,

Boris

[1]https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L429
