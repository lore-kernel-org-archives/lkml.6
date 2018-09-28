Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE541216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="kH81cvsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE541216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeI1OTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:19:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43259 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeI1OTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:19:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id z14-v6so5276714wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiagCQSalZ+pBspGCNboM4PLT8lf8Whrt7wUFmS3Mjs=;
        b=kH81cvsZ3tofrCBNDv3Hu7a/nNxzyrljL8PuTadVBY6Fj+JRucF3+iUukmhbXQUS9M
         fiPgkSvJU/e5eJgSpnbKoDO3EOErK7526CaBlbVCndJCHtlF2vBLWBO/ZB4M9evgzBaa
         YUdchdapvxhRV0jXDg3YOmgtf7O89sJ9jOtTEpX/YjBO0W9YvDx2I9UNu7SmACjuEPiQ
         P0JbGXozfQ0mtlaNOyMquKEbOt/gYnJUh/4VALTki757qaJADG44OsXIMkyVjdKfBG1R
         HGQq3BysIjOLb32sqMuJGZqXRDJLknl7wGda8elhhfKTjoSx1IFj0orAdyHJDBaXx0gz
         JEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiagCQSalZ+pBspGCNboM4PLT8lf8Whrt7wUFmS3Mjs=;
        b=QWVLfQv68bdgx4YqVH4HPoT5WqtkvX+zJ2iftjObg7AstjpW+PyADFfK3S8CdRR726
         Bd3F2t4haRLIddMUuDZrND0RpLCeyhNGIEIMd3/IcIgCfm4swLINb4v5usu/idcB/+Y+
         FXDhB6jpiGrQqj3tYfEykXv+nsqdnF+nqoWdvviuiDgwz2/IWnoQ16m+Ppe1qzjIwZz1
         1kMKmVjVZzw/hyrb7boDlwpZNg051GyDyVlTh7CGXO1SUZC7Wk+dNsWCD7Pi5TvsHG2M
         7WNEyKqM+rs9NtIYUPkfTMRTIapaPajW8oqER72P8tiZ4QDViEd0AWmo73mwzN6LwfPZ
         zqxQ==
X-Gm-Message-State: ABuFfohIpHTDv41lVfa5yLr2Z2YFUzq//yKBZYNi5reL8Z0AF6ce66xD
        ATzZOv5OjBgQgSvydzTU1JsrkcSRhpt91hMgyxi1wA==
X-Google-Smtp-Source: ACcGV614Utxo1d/KFowhN3rOHP+G43ogD6mPfl0yDYFdwpuxw05vySQAzGJ45rafqrld0lwDH4NHrQtGQokzm0qWtH4=
X-Received: by 2002:adf:a969:: with SMTP id u96-v6mr11267291wrc.222.1538121421569;
 Fri, 28 Sep 2018 00:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com> <1532697292-14272-18-git-send-email-loic.pallardy@st.com>
In-Reply-To: <1532697292-14272-18-git-send-email-loic.pallardy@st.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 28 Sep 2018 13:26:50 +0530
Message-ID: <CAAhSdy3nyHqv+6EaYxN9qW0qhnNgTk-8MhFeB7QTBgxaFBtVVA@mail.gmail.com>
Subject: Re: [PATCH v4 17/17] rpmsg: virtio: allocate buffer from parent
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        arnaud pouliquen <arnaud.pouliquen@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>, s-anna@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 6:45 PM Loic Pallardy <loic.pallardy@st.com> wrote:
>
> Remoteproc is now capable to create one specific sub-device per
> virtio link to associate a dedicated memory pool.
> This implies to change device used by virtio_rpmsg for
> buffer allocation from grand-parent to parent.
>
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 664f957..5c89201 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -912,7 +912,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>         total_buf_space = vrp->num_bufs * vrp->buf_size;
>
>         /* allocate coherent memory for the buffers */
> -       bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
> +       bufs_va = dma_alloc_coherent(vdev->dev.parent,
>                                      total_buf_space, &vrp->bufs_dma,
>                                      GFP_KERNEL);
>         if (!bufs_va) {
> @@ -980,7 +980,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>         return 0;
>
>  free_coherent:
> -       dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
> +       dma_free_coherent(vdev->dev.parent, total_buf_space,
>                           bufs_va, vrp->bufs_dma);
>  vqs_del:
>         vdev->config->del_vqs(vrp->vdev);
> @@ -1015,7 +1015,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
>
>         vdev->config->del_vqs(vrp->vdev);
>
> -       dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
> +       dma_free_coherent(vdev->dev.parent, total_buf_space,
>                           vrp->rbufs, vrp->bufs_dma);
>
>         kfree(vrp);
> --
> 1.9.1
>

Reviewed-by: Anup Patel <anup@brainfault.org>

Also, tried this patch on Linux running inside Guest/VM on
Xvisor ARM/ARM64.
Tested-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
