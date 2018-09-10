Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778FAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EFF20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EFF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeIKBG0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:06:26 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43251 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeIKBG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:06:26 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so42684796oib.10;
        Mon, 10 Sep 2018 13:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n3NcV2Q4Hma1laT8mgAByOx3Z6nGbKNdPf+oJIOVDhM=;
        b=YcDXV7DQJTmQykXTsbouHvnhPv8k77IkC2ECfbQdK8v5Y9SLYv5VfQOCOIz5t4feQt
         txgWsOMqM/6TXMJ/ZD8Zk2GXpdTPQE2s7aEm+onVoVrXNVL8UiyWzUQmH5JlRzaue9iq
         AS6mZQA+H3FUgNVcwfpH5Abu2EoWjxt/9bmOHzym5ivupu6MoRRSzNVt1pLGPpM2bm/M
         vbHDNfuHwaLWYdav5xC7SQrF3dqQJ4OMfw3K0p8yK++ESsm2z2zGgTBCeafiqM16nDRs
         NrNba2/8UQON9FL8hldqh/pCNW4xKojjj//4/x4NH3XbRxklqukFdrUPjUf+Odm62tBo
         Dt9A==
X-Gm-Message-State: APzg51BeQRUmejoVog8GeyyWHvAcKF/4NTuLxuIcv6mMhB/RqiAjSuA5
        deHzWIO3uBQ/D53cR5tOW8UMA/Y9zew=
X-Google-Smtp-Source: ANB0VdaBuERy7C74CSNQGZbMoLx8T3mpItdKZ21egGW6/agXsoYwuqR1wlP0S3qWSv5KYFlQoqUeYw==
X-Received: by 2002:aca:57d4:: with SMTP id l203-v6mr25628380oib.329.1536610241320;
        Mon, 10 Sep 2018 13:10:41 -0700 (PDT)
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id k85-v6sm50671722oiy.2.2018.09.10.13.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 13:10:40 -0700 (PDT)
Received: by mail-oi0-f53.google.com with SMTP id 8-v6so42764759oip.0;
        Mon, 10 Sep 2018 13:10:40 -0700 (PDT)
X-Received: by 2002:aca:b2c4:: with SMTP id b187-v6mr678118oif.160.1536610240159;
 Mon, 10 Sep 2018 13:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180910171550.5659-1-horia.geanta@nxp.com> <20180910171550.5659-3-horia.geanta@nxp.com>
In-Reply-To: <20180910171550.5659-3-horia.geanta@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 10 Sep 2018 15:10:28 -0500
X-Gmail-Original-Message-ID: <CADRPPNRVwQP31NEob5T974Fkrt4UxHxSAjjiOY6rR0MSqVUx8w@mail.gmail.com>
Message-ID: <CADRPPNRVwQP31NEob5T974Fkrt4UxHxSAjjiOY6rR0MSqVUx8w@mail.gmail.com>
Subject: Re: [PATCH 02/11] Revert "staging: fsl-mc/dpio: remove couple of
 unused functions"
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Miller <davem@davemloft.net>, aymen.sghaier@nxp.com,
        linux-crypto@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:19 PM Horia Geantă <horia.geanta@nxp.com> wrote:
>
> This reverts commit a211c8170b3c348353decb6e175c58a7814f218c.
> (+ updated to account for driver being moved out of staging)

So this is not a straightforward revert, as the original files have
been moved.  Probably it will be better not to use the standard format
of a revert commit which could cause confusion.

Otherwise,
Acked-by: Li Yang <leoyang.li@nxp.com>

