Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A85DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085582147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQcn58Ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfBSWnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:43:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41347 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbfBSWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:43:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so2550524pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pApVEXJUMILHLOZAriI8qcA0BzbM6/0ceKJa7Oe14Xw=;
        b=nQcn58HaJIn+zUdtVolke6AId57tfgpL4hiX+/xPoj6Zgim1TqL0wls2jbAN+3SA1K
         O6m95/59o6BD5Q+J9QE4S3MjuOQeBEyNUTRVusp5jLsHEzg6w+1cpXXHZ4g5v4WrdvHu
         1MBXqv922EKdpac/2wSuDbdA3AFJv4d5OZDSt/tvEAtRv/WD0X3ZVnj3a5lnl4cdocUG
         /cYyIAU29BXy0zNzNtx+2hPzFIL5TzWog07f2/fs58Vdqy91yJqNzkkVgow54fEQICQk
         2/mK1wNeb9GUR5ZxUAFQIyLi2Zt+mJ1bRxOYCc/Fblxrs8wC5jAHRA2x6LcC9ofng7E0
         hIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pApVEXJUMILHLOZAriI8qcA0BzbM6/0ceKJa7Oe14Xw=;
        b=kIGMC4yLhYcevqBEcZAg3Byd0BboSJ6QOQ6LwK/Dy0BUnAGwrY+1MUUy4gQsy3Mn8v
         2OrQMlFVz1XHcU03C5IqPJV9t5EPkwYrU+4EqbaMX8NQyOdeRbbBAWjLbJ0lrOraHJzh
         zxRXvfBrdfRdxqa20FMvym7LWoy00uuEvMwleaHkZyjC+QnU5yfZg6DKDTtBzKetvW+o
         TL/r17XtM9mcbBvGg6FM/Ou8WlMJNFTz4jOkhTRSaCdyABnk3iITy5iMFRXaNjjcwsor
         ZHlX1knOkCZlMl36sgwyk71NbfhSJLlaybVncbwIWDWqmDddmnEUfqIvd2IyniCudns7
         Pr7g==
X-Gm-Message-State: AHQUAuYzCoJS9eFJDvrCKfmRvgVuE3VnvL0j71eITBM3epYY0FGoPagl
        9/DdY/0gVxg3UHh3p0sbBPGFaWqSWxN2i9F8EywLww==
X-Google-Smtp-Source: AHgI3IZ7wRXKKHAa/B1hNn63/JnB9QYXquA0c8HPUMqB1IdtFjm2sUROTF41Ejq8Gf8kTaKaXSbaswGi6iexxEO9Rew=
X-Received: by 2002:a62:e704:: with SMTP id s4mr31607789pfh.94.1550616195469;
 Tue, 19 Feb 2019 14:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <1550614664.6911.45.camel@lca.pw>
In-Reply-To: <1550614664.6911.45.camel@lca.pw>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Feb 2019 14:43:04 -0800
Message-ID: <CAKwvOdn+MJxYc+ykvyf-WhEzzDn0zEusjpQuksknnf8bPb=Q6g@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Qian Cai <cai@lca.pw>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Evgenii, Kostya for KASAN

On Tue, Feb 19, 2019 at 2:17 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2019-02-19 at 22:49 +0100, Arnd Bergmann wrote:
> > Building an arm64 allmodconfig kernel with clang results in over 140 warnings
> > about overly large stack frames, the worst ones being:
> >
> > drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size
> > of 20224 bytes in function 'st7789v_prepare'
> > drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12:
> > error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
> > drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes
> > in function 'max3421_spi_thread'
> > drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes
> > in function 'slic_ds26522_probe'
> > drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in
> > function 'ccp_run_cmd'
> > drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840
> > bytes in function 'stv0367ter_algo'
> >
> > None of these happen with gcc today, and almost all of these are the result
> > of a single known bug in llvm.  Hopefully it will eventually get fixed with
> > the
> > clang-9 release.

Would it be better to disable outright if CC_IS_CLANG, then go back
and adjust it once we know explicitly which version it lands in?
(Maybe I'm being too pessimistic about when it may be fixed).

> >
> > In the meantime, the best idea I have is to turn off asan-stack for clang-8
> > and earlier, so we can produce a kernel that is safe to run.
> >
> > I have posted three patches that address the frame overflow warnings that are
> > not addressed by turning off asan-stack, so in combination with this change,
> > we get much closer to a clean allmodconfig build, which in turn is necessary
> > to do meaningful build regression testing.
>
> Well, I am using clang 8.0 on arm64 and running the kernel just fine for a few
> weeks now and never trigger a single stack overflow (THREAD_SHIFT = 15) because
> I never use any of those drivers you mentioned above. I don't think it is a good
> idea to blankly remove the testing coverage here and affect people don't use all
> those offensive functions at all.

Thanks for the patch, Arnd!  Hopefully we can fix that up in Clang
soon.  Qian, I guess the alternative would be to add `-mllvm
-asan-stack=0` on potentially up to 140 Makefiles?

-- 
Thanks,
~Nick Desaulniers
