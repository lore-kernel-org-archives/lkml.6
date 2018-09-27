Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B87C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A312F21570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wXhQ9+3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A312F21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeI0MpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeI0MpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:45:12 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B39A21580;
        Thu, 27 Sep 2018 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538029715;
        bh=EX3+w47XxVp8GJbAymlfb/3/t/vGkomTR7b5qBaKzkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wXhQ9+3SN++PgOlGw4V2/FppnvJ1bZoNDk6JbTkkIAt+O26wKIX9Gs3L9StSgO5Xr
         6lJCAqjILLhY1o0JRIUVoCzfl16THVLqMciior+KdsLLjvFLuPjKlnQCPoirPlhScn
         +zS7QSNJViXvl49OrtCz8ZMX62JVtMB0v7m7Gc2E=
Received: by mail-wm1-f48.google.com with SMTP id o2-v6so4635548wmh.5;
        Wed, 26 Sep 2018 23:28:35 -0700 (PDT)
X-Gm-Message-State: ABuFfoitrWUb3MNfFV6r+gk8+iBuBLgnhtbtLOb4LfOFbHZxcG0UxYI3
        PvPmptaXDDe+gzLyu+VwrFwonIxDyvhxixTt+3Q=
X-Google-Smtp-Source: ACcGV615mNtlw6BmNRf2YH9/cmSje+8EBmZwOMbWU89uG9xXjOptRUaXKf4WVxh6+Qt1ADXWoGGeTBdqZDEIoGmCVEc=
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr6477471wmg.67.1538029713718;
 Wed, 26 Sep 2018 23:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180922075238.884-1-linux.amoon@gmail.com> <20180922075238.884-6-linux.amoon@gmail.com>
 <20180926190639.GA6461@kozik-lap> <CANAwSgSPkKL3jaHHSkEhgocKT_Sq4zg3Z=+7d5889ttpnNPHDA@mail.gmail.com>
In-Reply-To: <CANAwSgSPkKL3jaHHSkEhgocKT_Sq4zg3Z=+7d5889ttpnNPHDA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 27 Sep 2018 08:28:22 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeRauojpS9kEbQK8k+BQLSGEHEVsAwi406tW3zN2RzPWQ@mail.gmail.com>
Message-ID: <CAJKOXPeRauojpS9kEbQK8k+BQLSGEHEVsAwi406tW3zN2RzPWQ@mail.gmail.com>
Subject: Re: [PATCHv4 4/6] ARM: dts: exynos: Add CD and WP pins to Odroid
 XU3/XU4 SD card
To:     linux.amoon@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 at 05:45, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Krzysztof,
> On Thu, 27 Sep 2018 at 00:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Sat, Sep 22, 2018 at 07:52:36AM +0000, Anand Moon wrote:
> > > Add the card-detect and write-protect GPIO pins for OdroidXU3/XU4
> > > SD card by adding pinctrl setting for wp-gpio pin and set it to
> > > active low.
> > >
> > > This also removes debug messages:
> > >     dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
> > >     dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
> > >
> > > Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > Fix the commit message and squash it with cd-gpios and wp-gpio
> > > patches into single patch as suggested by Krzysztof.
> >
> > As Marek pointed to my Odroid XU patch, there is no point of adding
> > cd-gpios and wp-gpios properties.
> >
> > Adding pin configuration for wp pin is also not needed. Reset values are
> > working properly. However there might be meaning of adding it just in
> > case - if bootloader decided to touch it...
> >
> > Best regards,
> > Krzysztof
> >
>
> Do I need to send the all the patches again or just resend this as per
> your patch for Odroid XU.
> with dropping the cd-gpios and wp-gpios changes.

I am fine with both (resend all or only this).

Best regards,
Krzysztof
