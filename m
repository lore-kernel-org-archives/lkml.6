Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1383150-1519213251-2-12365986344354949753
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519213251; b=EPG6GBWTjkpZXEagsM4jLQVxpNZweRYAFq4AWE8ws6G2Bhr
    Hx6zfNWz5GKxdEByw+X4/8tTG9ihSM10z7VIkBgsHugyePqYMNMmmtRUonUnk6nT
    OGYGaaSAWa+DT8Uftn0Rtm+jfDMJxxAhRMSSS5iHQkJUE3Y3lX/LqGnowCrnqmel
    U841H4TtfZySgOjNIddGTKBHa5YRSJ52JiU6+InWJ/stBXuBtf3pb7cvdzDyNUPg
    mCaGoT5nRbK0e9ivN84RY52Jwt1aj7aaqCFnmoSEQ4kHOVs5IRNOy/V3GjWPK54w
    khsckQHYHGptXUGpFGfCX0F2vxT933ij9U50Yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519213251; bh=sxZPIZMhznUN+XUYtcAMld7nS7kZ/cOhL4N6i0
    pnXrU=; b=NId0f3a1NwoL+jg7tEUDY3FMuAgwKYlD88tCUgi/zQ9KY1Xl29eTjr
    1HAlRSEtfHI62UI4uE/FKDd/+oN/usTpSVrW+VqTqJNAoMCsSitBlKDAVKob10XI
    GdUl7HnSyECjsTMJ0hFq4j05Ucc5nhZo4h1lA96SpMJmcegeRzBxV0I/I/20lMLv
    KXLT5LHgprqB254hW/sP55L2a5TzKrZWh3eEFp81Uaw5Z9AlL9mGkZa0wQ3MvAZq
    tnR7m7AoEDsLCM+6qp8jZPDxYJhyk3mpQoRb1Z4DrAjV/K0JNs6AU1g0aoKcYWWs
    ZvxY0dHj72cS9Eov0LxBKHS97bLFgftQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b=zYeEgWrE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brainfault.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z/kFbrRq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=brainfault.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b=zYeEgWrE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brainfault.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z/kFbrRq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=brainfault.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933575AbeBULk3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 06:40:29 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40045 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933558AbeBULk2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 06:40:28 -0500
X-Google-Smtp-Source: AH8x227gzF7w7swf8Jm5f3GUcN+upBOHLkAaxBYM1jT6LnGKT2Gw9kyAJzOztEQNgxNWFQ/z5yPwbhQj53e9EqjM9HA=
MIME-Version: 1.0
In-Reply-To: <1515590217-24256-1-git-send-email-anup@brainfault.org>
References: <1515590217-24256-1-git-send-email-anup@brainfault.org>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 21 Feb 2018 17:10:26 +0530
Message-ID: <CAAhSdy05w4HnbcWw+-vdp+cN=F95KMnSp_JUgzHbxSNZdh-UdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] rpmsg: virtio_rpmsg_bus: fix rpmsg_probe() for
 virtio-mmio transport
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 10, 2018 at 6:46 PM, Anup Patel <anup@brainfault.org> wrote:
> When virtio-rpmsg device is provided via virtio-mmio transport, the
> dma_alloc_coherent() (called by rpmsg_probe()) fails on ARM/ARM64
> systems because "vdev->dev.parent->parent" device is used as parameter
> to dma_alloc_coherent().
>
> The "vdev->dev.parent->parent" device represents underlying remoteproc
> platform device when virtio-rpmsg device is provided via virtio-remoteproc
> transport. When virtio-rpmsg device is provided via virtio-mmio transport,
> the "vdev->dev.parent->parent" device represents the parent device of
> virtio-mmio platform device and dma_alloc_coherent() fails for this device
> because generally there is no corresponding platform device and dma_ops
> are not setup for "vdev->dev.parent->parent".
>
> This patch fixes dma_alloc_coherent() usage in rpmsg_probe() by trying
> dma_alloc_coherent() with "vdev->dev.parent" device when it fails with
> "vdev->dev.parent->parent" device.
>
> Fixes: b5ab5e24e960 ("remoteproc: maintain a generic child device for
> each rproc")
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 82b8300..7f8710a 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -64,6 +64,7 @@
>  struct virtproc_info {
>         struct virtio_device *vdev;
>         struct virtqueue *rvq, *svq;
> +       struct device *bufs_dev;
>         void *rbufs, *sbufs;
>         unsigned int num_bufs;
>         unsigned int buf_size;
> @@ -924,9 +925,16 @@ static int rpmsg_probe(struct virtio_device *vdev)
>                                      total_buf_space, &vrp->bufs_dma,
>                                      GFP_KERNEL);
>         if (!bufs_va) {
> -               err = -ENOMEM;
> -               goto vqs_del;
> -       }
> +               bufs_va = dma_alloc_coherent(vdev->dev.parent,
> +                                            total_buf_space, &vrp->bufs_dma,
> +                                            GFP_KERNEL);
> +               if (!bufs_va) {
> +                       err = -ENOMEM;
> +                       goto vqs_del;
> +               } else
> +                       vrp->bufs_dev = vdev->dev.parent;
> +       } else
> +               vrp->bufs_dev = vdev->dev.parent->parent;
>
>         dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>                 bufs_va, &vrp->bufs_dma);
> @@ -988,7 +996,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>         return 0;
>
>  free_coherent:
> -       dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
> +       dma_free_coherent(vrp->bufs_dev, total_buf_space,
>                           bufs_va, vrp->bufs_dma);
>  vqs_del:
>         vdev->config->del_vqs(vrp->vdev);
> @@ -1023,7 +1031,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
>
>         vdev->config->del_vqs(vrp->vdev);
>
> -       dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
> +       dma_free_coherent(vrp->bufs_dev, total_buf_space,
>                           vrp->rbufs, vrp->bufs_dma);
>
>         kfree(vrp);
> --
> 2.7.4
>

Hi Bjorn,

Can you please review this patch?

Regards,
Anup
