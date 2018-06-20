Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21D1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FA720652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FA720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeFTJEr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:04:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46061 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754574AbeFTJD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:03:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6AA2E20737; Wed, 20 Jun 2018 09:43:52 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1A14920012;
        Wed, 20 Jun 2018 09:43:42 +0200 (CEST)
Date:   Wed, 20 Jun 2018 09:43:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Marek Vasut" <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH v2 5/6] mtd: rawnand: micron: add
 ONFI_FEATURE_ON_DIE_ECC to supported features
Message-ID: <20180620094342.6689f0d4@xps13>
In-Reply-To: <b7bfe97c079e4e83bc108625224c2b16@svr-chch-ex1.atlnz.lc>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
        <20180619053125.16792-6-chris.packham@alliedtelesis.co.nz>
        <20180619074056.420d5560@bbrezillon>
        <20180619085244.77790406@xps13>
        <b7bfe97c079e4e83bc108625224c2b16@svr-chch-ex1.atlnz.lc>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, 19 Jun 2018 21:22:00 +0000, Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:

> On 19/06/18 18:53, Miquel Raynal wrote:
> > Hi Boris, Chris,
> > 
> > On Tue, 19 Jun 2018 07:40:56 +0200, Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> >   
> >> On Tue, 19 Jun 2018 17:31:24 +1200
> >> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> >>  
> >>> Add ONFI_FEATURE_ON_DIE_ECC to the set/get features list for Micron
> >>> NAND flash.
> >>>     
> >>
> >> Fixes: 789157e41a06 ("mtd: rawnand: allow vendors to declare (un)supported features")  
> > 
> > Sorry for breaking it in my previous series.
> >   
> >> Cc: <stable@vger.kernel.org>
> >>
> >> No need to send a new version, I'll add that when queuing the patch.
> >>
> >> Miquel, if you're okay, I'm gonna take this patch in the mtd/fixes branch
> >> and let you deal with other patches in this series.  
> > 
> > Yes please, take this one.
> > 
> > * Chris, I'll take patches 1, 2, 3 with Boris comments.  
> 
> OK.
> 
> I also got a kbuild report on
> 
> include/linux/mtd/rawnand.h:788: warning: Function parameter or member 
> 'fixup_onfi_param_page' not described in 'nand_manufacturer_ops'
> 
> Do you want me to send a v3 for that? (given our timezones I'll just 
> send it anyway and you can choose to take it or just stick with v2).

I'll take v3 for sure, thanks for already sending it.

> 
> > * Patch 4 I think I'll just drop it as nobody can test it (and it's a
> >    oneliner). I prefer people requesting a feature than complaining
> >    about a bug :)  
> 
> Agreed. It's in the mailing list archive now if someone needs it we can 
> resurrect it from there
> 
> > * Boris will take patch 5 in the mtd/fixes branch.  
> 
> Thanks all. Sorry our emails crossed so I couldn't just send #5 as a fix 
> on it's own.
> 
> > * I'll let you write a v3 for patch 6 only.  
> 
> I'll have a read through the old thread and see if I can make sense of it.

Thanks!

Miquèl
