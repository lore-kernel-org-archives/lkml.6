Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBBCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB27218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBHJXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:23:42 -0500
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:40719 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725998AbfBHJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:23:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 91D4418224D73;
        Fri,  8 Feb 2019 09:23:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: card36_7731ced553b11
X-Filterd-Recvd-Size: 2421
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Feb 2019 09:23:38 +0000 (UTC)
Message-ID: <7e1121479b38e98949b44c9fba91dee3adf97b99.camel@perches.com>
Subject: Re: [PATCH 07/11] mtd: rawnand: denali: use bool type instead of
 int where appropriate
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Date:   Fri, 08 Feb 2019 01:23:37 -0800
In-Reply-To: <1549613335-30319-8-git-send-email-yamada.masahiro@socionext.com>
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
         <1549613335-30319-8-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 17:08 +0900, Masahiro Yamada wrote:
> Use 'bool' type for some function arguments.
> 
>  - write (write or read?)
>  - raw (the raw access mode or not?)
> 
> It is true that denali_nand_info::dma_avail is also boolean, but
> I am keeping it as 'int' because 'scripts/checkpatch --strict' would
> report the following:
> 
> CHECK: Avoid using bool structure members because of possible alignment issues
>   - see: https://lkml.org/lkml/2017/11/21/384
> 
> I do not think it is a matter here, but I am sticking to the suggestion.

just fyi: that suggestion has been removed by:

commit 7967656ffbfa493f5546c0f18bf8a28f702c4baa
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Fri Jan 18 15:50:47 2019 -0700

    coding-style: Clarify the expectations around bool
    
    There has been some confusion since checkpatch started warning about bool
    use in structures, and people have been avoiding using it.
    
    Many people feel there is still a legitimate place for bool in structures,
    so provide some guidance on bool usage derived from the entire thread that
    spawned the checkpatch warning.
    
    Link: https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x



