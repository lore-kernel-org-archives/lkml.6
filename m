Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C21AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A5C2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oF7bovPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A5C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeIYJYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:24:51 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36865 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeIYJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:24:51 -0400
Received: by mail-yw1-f65.google.com with SMTP id y14-v6so1534680ywa.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zeWTebeAxARUzl/YFhOMo2zcdGhREudniyf6t3HAxPI=;
        b=oF7bovPEIwn8CgjPH8HxJfEMEvE3zBIYU3fxT6/JVwLxB9i6xwuI1KzTwGrpzdIKxL
         Wcirs7k+8gyIWGPDwPw0nMzla9LVQD0uWrtHf1G60B0d0eR9auCkJAQfqUHPRoxc0WpE
         5vvKz4U/UsBEbCdGqeMTk1azyJZKHuZdrE0nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zeWTebeAxARUzl/YFhOMo2zcdGhREudniyf6t3HAxPI=;
        b=pxgp6Imco6L0FKQk6z6SZAUX6ed4CoaK/5q+CMpUscBLZyfzitcHzXAxnxPbxfdfr/
         X/8OO7bIpXahmYELAPo5lsfHAhcogw2x8jghRcYovWQ6OAkwRYJK+VPpCkT7sCuIKhQX
         bKpkNZIM3W3Vq+XoeRLUdA+7yGuPIMsKG2z8aRoq2lxwH5mPQBY5f91I8zoobULOT/xL
         AGNUiIF2yHc9h3SAoZE/x4hPoUXIPGSLeS9D1TRvcMOL3nWFfKu+XWggSLjWBBa1v55t
         kywR2GgSYuF523JjDWTd7xT7aEVzDuw1dSnoQwCi8Ruq4eQLK/ujMVOqQQUTD5EsJfCv
         ohXA==
X-Gm-Message-State: ABuFfojdR1TB5EDvnDqWFDbEpr01YS92mHn6xZLOIErK2kA8Q0IQrk56
        rnMalBVXHtTFzV//rMmBrfDsoSmDYME=
X-Google-Smtp-Source: ACcGV623kwhQ+/6zrTa+86zo0/mY5yKAayaBJXE9xmCgbNY1ojeuczUN4mXzA/yJtfmDE0QEoR288w==
X-Received: by 2002:a81:6c0b:: with SMTP id h11-v6mr762702ywc.427.1537845566880;
        Mon, 24 Sep 2018 20:19:26 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id j133-v6sm434649ywa.76.2018.09.24.20.19.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 20:19:25 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id j131-v6so8749349ywc.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 20:19:25 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr767475ywg.47.1537845565280;
 Mon, 24 Sep 2018 20:19:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 20:19:24
 -0700 (PDT)
In-Reply-To: <20180906000926.GA18830@beast>
References: <20180906000926.GA18830@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 24 Sep 2018 20:19:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ-Hbj143Sv7ikxmLnBPyvcd1cGoT5fSbwG21LomnsORw@mail.gmail.com>
Message-ID: <CAGXu5jJ-Hbj143Sv7ikxmLnBPyvcd1cGoT5fSbwG21LomnsORw@mail.gmail.com>
Subject: Re: [PATCH] sunvdc: Remove VLA usage
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 5:09 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> moves the math for cookie calculation into macros and allocates a fixed
> size array for the maximum number of cookies and adds a runtime sanity check.
> (Note that the size was always fixed, but just hidden from the compiler.)
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping. Jens, can you take this?

Thanks!

-Kees

> ---
>  drivers/block/sunvdc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> index 5ca56bfae63c..f68e9baffad7 100644
> --- a/drivers/block/sunvdc.c
> +++ b/drivers/block/sunvdc.c
> @@ -36,6 +36,10 @@ MODULE_VERSION(DRV_MODULE_VERSION);
>  #define VDC_TX_RING_SIZE       512
>  #define VDC_DEFAULT_BLK_SIZE   512
>
> +#define MAX_XFER_BLKS          (128 * 1024)
> +#define MAX_XFER_SIZE          (MAX_XFER_BLKS / VDC_DEFAULT_BLK_SIZE)
> +#define MAX_RING_COOKIES       ((MAX_XFER_BLKS / PAGE_SIZE) + 2)
> +
>  #define WAITING_FOR_LINK_UP    0x01
>  #define WAITING_FOR_TX_SPACE   0x02
>  #define WAITING_FOR_GEN_CMD    0x04
> @@ -450,7 +454,7 @@ static int __send_request(struct request *req)
>  {
>         struct vdc_port *port = req->rq_disk->private_data;
>         struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
> -       struct scatterlist sg[port->ring_cookies];
> +       struct scatterlist sg[MAX_RING_COOKIES];
>         struct vdc_req_entry *rqe;
>         struct vio_disk_desc *desc;
>         unsigned int map_perm;
> @@ -458,6 +462,9 @@ static int __send_request(struct request *req)
>         u64 len;
>         u8 op;
>
> +       if (WARN_ON(port->ring_cookies > MAX_RING_COOKIES))
> +               return -EINVAL;
> +
>         map_perm = LDC_MAP_SHADOW | LDC_MAP_DIRECT | LDC_MAP_IO;
>
>         if (rq_data_dir(req) == READ) {
> @@ -984,9 +991,8 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>                 goto err_out_free_port;
>
>         port->vdisk_block_size = VDC_DEFAULT_BLK_SIZE;
> -       port->max_xfer_size = ((128 * 1024) / port->vdisk_block_size);
> -       port->ring_cookies = ((port->max_xfer_size *
> -                              port->vdisk_block_size) / PAGE_SIZE) + 2;
> +       port->max_xfer_size = MAX_XFER_SIZE;
> +       port->ring_cookies = MAX_RING_COOKIES;
>
>         err = vio_ldc_alloc(&port->vio, &vdc_ldc_cfg, port);
>         if (err)
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
