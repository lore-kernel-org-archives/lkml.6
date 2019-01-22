Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E80C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7F52084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mNt3q0KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfAVIBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:01:37 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34453 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfAVIBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:01:37 -0500
X-Greylist: delayed 989 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 03:01:35 EST
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x0M81VGa006056;
        Tue, 22 Jan 2019 17:01:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0M81VGa006056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548144092;
        bh=E9edDR1WQ/jfpO6pQ7+TCwEoztR/YTcdual/1f3RrJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mNt3q0KB2dr3Rnmwg5yoa571kc0efSw5gwAy4+lDtuZs6ZLlbL5GMRyR2q9m7oetN
         6UeDpn7h2sYhC5QsYdX7iuyMUeE7lyiqTQoOkiQQs2GJxckAcDmgtzfBvC61uwdRPL
         NF7C/FKkSuUptoON/pLZ+gt5azxmbDS7i6iW3nkAjz4o/Gv24ot7yq2JWcN5LqORrp
         HqzD0jnjNo6CkLQPKve9gCShU7aiPYoR3bMqUUDeYco377Igh+Vjf0IbEk8PHEnW5h
         MdhdjFjwk01iGEMFNpZMyQE5HVfdPGTxpverpOsws6VDTBBnBNlBj4djz7QD2B6zkI
         iD98LZKAZSqWw==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id t17so14140552vsc.8;
        Tue, 22 Jan 2019 00:01:31 -0800 (PST)
X-Gm-Message-State: AJcUukcmv5fOPtgCRFoXsvR6GK0/K2jGCCf2HtyfZHeEdTUfTFrhaeE7
        zB9Ts9+ltPpsK6gDNAtGMiKwEOWNMxu8/NXBJWw=
X-Google-Smtp-Source: ALg8bN7u1hvKwS6Djr7qhlyWuQwSx82MWeLiy2pvqllCMHXAzG64fuWy9IspyT8wzkmpgV/8TX36UHxAwWW/sK+GS+M=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr13583238vsm.181.1548144090409;
 Tue, 22 Jan 2019 00:01:30 -0800 (PST)
MIME-Version: 1.0
References: <1548142975-14219-1-git-send-email-yamada.masahiro@socionext.com>
 <1548142975-14219-3-git-send-email-yamada.masahiro@socionext.com> <20190122084944.420fcd4a@xps13>
In-Reply-To: <20190122084944.420fcd4a@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 22 Jan 2019 17:00:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvD03By1PQJ8KZG-UqX+NVQcL6JU-5a-2ZVVovdgBpEQ@mail.gmail.com>
Message-ID: <CAK7LNAQvD03By1PQJ8KZG-UqX+NVQcL6JU-5a-2ZVVovdgBpEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: use unnamed union in struct nand_op_parser_pattern_elem
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lucas Stach <dev@lynxeye.de>, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:50 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 22 Jan
> 2019 16:42:55 +0900:
>
> > Although drivers do not directly get access to the private data of
> > instruction patterns, let's use unnamed union field to be consistent
> > with nand_op_instr.
> >
>
> Actually this is how we wrote it the first time. Then we got robots
> reporting that anonymous unions where not allowed with older (still
> supported) GCC versions and I had to do this:
>
>
> commit c1a72e2dbb4abb90bd408480d7c48ba40cb799ce
> Author: Miquel Raynal <miquel.raynal@free-electrons.com>
> Date:   Fri Jan 19 19:11:27 2018 +0100
>
>     mtd: nand: Fix build issues due to an anonymous union
>
>     GCC-4.4.4 raises errors when assigning a parameter in an anonymous
>     union, leading to this kind of failure:
>
>     drivers/mtd/nand/marvell_nand.c:1936:
>         warning: missing braces around initializer
>         warning: (near initialization for '(anonymous)[1].<anonymous>')
>         error: unknown field 'data' specified in initializer
>         error: unknown field 'addr' specified in initializer
>
>     Work around the situation by naming these unions.
>
>     Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
>     Reported-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
>     Tested-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>


Hmm, how come Andrew's compiler was fine with the following?

struct nand_flash_dev {
        char *name;
        union {
                struct {
                        uint8_t mfr_id;
                        uint8_t dev_id;
                };
                uint8_t id[NAND_MAX_ID_LEN];
        };
        unsigned int pagesize;
        ...
};



The current minimum version is GCC 4.6
(commit cafa0010cd51fb7)
but I am not sure if this restriction is remaining.


-- 
Best Regards
Masahiro Yamada
