Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E34C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8C920883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nfYLxhyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfAHPdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:33:17 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50648 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:33:16 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x08FX5Wm020694;
        Wed, 9 Jan 2019 00:33:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x08FX5Wm020694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546961586;
        bh=LQPAha78p1HdGEOw/+HOSVmjiCEBVHG9OH8+5nRjDXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nfYLxhygb44lhetpxe6J0JzMmmwr41+VdNBBM5vEJ3/FuUDHsxhdzlKNhjEFVmBLX
         /zbCfbPeruPPLAq9SJMLh8VK3J3uKfKQSNAW2x/PyQYj6rLtwcgR97QOOrtRsiZtuo
         AyWYcw6YlX8sqSIm36EkqIJUgth7BNL9lrFPVyZp1Saw5dl67ObIyPOYAatJoKWuzj
         jHUkeBlp9YUduVcQkbAJFKvANUrLhHuqekBQa0o1WFy4jv8fIVcDHF/hevu7Tn32Jt
         xGFJcFRNq0dkGixKw41lR1mdtP4JrddmCxklqy1diO8bU2GfXHoga3v5l5zH7cZ9yc
         bHBdQH7vexjRw==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id x1so2686551vsc.10;
        Tue, 08 Jan 2019 07:33:05 -0800 (PST)
X-Gm-Message-State: AJcUukfMoSrRh/PYGaM/JcSF2o2xrXPwR/QVWEtJi/rfB4jabXYv+vqi
        bUiQWXZzlNN9E0sw72+HqBAyoO2Nr0IbhHYmS/c=
X-Google-Smtp-Source: ALg8bN4zwJf60tEd8jwfN7+Nb1jFcxO+xLEgXSz53PG8ujjktkHKI+pGN4SaRdDw6eAdTUUVDLjnKur14xYyNJ5b8Q8=
X-Received: by 2002:a67:a858:: with SMTP id r85mr862339vse.215.1546961584270;
 Tue, 08 Jan 2019 07:33:04 -0800 (PST)
MIME-Version: 1.0
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com> <20190108111032.GP3235@lianli.shorne-pla.net>
In-Reply-To: <20190108111032.GP3235@lianli.shorne-pla.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 9 Jan 2019 00:32:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+grgqHM-ht0CCTmZHp+JRvr=Q+sJOo0URqRgTAYRs0w@mail.gmail.com>
Message-ID: <CAK7LNAS+grgqHM-ht0CCTmZHp+JRvr=Q+sJOo0URqRgTAYRs0w@mail.gmail.com>
Subject: Re: [PATCH] arch: unexport asm/shmparam.h for all architectures
To:     Stafford Horne <shorne@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-riscv@lists.infradead.org, Greentime Hu <green.hu@gmail.com>,
        linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        openrisc@lists.librecores.org, Mark Salter <msalter@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,



On Tue, Jan 8, 2019 at 8:12 PM Stafford Horne <shorne@gmail.com> wrote:
>
> What is this patch based on?  I tried to apply it to 5.0-rc1 and am having an
> issue with applying the arch/openrisc/include/uapi/asm/Kbuild part.


Based on Linus' latest tree.
(commit 3bd6e94be)

v5.0-rc1 is NOT the latest.



> It seems shmparam.h is not there. It was removed with the others in your
> ("d6e4b3e326d8") arch: remove redundant UAPI generic-y defines, commit a few
> days ago.
>
> Note, I can't compile 5.0-rc1 without the first part of this patch.  So please
> get it merged asap :)


I notice the breakage of several arches after v5.0-rc1 release,
so I asked Linus to pick up 3d6e94be.

I had already noticed
having shmparam.h in uapi is werid,
but I decided to fix the build errors first.


-- 
Best Regards
Masahiro Yamada
