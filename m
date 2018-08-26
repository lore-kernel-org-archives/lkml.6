Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A4BC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273FF208DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsYfY7uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273FF208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeHZMEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 08:04:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39037 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeHZMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 08:04:35 -0400
Received: by mail-it0-f66.google.com with SMTP id t69-v6so6943047itb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iv8vMp7U6kpiizLVr4U54BzhKMFYPmA2/siXMyoADMM=;
        b=CsYfY7uUiznY4QVL55BTKkl5LXEVO5s54pTIP2Va3AmTnLCwnVILEmHVBMrPkZDzvx
         lxWFhY99Zult+9nIdczOYJASU2q6MCRb1G/F8vA1k+3pwFljrUI1ZWI8oVcZVCIPdKTw
         5W1n5v7EV3Ofn62V1BsqVCduntCx8DOQUiIbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iv8vMp7U6kpiizLVr4U54BzhKMFYPmA2/siXMyoADMM=;
        b=TN/0g0QgFSUOpAJyPM2Q8rcLEtdHsEriOTViqN9vOeOrZ0bvEEhb/PMYD8YUu9eCgq
         yOVTWxLBrV/Q5Zs+LOpMhiEPBAv+utAdR75riHgPt7lr6PP6w7wQgIb4bk5DWkLD4G6v
         kdS0kup0I/nxKAsDLYkibeve3Uc1jGakTkwidqSck2t7YOUtW7QgtpnUzAvbbaftGzJ6
         hdY46mlAq/0aeibWOzSPjXHkagIT3LLeFdFMaURulbYx6ieOZGd/WJpPy6j8RVk3exOG
         2a67tmFwscnnWm14l0P9vsD5ztGFoitqp6IAAt580dbt1S/EKhlLOtTzgRB92NluzP+X
         LYGQ==
X-Gm-Message-State: APzg51AXVYv/JkrunxkAlp7ctpAJY/XQqXk19MesrIJmyHaxVApm6cvg
        Tp9CAL1KUZxW7KKOHIQieWzYxSA3xUgXEi7AlNN7cw==
X-Google-Smtp-Source: ANB0VdYduiWWObednfhT8vH9krCiT+85Vqus2Qt0hc7RlihzzmGOotv0Kw3Z62tcN9eFebPcrX3u3oYoYNDTh9Eox3Q=
X-Received: by 2002:a02:1515:: with SMTP id j21-v6mr6818250jad.2.1535271764642;
 Sun, 26 Aug 2018 01:22:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 01:22:43
 -0700 (PDT)
In-Reply-To: <20180826024006.13800-4-martin.petersen@oracle.com>
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
 <20180826024006.13800-1-martin.petersen@oracle.com> <20180826024006.13800-4-martin.petersen@oracle.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 26 Aug 2018 09:22:43 +0100
Message-ID: <CAKv+Gu92yj5Cuz36bRS7wz3Lg2srp8OFJC6QVO0UWYSjm8eEeg@mail.gmail.com>
Subject: Re: [PATCH 4/4] block: Integrity profile init function to trigger
 module loads
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Jeffrey Lien <Jeff.Lien@wdc.com>,
        David Darrington <david.darrington@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Furlong <jeff.furlong@wdc.com>,
        linux-block@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 26 August 2018 at 03:40, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> The T10 CRC library function is built into the kernel and therefore
> registered early. The hardware-accelerated CRC helpers are typically
> loaded as modules and only become available later in the boot
> sequence. A separate patch modifies the T10 CRC library to subscribe
> to notifications from crypto and permits switching from the
> table-based algorithm to a hardware accelerated ditto once the
> relevant module is loaded.
>
> However, since the dependency for "crc10dif" is already satisfied,
> nothing is going to cause the hardware-accelerated kernel modules to
> get loaded.

This is not true. All accelerated implementations based on SIMD
polynomial multiplication are tried to the respective CPU features
bits. This applies to x86, power, ARM and arm64.

E.g., for x86 you have

alias:          cpu:type:x86,ven*fam*mod*:feature:*0081*

