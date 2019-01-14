Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E084520659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="Nmh/xNce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfANFmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:42:42 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35567 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfANFmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:42:42 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so10736995itp.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 21:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HSgKgbhJy3PL1bhv/klZCkmkbvysuPWwCJRYGcwjJTg=;
        b=Nmh/xNcethll9qbV2OLwDdv1hUVVX8tJVgeKLQ0+yaFwdAGVXXNzWGeMs5TezXTczq
         7EuOW8BAb6vg8ZAKGeqLwp4QVkmiq2OCVxenHlzJyhC/Mm3L0DzUwnBrDX687PR9lkqE
         cMZfPKP/lXc/RfXf5PoyetznzbQgqqQ5I2d4CglZAgeULvIFnKEW2ukLRldwh4w6/zS9
         4lQ2uBEAjiMpj+vITYhaprDX2wrDwB4JiiGAwyR66S9JiAIlVg4RGYBbZ6WwgEeOIlAJ
         kBz62BUB51uF39qwI3x/brwd7jXtU2iCAumcD6NeqZjO+E5TJbasbuc4d9kkEnMjxSLP
         RFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HSgKgbhJy3PL1bhv/klZCkmkbvysuPWwCJRYGcwjJTg=;
        b=LzSRWSr10QKByeqrbL/Q79+eTQFXc8JPM/Xnj+XKhEW3cZmKSE7e0YPlBxG2FxzKTx
         C4xfWj5H9erF7ypc3g3DYpLQYv52q1MUGeCoIDgcv2GESQTBa8+Ev0eZxCkFdpRMLmAx
         WQEhKaE51r/9+2PH4EGmPE3PLI+xD0LUIH0AHPglI0u+OJGjeKbIAAMAjpvh7KKzsMHb
         kk+h6rDNKEhRWlZHiDwQRPlaSQYITluvJuJ3oMlBjOcgBzaJhTyfQhMW0vIDT5c1AKfE
         CMfbknTZcgVClLCUN2WgQsIdUyscSBd5WwM0c36H21dxzl60tCbn2dawlzx4ptkas0Ge
         xDYA==
X-Gm-Message-State: AJcUukfyOqkr8MDH7NgHpDTCcbmi2BqptNUQGzvRKYlTmWjbmc4TN4Il
        v7j+HR+Wu129NGikonriE0+vrEjhUL4kRUrF+Hb4Aw==
X-Google-Smtp-Source: ALg8bN5wx78dlXAAoP8KvigCFwOyTYdkAGqRzr759fjCHMIDReeAy1NZ1glA3BtYsWtgmkMUstFsgTTQfoFIgJBZdAI=
X-Received: by 2002:a02:946e:: with SMTP id a101mr4048186jai.90.1547444561195;
 Sun, 13 Jan 2019 21:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20190114134726.335c1da6@canb.auug.org.au>
In-Reply-To: <20190114134726.335c1da6@canb.auug.org.au>
From:   =?UTF-8?B?6buD5riF6ZqG?= <ching2048@areca.com.tw>
Date:   Mon, 14 Jan 2019 13:42:45 +0800
Message-ID: <CAKiknE937fCJ0fyphOKvez_OWgearpfMXhxigW_e=XN2t3ktKg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the scsi tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen's help.

Ching Huang

Stephen Rothwell <sfr@canb.auug.org.au> =E6=96=BC 2019=E5=B9=B41=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:48=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi all,
>
> Today's linux-next merge of the scsi tree got a conflict in:
>
>   drivers/scsi/arcmsr/arcmsr_hba.c
>
> between commit:
>
>   750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")
>
> from Linus' tree and commit:
>
>   381d66da7212 ("scsi: arcmsr: Rename acb structure member roundup_ccbsiz=
e to ioqueue_size")
>
> from the scsi tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/scsi/arcmsr/arcmsr_hba.c
> index 57c6fa388bf6,9f85d5abbb0c..000000000000
> --- a/drivers/scsi/arcmsr/arcmsr_hba.c
> +++ b/drivers/scsi/arcmsr/arcmsr_hba.c
> @@@ -585,12 -641,9 +641,11 @@@ static bool arcmsr_alloc_io_queue(struc
>
>         switch (acb->adapter_type) {
>         case ACB_ADAPTER_TYPE_B: {
> -               struct MessageUnit_B *reg;
> -               acb->roundup_ccbsize =3D roundup(sizeof(struct MessageUni=
t_B), 32);
> +               acb->ioqueue_size =3D roundup(sizeof(struct MessageUnit_B=
), 32);
>  -              dma_coherent =3D dma_zalloc_coherent(&pdev->dev, acb->ioq=
ueue_size,
>  -                      &dma_coherent_handle, GFP_KERNEL);
>  +              dma_coherent =3D dma_alloc_coherent(&pdev->dev,
> -                                                 acb->roundup_ccbsize,
> ++                                                acb->ioqueue_size,
>  +                                                &dma_coherent_handle,
>  +                                                GFP_KERNEL);
>                 if (!dma_coherent) {
>                         pr_notice("arcmsr%d: DMA allocation failed\n", ac=
b->host->host_no);
>                         return false;
> @@@ -616,13 -655,9 +657,11 @@@
>                 }
>                 break;
>         case ACB_ADAPTER_TYPE_D: {
> -               struct MessageUnit_D *reg;
> -
> -               acb->roundup_ccbsize =3D roundup(sizeof(struct MessageUni=
t_D), 32);
> +               acb->ioqueue_size =3D roundup(sizeof(struct MessageUnit_D=
), 32);
>  -              dma_coherent =3D dma_zalloc_coherent(&pdev->dev, acb->ioq=
ueue_size,
>  -                      &dma_coherent_handle, GFP_KERNEL);
>  +              dma_coherent =3D dma_alloc_coherent(&pdev->dev,
> -                                                 acb->roundup_ccbsize,
> ++                                                acb->ioqueue_size,
>  +                                                &dma_coherent_handle,
>  +                                                GFP_KERNEL);
>                 if (!dma_coherent) {
>                         pr_notice("arcmsr%d: DMA allocation failed\n", ac=
b->host->host_no);
>                         return false;
> @@@ -662,11 -671,9 +675,11 @@@
>         case ACB_ADAPTER_TYPE_E: {
>                 uint32_t completeQ_size;
>                 completeQ_size =3D sizeof(struct deliver_completeQ) * ARC=
MSR_MAX_HBE_DONEQUEUE + 128;
> -               acb->roundup_ccbsize =3D roundup(completeQ_size, 32);
> +               acb->ioqueue_size =3D roundup(completeQ_size, 32);
>  -              dma_coherent =3D dma_zalloc_coherent(&pdev->dev, acb->ioq=
ueue_size,
>  -                      &dma_coherent_handle, GFP_KERNEL);
>  +              dma_coherent =3D dma_alloc_coherent(&pdev->dev,
> -                                                 acb->roundup_ccbsize,
> ++                                                acb->ioqueue_size,
>  +                                                &dma_coherent_handle,
>  +                                                GFP_KERNEL);
>                 if (!dma_coherent){
>                         pr_notice("arcmsr%d: DMA allocation failed\n", ac=
b->host->host_no);
>                         return false;
