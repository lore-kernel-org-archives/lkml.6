Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52D9218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsrZo98r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfBGJIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:08:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40414 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBGJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:08:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so649603wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+jTkujky4AE5vc4xMQoKZMHg+3sbx8t0WyPCS7ve00M=;
        b=DsrZo98rfzwuZaDD06Px6Jn+g0bDVUU4Bii5BQisSz4Yrbmdm+hb4JvrFUm2acZ9Yj
         QdXBddg1dT4kWRHixCGCOwUW/Jyo6VQkUkLsITqLqblOsKqQzaqfU3uP3+cAYoUyKSOl
         Dbn0sbSnNsYOj0c0+9RkiZ91YKPtySWLcFLPOBdELt7zRaNODLKgWRej9sJ5heAcD11i
         /FGGUUAD6t1qb98AEj9dbNLabhluF5Bi7kWi5EXFg8yRQpapE0Mt/XePaHpqgVZF+4kx
         1FcB9qV/X2UnM/s9RzHai66a22VnES5A/7k8BqRgoGMDFV+dP9sPHjXruTT6n4u/IB2y
         i7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+jTkujky4AE5vc4xMQoKZMHg+3sbx8t0WyPCS7ve00M=;
        b=FgIogDQOG6vecKn2wl6ysoWEsbLE69YyABG0L+Abkq562fzA7sFwtphXl1plO5OdC1
         hr4fQnoTadPiSr+frawtUkIxRr5AtvaFjKk4i0Zlko4MPkWLCHhuWFXJwL+1k8D74bfS
         ZOyi2JdLa2i4nqti/Xs4KdHeONqAwBiXLQyxU6GcIgV0wDIf0Yg3O4L3GaJx/jdjM4iB
         zPjFQXI47q08kXsxme+qXVVc0+GP0NlbK0AG8SpW5LdFMXSsLmMnu8lqc491/2FWfaw4
         JWnCSbpW1SovLzpGDZXdcehTGlB2YrpIzRuvn6Q3pCdTcl6zqx00Ds0wuNILJ0H4tMSW
         BlvA==
X-Gm-Message-State: AHQUAubQV7M05tJLW+hsZf3NMtdHs97qVJiAvATxXrE4j1XNOWThTOkz
        YhTuAZYwlVHyGEx0ELjSCiQSdA==
X-Google-Smtp-Source: AHgI3IaUfJPR7k9AWINvkWdUBw/FGNg5qowLMllB4reECGa05XO60NWMhq57je1OXLyA6cwEKLbnzA==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr10886447wrv.116.1549530512402;
        Thu, 07 Feb 2019 01:08:32 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id 133sm28982022wme.9.2019.02.07.01.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 01:08:31 -0800 (PST)
Date:   Thu, 7 Feb 2019 09:08:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 1/6] mfd: mt6397: extract irq related code from core
 driver
Message-ID: <20190207090830.GG4672@dell>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548839891-20932-2-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Hsin-Hsiung Wang wrote:

> In order to support different types of irq design,
> we decide to add separate irq drivers for different
> design and keep mt6397 mfd core simple and reusable
> to all generations of PMICs so far.

Why have you cut these lines so short?

In all cases:

 s/irq/IRQ/
 s/mfd/MFD
 s/mt6397/MT6397/

> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/Makefile            |   2 +-
>  drivers/mfd/mt6397-core.c       | 235 +++++++---------------------------------
>  drivers/mfd/mt6397-irq.c        | 214 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h |  12 ++
>  4 files changed, 265 insertions(+), 198 deletions(-)
>  create mode 100644 drivers/mfd/mt6397-irq.c
> 
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4..088e249 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -230,7 +230,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
> -obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
> +obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o mt6397-irq.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 77b64bd..a72524d 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -12,23 +12,19 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/core.h>

> -#include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6323/core.h>
> -#include <linux/mfd/mt6397/registers.h>
> +#include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6397/registers.h>

I will ignore these unrelated changes!

>  #define MT6397_RTC_BASE		0xe000
>  #define MT6397_RTC_SIZE		0x3e
>  
> -#define MT6323_CID_CODE		0x23
> -#define MT6391_CID_CODE		0x91
> -#define MT6397_CID_CODE		0x97

CID_CODE is a bit cryptic.

Why not use *_CHIP_ID instead?

[...]

> +static const struct chip_data mt6323_core = {
> +	.cid_addr = MT6323_CID,
> +};

Does the chip ID address change from device to device?

If not, you can get rid of all of this hoop jumping.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
