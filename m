Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4777120855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfARH5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:57:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36958 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfARH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:57:41 -0500
Received: by mail-vs1-f65.google.com with SMTP id n13so7923488vsk.4;
        Thu, 17 Jan 2019 23:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2etTsr6eABn9rr4OAtp4qwGzvi48gpko/JR6dDrfj6U=;
        b=uJnGAruL4XXvbWGzQweFaR8Q5hM7uR/073dmqFJSymM8bXBiC7QplGcjClvlE7evlu
         1NcziqP2dJpjEyxhCcD2+OgXlvxrW2w2LjFHu+3NoyrVwFaidv3aWiqixQbM3xOdhgwS
         n5GuLDQIj6OubnbPt2pirRsQq/4X7JsBYbR+DtNA8g7XenxZTHbbL8tiPaHGauxdQBD2
         pHEdkIw55CmOttrBi3gd6pEB4Y5gFc/wLtt+ULTtGSdVZ+9rs7BNQ5W9oRLM2vd1xzvr
         NQjw2fdqm6m+E/YkTwdkps54T91W5K2IQ8ocHEBzmNRU6qE2Xpu3ZBBS+wqtgybUJIE0
         9wUA==
X-Gm-Message-State: AJcUukcGnMbbAZ96VtCCoSfMB3kBtXMiZKxP4rNphkbqhk5GyHK4lzdj
        EpkP+YyXD+RxhGclD2rAb28O4nkB1318nP7abok=
X-Google-Smtp-Source: ALg8bN6tQccVpfMr2BeJmL6Uah6hNrTBtHaqVDmuLqfUFD8RHIVJDKP8qS+SP3yy8L28QJjI4FSdcQyCCnOgKGKPB5c=
X-Received: by 2002:a67:d119:: with SMTP id u25mr6703849vsi.63.1547798260103;
 Thu, 17 Jan 2019 23:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20190114135144.26096-1-geert+renesas@glider.be> <CAK7LNASdA+5_pdTjr1dY-cKGSDq804Huc_CX_8-Gg+ypFCmajQ@mail.gmail.com>
In-Reply-To: <CAK7LNASdA+5_pdTjr1dY-cKGSDq804Huc_CX_8-Gg+ypFCmajQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Jan 2019 08:57:27 +0100
Message-ID: <CAMuHMdWGbJwWXMK7f10n2zPSiMEj7EHJfiK0Pj4ABHHu3f4sdw@mail.gmail.com>
Subject: Re: [PATCH 00/12] selftests: Miscellaneous fixes
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Shuah Khan <shuah@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Fri, Jan 18, 2019 at 5:15 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Mon, Jan 14, 2019 at 10:52 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This patch series contains several build fixes and cleanups for issues I
> > encountered when trying to cross-build an rtctest binary in a separate
> > output directory (like I use for all my kernel builds).
>
> Geert,
> Thanks for working on this!
>
> My fundamental question is,
> why did tools/ opt out Kbuild?

Good question.  I think it originally started as a separate small project.

> I think lots of mess comes in
> in order to support
>   cd tools/gpio; make
>
> instead of
>
>   make tools/gpio/
>
> Lots of files are duplicated in tools/build/
> in order to invent a different build system for tools/

I agree switching to kbuild would be the best solution.
Unfortunately my kbuild foo is not strong enough...

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
