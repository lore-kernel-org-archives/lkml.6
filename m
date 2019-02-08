Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577CBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CAF2080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Kfqg8l0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfBHJek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:34:40 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:28135 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfBHJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:34:40 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x189YAc3022967
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 18:34:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x189YAc3022967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549618451;
        bh=lt3wPoP+t27ffzMBv85cWeV71nOytCWkJfmB03BwrdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kfqg8l0Bs9Z2dEcs4DTj/fCg1t7QSlB78qgEZY7Q8FEZSIK9MkJSuXpfFaiY9FZGR
         dQYbxUuMGQZfBQx9CKQe6da5A91BtVOkfsJ1zLix/MxDsW7+5PP0GOB+1ix2l7Idty
         Fbwih19hGZ/o7K/oSZ6Rtf/MCJBbTzKqEsWNg5731Gd5aZCI2jci6dwOI/D2B0wDEU
         uyhIE2ssMsE2yjFsicX/N1Euv2HrgZYQV+KV8SCocT22IH22zRR34nq3EopVnIY1fy
         7DrMecBXgiXARLhH3siqEhBCfoMRZdt8aHwcG6gb2IUG+SJtntuxrj4VTwrvI2wV7O
         cPyWtd85nOsDw==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id e16so1719515vsq.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 01:34:10 -0800 (PST)
X-Gm-Message-State: AHQUAuYVQvcokzRBQXTJv0GI4cv/H9Z8+R/zlvJmGL7CoPhJ7VMhVtwR
        PIHyVhWbsvWIh0cZJmJ3XFp8gIPJLIrg+aLLvv0=
X-Google-Smtp-Source: AHgI3Iaiw10ysv9Vo1vkQwNPbWBJBsErM9llboqiAR1sPdFHEwF4zOs92KsA19OXB9ixTrvrD7J0mZtYlmFAZCEVfV8=
X-Received: by 2002:a67:f759:: with SMTP id w25mr2811450vso.215.1549618449330;
 Fri, 08 Feb 2019 01:34:09 -0800 (PST)
MIME-Version: 1.0
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
 <1549613335-30319-8-git-send-email-yamada.masahiro@socionext.com> <7e1121479b38e98949b44c9fba91dee3adf97b99.camel@perches.com>
In-Reply-To: <7e1121479b38e98949b44c9fba91dee3adf97b99.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 8 Feb 2019 18:33:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbHBmu4a62rcBKmBR8eD=-pgUOW3mWh3PZtqOMPEpWJg@mail.gmail.com>
Message-ID: <CAK7LNATbHBmu4a62rcBKmBR8eD=-pgUOW3mWh3PZtqOMPEpWJg@mail.gmail.com>
Subject: Re: [PATCH 07/11] mtd: rawnand: denali: use bool type instead of int
 where appropriate
To:     Joe Perches <joe@perches.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 6:24 PM Joe Perches <joe@perches.com> wrote:
>
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


Thanks, this is good to know.


I will use 'bool' for denali_nand_info::dma_avail in v2.

I will wait for other comments until then.





-- 
Best Regards
Masahiro Yamada
