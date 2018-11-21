Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A8BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589D72146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h7hjQsuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589D72146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeKUTZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:25:30 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34200 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeKUTZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:25:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so3914980oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ArGJLbtCwPhwjPL7JTYWaUDheD9J/FfGKkJ/gUvMjAs=;
        b=h7hjQsuOXw07C9whVQyX0IOV8A/vwXTIaRu/1cYhSBjz6lBnEQekZtH16nMat5lFxw
         pIP5T8IxlwmXLPYNw332CM7pSApW/gy0s3tRSqy2SSnFSJR9sMLYx8p5dWf7zRUWFI54
         LaNMf6ViOS/oguAQPMFRvaxNirEkxZrGDKXSojtknkNG2LpJG9RCs38MvxcDw7g44j99
         t/UrzEpc4j3Kag89qyCkjVRImfT8ciN2wNALz/3LIdki7onILdO74Abb7WNqYpVg6zgB
         7CeVCmqZQ8OBvgEOK2DbRSDX/DH450/Z49JMMe4ebaqxWyvFYbGe33/wCSA7gPOgFPFB
         tRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ArGJLbtCwPhwjPL7JTYWaUDheD9J/FfGKkJ/gUvMjAs=;
        b=IZs7K4huH1ZSm0bNxVEUHgjwzRoDpQx5QB/6SsDZ+suHwsxO/42hZqY4+jEltl/FhH
         gUJCLCivN9SRHyPPe0s5jkSlyZe+uaajJ+0TrQuEgOOv8H3KiThrCAwPfRBjqiRXL8nW
         mG8MnAqrNlqGw4DjZPUMrcwGh67Ew6hibTjYOInYPS1vf+hPeCDtdbz8h+aRothwk4jb
         MWCNvJXuEBik/KH38w+L65zVjSxTcQzofstFHH7PTKBpaH5PfrI4S/mhbzTKQ/zlLIhm
         WUpk8s+3FiP9mDgq/EuKPF8JF1MzkSUCu3ARbpKidVFoC8ksAZjgb3vsphKB88wXQ+Bt
         tRLA==
X-Gm-Message-State: AGRZ1gLYR+ZRIJSIbH7zgaVji1B6MJxT0AvGg8HCp0LQdeL19/f4MPVV
        5eTH+BFWDjWYu+caTyZ+FeFGTxf0ALjo32HJN8W8Yw==
X-Google-Smtp-Source: AJdET5dNiAqcR45vbU7awEH1t6+pZDTYQtkzCAUmZUomhdetGx2nu7aVlC8mVbv7uXof4gx1gKwPQH+1lPxwvbh9P/4=
X-Received: by 2002:aca:fd12:: with SMTP id b18-v6mr3235910oii.337.1542790312258;
 Wed, 21 Nov 2018 00:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20181113135051.15308-1-brgl@bgdev.pl> <20181113135051.15308-2-brgl@bgdev.pl>
 <c092b014-d5cf-f1ad-de91-6696b05cdf17@ti.com> <63ac671f-b202-2533-3878-af16149fbdbb@ti.com>
 <b30f6b76-52c1-89ca-dbf3-a4156d1fb55e@ti.com>
In-Reply-To: <b30f6b76-52c1-89ca-dbf3-a4156d1fb55e@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 21 Nov 2018 09:51:41 +0100
Message-ID: <CAMpxmJV8rEC5s4Mi-_3g_V1oojt_WpiRkB1RrCCYJGF+fiwYLA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: davinci: define gpio interrupts as separate resources
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     j-keerthy@ti.com, Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>, stable@vger.kernel.org,
        lokeshvutla@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 21 lis 2018 o 00:07 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 20/11/18 12:08 PM, J, KEERTHY wrote:
> >
> >
> > On 11/20/2018 2:22 AM, Sekhar Nori wrote:
> >> On 13/11/18 7:20 PM, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
> >>> IRQ numbering") the davinci GPIO driver fails to probe if we boot
> >>> in legacy mode from any of the board files. Since the driver now
> >>> expects every interrupt to be defined as a separate resource, split
> >>> the definition in devices-da8xx.c instead of having a single continuo=
us
> >>> interrupt range.
> >>>
> >>> Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ
> >>> numbering")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> There are a number of other boards that need such fixing too. And the
> >> commit in question does not do a good job of explaining why it was
> >> needed in the first place. The description  just repeats what can be
> >> inferred by reading the patch.
> >
> > Cc Lokesh
> >
> > Sekhar,
> >
> > DT explicitly mentions every IRQ number. The patch in discussion
> > explicitly calls platform_get_irq for all the interrupts which to me is
> > the right thing to do as: platform_get_irq-->
> > of_irq_get-->irq_create_of_mapping--> sequence is to be done for every =
IRQ.
> >
> > k3-am654 definitely will need explicit calls to platform_get_irq as it
> > will be involving interrupt router and interrupt numbers need not be
> > continuous.
> >
> > So i do not think reverting the patch is the right idea.
>
> Well, all of this description of patch motivation should have been in
> the patch description to begin with.
>
> Bartosz, can you please extend this patch to fix this problem for other
> DaVinci SoCs too? I am on the road this week, but will do my best to
> queue these fixes at the earliest .
>
> Thanks,
> Sekhar

Ok, to make it easier for you, I'll resend all the patches addressing
the GPIO issue.

Bart
