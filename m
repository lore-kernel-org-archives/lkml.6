Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148D4C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7312084D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqlf7rRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7312084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeH2A0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:26:45 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35407 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeH2A0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:26:43 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so2617452iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EobDtR1uPWrga1kvJ9twVi4bia4L5yU3pbNaSwQR/0Y=;
        b=aqlf7rRieYt88ozUU1xNpqApljNMNHgjx9I9/KRgg5T7x5y0bVx71lsKb31qhMdpNh
         azvm8/zC/rIvi8AtFxQpPwZxk9Qscez6VVodu1i9/RZDQ0sHyWXbYYpEjKcVECHbJaMJ
         3stlz57uImrXEMzzhuYm1inAGN5KSAEHbyECmw7u0z96nBXMxt3ec2hvr1IQ/4kCOX9V
         HKx2v2W0X0BTRN2OEAxzybs/3tI5wPN2i4KcQLvunOdBCURfW9l5xuKJdSk0dubCGIsa
         Axq8Q4oR6hkUsBUMVq4Uc3GZjmxTBdcHrSpuIorDjPWJhfPCwRWLlOxr92bWQJEnChcP
         g5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EobDtR1uPWrga1kvJ9twVi4bia4L5yU3pbNaSwQR/0Y=;
        b=XYijtOb24f2s960U6CB1eZUJh/5tnxpJy48Jb+CXixS3EahytlH12aI52yRtkckTMS
         CaAN2/J6q5wmtz9ctsvJk3Gx7tqL7QMJm1bcpbpHeKKb3FGVmY4vAtB/ZH+e7zLjtbAZ
         OLu7IbggOqbapT7p2kEdC9mRjTXUyD/Achtr9wOsow9Bux2sKvQQ2n9QhFr9Q0i6ZHpS
         5cVWoG256VVKoPeBY/d00vwk1jIzTIGDZkpjwTpQk0W/Crkj/29Wvo/Fv4c2l25j/XB1
         ieUKQR55RWgP3RAwAMxW8jqbsUoNUWJWMTroE0gNRxk6lVV9HiCzzHWILyVJQWmNpOf+
         D5HA==
X-Gm-Message-State: APzg51D98s0vG9U8jrtsjCeGZnfLTt1QyKtnnau08RhtDWh5UBiXA0Ma
        DypbNRiQ/nMdnaDVSg2qnLsIAF4Vqw1NdOiylH0=
X-Google-Smtp-Source: ANB0VdbCudw8AT2HAlt0/qGHQlDg4CruiWjROvE6OOoEZcid4+bf+zA66QseiA5d7TWrxhXRrTsHJutm4R5hhNpRp/o=
X-Received: by 2002:a6b:9d95:: with SMTP id g143-v6mr2931726ioe.46.1535488404142;
 Tue, 28 Aug 2018 13:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <1535486560-16267-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1535486560-16267-1-git-send-email-festevam@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 28 Aug 2018 13:33:12 -0700
Message-ID: <CAFXsbZrWjoSxD4CTaX10mAKMq5O=ik3jvO9crD6qh7rbs5-Mhg@mail.gmail.com>
Subject: Re: [PATCH] mfd: mc13xxx-core: Fix PMIC shutdown when reading ADC values
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        u.kleine-koenig@pengutronix.de,
        "andrey.gusakov@cogente..." <andrey.gusakov@cogentembedded.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on a i.MX51 platform with rev 2.4 PMIC silicon.  System reboots
without the patch.  System works correctly with the patch in place and
reports a sane temperature.

Tested-by: Chris Healy <cphealy@gmail.com>
On Tue, Aug 28, 2018 at 1:02 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> When trying to read any MC13892 ADC channel on a imx51-babbage board:
>
> # cat /sys/class/hwmon/hwmon0/device/in7_input
>
> The MC13892 PMIC shutdowns completely.
>
> After debugging this issue and comparing the MC13892 and MC13783
> initializations done in the vendor kernel, it was noticed that the
> CHRGRAWDIV bit of the ADC0 register was not being set.
>
> This bit is set by default after power on, but the driver was
> clearing it.
>
> After setting this bit it is possible to read the ADC values correctly.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/mfd/mc13xxx-core.c  | 3 ++-
>  include/linux/mfd/mc13xxx.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index c63e331..f475e84 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -276,7 +276,8 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>
>         mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
>
> -       adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
> +       adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
> +              MC13XXX_ADC0_CHRGRAWDIV;
>         adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
>
>         /*
> diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
> index 54a3cd8..2ad9bdc 100644
> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -249,6 +249,7 @@ struct mc13xxx_platform_data {
>  #define MC13XXX_ADC0_TSMOD0            (1 << 12)
>  #define MC13XXX_ADC0_TSMOD1            (1 << 13)
>  #define MC13XXX_ADC0_TSMOD2            (1 << 14)
> +#define MC13XXX_ADC0_CHRGRAWDIV                (1 << 15)
>  #define MC13XXX_ADC0_ADINC1            (1 << 16)
>  #define MC13XXX_ADC0_ADINC2            (1 << 17)
>
> --
> 2.7.4
>
