Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C5C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A821E2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jkYK+RHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBKBQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:16:05 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:55968 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfBKBQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:16:04 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1B1FiN7031375
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:15:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1B1FiN7031375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549847745;
        bh=liz0a8bmiw0FcM/TWTCUBPm8kJRY4MTjd3tYETr+dQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jkYK+RHpAwsxV3e8camizcZd99ZpqOsKQ3iKeFmanLkNdLMSuz1MtKHeBRAYOQ0vw
         BtvHjkUq3zsbsPFPBQL+ccP9Yjtg0+RVtnjIoId+O7PVUIC2EqWDVY0pCgeuYTWnFg
         Av0I718bzJOhWpEMAO2Lma4uR5lFbGWU3dVokxd5zY/elNmKbR1tKXT7zjiB2kQw/N
         58rpNYbE3bkfOj+rus+N1nWtji+dru9DyLA6VGL6HxNRGGLwMabKnIhxTlrSt3Up9p
         fJtqSDt/y1twwyvNp1bnkCki/Fxzcg1VxQ75pTJ4BC2jklA/d9AaKqWNmO1jJHwoqX
         kgSDnrIePl2VA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id z24so2895412ual.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 17:15:44 -0800 (PST)
X-Gm-Message-State: AHQUAuZgEgsJ2Q4nWIJZKUn89p231X/+3sVoiKAa1UBWjlRUG6GyhvsO
        gJKA/MvC8N4/Tyb6iOMfgW/f142CmkIOtxGksrg=
X-Google-Smtp-Source: AHgI3IYpFWX9qhhmBNeNSLY7sQ+QD247/WyYD607wgddcoSWfCvZgNf8CTZvizxwT0YsPr/nPUyLrv3+kg9ey47OxRM=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr12021102uaj.42.1549847743634;
 Sun, 10 Feb 2019 17:15:43 -0800 (PST)
MIME-Version: 1.0
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
 <1549613335-30319-6-git-send-email-yamada.masahiro@socionext.com> <20190208225733.2c8779b9@xps13>
In-Reply-To: <20190208225733.2c8779b9@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 11 Feb 2019 10:15:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0hJJ=PWJhWo5cjtboN6qW5JFtOV+WzrLyFy=zRXjwFw@mail.gmail.com>
Message-ID: <CAK7LNAT0hJJ=PWJhWo5cjtboN6qW5JFtOV+WzrLyFy=zRXjwFw@mail.gmail.com>
Subject: Re: [PATCH 05/11] mtd: rawnand: denali: rename irq_status to irq_stat
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Sat, Feb 9, 2019 at 6:57 AM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri,  8 Feb
> 2019 17:08:49 +0900:
>
> > I will add the third argument to denali_wait_for_irq() in the
> > following commit. Then, some lines will exceed 80 columns.
> >
> > Rename 'irq_status' to 'irq_stat'. Saving two characters will avoid
> > line-wrapping in some places, and keep the code clean.
>
> I had a look at the changes and I don't think this is worth the
> trouble. I don't find irq_stat meaningful enough compared to
> irq_status. If you want, you may break lines between arguments of a
> function instead.

OK, I will drop this patch from v2.


> >
> > I replaced uint32_t with u32 in the touched lines. This will reduce
> > the reports from 'scripts/checkpatch.pl --strict'.
>
> While you are at it, it might be interesting to convert the whole
> driver in one go to using u8, u16 and u32?

I did this in 11/11.
http://patchwork.ozlabs.org/patch/1038507/

I will move all uint32_t -> u32 conversions to the last patch
if this is worthwhile.


Thanks.

> Thanks,
> Miqu=C3=A8l
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--=20
Best Regards
Masahiro Yamada