which will be matched by udev if /sys/devices/system/cpu/modalias
contains feature 0081, and so the modules will be loaded automatically
at boot.



> Introduce an init_fn in the integrity profile that can be
> called to trigger a load of modules providing the T10 CRC calculation
> capability. This function will ony get called when a new integrity
> profile is registered during device discovery.
>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  block/blk-integrity.c  |  5 +++++
>  block/t10-pi.c         | 10 ++++++++++
>  include/linux/blkdev.h |  2 ++
>  3 files changed, 17 insertions(+)
>
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 6121611e1316..5cacae9a2dc2 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -27,6 +27,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> +#include <linux/module.h>
>
>  #include "blk.h"
>
> @@ -391,6 +392,7 @@ static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
>
>  static const struct blk_integrity_profile nop_profile = {
>         .name = "nop",
> +       .init_fn = NULL,
>         .generate_fn = blk_integrity_nop_fn,
>         .verify_fn = blk_integrity_nop_fn,
>  };
> @@ -418,6 +420,9 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
>         bi->tuple_size = template->tuple_size;
>         bi->tag_size = template->tag_size;
>
> +       if (bi->profile->init_fn)
> +               bi->profile->init_fn();
> +
>         disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
>  }
>  EXPORT_SYMBOL(blk_integrity_register);
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index a98db384048f..b83278f9163a 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -24,6 +24,7 @@
>  #include <linux/t10-pi.h>
>  #include <linux/blkdev.h>
>  #include <linux/crc-t10dif.h>
> +#include <linux/module.h>
>  #include <net/checksum.h>
>
>  typedef __be16 (csum_fn) (void *, unsigned int);
> @@ -157,8 +158,14 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
>         return t10_pi_verify(iter, t10_pi_ip_fn, 3);
>  }
>
> +static void t10_pi_crc_init(void)
> +{
> +       request_module_nowait(CRC_T10DIF_STRING);
> +}
> +
>  const struct blk_integrity_profile t10_pi_type1_crc = {
>         .name                   = "T10-DIF-TYPE1-CRC",
> +       .init_fn                = t10_pi_crc_init,
>         .generate_fn            = t10_pi_type1_generate_crc,
>         .verify_fn              = t10_pi_type1_verify_crc,
>  };
> @@ -166,6 +173,7 @@ EXPORT_SYMBOL(t10_pi_type1_crc);
>
>  const struct blk_integrity_profile t10_pi_type1_ip = {
>         .name                   = "T10-DIF-TYPE1-IP",
> +       .init_fn                = NULL,
>         .generate_fn            = t10_pi_type1_generate_ip,
>         .verify_fn              = t10_pi_type1_verify_ip,
>  };
> @@ -173,6 +181,7 @@ EXPORT_SYMBOL(t10_pi_type1_ip);
>
>  const struct blk_integrity_profile t10_pi_type3_crc = {
>         .name                   = "T10-DIF-TYPE3-CRC",
> +       .init_fn                = t10_pi_crc_init,
>         .generate_fn            = t10_pi_type3_generate_crc,
>         .verify_fn              = t10_pi_type3_verify_crc,
>  };
> @@ -180,6 +189,7 @@ EXPORT_SYMBOL(t10_pi_type3_crc);
>
>  const struct blk_integrity_profile t10_pi_type3_ip = {
>         .name                   = "T10-DIF-TYPE3-IP",
> +       .init_fn                = NULL,
>         .generate_fn            = t10_pi_type3_generate_ip,
>         .verify_fn              = t10_pi_type3_verify_ip,
>  };
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 79226ca8f80f..a43c02e4f43d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1806,10 +1806,12 @@ struct blk_integrity_iter {
>  };
>
>  typedef blk_status_t (integrity_processing_fn) (struct blk_integrity_iter *);
> +typedef void (integrity_init_fn) (void);
>
>  struct blk_integrity_profile {
>         integrity_processing_fn         *generate_fn;
>         integrity_processing_fn         *verify_fn;
> +       integrity_init_fn               *init_fn;
>         const char                      *name;
>  };
>
> --
> 2.17.1
>
