Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeFANna (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:43:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54618 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbeFANn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:43:29 -0400
Date: Fri, 1 Jun 2018 15:43:26 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pgaikwad@nvidia.com,
        dev@lynxeye.de, mirza.krak@gmail.com, benjamin.lindqvist@endian.se,
        pdeschrijver@nvidia.com, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, jonathanh@nvidia.com,
        marek.vasut@gmail.com, thierry.reding@gmail.com,
        linux-mtd@lists.infradead.org, krzk@kernel.org, richard@nod.at,
        linux-tegra@vger.kernel.org, digetx@gmail.com,
        computersforpeace@gmail.com, dwmw2@infradead.org, marcel@ziswiler.com
Subject: Re: [PATCH v3 1/6] mtd: rawnand: add Reed-Solomon error correction
 algorithm
Message-ID: <20180601154326.6c60c579@bbrezillon>
In-Reply-To: <18ce3100aabf42059dbd514fb8c93e84@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-2-stefan@agner.ch>
        <20180601092600.03c14f53@bbrezillon>
        <20180601112506.2157e8b0@bbrezillon>
        <18ce3100aabf42059dbd514fb8c93e84@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jun 2018 15:34:33 +0200
Stefan Agner <stefan@agner.ch> wrote:

> On 01.06.2018 11:25, Boris Brezillon wrote:
> > On Fri, 1 Jun 2018 09:26:00 +0200
> > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> >   
> >> On Fri,  1 Jun 2018 00:16:32 +0200
> >> Stefan Agner <stefan@agner.ch> wrote:
> >>  
> >> > Add Reed-Solomon (RS) to the enumeration of ECC algorithms.
> >> >
> >> > Signed-off-by: Stefan Agner <stefan@agner.ch>  
> >>
> >> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >>  
> >> > ---
> >> >  drivers/mtd/nand/raw/nand_base.c | 1 +
> >> >  include/linux/mtd/rawnand.h      | 1 +  
> > 
> > Hm, you forgot to update Documentation/devicetree/bindings/mtd/nand.txt.
> >   
> 
> Yeah I was not sure about that. Currently it says:
> 
> - nand-ecc-algo: string, algorithm of NAND ECC.                         
>                                                                    
>                  Supported values are: "hamming", "bch".
> 
> Is supported meant by software ECC here? I feel "supported" is a rather
> strong word since it is clearly controller dependent whether it is
> actually supported...

I guess "valid values" or "accepted values" would be more appropriate
here.
