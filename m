Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F7DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B9520661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQbYHXfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B9520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeLFLqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:46:08 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37309 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeLFLqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:46:06 -0500
Received: by mail-yb1-f196.google.com with SMTP id w129-v6so113543ybe.4;
        Thu, 06 Dec 2018 03:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZ7vRuJUscF0fXCaVSCS9+Svqzy+7bTV0nmdt5vlV3Q=;
        b=VQbYHXfRKfC0VL+1iBLCRUGMJ/BMHe8tApINf00LvHPOA1pBwkbtTQmLu9brr0eGTa
         9Hjf0T0XcH9EAJxzpwDymmdyGR4/aMu627aGWpztlcmS8AP4R7QzrKujZss2awW1YsAH
         QcdLNIGB0HGfKM51JayGukbqHg9sMSr2610sPTUd8FukO/+ENecOGh9aqo51EM7wV4TL
         fE4ujBl2vyfoKSEhuE83Qu5nI8+SXUkTzTPY2rK0s+6FdhePSCLOBxaPUt5fFPmE+5JA
         0ZXOuAZMGaMJ5bmbYudRtDDRHM28LB+/9i3fmTSHgEJ6yp8F47VO+28CPzd54ugly/Gc
         UJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZ7vRuJUscF0fXCaVSCS9+Svqzy+7bTV0nmdt5vlV3Q=;
        b=H8Fa75hGONBSoPvtXfsKBrA0j1phzQDnpLzMOKjizbGahiJVvrZC2BozI0I3tVLL4i
         DwiAOu2qvPWyDdXE2Py1fwTF6YP1+99aRhWHYQJktBT7A/5Bqo/1SD5ngWQr6dGotzN3
         HJ7H98+QFCjbuxFQV6Ux4OEO3ZblCnOqnKJW9yr34mKDr971WM+rIWsWJPQwVISB5eNC
         PjFsnBKQRK5G5maLeIpP0IXflQxV27t52xk5VEUnM24YUbSwccqxKR9Axgtzdu3CPTd0
         wpr2nDRHRbEvVqrBDPTqTuvBGVSDKVpP5KonyOfBdK76bDmj43paQc+NDApliY9mfxIR
         0Fjg==
X-Gm-Message-State: AA+aEWaeUsOwUsp+csp3hwdPUs33bqxNsTMW/zMpN1vPDeWkwXeLZruN
        EyrOghrWbaTa+sxptIA/9dPf6ueMqxiDLAjn5mk=
X-Google-Smtp-Source: AFSGD/WokPaxjAwy8hkuL6Qg8Wbl966PTFvlm4hVV8VyCaXpPTsi5hrLQ9Xtl/k4WPjQDd8tAeal6QcF8srfM2iLn9Q=
X-Received: by 2002:a81:60c4:: with SMTP id u187mr27516642ywb.345.1544096764951;
 Thu, 06 Dec 2018 03:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20181119104718.18716-1-peron.clem@gmail.com>
In-Reply-To: <20181119104718.18716-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 6 Dec 2018 12:45:54 +0100
Message-ID: <CAJiuCceQCGDY6hdPw50_=WyH-DaiAXTAmdy80FDHee8DTD5ywg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-audmux: complete dt-bindings for i.MX6
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org,
        Colin Didier <colin.didier@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle up,

Thanks
On Mon, 19 Nov 2018 at 11:47, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> From: Colin Didier <colin.didier@devialet.com>
>
> The i.MX6 audmux differs from i.MX51.
>
> This patch adds the audmux for i.MX6 family.
>
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>
> v2:
>         Repost with ASoC maintainer and list
>
>  include/dt-bindings/sound/fsl-imx-audmux.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bind=
ings/sound/fsl-imx-audmux.h
> index 15f138bebe16..a1d0741d9ed1 100644
> --- a/include/dt-bindings/sound/fsl-imx-audmux.h
> +++ b/include/dt-bindings/sound/fsl-imx-audmux.h
> @@ -25,6 +25,14 @@
>  #define MX51_AUDMUX_PORT6              5
>  #define MX51_AUDMUX_PORT7              6
>
> +#define MX6_AUDMUX_PORT1_SSI1          0
> +#define MX6_AUDMUX_PORT2_SSI2          1
> +#define MX6_AUDMUX_PORT3               2
> +#define MX6_AUDMUX_PORT4               3
> +#define MX6_AUDMUX_PORT5               4
> +#define MX6_AUDMUX_PORT6               5
> +#define MX6_AUDMUX_PORT7_SSI3          6
> +
>  /*
>   * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
>   * can be sourced from Rx/Tx.
> --
> 2.19.1
>
