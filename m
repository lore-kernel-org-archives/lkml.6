Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeEDSi7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:38:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42384 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbeEDSi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:38:57 -0400
Date: Fri, 4 May 2018 20:38:44 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: <cyrille.pitchen@wedev4u.fr>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] spi-nor: Add support for Atmel Dataflash memories
Message-ID: <20180504203844.0c09bf6d@bbrezillon>
In-Reply-To: <1519818901-7116-1-git-send-email-radu.pirea@microchip.com>
References: <1519818901-7116-1-git-send-email-radu.pirea@microchip.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Radu,

Sorry for the late reply.

On Wed, 28 Feb 2018 13:55:01 +0200
Radu Pirea <radu.pirea@microchip.com> wrote:

> This patch add support in spi-nor for allmost all dataflash memories
> supported by old mtd_dataflash driver.

Those devices clearly use a different instruction set, so I don't think
they fit in this framework. Can you tell us why you want to move
dataflash support to the SPI NOR framework. I think I know why, but I'd
like to get your version. My guess is that some people want to connect
dataflash chips to the Atmel QSPI controller, and it's not supported
right now because the Atmel QSPI controller implements the SPI-NOR
interface and not the generic SPI one, thus preventing anything that
is not a SPI NOR from being connected to this controller.

If I'm right, then the solution is to convert the QSPI driver to the
spi-mem interface [1] and move it to drivers/spi/.

Regards,

Boris

[1]http://patchwork.ozlabs.org/project/linux-mtd/list/?series=41174
