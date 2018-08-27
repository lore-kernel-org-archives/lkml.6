Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1109208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmQ3XFZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1109208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeH0Sbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:31:42 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34606 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeH0Sbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:31:42 -0400
Received: by mail-it0-f67.google.com with SMTP id x79-v6so11861592ita.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Zbg0l+zPmcIWKxIIdhrxwqbyKJ1VUIkhHVxV2FVNnM=;
        b=YmQ3XFZSCaB+Zs9Qx+O4u1zTyD7oQPwtjHOR9DJcEOWM5gJOVZ2Ucd2+s+cv88kUA1
         NERsoA7RSqp6Rq7S3uy4fK7PAkvt4wqZjaPchhIM0e0SzHlXIPOVhgzw6rcA779H+wbs
         MV999QInIgdx4eHn9rHGNIEqCDD9hAR/LK1fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Zbg0l+zPmcIWKxIIdhrxwqbyKJ1VUIkhHVxV2FVNnM=;
        b=o+Go6hsw68sVrs+rXUCx9jrQg+iS8l6e/EcfvZ6IlNGVV23v+egdefrr4kNtsuRP4E
         RdyBaqMJW6HIBveZPof+1dnEjP42UBZnIuGTrn/ruHzgDr4aT8om0tmMzmclYjT6NMRj
         PsIYcmuM5uiszR6E0vzQ/2jvC4pPJxmrK3bGT7ElZmZ2o3lZ9oquZ0VJ1vafar7hCEjt
         yLfkYX0nIBXFvIU2enZEjbfWPcV8yR4BnifwtEdNVU6OeMQgoSQbQwxyjpUtE56yKuss
         s307iFRVHWRJhkxSLYlph4CdtjeTXIzQKWnkmH8ZH9fuE3po33EFq4HWiEc8+5xqP282
         8Dyw==
X-Gm-Message-State: APzg51CH8QhF0+yjG8XpK0iQPc4jpAleajnEu1pNm7Q2e9ZSzrH8wvLr
        az3dW475uWToM1YWAtNvvokRPDu1ImxgN0W5YtRb2g==
X-Google-Smtp-Source: ANB0VdYx5hNB2uukFtGsB3VkKSAIJA/A+W7dyfmm0dJwYKbMuImDTsbezyxLrfnqbCz51vcvvnOoAkR9VtAxUNJk1F4=
X-Received: by 2002:a24:a388:: with SMTP id p130-v6mr6854659ite.146.1535381085735;
 Mon, 27 Aug 2018 07:44:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 07:44:44
 -0700 (PDT)
In-Reply-To: <20180827082153.22537-5-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org> <20180827082153.22537-5-johan@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Aug 2018 16:44:44 +0200
Message-ID: <CAPDyKFot-Nx=R83vxS=WQp2kSFmMiQ7wfOK4m6hbPt0MB3Z25A@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mmc: meson-mx-sdio: fix OF child-node lookup
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 August 2018 at 10:21, Johan Hovold <johan@kernel.org> wrote:
> Use the new of_get_compatible_child() helper to lookup the slot child
> node instead of using of_find_compatible_node(), which searches the
> entire tree from a given start node and thus can return an unrelated
> (i.e. non-child) node.
>
> This also addresses a potential use-after-free (e.g. after probe
> deferral) as the tree-wide helper drops a reference to its first
> argument (i.e. the node of the device being probed).
>
> While at it, also fix up the related slot-node reference leak.
>
> Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
> Cc: stable <stable@vger.kernel.org>     # 4.15
> Cc: Carlo Caione <carlo@endlessm.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/meson-mx-sdio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 09cb89645d06..2cfec33178c1 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -517,19 +517,23 @@ static struct mmc_host_ops meson_mx_mmc_ops = {
>  static struct platform_device *meson_mx_mmc_slot_pdev(struct device *parent)
>  {
>         struct device_node *slot_node;
> +       struct platform_device *pdev;
>
>         /*
>          * TODO: the MMC core framework currently does not support
>          * controllers with multiple slots properly. So we only register
>          * the first slot for now
>          */
> -       slot_node = of_find_compatible_node(parent->of_node, NULL, "mmc-slot");
> +       slot_node = of_get_compatible_child(parent->of_node, "mmc-slot");
>         if (!slot_node) {
>                 dev_warn(parent, "no 'mmc-slot' sub-node found\n");
>                 return ERR_PTR(-ENOENT);
>         }
>
> -       return of_platform_device_create(slot_node, NULL, parent);
> +       pdev = of_platform_device_create(slot_node, NULL, parent);
> +       of_node_put(slot_node);
> +
> +       return pdev;
>  }
>
>  static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
> --
> 2.18.0
>
