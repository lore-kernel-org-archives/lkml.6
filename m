Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF56C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADAB2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGra0IY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADAB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbeIUSTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:19:13 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40400 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUSTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:19:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so11240579oig.7;
        Fri, 21 Sep 2018 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JD0C/xVL+zj8EEDuuU4RL25rciELr13+UwCgXOw96dc=;
        b=ZGra0IY8BJOlLoqVoE/EcWKWZIJNSSSvh38cTEVCW51pUzk4D3igZLE/wmEVBJ2cwt
         KqEqVl6OyQxZCvkhtUPE6HtSjP8LQ0usHWhcXEuks6dNgVbCnZbHW/cO5N3B223KWg89
         L46p4PVO7/qBYLuF+MlfRWjA0vDvTg8dG4oiKB68EodC/mIBOxxTuseOWrqbzKoDh6db
         GfnrhaQB69tFtRSai5No51Slds0hHnF9mcAZj/yAVtMxaKlcSAAuLbIcXVTMAjQNNqfa
         9R5zoL7rVs3h19Dor073MQd+4uhuU/9ym6d5Fe3c5zf0ZrUxHVho9uOUv/25nNYm2MBk
         Q8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JD0C/xVL+zj8EEDuuU4RL25rciELr13+UwCgXOw96dc=;
        b=F8WOPOEUShscOf3uGRcLhE7NoP8sTNeTJv9Jx5Eh2101zYhB0WXsZ32fSfpeYsMTeM
         bspCFb4WPCBTfYRLAeM/DKrSecRqJtvy6LohFakLNyghMjyMW/p9lDA5PbtaGTPiIgVG
         Sdk3u0JN8JmvtvF3Wi9dI9/4ANtej0TiAfXAPrihYNA8tJjg0UD5918IwWsdv/TbUps+
         ZJcEyKg2SEAHA5HJUttCW/nb9L4+p9/lPJhgwePtLPqI/CC0kP165B1p7UHebbsDszGa
         uRp2XFIMLPFFHyFcUQVKOSOdPJMU0JtTTKiAXzanPPBxn9AQocw0FlSMxO67VH8e/LjH
         M5sw==
X-Gm-Message-State: APzg51BaJBzjTLsdwWIyyiWyRo0/U/g0OvO0VZCeispjO2OAWa4BHYnF
        msSSg6jbjDMBvKtHhdbv0AeUhmycIX9bEEw07Tiw4rSk
X-Google-Smtp-Source: ANB0Vda65sHFKZ9nwXVtfJ8fcYwKlSKlt2Cul49ABdKY8weAv0h1Y6gktvPvZBG+Q5All95aFeZESJfPvwCo93bB5Po=
X-Received: by 2002:aca:b585:: with SMTP id e127-v6mr1369474oif.119.1537533032461;
 Fri, 21 Sep 2018 05:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180920175826.1284-1-linux.amoon@gmail.com> <CAJKOXPdsAK1_9JRzq7_pVfDwBK6WGkFbYUsbcsujCh31Fzsz6g@mail.gmail.com>
In-Reply-To: <CAJKOXPdsAK1_9JRzq7_pVfDwBK6WGkFbYUsbcsujCh31Fzsz6g@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 21 Sep 2018 18:00:18 +0530
Message-ID: <CANAwSgT-1pz-NQMb68F7m0rAFNkpCOyFqFPf7-HbZe+92+sPPQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/7] Add support for UHS-I on Exynos5422 odroid boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, 21 Sep 2018 at 16:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 20 Sep 2018 at 19:58, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > This is series v3 since my previous patches we incomplete with driver
> > changes missing.
> >
> > These changes add UHS-I tuning for dw_mmc-exynos driver.
> > Some new patches are added to enhance the performace.
>
> Patches look like based on some older version of kernel tree (or
> current mainline) and probably they will not apply on my tree. The
> easiest is to base on top of linux-next or, for DTS patches, on my
> next/dt branch.
>
> Best regards,
> Krzysztof
>
Yes this patch is based on current mainline.
I will try to re-base on your next/dt branch and resend them.

Best Regards
-Anand
> >
> > Anand Moon (7):
> >   ARM: dts: exynos5422: Added UHS-I bus speed support
> >   ARM: dts: exynos5422: fix regulator min values of LDO13 for Odroid
> >     XU3/XU4
> >   ARM: dts: exynos5422: update maximum frequency for sdcard to 200MHz
> >   ARM: dts: exynos5422: use cd-gpio method to detect sd-card
> >   ARM: dts: exynos5422: use wp-gpio method to detect sd-card
> >   ARM: dts: exynos5422: update maximum frequency for emmc to 200MHz
> >   mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
> >
> >  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 +++++++-
> >  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
> >  drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > --
> > 2.17.1
> >
