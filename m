Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675C5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF6D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrz18ZdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF6D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJHXlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:41:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37106 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJHXlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:41:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so14384511lfa.4;
        Mon, 08 Oct 2018 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyAm9SLv13RgA9QfKrScA+H2W3N49j8DBwJun9hz19g=;
        b=Yrz18ZdNsQtSN+agOLhfyZJCtBNhDSRstEgcqyKHf7p5UQ1rOeTZ08vi6ZCsvLP5j0
         CTpyXUQQmXOkzsaF8tLo6CVSQwoRaYLbNuzsAxIkGHGBiae/FnoneglqA6uZPinwTfhX
         4nGaM5qHidAzpvoQcZ3RH+oucStiYsf19yF6RyhV4zR3uUzAtu/aEhrR8x5s9EVsSfXP
         B02fCAMWWUk7O18QDahxKRGt93PG8yh5h1d4bbgf9ad8bbp4PMFi0shcqzsJHoOExIKW
         kUMHGJbZOc3Mc2OyvgFPsZPsxXcbY4PSac9rkt3YvH4vJ3nueLpOZDI8L0sA6M86geMu
         v2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyAm9SLv13RgA9QfKrScA+H2W3N49j8DBwJun9hz19g=;
        b=QyxdJo6WavYa8r6cLNgv4kTzoKV1chJ/ndT6g7XGHnaOkF66Cl0mb2b3b6RBfuRIa1
         0xm34fIbHM59PuoiP2hqZaHY+1/FI3NBJRdwedccMKO7HTnXEI7OXA1NCx2WNLeDSqBc
         mrOTYYggY1GoPBEJO7gIxRigOQw70vnJ1xFsvh9NeL1B/FX5GuGPOFwZ7/2Fs8dEsRRa
         84TFgisyFmthDEEC75QDXZj0pKT/s7iY3P70vZA60vpdOq+SxvDqFvkBVfo7dz8+C6mk
         Gm3olE9fo4hEQwGtVFwMWsobMDXkjz8NFp4xLKP55+Nfnrye1VLVYhVMm31TQOaxJehB
         C2ZQ==
X-Gm-Message-State: ABuFfohvRaBoRw9kL59SoALkmMfhkrkL0uySDjg6skKChPaim/Qjmn9A
        k2MD3ygWUypo3Co/W/aUAtJxfDX+kMRu/zDNG2bB5Q==
X-Google-Smtp-Source: ACcGV63J4cAH0hzK2SdxO96rWOil/IOZobFw++3OxL7VUxiSkgrjbGJUD16ntckcAfvZmJuOW0ve+d4V//YjVQ1KnJc=
X-Received: by 2002:a19:124b:: with SMTP id h72-v6mr13567102lfi.72.1539016117780;
 Mon, 08 Oct 2018 09:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181002054804.GA11315@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181002054804.GA11315@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 8 Oct 2018 21:58:26 +0530
Message-ID: <CAFqt6za2WuCSNxfQs48xXRctQ+V3xi-Dw7Gk785AtFXY2WCfJw@mail.gmail.com>
Subject: Re: [PATCH] scsi/mpt3sas: Use dma_pool_zalloc
To:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 11:14 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Replaced dma_pool_alloc + memset with dma_pool_zalloc.
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index 59d7844..d7ef671 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -4516,7 +4516,7 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
>         i = 0;
>         do {
>                 ioc->reply_post[i].reply_post_free =
> -                   dma_pool_alloc(ioc->reply_post_free_dma_pool,
> +                   dma_pool_zalloc(ioc->reply_post_free_dma_pool,
>                     GFP_KERNEL,
>                     &ioc->reply_post[i].reply_post_free_dma);
>                 if (!ioc->reply_post[i].reply_post_free) {
> @@ -4525,7 +4525,6 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
>                         ioc->name);
>                         goto out;
>                 }
> -               memset(ioc->reply_post[i].reply_post_free, 0, sz);
>                 dinitprintk(ioc, pr_info(MPT3SAS_FMT
>                     "reply post free pool (0x%p): depth(%d),"
>                     "element_size(%d), pool_size(%d kB)\n", ioc->name,
> @@ -4852,14 +4851,13 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
>                         ioc->name);
>                 goto out;
>         }
> -       ioc->reply_free = dma_pool_alloc(ioc->reply_free_dma_pool, GFP_KERNEL,
> +       ioc->reply_free = dma_pool_zalloc(ioc->reply_free_dma_pool, GFP_KERNEL,
>             &ioc->reply_free_dma);
>         if (!ioc->reply_free) {
>                 pr_err(MPT3SAS_FMT "reply_free pool: dma_pool_alloc failed\n",
>                         ioc->name);
>                 goto out;
>         }
> -       memset(ioc->reply_free, 0, sz);
>         dinitprintk(ioc, pr_info(MPT3SAS_FMT "reply_free pool(0x%p): " \
>             "depth(%d), element_size(%d), pool_size(%d kB)\n", ioc->name,
>             ioc->reply_free, ioc->reply_free_queue_depth, 4, sz/1024));
> --
> 1.9.1
>
