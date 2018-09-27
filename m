Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE27C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA87216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA87216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeI1CXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:23:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34664 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1CXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:23:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id 13-v6so3342192ois.1;
        Thu, 27 Sep 2018 13:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akTG7NIkA3DZ73BdkZXhwiFW3y+6ZJIZLJNRyRW5xmY=;
        b=nAPVlLRcZkr9fPkMULJU4bKOC3IE7rfFWkDR+ZhMnfgXmKMHFt7FPOWN8SFVnuEPWM
         PcSqfCxLzbpkkIasobuVqvd4TJX0jGcLW+YUbf7W8sJd6M/3kn3iDJx9rj1cxYaRP0/9
         f5HGEhYO8slOL+/k2WeqbRJS392f5sd69E3nEpOLO1EQLYqIeXo56kLkqmtxuaIH3csz
         nUmMmRpVBXKjuS9qzfjnC3MMughHAofZgJINq9l72tCP5DOYzwk5p5cNSCue6ziPsvtB
         +VqO/SqqRcJNgW6uk6nND5il0PriOHEljWBWWCUXj4j/Vq/DKw96OLd3J4mNXt+B0d44
         QpKg==
X-Gm-Message-State: ABuFfogt+P+y7QvC9PKgBk4yDa6MpR+SkwAn2akQBqFSbUa1Rwlx6MZx
        9xkDktXk2qnB4h8l3BIJ8dhTIyjB11o=
X-Google-Smtp-Source: ACcGV60yMiwGJW4tKr/tGbo1zQw17fS37UsA/eQ02eG6RMLbfcgHbESQV2EdMqf8LaMsQOEn+Zu1Qw==
X-Received: by 2002:aca:3787:: with SMTP id e129-v6mr4061296oia.39.1538078630800;
        Thu, 27 Sep 2018 13:03:50 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id c58-v6sm595117otd.77.2018.09.27.13.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:03:50 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id e18-v6so3795445oti.8;
        Thu, 27 Sep 2018 13:03:50 -0700 (PDT)
X-Received: by 2002:a9d:4b89:: with SMTP id k9-v6mr7827993otf.51.1538078629829;
 Thu, 27 Sep 2018 13:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com> <20180926132247.10971-9-laurentiu.tudor@nxp.com>
