Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76517C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC3A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WUXfixx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC3A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbeLCGnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:43:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34690 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeLCGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:43:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so9755895ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 22:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3KdqAynByDLNpI9px0tmlm63M2ZByYfPZfbkHm6Mk8=;
        b=WUXfixx3Muz1sp49jUDfvsAPqZ3HuECW6dljgc6A3kf+zBu2GjGzaK2b1iX+T2XrQL
         VUIGo9HIqWiXwFTA/ZwmhQtw2QKm5Fpwl06UvHK3frXX4pFUzgE0y2bb83lwcCLhjL+u
         N2TiDVNJ1rH48K5Hr110Z/AaezcpLVIZTxnQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3KdqAynByDLNpI9px0tmlm63M2ZByYfPZfbkHm6Mk8=;
        b=Hfb1n9249KOkY21w0ULdpQeJ5LKyKXob3xHNT0v9GUJTzHgnivMUvARtuxQIXlEvJO
         X3qvnkE1cAwlAgeTHwuuiZ3T4OEI4Tn5AlwZDhAS9XQLQDEW/rC6DC9/A9Od3E/l4N11
         B/LX4pNymMdBZewGnfA5u+d+NgEB+3aC9DwDFUDBYjgwClp/f0U3Z9kecJfYlTNAytZq
         TT7tjON0RyvFdFzuWZDrMh7o6719RGlMb5FbHPR6zqcdIyi19lJWKqAA0hC1quyoUsi/
         ZKek2AjYlgCoQvqO+s7utOmpS/+qEKvb0o4E54HquNZvnfZuS2avz5ke3DeAMT6ZgQ8l
         NcFw==
X-Gm-Message-State: AA+aEWa05wfPh/juJCUuIwGB4glNz0ZpERArFjoZ8aNwDO1lt6BZXqUv
        rCCMQP5SqpM08jpWvyXtKmwJJUa/vJ1wfTdJxb+wrQ==
X-Google-Smtp-Source: AFSGD/XALzaQRbNhUnvcyo9qNimKSReQMWeSvwW2ybtNRRBMJPpij7U+6uC84VwKzBSKsAPqHNb7AolSkxcbVfKC5Eo=
X-Received: by 2002:a50:8799:: with SMTP id a25mr13698395eda.96.1543819409124;
 Sun, 02 Dec 2018 22:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20181128080553.37658-1-wen.yang99@zte.com.cn>
In-Reply-To: <20181128080553.37658-1-wen.yang99@zte.com.cn>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Mon, 3 Dec 2018 12:13:18 +0530
Message-ID: <CAL2rwxp=GUa+Uk9kVy9qoZLJ-PU95Jxb5B+OGKG=qujwhRAACA@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid_sas: NULL check before some freeing
 functions is not needed
To:     wen.yang99@zte.com.cn
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>, zhong.weidong@zte.com.cn,
        Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 1:36 PM Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> dma_pool_destroy(NULL) is safe, so removes NULL check before freeing
> the mem. This patch also fix the ifnullfree.cocci warnings.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>

Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> CC: Julia Lawall <julia.lawall@lip6.fr>
> CC: Kashyap Desai <kashyap.desai@broadcom.com>
> CC: Sumit Saxena <sumit.saxena@broadcom.com>
> CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index f74b5ea24f0f..aa477f09a7a5 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -807,10 +807,8 @@ megasas_free_rdpq_fusion(struct megasas_instance *instance) {
>
>         }
>
> -       if (fusion->reply_frames_desc_pool)
> -               dma_pool_destroy(fusion->reply_frames_desc_pool);
> -       if (fusion->reply_frames_desc_pool_align)
> -               dma_pool_destroy(fusion->reply_frames_desc_pool_align);
> +       dma_pool_destroy(fusion->reply_frames_desc_pool);
> +       dma_pool_destroy(fusion->reply_frames_desc_pool_align);
>
>         if (fusion->rdpq_virt)
>                 dma_free_coherent(&instance->pdev->dev,
> @@ -830,8 +828,7 @@ megasas_free_reply_fusion(struct megasas_instance *instance) {
>                         fusion->reply_frames_desc[0],
>                         fusion->reply_frames_desc_phys[0]);
>
> -       if (fusion->reply_frames_desc_pool)
> -               dma_pool_destroy(fusion->reply_frames_desc_pool);
> +       dma_pool_destroy(fusion->reply_frames_desc_pool);
>
>  }
>
> @@ -1627,8 +1624,7 @@ static inline void megasas_free_ioc_init_cmd(struct megasas_instance *instance)
>                                   fusion->ioc_init_cmd->frame,
>                                   fusion->ioc_init_cmd->frame_phys_addr);
>
> -       if (fusion->ioc_init_cmd)
> -               kfree(fusion->ioc_init_cmd);
> +       kfree(fusion->ioc_init_cmd);
>  }
>
>  /**
> --
> 2.19.1
>
