Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbeEWKmx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:42:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35961 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932394AbeEWKmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:42:50 -0400
Date: Wed, 23 May 2018 12:42:45 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Josh Wu <rainyfeeling@outlook.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180523124245.4ca332fd@bbrezillon>
In-Reply-To: <498f4a40-0f4b-fb32-2d6c-032b5341f2b0@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
        <20180329153322.5e2fc1e7@bbrezillon>
        <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
        <20180329154416.5c1a0013@bbrezillon>
        <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
        <20180402142249.7e076a64@bbrezillon>
        <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
        <20180402212843.164d5d21@bbrezillon>
        <20180402222020.1d344c14@bbrezillon>
        <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
        <20180403091813.5fb5c18c@bbrezillon>
        <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
        <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
        <498f4a40-0f4b-fb32-2d6c-032b5341f2b0@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 20:03:41 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-04-11 17:34, Nicolas Ferre wrote:
> > On 11/04/2018 at 16:44, Peter Rosin wrote:  
> >> Hi Nicolas,
> >>
> >> Boris asked for your input on this (the datasheet difference appears to
> >> have no bearing on the issue) elsewhere in the tree of messages. It's
> >> now been a week or so and I'm starting to wonder if you missed this
> >> altogether or if you are simply out of office or something?  
> > 
> > Hi Peter,
> > 
> > I didn't dig into this issue with matrix datasheet reset values and your 
> > findings below. I'll try to move forward with your detailed explanation 
> > and with my contacts within the "product" team internally.  
> 
> Hi again, just checking in to see if there is any progress? If not, maybe
> it's time to just take the patch as-is, warts and imperfections included,
> and even if we all hate it. But what to do...

Well, it's not really that the fix is ugly, but I'm pretty sure it's
actually not fixing the problem, just make it less likely to happen.
And, as soon as you'll have more traffic going through the DRAM
controller you'll experience the same problem again.
