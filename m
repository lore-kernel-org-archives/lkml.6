Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957FBC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211AF20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYdVoDvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211AF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeJLVb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:31:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39951 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeJLVb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:31:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id b4-v6so13877274qtc.7;
        Fri, 12 Oct 2018 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwIDfMoO5x+BincI0WTcYxeasn706BRHFShHFWqdj/I=;
        b=dYdVoDvJj74kJDJSRvjubzMhk6yZNbHRakkqRLjkE+IcuT3dwZrYmDh8teu3XaDj9/
         iPXnx535aSqpt7C3RhZNUZcdCLfsxvVAiepEZ8Zu9A4ayGiWWbintX9+UzlPNaZ6/BpO
         +C01Megnk5iWVhQiDSaEtt4rTuYPY71sZPpR0ajZG1C0ry1zRK8yMazx1RRkSDYjsQd8
         jQtunO7b0PqkSPhuxmeqS8LC+3ERRnlH3TeSq835YK/f4eUfwHA+MNWFSPS2+bMopK0b
         P+20ReHdcRsMNt1LboJ+DHBwRlDTUmAz14+Dh4Bf0N43IFCm34xk8C+wkb25g+SakzBM
         DLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwIDfMoO5x+BincI0WTcYxeasn706BRHFShHFWqdj/I=;
        b=Uz+/jQ+/NI05lvk1Nh25DIS3+viE0YBow/+7etx1lYh2BzPqpuVZXFSI5U6UkD+3mD
         CzBolhFnasH3O5oD/2S0E/Qea/N6xnUjuEHkio8/m+wBhnMM/QBFQNrmD04P9mtcarz3
         7yptiNkd8WHjjqW5dYkNVtAmp/r6lMIQuzViVSlatZY6jzHkPSP5plZ6gwX97BvCqdD9
         m2rJXYReettEGM5vZhvygb/25KK1SayKd5bdPv8S0kjDdiuGwihwqq8azd62MP547oI5
         hRmbBrqn84KcuzB8ZUh3B2H84QinjIdFyn9mbi0HsfjaPE4v5/boJ8EujCuRXFWONqbs
         i6mA==
X-Gm-Message-State: ABuFfohZckqH4sGrFf7/CvloxT8QHEZU34u3TtGCRyTxA1ZQBHoVkBdK
        sFdfFnfRrw0ZHNiWqkPyQLV0c8MmI2LV8SN/Pjk=
X-Google-Smtp-Source: ACcGV61wlIjh4rFhoTqdZ62Q5vFKigeUzmEj2m3cqUi3x28gc+CFjCtjbLfG2UsZFBN0jP5Lom/sEd3S1Yuo55/QeSk=
X-Received: by 2002:ac8:6784:: with SMTP id b4-v6mr5819980qtp.373.1539352730925;
 Fri, 12 Oct 2018 06:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
 <20180906122436.25610-1-linus.walleij@linaro.org> <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com> <1539272073.18645.12.camel@toradex.com>
 <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
 <1539337415.30485.21.camel@toradex.com> <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
 <20181012104338.GS30658@n2100.armlinux.org.uk>
In-Reply-To: <20181012104338.GS30658@n2100.armlinux.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 Oct 2018 16:58:38 +0300
Message-ID: <CAHp75VecxqphJBZ2xUTku-WhyjkDRKQPbxvuGFAZ+-1voZRW9Q@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        jmondi <jacopo@jmondi.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>, philipp.zabel@gmail.com,
        linux-tegra@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 1:45 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Fri, Oct 12, 2018 at 11:39:15AM +0100, Jon Hunter wrote:
> > We had the same situation for Tegra124 Jetson TK1 but I don't think that
> > adding a pseudo intermediate regulator is cleaner. If the GPIO controls
> > more than one regulator, I don't see why is it necessary to change the
> > DT. There are several other people reporting the same problem with
> > various different boards. So this does seem to be a common usage.
>
> Given that DT describes the hardware, not the software implementation,
> it must not change just because we move from GPIO numbers to GPIO
> descriptors.
>
> The existing DT description is reasonable, and introducing ficticious
> regulators in DT to work around the implementation is not reasonable.

If there is no way to detect shared use of GPIO line for regulators
(*) from current DT description, DT description should be updated to
reflect, yes, hardware.

(*) Not familiar with the guts of DT descriptive language, don't know
if there are some ways to do a such without additional flags or so.

-- 
With Best Regards,
Andy Shevchenko
