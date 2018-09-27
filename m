Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87B4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE522159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFeZzvxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE522159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeI0Xgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:36:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45605 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeI0Xgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:36:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23-v6so2345270pfi.12;
        Thu, 27 Sep 2018 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKAA2VAC84n6TIbznCwucmmAyO2Kyz4CN/fhDSqX+oA=;
        b=gFeZzvxZElzMMeojUb3Xe6yh2D2bdsNI9TRrvoerbUm88Z5OqCvYN6xg9yV+EQIUSW
         qiU5IQ95daEwnXgo4VcMEkKndR4LpHjcIWqlotsBD9UQL+U8Q0ITgLVTpxe9BJuUiLbo
         +w3Vk09tX2Lfup/sGaJj8c5veKTPzIvlj8HTlMAOdPONaDmRJrhs6S7+MlQYTf4pWa8k
         60sIovFbLE3cp9fnsVFPmH7/FMrruK1H7gdLGMQ+k6Olu18r+AF2eBV2lrekrdoBBr7B
         hq2SDCQ2wIgjKeEV71HPbydIOoN5Hn0YNMxs0rgpq07yoQuW6do3ZFpaZTcyRYiWmRod
         LCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKAA2VAC84n6TIbznCwucmmAyO2Kyz4CN/fhDSqX+oA=;
        b=Y2/tIaHrcWMYS/lz/QdS7OrNFGYYholbAbuhEeiLbukvt0qYhvntCKbuNdZ+T1nd48
         OOkT/MTkKCfexrepdqWS3qNd6ugSKjBrbaJ8EUt1Gs1HgMImPtsMT1SfLwEkiD27PJq8
         3s6/dkMLm4tjp+ZvuoCXsrd807vdJnYh9zKXJNiueDhbIBRpOsxSMa46oml1kA2Lv4QV
         tFZuREWO6Mv55Q3X/dXUWg2yafv17Z1MWHfMOPWLSt94DxeVV38GeANVYkObuLfvovIx
         dML3l0elyuI/VjoorLjZYPdv35veo2cZoy0iFLbBIuQmcUdKvG4qQK+mjOUuWmzAEiPk
         mRYg==
X-Gm-Message-State: ABuFfohWAqNdU073EjCiZiqGTt819v+LT+ZnliTQyB82L5JFWDn2ceUy
        adivLCqiIdcNVCars2TppVOahJ8Z8ejS1yjzicQ=
X-Google-Smtp-Source: ACcGV61yhPstkYMAhMjQUhA3SQ4sLQUFkfUUeW7xs5IFrxLZzMLMH64Y4xpbxa//yRpQZqb29AOb1S9Ds+vFS5pt/xc=
X-Received: by 2002:a63:4745:: with SMTP id w5-v6mr11378574pgk.377.1538068644426;
 Thu, 27 Sep 2018 10:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com> <1532697292-14272-14-git-send-email-loic.pallardy@st.com>
In-Reply-To: <1532697292-14272-14-git-send-email-loic.pallardy@st.com>
From:   Wendy Liang <sunnyliangjy@gmail.com>
Date:   Thu, 27 Sep 2018 10:17:13 -0700
Message-ID: <CAA07jV8tJNwQ0RMu_SG=KKjRNNGx=X5XW0Mzu1VFSPgJa-Uwrg@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] remoteproc: create vdev subdevice with specific
 dma memory pool
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org,
        Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 6:16 AM Loic Pallardy <loic.pallardy@st.com> wrote:
