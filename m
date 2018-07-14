Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A6CECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A463C20896
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/r3R2h4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A463C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeGNQQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:16:32 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40699 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeGNQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:16:32 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so13907176ybm.7;
        Sat, 14 Jul 2018 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HwHZMPoWLasNY5WCoKItAo80+rfiDuGKoVBN3gf+QgA=;
        b=C/r3R2h4mZHiXnlPBnDRVoOqj10QO+AEyoJML6hX5tw15l4U5kr2nnO7ZYGSo8v8Qf
         h1uBBvRcR74aFlXhRezcthQSvEpJSW0zjw5YObMJxhqwsQapJdtPhZhSLUF+8Q6INBdU
         amyEFIRVNqDQLBF1DzScoi/agi/okC/VR09TPfDGiWrYkwrJtutMck4bWuzwmwe0xRGG
         3gZoOfrhZ0Qpjl/OKrTZc4WQFKLJWZBohufl7NlQ8Bhq5YYYEr7Jw5csgxl0qmyq05RF
         PwPA3LPuIn5+BgStVOPi3VbtcsfdF4BPCgRKjULoJCA8l5/ATyBNRuj7lCkA/7DcNNyO
         gzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HwHZMPoWLasNY5WCoKItAo80+rfiDuGKoVBN3gf+QgA=;
        b=uCN5c0O2gUR/1ORTwiOp5Kt1h2o1dNrRJBVlKnRFFpE1/vN4C5IBlFtDrsjzeuyN+x
         GURcQkv67Yf94GKwbkgCnT9DI5a5lP8VevaA+cGSIaprALs9u6KySCONPlcjcGQZKQOt
         mctamK/8SkLXElcyEczczb6pK9fWtEyKdnJJL5QIZ22La0ar/JbKtpJLX4UG5sDeqPbw
         G1RSidFpmohX/726MWXzxT8pXNr332mqlPKB/TJBgpH3CQYz7lpRnkMe581aHqg2AdOR
         SvSjeSD5xWK2hj0hyvsj53BA7c0Fen1QMfGlIDEojW/oGWg/CdDs/UqF4Y/VbNvXFmxM
         GfvA==
X-Gm-Message-State: AOUpUlG7A2F+eHEEFoC12NyUd7mgEviOlSwZS+Yl9Z/ly/SXkdjVsJA6
        vZAOUg8li/BenJVVXNPv3QWu+Qsvi35OqctraJ4=
X-Google-Smtp-Source: AAOMgpfOb1TWVfCbne1ZLcw+6xmHfH1X3CAFH3DHITl33rLz7pVYRc57FzSFu//IVXB3oWDwKWWM1tSxCMLJjSDSOPc=
X-Received: by 2002:a25:1388:: with SMTP id 130-v6mr5362248ybt.346.1531583822075;
 Sat, 14 Jul 2018 08:57:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:5d04:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 08:57:01
 -0700 (PDT)
In-Reply-To: <20180713235021.18141-1-qing.huang@oracle.com>
References: <20180713235021.18141-1-qing.huang@oracle.com>
From:   Or Gerlitz <gerlitz.or@gmail.com>
Date:   Sat, 14 Jul 2018 18:57:01 +0300
Message-ID: <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same devices repeatedly
To:     Daniel Jurgens <danielj@mellanox.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, gerald.gibson@oracle.com,
        Qing Huang <qing.huang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 2:50 AM, Qing Huang <qing.huang@oracle.com> wrote:
> When a CX5 device is configured in dual-port RoCE mode, after creating
> many VFs against port 1, creating the same number of VFs against port 2
> will flood kernel/syslog with something like
> "mlx5_*:mlx5_ib_bind_slave_port:4266:(pid 5269): port 2 already
> affiliated."
>
> So basically, when traversing mlx5_ib_dev_list, mlx5_ib_add_slave_port()
> shouldn't repeatedly attempt to bind the new mpi data unit to every device
> on the list until it finds an unbound device.

Daniel,

What is mpi data unit?

Or.

>
> Reported-by: Gerald Gibson <gerald.gibson@oracle.com>
> Signed-off-by: Qing Huang <qing.huang@oracle.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index b3ba9a2..1ddd1d3 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -6068,7 +6068,8 @@ static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev, u8 port_num)
>
>         mutex_lock(&mlx5_ib_multiport_mutex);
>         list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
> -               if (dev->sys_image_guid == mpi->sys_image_guid)
> +               if (dev->sys_image_guid == mpi->sys_image_guid &&
> +                   !dev->port[mlx5_core_native_port_num(mdev) - 1].mp.mpi)
>                         bound = mlx5_ib_bind_slave_port(dev, mpi);
>
>                 if (bound) {
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
