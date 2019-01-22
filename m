Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243C2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15D420870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ubwnKfx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfAVI4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:56:48 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30216 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfAVI4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:56:47 -0500
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x0M8uHHQ024251;
        Tue, 22 Jan 2019 17:56:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x0M8uHHQ024251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548147378;
        bh=smsVEI+nS4GxdebYfz+g3FYvtIn8efSFFYmFzJSH/do=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ubwnKfx0rlazLULIFSuZIkpvDWOSd1vSiHAhadJEnHQSXablUiH+iG/0dy0FXJuBi
         41F3Op9X65/LKRaBq8ABpSvnhCKHwaf92W3V6PQwAsVBeHq/skwdSbb+mwgDZCciI2
         5azSOdr05tA/J9HCYbHmw7QJyI6Z2BZDo3Y6o/n5s+oCgsa+AXRPtJQAaayWrc5Bn5
         lhhx2ix+4eiQbjRwHSm2+i9ZzLLeslDwPOuEkKm9rWefE2ojy7kwejUciMl2aAF/+c
         y3RXPjNS7Ct1Ruc5BFxODKtKTD5nRqj0PQZn9sK8En6QX4CQjwc+sho8QF4LYRvx42
         iLcIdtaZOZsFw==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id j23so5173297vke.13;
        Tue, 22 Jan 2019 00:56:17 -0800 (PST)
X-Gm-Message-State: AJcUukfwQYLZzCGn3NKHdEIQVK0FPxkjI+Zg5PAlE1cmy2A1OnmPlfUO
        mx9Ci09NiJ33KtwrCrXtj9hqc3x56DV/GSUqPdY=
X-Google-Smtp-Source: ALg8bN61wQ6e4LPjiM6HUfkbwIQw6hzkjHKsGZzfbRDO/Q02YlklZz6OTqn+3zZGxGfpXCy1KmD1H+bMCFppn4WFr8c=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr12819882vkd.74.1548147376729;
 Tue, 22 Jan 2019 00:56:16 -0800 (PST)
MIME-Version: 1.0
References: <1548142975-14219-1-git-send-email-yamada.masahiro@socionext.com>
 <1548142975-14219-3-git-send-email-yamada.masahiro@socionext.com>
 <20190122084944.420fcd4a@xps13> <CAK7LNAQvD03By1PQJ8KZG-UqX+NVQcL6JU-5a-2ZVVovdgBpEQ@mail.gmail.com>
 <20190122090830.118eb6be@xps13> <20190122093313.67375948@bbrezillon>
In-Reply-To: <20190122093313.67375948@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 22 Jan 2019 17:55:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAbJ01n9+oh-VNAPP9Tt7NSBX8a-teSbDDhADF-bKAKw@mail.gmail.com>
Message-ID: <CAK7LNARAbJ01n9+oh-VNAPP9Tt7NSBX8a-teSbDDhADF-bKAKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: use unnamed union in struct nand_op_parser_pattern_elem
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 5:33 PM Boris Brezillon <bbrezillon@kernel.org> wrote:
>
> On Tue, 22 Jan 2019 09:08:30 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> > Hi Masahiro,
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 22 Jan
> > 2019 17:00:54 +0900:
> >
> > > On Tue, Jan 22, 2019 at 4:50 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >
> > > > Hi Masahiro,
> > > >
> > > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 22 Jan
> > > > 2019 16:42:55 +0900:
> > > >
> > > > > Although drivers do not directly get access to the private data of
> > > > > instruction patterns, let's use unnamed union field to be consistent
> > > > > with nand_op_instr.
> > > > >
> > > >
> > > > Actually this is how we wrote it the first time. Then we got robots
> > > > reporting that anonymous unions where not allowed with older (still
> > > > supported) GCC versions and I had to do this:
> > > >
> > > >
> > > > commit c1a72e2dbb4abb90bd408480d7c48ba40cb799ce
> > > > Author: Miquel Raynal <miquel.raynal@free-electrons.com>
> > > > Date:   Fri Jan 19 19:11:27 2018 +0100
> > > >
> > > >     mtd: nand: Fix build issues due to an anonymous union
> > > >
> > > >     GCC-4.4.4 raises errors when assigning a parameter in an anonymous
> > > >     union, leading to this kind of failure:
> > > >
> > > >     drivers/mtd/nand/marvell_nand.c:1936:
> > > >         warning: missing braces around initializer
> > > >         warning: (near initialization for '(anonymous)[1].<anonymous>')
> > > >         error: unknown field 'data' specified in initializer
> > > >         error: unknown field 'addr' specified in initializer
> > > >
> > > >     Work around the situation by naming these unions.
> > > >
> > > >     Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
> > > >     Reported-by: Andrew Morton <akpm@linux-foundation.org>
> > > >     Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > > >     Tested-by: Andrew Morton <akpm@linux-foundation.org>
> > > >     Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > >
> > >
> > >
> > > Hmm, how come Andrew's compiler was fine with the following?
> > >
> > > struct nand_flash_dev {
> > >         char *name;
> > >         union {
> > >                 struct {
> > >                         uint8_t mfr_id;
> > >                         uint8_t dev_id;
> > >                 };
> > >                 uint8_t id[NAND_MAX_ID_LEN];
> > >         };
> > >         unsigned int pagesize;
> > >         ...
> > > };
> > >
> >
> > It is probably not :)
>
> It was compile fine. I don't know all the subtleties, but maybe it's
> because ->id[] is a base type and not a struct.
>
> >
> > >
> > >
> > > The current minimum version is GCC 4.6
> > > (commit cafa0010cd51fb7)
> > > but I am not sure if this restriction is remaining.
> > >
> >
> > That's right, can you please test if this limitation is still
> > ongoing wit GCC 4.6?
>
> I have a more important question: why should we go bad back to unnamed
> unions? Why is that a problem to have a named union? Sure, we initially
> started with an unnamed ones because it made lines shorter, but now that
> we switched to named unions I don't see the point of going back and
> patching all drivers again (at the risk of seeing this problem appear
> again when compiled with an old compiler version).


I did not know commit c1a72e2dbb4.

We can drop the union name if and only if we are "100% sure" about the safety.
I cannot prove it.

Generally, 0day bot helps us.
Last time, nobody noticed the build error until Andrew reported it.
So, we cannot count on the 0day bot.


Less praise for this work.
Lots of criticism once I break it.

So, I have no reason to take the risk.



--
Best Regards
Masahiro Yamada
