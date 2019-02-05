Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99A6206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfBENS6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:18:58 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:50337 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:18:58 -0500
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B7DB7240011;
        Tue,  5 Feb 2019 13:18:54 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:18:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali_dt: remove single anonymous clock
 support
Message-ID: <20190205141853.4b7ed954@xps13>
In-Reply-To: <20190131182644.366a54a5@bbrezillon>
References: <1547539894-12898-1-git-send-email-yamada.masahiro@socionext.com>
        <20190115092229.59e09c2d@xps13>
        <CAK7LNATnfTQXHrXJQp7732-e7hvd8ORcYubyDmz0KHaRXRMDqQ@mail.gmail.com>
        <20190128112007.440046e6@xps13>
        <da2ea926-30e9-c7b9-8b1f-ee65ccc0fb7a@kernel.org>
        <20190131182644.366a54a5@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,

Boris Brezillon <bbrezillon@kernel.org> wrote on Thu, 31 Jan 2019
18:26:44 +0100:

> Hi Dinh,
> 
> On Thu, 31 Jan 2019 11:24:16 -0600
> Dinh Nguyen <dinguyen@kernel.org> wrote:
> 
> > On 1/28/19 4:20 AM, Miquel Raynal wrote:  
> > > Hi Dinh,
> > > 
> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Wed, 16 Jan
> > > 2019 10:27:11 +0900:
> > >     
> > >> (+CC Dinh Nguyen)
> > >>
> > >> On Tue, Jan 15, 2019 at 5:22 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:    
> > >>>
> > >>> Hi Masahiro,
> > >>>
> > >>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 15 Jan
> > >>> 2019 17:11:34 +0900:
> > >>>      
> > >>>> Commit 6f1fe97bec34 ("mtd: rawnand: denali_dt: add more clocks based
> > >>>> on IP datasheet") introduced a more correct binding that requires
> > >>>> three named clocks.
> > >>>>
> > >>>> Now that all upstream DT files migrated over to it, remove the single
> > >>>> anonymous clock support.      
> > >>>
> > >>> I would love to do that but I think this is against the "DT backward
> > >>> compatibility rule".      
> > >>
> > >> Yeah, I know this rule, but we break DT binding from time to time.
> > >>
> > >>
> > >>    
> > >>> Anyway, IIRC it is accepted that this kind of
> > >>> rule might be broken if decided per the arch-maintainer (in this
> > >>> case, you I suppose). So if this is really what you want, I'll queue
> > >>> it.      
> > >>
> > >> My platform is fine, but this driver is used by SOCFPGA boards as well.
> > >>
> > >> I CCed the SOCFPGA maintainer, Dinh Nguyen.
> > >>    
> > > 
> > > Gentle ping on this topic.
> > >     
> > 
> > This patch looks fine to be. Feel free to add:
> > 
> > Tested-by: Dinh Nguyen <dinguyen@kernel.org>  
> 
> I think Miquel is waiting for an Acked-by to confirm that you're okay
> breaking backward compat with old DT.

Yes, I am waiting for your Acked-by.


Thanks,
Miquèl