In-Reply-To: <20180926132247.10971-9-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 27 Sep 2018 15:03:38 -0500
X-Gmail-Original-Message-ID: <CADRPPNTD=SNpSqz=zoLyGP1tvh_xDr5E1NDHF_P0bcSPyx9X1A@mail.gmail.com>
Message-ID: <CADRPPNTD=SNpSqz=zoLyGP1tvh_xDr5E1NDHF_P0bcSPyx9X1A@mail.gmail.com>
Subject: Re: [PATCH v2 08/22] soc/fsl/qbman_portals: add APIs to retrieve the
 probing status
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
> Add a couple of new APIs to check the probing status of the required
> cpu bound qman and bman portals:
>  'int bman_portals_probed()' and 'int qman_portals_probed()'.
> They return the following values.
>  *  1 if qman/bman portals were all probed correctly
>  *  0 if qman/bman portals were not yet probed
>  * -1 if probing of qman/bman portals failed
> Drivers that use qman/bman portal driver services are required to use
> these APIs before calling any functions exported by these drivers or
> otherwise they will crash the kernel.
> First user will be the dpaa1 ethernet driver, coming in a subsequent
> patch.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_portal.c | 10 ++++++++++
>  drivers/soc/fsl/qbman/qman_portal.c | 10 ++++++++++
>  include/soc/fsl/bman.h              |  8 ++++++++
>  include/soc/fsl/qman.h              |  9 +++++++++
>  4 files changed, 37 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
> index f9edd28894fd..8048d35de8a2 100644
> --- a/drivers/soc/fsl/qbman/bman_portal.c
> +++ b/drivers/soc/fsl/qbman/bman_portal.c
> @@ -32,6 +32,7 @@
>
>  static struct bman_portal *affine_bportals[NR_CPUS];
>  static struct cpumask portal_cpus;
> +static int __bman_portals_probed;
>  /* protect bman global registers and global data shared among portals */
>  static DEFINE_SPINLOCK(bman_lock);
>
> @@ -85,6 +86,12 @@ static int bman_online_cpu(unsigned int cpu)
>         return 0;
>  }
>
> +int bman_portals_probed(void)
> +{
> +       return __bman_portals_probed;
> +}
> +EXPORT_SYMBOL_GPL(bman_portals_probed);
> +
>  static int bman_portal_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -148,6 +155,7 @@ static int bman_portal_probe(struct platform_device *pdev)
>         spin_lock(&bman_lock);
>         cpu = cpumask_next_zero(-1, &portal_cpus);
>         if (cpu >= nr_cpu_ids) {
> +               __bman_portals_probed = 1;

What if the last CPU is not used for portals?  Is there a hard
requirement that all CPUs need to be used for portal?  What happens if
the last CPU is offline?

>                 /* unassigned portal, skip init */
>                 spin_unlock(&bman_lock);
>                 return 0;
> @@ -173,6 +181,8 @@ static int bman_portal_probe(struct platform_device *pdev)
>  err_ioremap2:
>         memunmap(pcfg->addr_virt_ce);
>  err_ioremap1:
> +        __bman_portals_probed = 1;
> +

There are other error paths that not covered.

>         return -ENXIO;
>  }
>
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index eef93cab84f1..1b2fc981c269 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -39,6 +39,7 @@ EXPORT_SYMBOL(qman_dma_portal);
>  #define CONFIG_FSL_DPA_PIRQ_FAST  1
>
>  static struct cpumask portal_cpus;
> +static int __qman_portals_probed;
>  /* protect qman global registers and global data shared among portals */
>  static DEFINE_SPINLOCK(qman_lock);
>
> @@ -219,6 +220,12 @@ static int qman_online_cpu(unsigned int cpu)
>         return 0;
>  }
>
> +int qman_portals_probed(void)
> +{
> +       return __qman_portals_probed;
> +}
> +EXPORT_SYMBOL_GPL(qman_portals_probed);
> +
>  static int qman_portal_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -306,6 +313,7 @@ static int qman_portal_probe(struct platform_device *pdev)
>         spin_lock(&qman_lock);
>         cpu = cpumask_next_zero(-1, &portal_cpus);
>         if (cpu >= nr_cpu_ids) {
> +               __qman_portals_probed = 1;

Ditto.

>                 /* unassigned portal, skip init */
>                 spin_unlock(&qman_lock);
>                 return 0;
> @@ -336,6 +344,8 @@ static int qman_portal_probe(struct platform_device *pdev)
>  err_ioremap2:
>         memunmap(pcfg->addr_virt_ce);
>  err_ioremap1:
> +       __qman_portals_probed = -1;
> +

Ditto.

>         return -ENXIO;
>  }
>
> diff --git a/include/soc/fsl/bman.h b/include/soc/fsl/bman.h
> index 5b99cb2ea5ef..173e4049d963 100644
> --- a/include/soc/fsl/bman.h
> +++ b/include/soc/fsl/bman.h
> @@ -133,5 +133,13 @@ int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num);
>   * failed to probe or 0 if the bman driver did not probed yet.
>   */
>  int bman_is_probed(void);
> +/**
> + * bman_portals_probed - Check if all cpu bound bman portals are probed
> + *
> + * Returns 1 if all the required cpu bound bman portals successfully probed,
> + * -1 if probe errors appeared or 0 if the bman portals did not yet finished
> + * probing.
> + */
> +int bman_portals_probed(void);
>
>  #endif /* __FSL_BMAN_H */
> diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
> index 597783b8a3a0..7732e48081eb 100644
> --- a/include/soc/fsl/qman.h
> +++ b/include/soc/fsl/qman.h
> @@ -1194,4 +1194,13 @@ int qman_release_cgrid(u32 id);
>   */
>  int qman_is_probed(void);
>
> +/**
> + * qman_portals_probed - Check if all cpu bound qman portals are probed
> + *
> + * Returns 1 if all the required cpu bound qman portals successfully probed,
> + * -1 if probe errors appeared or 0 if the qman portals did not yet finished
> + * probing.
> + */
> +int qman_portals_probed(void);
> +
>  #endif /* __FSL_QMAN_H */
> --
> 2.17.1
>
