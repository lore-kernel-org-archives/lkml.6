Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80FF217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JKTqT2Ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeLROGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:06:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40196 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeLROGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:06:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so15728399oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=08qcU/paV60f68CKwP0K6iUIgv1ssi9UDah9m0cgFw0=;
        b=JKTqT2IrrdgWv8HD2n5ENP8PWzibXanHkd0kGEibc8aekkP7j0Vv4VS6Kjbk7S9V9D
         AasHpdw98CBgxNCtJs0ToaHGoTo55AgjqWBRNVOaO2dBZ/04gIgS0zHJCNS/pzM5BKkw
         Q5l5Gd1d2yhZ70pkgbJqL8Dq9CzHpRAi/XFQX3tyHPFig3hm7DbBOioeXEPXv7lSLVQ6
         DEyZqly0rwS2EPzNxRYHtRH80VgvW2JDW/tOqDZnamYDdD4xPKAAmbaoRWydpPVrm0sh
         I5C5xtrSsb278PDTFzEOLd3I80GJUYEEQjnt8OeVviCS3oZkEQC1NHlx/khViZhaetYd
         bFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=08qcU/paV60f68CKwP0K6iUIgv1ssi9UDah9m0cgFw0=;
        b=oSHnYGdyVH42PAC0IYhcucQecmAiD0G5TRbrb5vW9LzeTThkqPeKC1dL7xm+rboBPU
         j3saWLdM4L9VIWLsiJ+D7JsFwdgTxgP0j7ziAB33yRoSkIS34BRzVs9yVFdEdU+Cmr3k
         PUK2BcZNgb4BXG63tRdJRTCqn4wpEIuVMWakoxzZ57NuV748sqNUvq4/k0gzrZ7Y/QsX
         x2jKm2E3UOAbJtP10vadyKnfgu6Xrl7NFUJ050myXP+eabZmvf6sFJNR5sePkX7omuQE
         R8v000DcUViUYU6uxxopyPX7SUjS1jBsihgdJK4aVSndC9BP/TCXgp0HFn56+VgiaTdy
         3leA==
X-Gm-Message-State: AA+aEWZyhXge1PfA+kAF1KO5crB6ABpi7ARgRl31Ak2uD0FjwLXBW0kH
        U2xgzsD8I8uxEXqea3zR6aWrTh3ZVEz5uDkBcfz73g==
X-Google-Smtp-Source: AFSGD/WVqYiN+Q5ujUFpuUSjPbHw9PPAD1vnXDKqfNPkgs0LTpE9/ZKqZqFl3lLoLQ3m8xz2wuhzKGKq9wkEIDPfA3U=
X-Received: by 2002:a9d:22e2:: with SMTP id y89mr11799293ota.108.1545141980294;
 Tue, 18 Dec 2018 06:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20181217153652.20056-1-jank@cadence.com> <20181217153652.20056-3-jank@cadence.com>
 <CAMpxmJXrjyK3m4JwgkxwkHjSj-ugb7UzwNrYcBwYjWwj+JBNxw@mail.gmail.com>
 <CACRpkdYq5Eg2DrwdED-yTZ4kMoCxew+0rdU-b4zuinOf7BEr6Q@mail.gmail.com>
 <CAMpxmJUnfnHmopyOfHRZrN1KoqZx_Bsra1BTiGud6UVmzz1ryA@mail.gmail.com> <220ECBA7-CD30-4221-8878-0DA93390DDCC@global.cadence.com>
In-Reply-To: <220ECBA7-CD30-4221-8878-0DA93390DDCC@global.cadence.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 18 Dec 2018 15:06:09 +0100
Message-ID: <CAMpxmJX5ScpYCL0DhM99U=sbhU4VOxaA+gPzBJ698gs0-UFMxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
To:     Janek Kotas <jank@cadence.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 18 gru 2018 o 14:54 Janek Kotas <jank@cadence.com> napisa=C5=82(a):
>
>
> > On 18 Dec 2018, at 13:50, Bartosz Golaszewski <bgolaszewski@baylibre.co=
m> wrote:
> >
> >
> > pon., 17 gru 2018 o 23:22 Linus Walleij <linus.walleij@linaro.org> napi=
sa=C5=82(a):
> >>
> >> On Mon, Dec 17, 2018 at 4:51 PM Bartosz Golaszewski
> >> <bgolaszewski@baylibre.com> wrote:
> >>
> >>> The driver looks good but is there any particular reason not to use
> >>> regmap for register IO?
> >>
> >> I thought we only use regmap for MMIO when the register range is
> >> shared (as in a system controller) so that some registers are for this=
,
> >> some register or even bits in a register for some other driver, so the=
y
> >> need the spinlock in the regmap to protect the register range.
> >>
> >
> > This is what syscon is for. Regmap simply abstracts any register IO.
> > For instance: there's no locking in this driver. Are we sure it's not
> > needed? Regmap provides internal locking for you in the form of a
> > mutex or spinlock.
> >
> > Also: it looks like the interrupts here are quite simple with a single
> > bit per interrupt in the status register and the same layout in the
> > mask register - it could probably profit from using the
> > regmap_irq_chip and not bother with reimplementing irq_chip callbacks.
> >
> >> It is also nice for shadowing/caching of register contents I guess,
> >> wat does this driver get from regmap MMIO?
> >>
> >
> > Code shrinkage IMO.
> >
> > Note that I'm not blocking this from being merged - I just think that
> > using modern frameworks is always a good idea.
>
> I can reimplement the driver using regmap, but It seems in such case
> I won=E2=80=99t be able to use the Generic GPIO Infrastructure, would I?
> So I would need to provide functions for setting direction, etc.
> I think it would make the driver code bigger.
>

Indeed. If anything: gpio-mmio would need to be converted to using regmap.

So I guess nevermind my comment.

Bart
