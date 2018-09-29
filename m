Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71946C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A1120685
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UHWNoUAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A1120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeI2XWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:22:08 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43238 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeI2XWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:22:07 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w8TGqgPt021326;
        Sun, 30 Sep 2018 01:52:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w8TGqgPt021326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538239962;
        bh=AAzDwdb6k8OEMf4qZz6SnjocYzfRWZqB26d4z5uy7f4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UHWNoUAk+Wyb9jDuuEohObetTkV3Sd+F73nHhweyy7SKLpNUyy1z/faAhdb23UVrC
         Uoq519azAEviISuQHdLAUebBeWK1/4n79x3YbArqPdNfza8rvx/tehHiONNlZAaD7B
         mQlstJqiK6EFzEyGX8Oi5ZmcZsLeUE3F6J9lt27ZaP/Fb5wdROWA155mcxyV2cUoll
         csw18CqUIigEjgWlPdMG9iVWHiHpaknkvr6XYA2oEu90mV4HGppHxLrus/9HYWrutc
         LrN/0bPPiXLr4nR5ZXOAHWFu+mjRgPHYSzQrRMcNrGLS1jYiqpssK6gPWnvvo1w6Tv
         J0DharI5Hp/LQ==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id h200-v6so2105221vke.5;
        Sat, 29 Sep 2018 09:52:42 -0700 (PDT)
X-Gm-Message-State: ABuFfoidsmwL0Z4be2elAAdqNtMk5UMl4ottI384rywgiSSW4f5E3JCM
        bFS6rpvgzmJ9CWQQvWd8NR/oIitTy8ZwvURriB0=
X-Google-Smtp-Source: ACcGV61Ct7Zq3jsuDbP8dUwzZrerOkMHBK9cS0GXvBecibfDkHWhw8lgDMSvvOyxu+s9aiUdmXmltAJHju6WgtppzQM=
X-Received: by 2002:a1f:3c01:: with SMTP id j1-v6mr1348011vka.84.1538239961376;
 Sat, 29 Sep 2018 09:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <1538117388-11945-1-git-send-email-yamada.masahiro@socionext.com> <CAK8P3a16pR5e1js7JiGreqHqxv5RNJZZY=JLFwLRE8i3nbg5hQ@mail.gmail.com>
In-Reply-To: <CAK8P3a16pR5e1js7JiGreqHqxv5RNJZZY=JLFwLRE8i3nbg5hQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 30 Sep 2018 01:52:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+mYBfjtO+MrRhedLCqwPnTLrK6nKSpFd=TVrMnQxx9Q@mail.gmail.com>
Message-ID: <CAK7LNAT+mYBfjtO+MrRhedLCqwPnTLrK6nKSpFd=TVrMnQxx9Q@mail.gmail.com>
Subject: Re: [PATCH] samples: run headers_install for host arch instead of
 target arch
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andy Gross <andy.gross@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B49=E6=9C=8829=E6=97=A5(=E5=9C=9F) 4:38 Arnd Bergmann <arnd@arnd=
b.de>:
>
> On Fri, Sep 28, 2018 at 8:51 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Some samples search headers in $(objtree)/usr/include, which is made
> > available by "make headers_install".  It is not kernel-space code but
> > host programs that need this header search path.
> >
> > Commit 3fca1700c4c3 ("kbuild: make samples really depend on
> > headers_install") is wrong because it installs headers of the target
> > architecture.  Besides, UML fails to build with CONFIG_SAMPLES=3Dy
> > because UML does not support headers_install.
> >
> > Invoke "make headers_install" for the _host_ architecture in the
> > prepare stage.  Introduce CONFIG_HOST_HEADERS_INSTALL so that this
> > happens only for samples that need it.
> >
> > I also removed 'Documentation/: headers_install', which I guess is
> > stale code.
> >
> > Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_ins=
tall")
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: David Howells <dhowells@redhat.com>
>
> I don't understand this one. Why would we want to build the samples for
> the host architecture rather than the target architecture?
>
> I would think that the bug is that we try to build them using
> HOSTCC, and they end up being unusable on the target as
> a consequence.


I just read Makefiles under samples/, and
all that require -I$(objtree)/usr/include
are listed in hostprogs-y,
so they are built for host architectures.

If this is different from our intent,
we need to fix this first.




--=20
Best Regards
Masahiro Yamada
