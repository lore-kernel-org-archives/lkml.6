Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2C1060555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbeFFH2t (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:28:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38419 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932122AbeFFH2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:28:47 -0400
Date: Wed, 6 Jun 2018 09:28:44 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mtd: rawnand: add an option to specify NAND chip
 as a boot device
Message-ID: <20180606092844.3ab746b2@bbrezillon>
In-Reply-To: <20180605201102.GA22487@rob-hp-laptop>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-3-stefan@agner.ch>
        <20180605201102.GA22487@rob-hp-laptop>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 5 Jun 2018 14:11:02 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Jun 01, 2018 at 12:16:33AM +0200, Stefan Agner wrote:
> > Allow to define a NAND chip as a boot device. This can be helpful
> > for the selection of the ECC algorithm and strength in case the boot
> > ROM supports only a subset of controller provided options.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  Documentation/devicetree/bindings/mtd/nand.txt | 4 ++++
> >  drivers/mtd/nand/raw/nand_base.c               | 3 +++
> >  include/linux/mtd/rawnand.h                    | 6 ++++++
> >  3 files changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
> > index 8bb11d809429..8daf81b9748c 100644
> > --- a/Documentation/devicetree/bindings/mtd/nand.txt
> > +++ b/Documentation/devicetree/bindings/mtd/nand.txt
> > @@ -43,6 +43,10 @@ Optional NAND chip properties:
> >  		     This is particularly useful when only the in-band area is
> >  		     used by the upper layers, and you want to make your NAND
> >  		     as reliable as possible.
> > +- nand-is-boot-medium: Whether the NAND chip is a boot medium. Drivers might use
> > +		       this information to select ECC algorithms supported by
> > +		       the boot ROM or similar restrictions.
> > +  
> 
> Shouldn't this be a partition level option? You could conceivably do one 
> ECC type for boot area and something else for the rest of the NAND.

I tried that a long time ago [1]. The result was far from perfect. I'm
not saying it's impossible to do it, but it definitely requires a lot
of work if we want to do it properly.

Also, what about boards that are not defining their partitions in the
DT but through the command line (using mtdparts)? That means patching
the mtdparts part parser to also take the ECC setup into account.

Regards,

Boris

[1]http://lists.infradead.org/pipermail/linux-mtd/2015-July/060600.html
