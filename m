Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B4AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFE0208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg6Gb1nG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFE0208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbeGMN41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:56:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbeGMN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:56:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so15953346wrt.2;
        Fri, 13 Jul 2018 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aBlaugupoF65hODnuUqXu/mB+ibRSiFdYjsxKlCzGyA=;
        b=Yg6Gb1nG0aEHPeVHKnAED6b24tg0+AuDRBVnQ40rzldwyVxc+QLk34/lnV3KFRGGbQ
         9rcuSfGyYBBNWR9kTgJnl93mD3RMlu5cVZ1r3PGNocM6s6/BkM4ooa1sT0K2Q7anEe5a
         +gmwizvvrQYGN/N6HavP4/0WIlj+2wRzDvdHO3oQIuQoepopSEwMuCy+HcripVRBfrlm
         uB0r46s2vYT5hQ4x9bqp6s1SfytAjxfqPBrrk9N2NDmCgsZkuWH8jmXhcaN6RKvJ0wnw
         9kAnZ3E0MHohhWQnLfaNap7WsYo6DmnNT3i15vPsjhKsRPL4O4eCE++oXIYWec61xsET
         m80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aBlaugupoF65hODnuUqXu/mB+ibRSiFdYjsxKlCzGyA=;
        b=IPMqN3JkYouE79sdUDXMf/MXmRZhUbzfIg4TPYHAPxPILHUb++/VV+RGbncR6Km2L2
         dXOO7mjoLaHnbKwRC9QD5Q0uG8oRbaL3NGRc3tP5N0lYa9O9JIYeIT81UtqImM0OBfO6
         q757ZhHdJOO48VACK4XTinh7IZSGvR5l6oK67c1TAxQxO2gyLo/KrrkH/JSOV51JG0hD
         9aipcXcTExYBmcIN349HEY6teJDYshO3qYPbmLThP/6mfRZ54oS/lZ9HQrPBJw6ZDZ8L
         YRQ3QhPqTiJKoviIBlTRbZP26u796wf3U1V9vKTNUPpPRRrykTQuindSk7v7+bT8uSiQ
         g5Eg==
X-Gm-Message-State: AOUpUlFkeQTeP39BSo0KdQbUqj7ReZwOS7xWiwe30Vn/tlyG/2TGfhjU
        NWHKJ9GX8ATeBMo7PeSTnZ8jpb1wmzTooTE4LJc=
X-Google-Smtp-Source: AAOMgpdA7AU2HJsvA27UC00yJYx0pd5HjB/NumybQ58vOvls8APAs9MQGe+2RNQGmRxwDeX7Vh9Uwyjkp7oy5u7KWFE=
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr4426527wre.5.1531489302688;
 Fri, 13 Jul 2018 06:41:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 06:41:41 -0700 (PDT)
In-Reply-To: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 13 Jul 2018 21:41:41 +0800
Message-ID: <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 9:29 PM, Patrick Steinhardt <ps@pks.im> wrote:
> When power management for SCSI is enabled and if a device uses blk-mq,
> it is possible to trigger a `NULL` pointer exception when resuming that
> device. The NPE is triggered when trying to dereference the `request_fn`
> function pointer of the device's `request_queue`:
>
>     __blk_run_queue_uncond:470
>     __blk_run_queue:490
>     blk_post_runtime_resume:3889
>     sdev_runtime_resume:263
>     scsi_runtime_resume:275
>
> When the SCSI device is being allocated by `scsi_alloc_sdev`, the
> device's request queue will either be initialized via
> `scsi_mq_alloc_queue` or `scsi_old_alloc_queue`. But the `request_fn`
> member of the request queue is in fact only being set in
> `scsi_old_alloc_queue`, which will then later cause the mentioned NPE.
>
> Fix the issue by checking whether the `request_fn` is set in
> `__blk_run_queue_uncond`. In case it is unset, we'll silently return and
> not try to invoke the callback, thus fixing the NPE.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> Since at least v4.14, I am easily able to trigger above NPE by
> unplugging USB mass storage devices on my computer (Skylake, ASUS
> Z170I) with CONFIG_SCSI_MQ_DEFAULT=y. The attached patch fixes
> the issue, but keep in mind that this is my first patch, so the
> proposed fix may not be appropriate at all. Feedback would be
> highly appreciated.
>
>  block/blk-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index f84a9b7b6f5a..0a2041660cd9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -456,7 +456,7 @@ inline void __blk_run_queue_uncond(struct request_queue *q)
>         lockdep_assert_held(q->queue_lock);
>         WARN_ON_ONCE(q->mq_ops);
>
> -       if (unlikely(blk_queue_dead(q)))
> +       if (unlikely(!q->request_fn) || unlikely(blk_queue_dead(q)))
>                 return;
>

Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue is
triggered on your machine.

Could you share the steps for reproducing this issue?

Thanks,
Ming Lei
