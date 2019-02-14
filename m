Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D08BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6853A2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QZi7V+Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438570AbfBNM4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:56:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37653 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbfBNM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:56:18 -0500
Received: by mail-it1-f195.google.com with SMTP id l131so14003299ita.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 04:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Naz9FCzf1rH5LzFaQw/O1btRmOdZ7nny+7TBXg4tchU=;
        b=QZi7V+FaORpgSTBl1SDpYJw1fLB9lo7PSNHv1iDB9VNCPRJ5DSftSdH/iK3BlC81YB
         Yc5qbMVnGYP35FQ6hOUD1rjr9ydZ8CErWyoIWH1/16DMHTMukZ0GbGnbSnJJzctTI6B6
         RSGtKu+9OnxpNDxLL1f96wHgRSGN0x0sflf6X4v41/WuJaEu/WVsnJAsnVX/UFMxSrX0
         SP8r3fAOVfrX60UeTzJc09KAKyXswvZmBeJPb2K5gw2TyFWKVaAxfmwqDkZCsAGTB7m4
         A9N59d8b8jRkVTDEy/7rb9KgJ4UiyFNk2/3ropa8MSeeQuKQ9yVvgHICDabYsCbLQK+r
         zrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Naz9FCzf1rH5LzFaQw/O1btRmOdZ7nny+7TBXg4tchU=;
        b=YpL9DGq5w/AA2dGbcVuyFLsRdBsI4taIvtHPmVD3Mxs/aYGoB4ULgvPTm3RTr456eE
         k17QXl841Ar56paV6F6TpIjlHOfi9orrjPWZRc06YJavPRPDqcN5PBNvjWwZsu/a2VjY
         V0l9kLXjGh+I/4RSl8e+iw+D3fGGtYpr/eFbp+3dV5DAql9K1ncEe1frcCZC3BxTO37E
         hf7y944cpFzLALAgIEs7iMRL1B9HGHJAE0MVk8UpC2R5aggo6fc4iYYFK200Ht108vdq
         t16kWvQzhvF6le0z1m0M8RbJRse0imCPseF7Yl3l6E7bvetKsjNegeAKLqAiCptZPxve
         9AVA==
X-Gm-Message-State: AHQUAuaX3iB5yYQ3aYxOak0YjgDtPdxcBPpdGsCGhfOLVPpU6O3BymOB
        HYoqCGUY4owl00mq5l3/Ej2egmWcp7u3qiSZD4Fzgg==
X-Google-Smtp-Source: AHgI3IZH6WSDvcG0nUPTCHoLLcxaePz6qJAANdijsV4E1HiC6aMrDz0xevkm5SyOGdLJEjIaaU45vbb1KhABg4wyXKs=
X-Received: by 2002:a24:9795:: with SMTP id k143mr1760175ite.74.1550148977354;
 Thu, 14 Feb 2019 04:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20190212103835.7768-1-brgl@bgdev.pl> <20190212103835.7768-21-brgl@bgdev.pl>
 <86mumyskmg.wl-marc.zyngier@arm.com> <28ca2198-ebe9-43b8-fcd6-c6dbd2939987@ti.com>
In-Reply-To: <28ca2198-ebe9-43b8-fcd6-c6dbd2939987@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Feb 2019 13:56:06 +0100
Message-ID: <CAMRc=Md+SPxKvHPz63SW84eSVopTesQ-MhX_yeQZ1OEserptLA@mail.gmail.com>
Subject: Re: [PATCH v3 20/37] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 14 lut 2019 o 13:44 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 14/02/19 4:27 PM, Marc Zyngier wrote:
> > On Tue, 12 Feb 2019 10:38:18 +0000,
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >>
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> I've been unable to figure out exactly why, but it seems that the
> >> IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
> >> level irq, not edge like all others.
> >>
> >> Let's move the handler setup out of the aintc driver where it's lived
> >> since the beginning and into the dm* SoC-specific files where it
> >> belongs.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >> ---
> >>  arch/arm/mach-davinci/dm355.c  | 8 ++++++++
> >>  arch/arm/mach-davinci/dm365.c  | 8 ++++++++
> >>  arch/arm/mach-davinci/dm644x.c | 8 ++++++++
> >>  arch/arm/mach-davinci/dm646x.c | 8 ++++++++
> >>  arch/arm/mach-davinci/irq.c    | 3 ---
> >>  5 files changed, 32 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm3=
55.c
> >> index c7cd765114af..a732f2ea1d9a 100644
> >> --- a/arch/arm/mach-davinci/dm355.c
> >> +++ b/arch/arm/mach-davinci/dm355.c
> >> @@ -15,6 +15,7 @@
> >>  #include <linux/dma-mapping.h>
> >>  #include <linux/dmaengine.h>
> >>  #include <linux/init.h>
> >> +#include <linux/irq.h>
> >>  #include <linux/irqchip/irq-davinci-aintc.h>
> >>  #include <linux/platform_data/edma.h>
> >>  #include <linux/platform_data/gpio-davinci.h>
> >> @@ -744,6 +745,13 @@ void __init dm355_init_time(void)
> >>      psc =3D ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
> >>      dm355_psc_init(NULL, psc);
> >>
> >> +    /*
> >> +     * Nobody knows why anymore, but this interrupt has been handled =
as
> >> +     * a level irq from the very beginning of davinci support in main=
line
> >> +     * linux.
> >> +     */
> >> +    irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_=
irq);
> >> +
> >
> > I've said it on v2, I'm repeating it on v3. There is no point in
> > duplicating this pointless hack on and on again. If there is a driver
> > using this interrupt, move the setup there, and fix the irq_set_type
> > callback.
> >
> > If nothing is using it, remove it altogether.
>
> Alright, fine with me as well. Dropping the hack is fine. And I think
> that just boils down to discarding this patch.
>

Actually this patch should simply remove the call to irq_set_handler()
from the driver.

Bart
