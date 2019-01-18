Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E4DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09CD2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WE8UyWZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfARI7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:59:21 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:24702 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfARI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:59:20 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x0I8wwUk013659;
        Fri, 18 Jan 2019 17:58:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x0I8wwUk013659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547801939;
        bh=7H8mp7prq3bqUVJ/R9LGUpDmJZhaqNOMZZ9Z29Z9Mcw=;
        h=From:Date:Subject:To:Cc:From;
        b=WE8UyWZLpgdL6TBbwl8Xp/y+B8jLGN5p3AyALNmPqUiq/H2RbPyFApOHsUT3LtkwA
         K2tz5KO2jBQEARpFx2i+NBfy7hfQ77REY9M5fbvxzVIlp0m++ozvBNDmUzxRLmAOIc
         oVSi9LCqN9HZzPlOpDRy4eQ/0IIxzcvdMpgTbP+wV32P0YD1qUyokpqi9Am1O5FQXx
         LpawcfchHaAyizeQdeKKEiHl+ZvbsVqqoCyriD7I8uxczj8q5jOq4XGdeIvwDuctB0
         y5dhTOCYspc+2Nk6JrSH6zTMO4qPkO0LOh1EzoWd6/8gqi+ChMyB+sBI8V8EJ8hZN5
         rMEUY+FcSZ9iw==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id n10so7953759vso.13;
        Fri, 18 Jan 2019 00:58:59 -0800 (PST)
X-Gm-Message-State: AJcUukdSOb8+WwNgfRFeO7xOVpmqU1apks42su2biRf62Twp2CXjsJnO
        a1iJfL+qH8dic/eGPzO/ijqFLCGcbnjwYiZRC4I=
X-Google-Smtp-Source: ALg8bN5pETRJJL3xnpwWK11OpcMVEsb1VUJY6lWaIST+lSa79T8K7XL78OfxU3oMZzmIMrVZ7+1cg5nbqbWMa5WiDuc=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr7357030vsb.155.1547801938012;
 Fri, 18 Jan 2019 00:58:58 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 18 Jan 2019 17:58:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyx5DtopKfkS4ge=6F7e16qjvOr_1XOTvCZqaZKnPwxQ@mail.gmail.com>
Message-ID: <CAK7LNATyx5DtopKfkS4ge=6F7e16qjvOr_1XOTvCZqaZKnPwxQ@mail.gmail.com>
Subject: [Question] What is the license of scripts/basic/fixdep.c ?
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


The comment block of scripts/basic/fixdep.c says as follows:


 * Author       Kai Germaschewski
 * Copyright    2002 by Kai Germaschewski  <kai.germaschewski@gmx.de>
 *
 * This software may be used and distributed according to the terms
 * of the GNU General Public License, incorporated herein by reference.



It does not explicitly mention the version of GPL.

In this case, I think the corresponding SPDX tag
is GPL-1.0+ instead of GPL-2.0

Is this correct?



There could be another problem regarding of this.



Commit 9f7ef9854e80 copied scripts/basic/fixdep.c
to tools/build/fixdep.c, but it ripped off its license term.

Later, it was tagged as GPL-2.0 by b24413180

See 'git show  b24413180 -- tools/build/fixdep.c'


Maybe tools/build/fixdep.c should be corrected to GPL-1.0+ ?


-- 
Best Regards
Masahiro Yamada
