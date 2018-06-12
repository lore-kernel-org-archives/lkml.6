Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CDD69C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7904F208B5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="SEBEGark"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7904F208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbeFLPsR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:48:17 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42615 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933137AbeFLPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:48:16 -0400
Received: by mail-io0-f194.google.com with SMTP id r24-v6so28613772ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PyVHSkGUjCx+oN3y+836pXf6VCJyXTQXyENuW1VdaQ4=;
        b=SEBEGarkDs3oUJOV4h5FQIiBgADiXCbmHphUY6u6LaLq0vm6F+wz3Y2XxItA1Q6HuM
         NX61ZBP4Z32JINvIfgptm9A9o0p0avHhgT+H9tvUV8NKvLTIgFxmSjmwfI/w0q9hJ0HZ
         94RfiiTPYMh1tVaNNu4XSwis/lbpU1/D9ve6rM7AuGVRnaFEbEfkHwbWAE2ws1jAvBRL
         kUWWKDDuLzIUNJ6/+1iVJfITocDw8wuaEBNvC+mflL+r2SIFH+HfJIkQKZSjGUIraYsL
         jBImHcgEyuH0TdEPpk4sDgd088u89S3BjS1brDN9LlBMrCpnPKi/Cy349SamFgP+kxxR
         X+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PyVHSkGUjCx+oN3y+836pXf6VCJyXTQXyENuW1VdaQ4=;
        b=fr52lQKQ0AwZN33sQUdptbt5c0oDEruULGk/dYyom79q8JoaxE5+MhYWP9LzpoMV3h
         i5gP6asoc6ng3jWNVMMDAIYyh2ocKZmR1mX1s2DKWLZ0nE6afywr6zOMuSGx3qZtF47g
         fjL2kMnqUCkyMmksN8ZBryX/e7vUx2fcp74TZTaZC/cZGdlAWtF5It9R5O0G4FSPR9AY
         xeAiTXe1Fod2xoTf47LlpxEUmI269QRl96cLCMaG5UyGUoq8m3Q71nmcJBDxobkt9LmL
         oh0iVCAJWwiyNcTWvkNAa3kpLlwU4Pj5yVr6GBc6TkKJ7y0XM7CqxK/4w1V8vvgPiRWV
         JUUw==
X-Gm-Message-State: APt69E2p2fKgSxxQL+Lfzc6oQvz7XGpCnTLnK56HQrom/dlXOaKXkqzp
        tzHGTwPgHN+WcACoQTc8Ax9YtbUr3GdmJKhpc/tnNw==
X-Google-Smtp-Source: ADUXVKKvAtJwEQKNOIneypHfjrMJpELWoAWOOl2g8g7OihKxPrLmqC/SSdEBad2YOc7/wyzEYC8E/YvYqDEt/yxSZS0=
X-Received: by 2002:a6b:82c7:: with SMTP id m68-v6mr1030258ioi.118.1528818495579;
 Tue, 12 Jun 2018 08:48:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:5147:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 08:48:15
 -0700 (PDT)
In-Reply-To: <20180609000819.13883-3-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com> <20180609000819.13883-3-logang@deltatee.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Tue, 12 Jun 2018 11:48:15 -0400
Message-ID: <CAPoiz9ykPufmQi=fhhA8k=CXdXwdo0v7+UPQwNwnkokXU-vWjw@mail.gmail.com>
Subject: Re: [PATCH 2/8] NTB: Setup the DMA mask globally for all drivers
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 8:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Commit  417cf39cfea9 ("NTB: Set dma mask and dma coherent mask to NTB
> devices") added code to set the DMA mask for the NTB device
> to each driver individually. However, it neglected to set it for the
> Switchtec driver. So when the monolithic commit 7f46c8b3a552 ("NTB:
> ntb_tool: Add full multi-port NTB API support") started allocating
> DMA memory against the NTB device it broke the Switchtec driver.
>
> Seeing this is setting up a property of the NTB device, it should be
> done by the common NTB code (inside ntb_register_device()) so we can be
> sure it's done properly for all drivers. This avoids each driver needing
> to duplicate the code and helps prevent us from inadvertently breaking
> one of the drivers in the future if we have to make changes in this area.
>
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c     |  6 ------
>  drivers/ntb/hw/intel/ntb_hw_intel.c |  4 ----
>  drivers/ntb/ntb.c                   | 13 ++++++++++++-
>  4 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 3cfa46876239..f0788aae05c9 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1020,10 +1020,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>                         goto err_dma_mask;
>                 dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>         }
> -       rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -                                         dma_get_mask(&pdev->dev));
> -       if (rc)
> -               goto err_dma_mask;
>
>         ndev->self_mmio = pci_iomap(pdev, 0, 0);
>         if (!ndev->self_mmio) {
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 8d98872d0983..1918a2db1c43 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2447,12 +2447,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>                 dev_warn(&pdev->dev,
>                         "Cannot set consistent DMA highmem bit mask\n");
>         }
> -       ret = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -                                          dma_get_mask(&pdev->dev));
> -       if (ret != 0) {
> -               dev_err(&pdev->dev, "Failed to set NTB device DMA bit mask\n");
> -               return ret;
> -       }
>
>         /*
>          * Enable the device advanced error reporting. It's not critical to
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 156b45cd4a19..341a3d5baa3f 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -2334,10 +2334,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>                         goto err_dma_mask;
>                 dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
>         }
> -       rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
> -                                         dma_get_mask(&pdev->dev));
> -       if (rc)
> -               goto err_dma_mask;
>
>         ndev->self_mmio = pci_iomap(pdev, 0, 0);
>         if (!ndev->self_mmio) {
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 2581ab724c34..93f24440d11d 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
>
>  int ntb_register_device(struct ntb_dev *ntb)
>  {
> +       int ret;
> +
>         if (!ntb)
>                 return -EINVAL;
>         if (!ntb->pdev)
> @@ -120,7 +122,16 @@ int ntb_register_device(struct ntb_dev *ntb)
>         ntb->ctx_ops = NULL;
>         spin_lock_init(&ntb->ctx_lock);
>
> -       return device_register(&ntb->dev);
> +       device_initialize(&ntb->dev);
> +
> +       ret = dma_coerce_mask_and_coherent(&ntb->dev,
> +                                          dma_get_mask(&ntb->pdev->dev));

ntb.c is more of a glue layer, and this is more device specific.
While I like adding it here for more common code, it should probably
reside in the ntb_hw_*.c files to enforce the hw specific code all
reside in that layer.  So, this probably needs to be replaced with a
patch which adds the setting of the mask to the switchtec driver.

Thanks,
Jon


> +       if (ret != 0) {
> +               dev_err(&ntb->dev, "Failed to set NTB device DMA bit mask\n");
> +               return ret;
> +       }
> +
> +       return device_add(&ntb->dev);
>  }
>  EXPORT_SYMBOL(ntb_register_device);
>
> --
> 2.11.0
>
