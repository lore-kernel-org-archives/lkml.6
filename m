Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AB5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F5020878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HDDB3w9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbfAKXd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:33:59 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33114 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfAKXd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:33:58 -0500
Received: by mail-vs1-f65.google.com with SMTP id p74so10338335vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdquelxyM31B3HhqLOpbZpiCdiHlaRLDSIQ8xr4xk4o=;
        b=HDDB3w9B7iR2vaV/oPBgu/OdJP5AuKGPDU/amm78+J87mmdRBLKBTZ/Hr3oYrJ61jk
         xiS0Hkm5xr+TsyrkMwcobVCnpt8rey04vRtGE8NqrYcedCbV8k49UkJF71yB7nxfAFYE
         oKYDpkQvZW+d462WgJKrQWeIoQBS7jCEteih4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdquelxyM31B3HhqLOpbZpiCdiHlaRLDSIQ8xr4xk4o=;
        b=nSgXDSlH+MVEdX8h9WkCUFO0fnvxuCxTUYIXOE4//6BFtk1VjiPHBQ4PFMm8zQ8fAo
         Y6+FivgZICyNL+cobiJiDFzeI0BTy308F+81z/GgVnHCd/izG5mRdyx1RzvtsTojTqqR
         /hamPFGLwlM/qL/fvu+mBA+55n5e2+GoBAV8I+MoIRddcGRgiKX5eKVV2Qm624Qj06Fv
         x7SPsIm72XsDqOe6ib0xeN47M24bYEKqJtMGLzUu3pCKGQLl0s/CL7qbRtfiyxpeCKqr
         41NFvVT1Pt/Mw90uezW1WfV9DWaTGXda8Revnn3Af1sm1UTrR12/7vAjBTa6PqpIhw82
         07VA==
X-Gm-Message-State: AJcUuke0UYGtspfLEPNcSukVDejDYg/68DKQZlYqwgN+JQCCXdh5urWf
        ZGDpZ46Ej4diyzCs3HovKfJ8paunlRM=
X-Google-Smtp-Source: ALg8bN6ix5NZ7QAvzRny9ErWR3WGkMcagp6WKlYOhR5gEyc8quMy8VKT08BkCn10a5T4PsKXq1Khew==
X-Received: by 2002:a67:34c4:: with SMTP id m65mr7082797vsi.192.1547249637401;
        Fri, 11 Jan 2019 15:33:57 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a187sm50533975vkf.26.2019.01.11.15.33.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 15:33:56 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id t8so5332385uap.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:33:55 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr5926952uaj.126.1547249635563;
 Fri, 11 Jan 2019 15:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20190111225402.6133-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190111225402.6133-1-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 11 Jan 2019 15:33:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WdCVENn8-5qBUPmiWm5z95_+pxuKv=075e6n1tcaS97w@mail.gmail.com>
Message-ID: <CAD=FV=WdCVENn8-5qBUPmiWm5z95_+pxuKv=075e6n1tcaS97w@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Consider device limitations for dma_mask
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 11, 2019 at 2:54 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Qualcomm SDM845 the capabilities of the UFS MEM controller states
> that it's capable of dealing with 64 bit addresses, but DMA addresses
> are truncated causing IOMMU faults when trying to issue operations.
>
> Limit the DMA mask to that of the device, so that DMA allocations
> is limited to the range supported by the bus and device and not just
> following what the controller's capabilities states.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 9ba7671b84f8..dc0eb59dd46f 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -8151,11 +8151,14 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
>   */
>  static int ufshcd_set_dma_mask(struct ufs_hba *hba)
>  {
> -       if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
> -               if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
> -                       return 0;
> -       }
> -       return dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(32));
> +       u64 dma_mask = dma_get_mask(hba->dev);
> +
> +       if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT)
> +               dma_mask &= DMA_BIT_MASK(64);
> +       else
> +               dma_mask &= DMA_BIT_MASK(32);

Just because I'm annoying like that, I'll point out  that the above is
a bit on the silly side.  Instead I'd do:

if (!(hba->capabilities & MASK_64_ADDRESSING_SUPPORT))
    dma_mask &= DMA_BIT_MASK(32);

AKA: your code is masking a 64-bit variable with a value that is known
to be 0xffffffffffffffff, which is kinda a no-op.


...other than the nit, this seems sane to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