>
> This patch creates a dedicated vdev subdevice for each vdev declared
> in firmware resource table and associates carveout named "vdev%dbuffer"
> (with %d vdev index in resource table) if any as dma coherent memory pool.
>
> Then vdev subdevice is used as parent for virtio device.
>
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 35 +++++++++++++++++++++++---
>  drivers/remoteproc/remoteproc_internal.h |  1 +
>  drivers/remoteproc/remoteproc_virtio.c   | 42 +++++++++++++++++++++++++++++++-
>  include/linux/remoteproc.h               |  1 +
>  4 files changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 4edc6f0..adcc66e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -39,6 +39,7 @@
>  #include <linux/idr.h>
>  #include <linux/elf.h>
>  #include <linux/crc32.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_ring.h>
>  #include <asm/byteorder.h>
> @@ -145,7 +146,7 @@ static void rproc_disable_iommu(struct rproc *rproc)
>         iommu_domain_free(domain);
>  }
>
> -static phys_addr_t rproc_va_to_pa(void *cpu_addr)
> +phys_addr_t rproc_va_to_pa(void *cpu_addr)
>  {
>         /*
>          * Return physical address according to virtual address location
> @@ -160,6 +161,7 @@ static phys_addr_t rproc_va_to_pa(void *cpu_addr)
>         WARN_ON(!virt_addr_valid(cpu_addr));
>         return virt_to_phys(cpu_addr);
>  }
> +EXPORT_SYMBOL(rproc_va_to_pa);
>
>  /**
>   * rproc_da_to_va() - lookup the kernel virtual address for a remoteproc address
> @@ -423,6 +425,20 @@ static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
>  }
>
>  /**
> + * rproc_rvdev_release() - release the existence of a rvdev
> + *
> + * @dev: the subdevice's dev
> + */
> +static void rproc_rvdev_release(struct device *dev)
> +{
> +       struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
> +
> +       of_reserved_mem_device_release(dev);
> +
> +       kfree(rvdev);
> +}
> +
> +/**
>   * rproc_handle_vdev() - handle a vdev fw resource
>   * @rproc: the remote processor
>   * @rsc: the vring resource descriptor
> @@ -455,6 +471,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>         struct device *dev = &rproc->dev;
>         struct rproc_vdev *rvdev;
>         int i, ret;
> +       char name[16];
>
>         /* make sure resource isn't truncated */
>         if (sizeof(*rsc) + rsc->num_of_vrings * sizeof(struct fw_rsc_vdev_vring)
> @@ -488,6 +505,18 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>         rvdev->rproc = rproc;
>         rvdev->index = rproc->nb_vdev++;
>
> +       /* Initialise vdev subdevice */
> +       snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> +       rvdev->dev.parent = rproc->dev.parent;
> +       rvdev->dev.release = rproc_rvdev_release;
> +       dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> +       dev_set_drvdata(&rvdev->dev, rvdev);
> +       dma_set_coherent_mask(&rvdev->dev, DMA_BIT_MASK(32));
I tried the latest kernel, this function will not set the DMA coherent mask as
dma_supported() of the &rvdev->dev will return false.
As this is a device created at run time, should it be force to support DMA?
should it directly set the dma_coherent_mask?

> +
> +       ret = device_register(&rvdev->dev);
> +       if (ret)
> +               goto free_rvdev;
> +
>         /* parse the vrings */
>         for (i = 0; i < rsc->num_of_vrings; i++) {
>                 ret = rproc_parse_vring(rvdev, rsc, i);
> @@ -518,7 +547,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>         for (i--; i >= 0; i--)
>                 rproc_free_vring(&rvdev->vring[i]);
>  free_rvdev:
> -       kfree(rvdev);
> +       device_unregister(&rvdev->dev);
>         return ret;
>  }
>
> @@ -536,7 +565,7 @@ void rproc_vdev_release(struct kref *ref)
>
>         rproc_remove_subdev(rproc, &rvdev->subdev);
>         list_del(&rvdev->node);
> -       kfree(rvdev);
> +       device_unregister(&rvdev->dev);
>  }
>
>  /**
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index f6cad24..bfeacfd 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -52,6 +52,7 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>
>  void *rproc_da_to_va(struct rproc *rproc, u64 da, int len);
> +phys_addr_t rproc_va_to_pa(void *cpu_addr);
>  int rproc_trigger_recovery(struct rproc *rproc);
>
>  int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index de21f62..9ee63c0 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -17,7 +17,9 @@
>   * GNU General Public License for more details.
>   */
>
> +#include <linux/dma-mapping.h>
>  #include <linux/export.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/remoteproc.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
> @@ -315,10 +317,48 @@ static void rproc_virtio_dev_release(struct device *dev)
>  int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  {
>         struct rproc *rproc = rvdev->rproc;
> -       struct device *dev = &rproc->dev;
> +       struct device *dev = &rvdev->dev;
>         struct virtio_device *vdev = &rvdev->vdev;
> +       struct rproc_mem_entry *mem;
>         int ret;
>
> +       /* Try to find dedicated vdev buffer carveout */
> +       mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer", rvdev->index);
> +       if (mem) {
> +               phys_addr_t pa;
> +
> +               if (mem->of_resm_idx != -1) {
> +                       struct device_node *np = rproc->dev.parent->of_node;
> +
> +                       /* Associate reserved memory to vdev device */
> +                       ret = of_reserved_mem_device_init_by_idx(dev, np,
> +                                                                mem->of_resm_idx);
> +                       if (ret) {
> +                               dev_err(dev, "Can't associate reserved memory\n");
> +                               goto out;
> +                       }
> +               } else {
> +                       if (mem->va) {
> +                               dev_warn(dev, "vdev %d buffer already mapped\n",
> +                                        rvdev->index);
> +                               pa = rproc_va_to_pa(mem->va);
> +                       } else {
> +                               /* Use dma address as carveout no memmapped yet */
> +                               pa = (phys_addr_t)mem->dma;
> +                       }
> +
> +                       /* Associate vdev buffer memory pool to vdev subdev */
> +                       ret = dmam_declare_coherent_memory(dev, pa,
> +                                                          mem->da,
> +                                                          mem->len,
> +                                                          DMA_MEMORY_EXCLUSIVE);
> +                       if (ret < 0) {
> +                               dev_err(dev, "Failed to associate buffer\n");
> +                               goto out;
> +                       }
> +               }
> +       }
> +
>         vdev->id.device = id,
>         vdev->config = &rproc_virtio_config_ops,
>         vdev->dev.parent = dev;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 6b3a234..2921dd2 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -547,6 +547,7 @@ struct rproc_vdev {
>         struct kref refcount;
>
>         struct rproc_subdev subdev;
> +       struct device dev;
>
>         unsigned int id;
>         struct list_head node;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
