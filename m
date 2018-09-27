Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B04216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B04216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeI1C5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:57:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42283 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1C5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:57:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id w81-v6so1696492oiw.9;
        Thu, 27 Sep 2018 13:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cf0+7Yp4KoIx4DGERHsWqP/XVQWTN0lHmTCyv+/Kt74=;
        b=Iizaa3KNIU/mJP93UXA/q8kgxOogWd/g83QmPs6oBt14wsUC1i6PCUcib/OrfFzZdm
         ccu474BR3g0rJpxOSJBZX/egy0W2ptYEv+iKhq5uvHXTugHr2sPdUvndg9kspLFwB0c+
         tD3lzplX+CJ34O7JazGXiFSr5zujDIx+NCvNXw03vIJaNTz4rM7VZEYqoggozYxDOQMF
         OzHK6+VdoKGwt+ZAbJbKlQO81IqGT5fruXPCqn/VWRg7JCCpjFOz0+aGxL13ml/zvldm
         PT2VcmTwRg7W0vVMiaeY+3wFBZlt8q9K3guftKNHVHNBLpkBoOSEU27qrgIlL0ZQdui3
         GMMw==
X-Gm-Message-State: ABuFfogp0obEeGeN5idjeWkU8HeeFyTKjYlFmz8WdpU+WkPO738D1YmJ
        KsIWJ1GW/lOaQ8XeyztODCmUcgMtwHA=
X-Google-Smtp-Source: ACcGV619z9fT1WAgJFzEDRV7NysMulQTtSOFfCGxr2kDKVSKEweTGG3P9tNHwb1XFaAmcIhC+noVtQ==
X-Received: by 2002:aca:49c8:: with SMTP id w191-v6mr3914806oia.114.1538080637430;
        Thu, 27 Sep 2018 13:37:17 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1634187otd.21.2018.09.27.13.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:37:17 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id q4-v6so3862619otf.13;
        Thu, 27 Sep 2018 13:37:16 -0700 (PDT)
X-Received: by 2002:a9d:3c1d:: with SMTP id q29-v6mr8216060otc.158.1538080636585;
 Thu, 27 Sep 2018 13:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com> <20180926132247.10971-6-laurentiu.tudor@nxp.com>
In-Reply-To: <20180926132247.10971-6-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 27 Sep 2018 15:37:05 -0500
X-Gmail-Original-Message-ID: <CADRPPNQCAs61R-2bLQDEO2ooDMHeVt2jJq8nh4rUNZk3jhDwGA@mail.gmail.com>
Message-ID: <CADRPPNQCAs61R-2bLQDEO2ooDMHeVt2jJq8nh4rUNZk3jhDwGA@mail.gmail.com>
Subject: Re: [PATCH v2 05/22] soc/fsl/qbman: add APIs to retrieve the probing status
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Roy Pledge <roy.pledge@nxp.com>, madalin.bucur@nxp.com,
        David Miller <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>, robin.murphy@arm.com,
        bharat.bhushan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 8:26 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Add a couple of new APIs to check the probing status of qman and bman:
>  'int bman_is_probed()' and 'int qman_is_probed()'.
> They return the following values.
>  *  1 if qman/bman were probed correctly
>  *  0 if qman/bman were not yet probed
>  * -1 if probing of qman/bman failed
> Drivers that use qman/bman driver services are required to use these
> APIs before calling any functions exported by qman or bman drivers
> or otherwise they will crash the kernel.
> The APIs will be used in the following couple of qbman portal patches
> and later in the series in the dpaa1 ethernet driver.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

As this is part of a bug fix for v4.19, applied on soc/fsl for fix.

> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
>  drivers/soc/fsl/qbman/qman_ccsr.c | 11 +++++++++++
>  include/soc/fsl/bman.h            |  8 ++++++++
>  include/soc/fsl/qman.h            |  8 ++++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index d180da003e4a..b209c79511bb 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -121,6 +121,7 @@ static void bm_set_memory(u64 ba, u32 size)
>   */
>  static dma_addr_t fbpr_a;
>  static size_t fbpr_sz;
> +static int __bman_probed;
>
>  static int bman_fbpr(struct reserved_mem *rmem)
>  {
> @@ -167,6 +168,12 @@ static irqreturn_t bman_isr(int irq, void *ptr)
>         return IRQ_HANDLED;
>  }
>
> +int bman_is_probed(void)
> +{
> +       return __bman_probed;
> +}
> +EXPORT_SYMBOL_GPL(bman_is_probed);
> +
>  static int fsl_bman_probe(struct platform_device *pdev)
>  {
>         int ret, err_irq;
> @@ -177,6 +184,8 @@ static int fsl_bman_probe(struct platform_device *pdev)
>         u16 id, bm_pool_cnt;
>         u8 major, minor;
>
> +       __bman_probed = -1;
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res) {
>                 dev_err(dev, "Can't get %pOF property 'IORESOURCE_MEM'\n",
> @@ -266,6 +275,8 @@ static int fsl_bman_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       __bman_probed = 1;
> +
>         return 0;
>  };
>
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 0cfe79f85a66..383a49dcce68 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -274,6 +274,7 @@ static const struct qman_error_info_mdata error_mdata[] = {
>  static u32 __iomem *qm_ccsr_start;
>  /* A SDQCR mask comprising all the available/visible pool channels */
>  static u32 qm_pools_sdqcr;
> +static int __qman_probed;
>
>  static inline u32 qm_ccsr_in(u32 offset)
>  {
> @@ -689,6 +690,12 @@ static int qman_resource_init(struct device *dev)
>         return 0;
>  }
>
> +int qman_is_probed(void)
> +{
> +       return __qman_probed;
> +}
> +EXPORT_SYMBOL_GPL(qman_is_probed);
> +
>  static int fsl_qman_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -699,6 +706,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
>         u16 id;
>         u8 major, minor;
>
> +       __qman_probed = -1;
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res) {
>                 dev_err(dev, "Can't get %pOF property 'IORESOURCE_MEM'\n",
> @@ -845,6 +854,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       __qman_probed = 1;
> +
>         return 0;
>  }
>
> diff --git a/include/soc/fsl/bman.h b/include/soc/fsl/bman.h
> index eaaf56df4086..5b99cb2ea5ef 100644
> --- a/include/soc/fsl/bman.h
> +++ b/include/soc/fsl/bman.h
> @@ -126,4 +126,12 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num);
>   */
>  int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num);
>
> +/**
> + * bman_is_probed - Check if bman is probed
> + *
> + * Returns 1 if the bman driver successfully probed, -1 if the bman driver
> + * failed to probe or 0 if the bman driver did not probed yet.
> + */
> +int bman_is_probed(void);
> +
>  #endif /* __FSL_BMAN_H */
> diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
> index d4dfefdee6c1..597783b8a3a0 100644
> --- a/include/soc/fsl/qman.h
> +++ b/include/soc/fsl/qman.h
> @@ -1186,4 +1186,12 @@ int qman_alloc_cgrid_range(u32 *result, u32 count);
>   */
>  int qman_release_cgrid(u32 id);
>
> +/**
> + * qman_is_probed - Check if qman is probed
> + *
> + * Returns 1 if the qman driver successfully probed, -1 if the qman driver
> + * failed to probe or 0 if the qman driver did not probed yet.
> + */
> +int qman_is_probed(void);
> +
>  #endif /* __FSL_QMAN_H */
> --
> 2.17.1
>