>
> dpseci object will make use of these functions, thus it's time to add
> them back.
>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  drivers/soc/fsl/dpio/dpio-service.c | 58 +++++++++++++++++++++++++++++++++++++
>  include/soc/fsl/dpaa2-io.h          |  4 +++
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index 9b17f72349ed..321a92613a7e 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -309,6 +309,37 @@ int dpaa2_io_service_rearm(struct dpaa2_io *d,
>  }
>  EXPORT_SYMBOL_GPL(dpaa2_io_service_rearm);
>
> +/**
> + * dpaa2_io_service_pull_fq() - pull dequeue functions from a fq.
> + * @d: the given DPIO service.
> + * @fqid: the given frame queue id.
> + * @s: the dpaa2_io_store object for the result.
> + *
> + * Return 0 for success, or error code for failure.
> + */
> +int dpaa2_io_service_pull_fq(struct dpaa2_io *d, u32 fqid,
> +                            struct dpaa2_io_store *s)
> +{
> +       struct qbman_pull_desc pd;
> +       int err;
> +
> +       qbman_pull_desc_clear(&pd);
> +       qbman_pull_desc_set_storage(&pd, s->vaddr, s->paddr, 1);
> +       qbman_pull_desc_set_numframes(&pd, (u8)s->max);
> +       qbman_pull_desc_set_fq(&pd, fqid);
> +
> +       d = service_select(d);
> +       if (!d)
> +               return -ENODEV;
> +       s->swp = d->swp;
> +       err = qbman_swp_pull(d->swp, &pd);
> +       if (err)
> +               s->swp = NULL;
> +
> +       return err;
> +}
> +EXPORT_SYMBOL(dpaa2_io_service_pull_fq);
> +
>  /**
>   * dpaa2_io_service_pull_channel() - pull dequeue functions from a channel.
>   * @d: the given DPIO service.
> @@ -341,6 +372,33 @@ int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
>  }
>  EXPORT_SYMBOL_GPL(dpaa2_io_service_pull_channel);
>
> +/**
> + * dpaa2_io_service_enqueue_fq() - Enqueue a frame to a frame queue.
> + * @d: the given DPIO service.
> + * @fqid: the given frame queue id.
> + * @fd: the frame descriptor which is enqueued.
> + *
> + * Return 0 for successful enqueue, -EBUSY if the enqueue ring is not ready,
> + * or -ENODEV if there is no dpio service.
> + */
> +int dpaa2_io_service_enqueue_fq(struct dpaa2_io *d,
> +                               u32 fqid,
> +                               const struct dpaa2_fd *fd)
> +{
> +       struct qbman_eq_desc ed;
> +
> +       d = service_select(d);
> +       if (!d)
> +               return -ENODEV;
> +
> +       qbman_eq_desc_clear(&ed);
> +       qbman_eq_desc_set_no_orp(&ed, 0);
> +       qbman_eq_desc_set_fq(&ed, fqid);
> +
> +       return qbman_swp_enqueue(d->swp, &ed, fd);
> +}
> +EXPORT_SYMBOL(dpaa2_io_service_enqueue_fq);
> +
>  /**
>   * dpaa2_io_service_enqueue_qd() - Enqueue a frame to a QD.
>   * @d: the given DPIO service.
> diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
> index ab51e40d11db..70997ab2146c 100644
> --- a/include/soc/fsl/dpaa2-io.h
> +++ b/include/soc/fsl/dpaa2-io.h
> @@ -97,9 +97,13 @@ void dpaa2_io_service_deregister(struct dpaa2_io *service,
>  int dpaa2_io_service_rearm(struct dpaa2_io *service,
>                            struct dpaa2_io_notification_ctx *ctx);
>
> +int dpaa2_io_service_pull_fq(struct dpaa2_io *d, u32 fqid,
> +                            struct dpaa2_io_store *s);
>  int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
>                                   struct dpaa2_io_store *s);
>
> +int dpaa2_io_service_enqueue_fq(struct dpaa2_io *d, u32 fqid,
> +                               const struct dpaa2_fd *fd);
>  int dpaa2_io_service_enqueue_qd(struct dpaa2_io *d, u32 qdid, u8 prio,
>                                 u16 qdbin, const struct dpaa2_fd *fd);
>  int dpaa2_io_service_release(struct dpaa2_io *d, u32 bpid,
> --
> 2.16.2
>
