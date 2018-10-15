Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E7AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B9D208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPl2Mrdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B9D208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJPD5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:57:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35549 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeJPD5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:57:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id d21-v6so10642054qtq.2;
        Mon, 15 Oct 2018 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TZCZM2ThHBLxdgdFwVJNRlV+2fIGiO8mK2wqokBjus=;
        b=JPl2Mrdm7/L9R8Qr63cT23NIa4Pp87k1ZADoMkyhYTizza1yTkuupDVDogwDasFBEX
         BFJ9KpI8/OvjB46JjTazCuqwEtsq9XX/Yv0IN8xMxCOXecPjza56T4zbopXRJT8cqnV4
         jcoeq3NUXyJy9KL/NRAzGKQFDaPPjAr+sMnznEqOhVSb1IahZ33+q/tM1J8lxrGAD+zx
         qlDRUuLVCgyPAKTDln0DFtEw6BS1h7Qm4Gl6bWKRdxt3JHoakn3NPsOfqY1Q29DpRPZu
         vkdQDfpXBi8u4jTWP+eTjdNpDo2wefeSYBLyHLNE9TYv9cL4g4gpyWhEuy0UDFBKHaGn
         9lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TZCZM2ThHBLxdgdFwVJNRlV+2fIGiO8mK2wqokBjus=;
        b=PAnIH7VgKYlyDrMOfll8ukEVCQuc/+5BYI/LNgCQstoPK8SIZFoOrfLwoJs1ex5yC3
         GKxP6W6pV/TMIFJq3BL+TGfDtaUsZqEcTZuoPM8wMR2M8dvYBD9IO6hL90DVpV15ganc
         xeI3BTgaXd4iOPhOvFKCSL1JziTwL67bpu2mJicTzrOqXFlht3d+F4QrveLDkc7nsZBe
         9zxG9ay4djTsPpst959fPVYQw/ShAd8JkRojeGPWT+jxEnBiYtm6PD/oChqlTXCb0HEX
         lHBJCC0F/p4P9TW9ZOBhkW56priWJfrtXaCbHthrrt1oss9K+MZcNc0ri/mF82GYYMVW
         YWKA==
X-Gm-Message-State: ABuFfoje3JKMN1CuoqKavt+QBM7Euol/NU0qsHvNApGS3ZT150XLRAdy
        f7ep8Hs62bBdlvETVGAUbqAVmgySG8K4/QbHZNg=
X-Google-Smtp-Source: ACcGV61s8gksIOgNor7WzcFcH2iyGCnI5VBB45aplJDar8EfXNeE2q5ztNxGxduz5XaDkgQGBtfmF6iiDOLrb3uiDHY=
X-Received: by 2002:aed:2791:: with SMTP id a17-v6mr17415572qtd.303.1539634259778;
 Mon, 15 Oct 2018 13:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <1537978342-17697-1-git-send-email-atull@kernel.org> <1537978342-17697-4-git-send-email-atull@kernel.org>
