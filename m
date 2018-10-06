Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F73ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001CB208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HDbmTk4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001CB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJGFEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 01:04:00 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:32171 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeJGFD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 01:03:59 -0400
X-Greylist: delayed 5217 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Oct 2018 01:03:57 EDT
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w96LwjSV030270;
        Sun, 7 Oct 2018 06:58:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w96LwjSV030270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538863126;
        bh=B0RUxl+W3iKJmKNJ2KljcYJ3zRiAJuTIN5e0bSoHY0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HDbmTk4MZ6yiPF5ZNAHo/Cm0nWN1P/uZKGzx46DCOGZiiyOohbb8j/9Hwd+32qLFz
         4/b8TBczxqteB1oGvLMp8/iP5Go+xgIZgiH5OX85Jgke0BFGZRbqXHcJT3JjOEOz4f
         DEaKKXKJHQbEY+PqufH+viJott38pLLd6keE/tglysOaiNXU3KwsytE4kXpB8naNyH
         3ZYHFykiRAcGDEG134Y/m+5+hi1g/a853Di4AxBnzLoK2PPsxnoqHV9vjZaE2xGFgW
         IWQK3ugbpbuCo28ntuuxcPmLmOsMCpBHx47yOnB7JUxMTcSaJz1AeE3xjsURXCQrDE
         XWWg74wODiOSA==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id b80-v6so1965924vke.3;
        Sat, 06 Oct 2018 14:58:45 -0700 (PDT)
X-Gm-Message-State: ABuFfohkyQPLr9fdpvmw4gTTP2jD3uI/znV+erUi8W6qPkGn+bPfAHf9
        mnXnaHhvMk19vhcOgHgyEuEGrn0gPJUxf6rkEUw=
X-Google-Smtp-Source: ACcGV60kM4X4O0kcz70R2hcAk5v0YFZL8ThG2SYvD80+4OGonWhJXk33u2dx1+uno8PJRw7Ltoj34MeQBf9I21IrCqo=
X-Received: by 2002:a1f:3c01:: with SMTP id j1-v6mr6418641vka.84.1538863124949;
 Sat, 06 Oct 2018 14:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20181005083313.2088252-1-arnd@arndb.de> <CANiq72mHDxe9-+pFf+dDuYXRz5YeyRYi6RW65tyo9-ENNngsCw@mail.gmail.com>
In-Reply-To: <CANiq72mHDxe9-+pFf+dDuYXRz5YeyRYi6RW65tyo9-ENNngsCw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Oct 2018 06:58:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5h+Rku7DbD+kHGv7Kgk8FfuX4wwL_pwNOLSJbqw99MA@mail.gmail.com>
Message-ID: <CAK7LNAT5h+Rku7DbD+kHGv7Kgk8FfuX4wwL_pwNOLSJbqw99MA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     miguel.ojeda.sandonis@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kieran.bingham+renesas@ideasonboard.com,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,


On Sun, Oct 7, 2018 at 6:18 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Oct 5, 2018 at 10:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Building any configuration with 'make W=3D1' produces a warning:
> >
> > kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissi=
ng-prototypes]
> >
> > When also passing -Werror, this prevents us from building any
> > other files. Nobody ever calls the function, but we can't make
> > it 'static' either since we want the compiler output.
> >
> > Calling it 'main' instead however avoids the warning, because gcc
> > does not insist on having a declaration for main.
>
> I think marking the function as static __used should do the trick and
> would be less confusing.




I tried __used, but I still see the warning.


masahiro@grover:~/ref/linux$ git diff
diff --git a/kernel/bounds.c b/kernel/bounds.c
index c373e88..aee0101 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -13,7 +13,7 @@
 #include <linux/log2.h>
 #include <linux/spinlock_types.h>

-void foo(void)
+void __used foo(void)
 {
        /* The enum constants to put into include/generated/bounds.h */
        DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
masahiro@grover:~/ref/linux$ make W=3D1  prepare
  CC      kernel/bounds.s
kernel/bounds.c:16:13: warning: no previous prototype for =E2=80=98foo=E2=
=80=99
[-Wmissing-prototypes]
 void __used foo(void)
             ^
  CC      arch/x86/kernel/asm-offsets.s





--=20
Best Regards
Masahiro Yamada
