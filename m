Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E029DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B883821841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBHWLt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:11:49 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:46769 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBHWLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:11:49 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7BF60100009;
        Fri,  8 Feb 2019 22:11:45 +0000 (UTC)
Date:   Fri, 8 Feb 2019 23:11:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 07/11] mtd: rawnand: denali: use bool type instead of
 int where appropriate
Message-ID: <20190208231144.413a8f6d@xps13>
In-Reply-To: <7e1121479b38e98949b44c9fba91dee3adf97b99.camel@perches.com>
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
        <1549613335-30319-8-git-send-email-yamada.masahiro@socionext.com>
        <7e1121479b38e98949b44c9fba91dee3adf97b99.camel@perches.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Joe Perches <joe@perches.com> wrote on Fri, 08 Feb 2019 01:23:37 -0800:

> On Fri, 2019-02-08 at 17:08 +0900, Masahiro Yamada wrote:
> > Use 'bool' type for some function arguments.
> > 
> >  - write (write or read?)
> >  - raw (the raw access mode or not?)
> > 
> > It is true that denali_nand_info::dma_avail is also boolean, but
> > I am keeping it as 'int' because 'scripts/checkpatch --strict' would
> > report the following:
> > 
> > CHECK: Avoid using bool structure members because of possible alignment issues
> >   - see: https://lkml.org/lkml/2017/11/21/384
> > 
> > I do not think it is a matter here, but I am sticking to the suggestion.  
> 
> just fyi: that suggestion has been removed by:
> 
> commit 7967656ffbfa493f5546c0f18bf8a28f702c4baa
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Fri Jan 18 15:50:47 2019 -0700
> 
>     coding-style: Clarify the expectations around bool
>     
>     There has been some confusion since checkpatch started warning about bool
>     use in structures, and people have been avoiding using it.
>     
>     Many people feel there is still a legitimate place for bool in structures,
>     so provide some guidance on bool usage derived from the entire thread that
>     spawned the checkpatch warning.
>     
>     Link: https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x
> 
> 
> 

Interesting, thanks for the link! I will consider this for my ongoing
developments.


Regards,
Miquèl
