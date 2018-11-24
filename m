Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E03AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0982086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC5Od98w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0982086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeKXTB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:01:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45568 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeKXTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 14:01:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so12364979ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 00:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXTlpUKfTDngNNnxSxdLA+oO+uAYUyyIwYbR1zytSQE=;
        b=TC5Od98wfdmfa1LU42rlmgtSE1W60RPnSJ56PBBO3s6m252gx1tUFFLcgdEZrtbVaU
         2dxWs5XK8vP8AH25pbX/R0H9GGdfepivZ/lal30OGVxtULiKn1umrOcqOR5KGLYVfHny
         sk9yDDsc7o7mbLnpSVhEnyMWBBWrC4GfcHT8dSE2cZPhAg0IritXziLOWYsoI9TNlNo1
         P19vR5M8H0kCglmQPvl7umOZfmCOfzJlwqcvkOaQDD8iZsbfeW6gdFeGFdAvv3K6MS9q
         jOTGCKe/qbAcpzJhEfZqaOrXv2OGy1Bwc+HIZun5P8RSW2zj0uw61gkbvsx54SJCS8Ig
         6tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXTlpUKfTDngNNnxSxdLA+oO+uAYUyyIwYbR1zytSQE=;
        b=k+eAQ7MN9DWiNyj2rHeACR4SkXsEr0p5Rty+SnmU/KsuMCpbhftM6KBkHlA3fSp0jr
         F4sCyXgxXY4/X1InRlnNoHZqCFehUXGpf6naQ7ucu8GzI/RkyyjGiImWQT0xeRybjm8d
         N8GbmxVG1gPiPnPR6utW5JeqM1+V9x/jzz5l4iS1KkzJVwRuIbI/G9iKMVWQH/SedGwM
         dSvz4UF/nm+PaLYA2ILG4nMmg0X6YWwJD9DWihttKJuEzGABQ0lFpGxVVIu9+ngGGVzV
         S3Hqa/+xkcWtkGE6VAQq2tScrYBGW+TBeqovDipPz4D1aFVn/EVdFiLaOJPnXcxVLsY1
         yqbg==
X-Gm-Message-State: AA+aEWZOCakxEdO9VGrczTO8k5FFHob2nFFj9cBkAhoxAgouOvw3u0zU
        HpuxTTvy9GQ1QJucsYI9iSXMSVo1dLHf0SqCig4=
X-Google-Smtp-Source: AFSGD/W0OMfVxG8tY4wjJfU4Tz44uy9xkUIaNM7ffcbFn0xEraAJoLdOwpPWpcbGPgZ+RT41hLrFx3KTVvcjh7DFpzc=
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr11680495ljd.45.1543047254684;
 Sat, 24 Nov 2018 00:14:14 -0800 (PST)
MIME-Version: 1.0
References: <1542349141-7229-1-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jJn5xRW6EqnULVESy1UZKjzxrxRAcHb412smtjoTVmsEQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJn5xRW6EqnULVESy1UZKjzxrxRAcHb412smtjoTVmsEQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 24 Nov 2018 09:14:03 +0100
Message-ID: <CANiq72kBpMG8kO+OQT_2TV7-=fU1Xifh6rtrhqDrO3Hjx-rqdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] build_bug.h: remove negative-array fallback for BUILD_BUG_ON()
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 8:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 16, 2018 at 12:19 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > The kernel can only be compiled with an optimization option (-O2, -Os,
> > or the currently proposed -Og). Hence, __OPTIMIZE__ is always defined
> > in the kernel source.
> >
> > A fallback for -O0 case is just hypothetical and pointless. Moreover,
> > commit 0bb95f80a38f ("Makefile: Globally enable VLA warning") enabled
> > -Wvla warning. The use of variable length arrays is banned.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Kees Cook <keescook@chromium.org>

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
