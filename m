Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47E0C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4C320820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfBDR7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:59:14 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38534 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfBDR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:59:12 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so492296vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJYrRa7k92kG+uvtxNHFZ8rf1xqRnJKTb5tJ9bainTM=;
        b=jJVc9k2ZzPAPELwYAROr7Rn1UQ85UdwSLFFj0CO4aci+pMGryxAj1WFaNIW2kd6rre
         iYXLP/scp4asDu28UKZ7XCCFY9BDdNsPqxqAD1DTxogLvOwGbIn5nWB5IObPVnM92OqC
         oO17GUyjePTg1lLD0hqTSI30JdiT2Fl1S/4JFPuDPcddV0//ovjVgWD+Biv22H7zML/t
         kr9eOUiybgrnA24ROAhonEyp6DzuRxlcmP1OE2V7hQWdUDeidasrG2hBUbqYqCqN5Ozj
         0kPR3a5o1nZnxhPggbR7rrNMNDJKt6Vd6OHi3ViIMtBHwPJQKY0E+1ZE04yC/caFojBW
         toew==
X-Gm-Message-State: AHQUAuakK0TvFCO8nJ3sJ7pt5uwkwN6F92b4DIWgehTwsApga4i2C4Ur
        +yygyTao+9+Hdv9QnAe57YnKIDu/UhfddbC1qG8=
X-Google-Smtp-Source: AHgI3IYqDfyK0SfqwcVwUHHnKChztUayoWfcknyGRIqLj+7xTPqZ50FMUcC7IOk2xISn1HdY88HtkKEmhw6tqyj7tb8=
X-Received: by 2002:a67:c202:: with SMTP id i2mr269044vsj.11.1549303150050;
 Mon, 04 Feb 2019 09:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20190204134234.13636-1-geert@linux-m68k.org> <33e58393-97f1-321e-5ee0-a1242c7c7a26@infradead.org>
 <5ccff302-3986-5892-d072-5c334484f990@infradead.org>
In-Reply-To: <5ccff302-3986-5892-d072-5c334484f990@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Feb 2019 18:58:57 +0100
Message-ID: <CAMuHMdUAVYd2922rDiLQSw-jMzK9g=7G20W3erV8d3J5oorbtQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.0-rc5
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Feb 4, 2019 at 6:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/4/19 9:46 AM, Randy Dunlap wrote:
> > On 2/4/19 5:42 AM, Geert Uytterhoeven wrote:
> >> Below is the list of build error/warning regressions/improvements in
> >> v5.0-rc5[1] compared to v4.20[2].
> >>
> >> Summarized:
> >>   - build errors: +2/-4
> >>   - build warnings: +113/-14843
> >>
> >> JFYI, when comparing v5.0-rc5[1] to v5.0-rc4[3], the summaries are:
> >>   - build errors: +0/-0
> >>   - build warnings: +56/-59
> >>
> >> Note that there may be false regressions, as some logs are incomplete.
> >> Still, they're build errors/warnings.
> >>
> >> Happy fixing! ;-)
> >>
> >> Thanks to the linux-next team for providing the build service.
> >>
> >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8834f5600cf3c8db365e18a3d5cac2c2780c81e5/ (238 out of 240 configs)
> >> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)
> >> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f17b5f06cb92ef2250513a1e154c47b78df07d40/ (238 out of 240 configs)
> >>
> >>
> >>
> >> *** WARNINGS ***
> >>
> >> 113 warning regressions:
> >
> >>   + warning: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS:  => N/A
> >
> > I am trying to find the above warning (needle) in the haystack.
> > Can you please direct me to which config/build it is in?
> >
> > Is there a good way for me to find it?
>
> Working backwards, it probably comes from this:
>
> config CURRITUCK
>         bool "IBM Currituck (476fpe) Support"
>         depends on PPC_47x
>         select SWIOTLB
>         select 476FPE
>         select PPC4xx_PCI_EXPRESS

powerpc-gcc4.6/44x/currituck_defconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