In-Reply-To: <1537978342-17697-4-git-send-email-atull@kernel.org>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Mon, 15 Oct 2018 13:10:49 -0700
Message-ID: <CAJYdmeNAbZRHOB8eCNgx466QkA6PBD8nOQVSO57oG=tYkqD1Eg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] fpga: add devm_fpga_region_create
To:     Alan Tull <atull@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:12 AM Alan Tull <atull@kernel.org> wrote:
>
> Add devm_fpga_region_create() which is the
> managed version of fpga_region_create().
>
> Change current region drivers to use
> devm_fpga_region_create().
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> Suggested-by: Federico Vaga <federico.vaga@cern.ch>

Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: add suggested-by
> v3: remove some unclear documentation about fpga_region_unregister
> ---
>  Documentation/driver-api/fpga/fpga-region.rst |  3 ++
>  drivers/fpga/dfl-fme-region.c                 |  6 +--
>  drivers/fpga/dfl.c                            |  6 +--
>  drivers/fpga/fpga-region.c                    | 65 +++++++++++++++++++++++----
>  drivers/fpga/of-fpga-region.c                 |  6 +--
>  include/linux/fpga/fpga-region.h              |  4 ++
>  6 files changed, 70 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
> index f30333c..dc9f75c 100644
> --- a/Documentation/driver-api/fpga/fpga-region.rst
> +++ b/Documentation/driver-api/fpga/fpga-region.rst
> @@ -90,6 +90,9 @@ API to add a new FPGA region
>     :functions: fpga_region
>
>  .. kernel-doc:: drivers/fpga/fpga-region.c
> +   :functions: devm_fpga_region_create
> +
> +.. kernel-doc:: drivers/fpga/fpga-region.c
>     :functions: fpga_region_create
>
>  .. kernel-doc:: drivers/fpga/fpga-region.c
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 3fa0de2..1eeb42a 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -39,7 +39,7 @@ static int fme_region_probe(struct platform_device *pdev)
>         if (IS_ERR(mgr))
>                 return -EPROBE_DEFER;
>
> -       region = fpga_region_create(dev, mgr, fme_region_get_bridges);
> +       region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
>         if (!region) {
>                 ret = -ENOMEM;
>                 goto eprobe_mgr_put;
> @@ -51,14 +51,12 @@ static int fme_region_probe(struct platform_device *pdev)
>
>         ret = fpga_region_register(region);
>         if (ret)
> -               goto region_free;
> +               goto eprobe_mgr_put;
>
>         dev_dbg(dev, "DFL FME FPGA Region probed\n");
>
>         return 0;
>
> -region_free:
> -       fpga_region_free(region);
>  eprobe_mgr_put:
>         fpga_mgr_put(mgr);
>         return ret;
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index a9b521b..2c09e50 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -899,7 +899,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>         if (!cdev)
>                 return ERR_PTR(-ENOMEM);
>
> -       cdev->region = fpga_region_create(info->dev, NULL, NULL);
> +       cdev->region = devm_fpga_region_create(info->dev, NULL, NULL);
>         if (!cdev->region) {
>                 ret = -ENOMEM;
>                 goto free_cdev_exit;
> @@ -911,7 +911,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>
>         ret = fpga_region_register(cdev->region);
>         if (ret)
> -               goto free_region_exit;
> +               goto free_cdev_exit;
>
>         /* create and init build info for enumeration */
>         binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
> @@ -942,8 +942,6 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>
>  unregister_region_exit:
>         fpga_region_unregister(cdev->region);
> -free_region_exit:
> -       fpga_region_free(cdev->region);
>  free_cdev_exit:
>         devm_kfree(info->dev, cdev);
>         return ERR_PTR(ret);
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 0d65220..bde5a9d 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -185,6 +185,10 @@ ATTRIBUTE_GROUPS(fpga_region);
>   * @mgr: manager that programs this region
>   * @get_bridges: optional function to get bridges to a list
>   *
> + * The caller of this function is responsible for freeing the resulting region
> + * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
> + * recommended.
> + *
>   * Return: struct fpga_region or NULL
>   */
>  struct fpga_region
> @@ -230,8 +234,8 @@ struct fpga_region
>  EXPORT_SYMBOL_GPL(fpga_region_create);
>
>  /**
> - * fpga_region_free - free a struct fpga_region
> - * @region: FPGA region created by fpga_region_create
> + * fpga_region_free - free a FPGA region created by fpga_region_create()
> + * @region: FPGA region
>   */
>  void fpga_region_free(struct fpga_region *region)
>  {
> @@ -240,21 +244,69 @@ void fpga_region_free(struct fpga_region *region)
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_free);
>
> +static void devm_fpga_region_release(struct device *dev, void *res)
> +{
> +       struct fpga_region *region = *(struct fpga_region **)res;
> +
> +       fpga_region_free(region);
> +}
> +
> +/**
> + * devm_fpga_region_create - create and initialize a managed FPGA region struct
> + * @dev: device parent
> + * @mgr: manager that programs this region
> + * @get_bridges: optional function to get bridges to a list
> + *
> + * This function is intended for use in a FPGA region driver's probe function.
> + * After the region driver creates the region struct with
> + * devm_fpga_region_create(), it should register it with fpga_region_register().
> + * The region driver's remove function should call fpga_region_unregister().
> + * The region struct allocated with this function will be freed automatically on
> + * driver detach.  This includes the case of a probe function returning error
> + * before calling fpga_region_register(), the struct will still get cleaned up.
> + *
> + * Return: struct fpga_region or NULL
> + */
> +struct fpga_region
> +*devm_fpga_region_create(struct device *dev,
> +                        struct fpga_manager *mgr,
> +                        int (*get_bridges)(struct fpga_region *))
> +{
> +       struct fpga_region **ptr, *region;
> +
> +       ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
> +       if (!ptr)
> +               return NULL;
> +
> +       region = fpga_region_create(dev, mgr, get_bridges);
> +       if (!region) {
> +               devres_free(ptr);
> +       } else {
> +               *ptr = region;
> +               devres_add(dev, ptr);
> +       }
> +
> +       return region;
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_region_create);
> +
>  /**
>   * fpga_region_register - register a FPGA region
> - * @region: FPGA region created by fpga_region_create
> + * @region: FPGA region
> + *
>   * Return: 0 or -errno
>   */
>  int fpga_region_register(struct fpga_region *region)
>  {
>         return device_add(&region->dev);
> -
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_register);
>
>  /**
> - * fpga_region_unregister - unregister and free a FPGA region
> + * fpga_region_unregister - unregister a FPGA region
>   * @region: FPGA region
> + *
> + * This function is intended for use in a FPGA region driver's remove function.
>   */
>  void fpga_region_unregister(struct fpga_region *region)
>  {
> @@ -264,9 +316,6 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
>
>  static void fpga_region_dev_release(struct device *dev)
>  {
> -       struct fpga_region *region = to_fpga_region(dev);
> -
> -       fpga_region_free(region);
>  }
>
>  /**
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index d6a70e4..75f64ab 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -410,7 +410,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>         if (IS_ERR(mgr))
>                 return -EPROBE_DEFER;
>
> -       region = fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
> +       region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
>         if (!region) {
>                 ret = -ENOMEM;
>                 goto eprobe_mgr_put;
> @@ -418,7 +418,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>
>         ret = fpga_region_register(region);
>         if (ret)
> -               goto eprobe_free;
> +               goto eprobe_mgr_put;
>
>         of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
>         platform_set_drvdata(pdev, region);
> @@ -427,8 +427,6 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>
>         return 0;
>
> -eprobe_free:
> -       fpga_region_free(region);
>  eprobe_mgr_put:
>         fpga_mgr_put(mgr);
>         return ret;
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 0521b7f..27cb706 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -44,4 +44,8 @@ void fpga_region_free(struct fpga_region *region);
>  int fpga_region_register(struct fpga_region *region);
>  void fpga_region_unregister(struct fpga_region *region);
>
> +struct fpga_region
> +*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
> +                       int (*get_bridges)(struct fpga_region *));
> +
>  #endif /* _FPGA_REGION_H */
> --
> 2.7.4
>

Thanks,
Moritz
