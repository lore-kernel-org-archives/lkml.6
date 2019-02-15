Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB1C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1992A222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="p/0cvPHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfBOQVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:21:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53090 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfBOQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:21:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so10527378wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1vCuB7D2H4CusMBH+6UUBpcpQnoqa6rNuNJ4590MY4=;
        b=p/0cvPHCAtnvauKh9iPXyQdmglLyL41qFfb2TxNAfQZo3f14Y1jM9JjlowPG+/eu89
         SSBOhAlYC0Ej9WLW7wgHWsOWRzPIXvbc4iicB8995m1h5MLT5ZkvOXyS5cd8TGgXT6Sb
         5Xl4pOyRbT6ek2RokuPk+qd5eqjg8CWeb7ZiI66/EnGiGLxdKYx8b5j1X8hU/KtSFeti
         6HQTvQQ1a8D9b01KTnbu1hoRTi+b6Im+I2Kk5WS0Cqwgqx+LRsA+2q3UFjB5hVXdvZsO
         DIVLC+Ja8j+0ozRft23an67eP4AnWGIcuKXXQwS7D8EetmWiXJF9EoOE/XmAXX7GF0/1
         KvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1vCuB7D2H4CusMBH+6UUBpcpQnoqa6rNuNJ4590MY4=;
        b=FMvTLWJR8n+iSMqC3L9kIYapmKKhqP1RO2PdWBxtyG87216doKYRm5Kyxhjh90mro4
         rcEcQl9EivTwinByfbcghVHP9A0csj6TjeJfz0fqAD+NXhDASR7PATa3WbeDIP9sIGRo
         PfthHf2ehGrynL2gf5gGcHlo9ZCnYiagFoLNPsHRCznkgAOukbwTfmSJBnEK9AJrnWOH
         s3a6rfAh/igKKyaJDq8inY9u9jedK5cKJplHCuKiSEe237RyToQcePUt60VZHk9GbQMn
         4fs73T4+Qf1ZYMDIw9dJLDvdyfIQRKC3cqETKrT3LCI49kwHMVTVnJOr+5jsWSDuK1BY
         X+WA==
X-Gm-Message-State: AHQUAuYIA1E3sIK/sGLBZ22jiVlRIHFRK3VK9HPtLQhK07LLpfxLo9Vq
        MUpcFkNG05ZrY43J+zG2dM9AW2x30sBNrIfvGoNtdg==
X-Google-Smtp-Source: AHgI3IaaVw67O54WAUtFIX9I+RuK8eeog5f/93MTbeujoIdPcHprpr3xjAXprOKYjeaTU3L0g6/jNRibdSzgprDGxLg=
X-Received: by 2002:a1c:c904:: with SMTP id f4mr7568771wmb.42.1550247658897;
 Fri, 15 Feb 2019 08:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20190215115421.4811-1-axel.lin@ingics.com>
In-Reply-To: <20190215115421.4811-1-axel.lin@ingics.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 15 Feb 2019 08:20:48 -0800
Message-ID: <CAJ+vNU33mUS5WySjFAjUB=JhEQ6mfmN6h3vjydE1GcmEoBeDyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: ltc3676: Simplify .readable_reg and
 .writable_reg callbacks
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 3:54 AM Axel Lin <axel.lin@ingics.com> wrote:
>
> Use case range for continuous range to make the code shorter.
> The .readable_reg and .writable_reg implementation are exactly the same,
> so use a common ltc3676_readable_writeable_reg function instead.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/ltc3676.c | 63 +++----------------------------------
>  1 file changed, 5 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
> index 71fd0f2a4b76..549a1a243870 100644
> --- a/drivers/regulator/ltc3676.c
> +++ b/drivers/regulator/ltc3676.c
> @@ -241,61 +241,10 @@ static struct regulator_desc ltc3676_regulators[LTC3676_NUM_REGULATORS] = {
>         LTC3676_FIXED_REG(LDO4, ldo4, LDOB, 2),
>  };
>
> -static bool ltc3676_writeable_reg(struct device *dev, unsigned int reg)
> +static bool ltc3676_readable_writeable_reg(struct device *dev, unsigned int reg)
>  {
>         switch (reg) {
> -       case LTC3676_IRQSTAT:
> -       case LTC3676_BUCK1:
> -       case LTC3676_BUCK2:
> -       case LTC3676_BUCK3:
> -       case LTC3676_BUCK4:
> -       case LTC3676_LDOA:
> -       case LTC3676_LDOB:
> -       case LTC3676_SQD1:
> -       case LTC3676_SQD2:
> -       case LTC3676_CNTRL:
> -       case LTC3676_DVB1A:
> -       case LTC3676_DVB1B:
> -       case LTC3676_DVB2A:
> -       case LTC3676_DVB2B:
> -       case LTC3676_DVB3A:
> -       case LTC3676_DVB3B:
> -       case LTC3676_DVB4A:
> -       case LTC3676_DVB4B:
> -       case LTC3676_MSKIRQ:
> -       case LTC3676_MSKPG:
> -       case LTC3676_USER:
> -       case LTC3676_HRST:
> -       case LTC3676_CLIRQ:
> -               return true;
> -       }
> -       return false;
> -}
> -
> -static bool ltc3676_readable_reg(struct device *dev, unsigned int reg)
> -{
> -       switch (reg) {
> -       case LTC3676_IRQSTAT:
> -       case LTC3676_BUCK1:
> -       case LTC3676_BUCK2:
> -       case LTC3676_BUCK3:
> -       case LTC3676_BUCK4:
> -       case LTC3676_LDOA:
> -       case LTC3676_LDOB:
> -       case LTC3676_SQD1:
> -       case LTC3676_SQD2:
> -       case LTC3676_CNTRL:
> -       case LTC3676_DVB1A:
> -       case LTC3676_DVB1B:
> -       case LTC3676_DVB2A:
> -       case LTC3676_DVB2B:
> -       case LTC3676_DVB3A:
> -       case LTC3676_DVB3B:
> -       case LTC3676_DVB4A:
> -       case LTC3676_DVB4B:
> -       case LTC3676_MSKIRQ:
> -       case LTC3676_MSKPG:
> -       case LTC3676_USER:
> +       case LTC3676_BUCK1 ... LTC3676_IRQSTAT:
>         case LTC3676_HRST:
>         case LTC3676_CLIRQ:
>                 return true;
> @@ -306,9 +255,7 @@ static bool ltc3676_readable_reg(struct device *dev, unsigned int reg)
>  static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         switch (reg) {
> -       case LTC3676_IRQSTAT:
> -       case LTC3676_PGSTATL:
> -       case LTC3676_PGSTATRT:
> +       case LTC3676_IRQSTAT ... LTC3676_PGSTATRT:
>                 return true;
>         }
>         return false;
> @@ -317,8 +264,8 @@ static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
>  static const struct regmap_config ltc3676_regmap_config = {
>         .reg_bits = 8,
>         .val_bits = 8,
> -       .writeable_reg = ltc3676_writeable_reg,
> -       .readable_reg = ltc3676_readable_reg,
> +       .writeable_reg = ltc3676_readable_writeable_reg,
> +       .readable_reg = ltc3676_readable_writeable_reg,
>         .volatile_reg = ltc3676_volatile_reg,
>         .max_register = LTC3676_CLIRQ,
>         .use_single_read = true,
> --
> 2.17.1
>

Acked-by: Tim Harvey <tharvey@gateworks.com>

Tim
