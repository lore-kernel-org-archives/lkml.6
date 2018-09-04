Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376CE20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="dD9x0giI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376CE20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeIEEIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:08:35 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44690 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeIEEIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:08:34 -0400
Received: by mail-yw1-f65.google.com with SMTP id l9-v6so1943912ywc.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l7cfVWEo+s72Cr+f/IYhNLNnmwH47pf9W7a9az82J0Y=;
        b=dD9x0giIiUICFigz0dtpjAo0Z1+LJYljzzrINoo9BCg/Tlf/PzhqUnQIj05u+VDCM0
         DtL5hm4yOKQ6KuUGCZxI9RKLvBh8GANRbCV4OZC92CSXwKCVykSMdW2Vh0bJfRzQ/4zj
         UaTK+GqQXQcXiLmzqMPKbY8TyrR42oAMnTfMJmKFbvO5rpjh4SHccAAPPEHOgiW1/fKp
         uVrzgvbw4jnnGmqY+DDvDGE0adFz5YdD2/R+2kN8ZuzBfVCQAoKsCWcfN3lfcPyTPZzW
         qO+ZgKFAWbdxVkrrFcCudVYZd6CkCJl06FWyFHmgXXkDHzgC0rJVjeou+MtjoiXO6pVf
         nBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l7cfVWEo+s72Cr+f/IYhNLNnmwH47pf9W7a9az82J0Y=;
        b=E0JJTtqgGGKNOFRQvY2cLcs7beFFbJsmIbDJUWEyWunY+JYExLYkaWH20ywTkMWO/u
         j/R7/1oQaonGNUGfv5cQbl9EEI329ay353748Dn6cp2nxN88MQmsfOcZxDDWsDIcB7+A
         LSA5Vim5jEstT6msfI/NYqRKtdnUCW3BFshEMllo3fozhoZvzv6KuE2J1FzPhVCz/8AN
         lkv4MAWQSo1xDtqLCZP6TwaI7O8MeazY5/7lcwy5+K5HzI2nqGLsmp1kjUnEqPA46czG
         Vit+9fI8gb05OtEVKu7LRnU+LQ9TED5oDuznw7iPKpM0yM97vuxruELSJqm7zzKHkhXl
         T05Q==
X-Gm-Message-State: APzg51DliwmFV9QeS8mNGLqx3lblGbc6aMHi/egBvcuExH+wnTp91Xca
        inIBvQSjAU6ZnuXwNwNp+Pma3P0WamsSLFbNvz4/8A==
X-Google-Smtp-Source: ANB0VdbeR1oZCqfPA+qZ/SShGK7kcGEsAbFhwIOTWM3X1MmvdF0ooEzaUUZT7NLubgu3UAvHq6Nio4HKNpwwL90rJZ8=
X-Received: by 2002:a0d:ef01:: with SMTP id y1-v6mr20209976ywe.498.1536104469894;
 Tue, 04 Sep 2018 16:41:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:e106:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 16:41:09 -0700 (PDT)
In-Reply-To: <20180904212237.3078-2-atull@kernel.org>
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-2-atull@kernel.org>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Tue, 4 Sep 2018 16:41:09 -0700
Message-ID: <CAAtXAHfzhmdZ6SnheZ-DXD14dde7Ccm66jEM=Q3UWDukKsyGBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] fpga: do not access region struct after fpga_region_unregister
To:     Alan Tull <atull@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Sep 4, 2018 at 2:22 PM, Alan Tull <atull@kernel.org> wrote:
> A couple drivers were accessing the region struct after it had been
> freed.  Save off the pointer to the mgr before the region struct gets
> freed.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: no change in v2 of patchset
> ---
>  drivers/fpga/dfl-fme-region.c | 4 +++-
>  drivers/fpga/of-fpga-region.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 0b7e19c..51a5ac2 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -14,6 +14,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
>
>  #include "dfl-fme-pr.h"
> @@ -66,9 +67,10 @@ static int fme_region_probe(struct platform_device *pdev)
>  static int fme_region_remove(struct platform_device *pdev)
>  {
>         struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +       struct fpga_manager *mgr = region->mgr;
>
>         fpga_region_unregister(region);
> -       fpga_mgr_put(region->mgr);
> +       fpga_mgr_put(mgr);
>
>         return 0;
>  }
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 35fabb8..052a134 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -437,9 +437,10 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  static int of_fpga_region_remove(struct platform_device *pdev)
>  {
>         struct fpga_region *region = platform_get_drvdata(pdev);
> +       struct fpga_manager *mgr = region->mgr;
>
>         fpga_region_unregister(region);
> -       fpga_mgr_put(region->mgr);
> +       fpga_mgr_put(mgr);
>
>         return 0;
>  }
> --
> 2.7.4
>

Thanks,
Moritz
