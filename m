Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AFEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1D320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="QrohxhwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfAQGR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:17:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39310 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfAQGR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:17:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so10183971qtj.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKfY06XBvP+7+lbG+bUd4k8JgUNDe4s1OC2BG4+aqNQ=;
        b=QrohxhwH+D46iYBRsQWtmMIQDDPdVNdtow+/ApAd/32mCnidizUfQOmFMdAIe8fcLw
         y8frZX0ZFffmR+9hEtWESUAUy0cOu4N0QsyVJYh8wikeRI4TYnk5i138YQW30SjCPYKp
         7N63THQsW+z6Z+Qz9ut5aTs7kFbJHp87ul2yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKfY06XBvP+7+lbG+bUd4k8JgUNDe4s1OC2BG4+aqNQ=;
        b=O8l7VSGShnbvLZt9CE2D/Nz6u2pFn1+HW4G2u6xcSbU6bTrw6mT6f/ecE9qxAV3faz
         ForH+cWjKogeOC+JOjPmfLPjN1JwdMpOgKwS//AWsDybFeraf5erOpdUhDWmdv27gRad
         UYj3vDUMZgzt5TFVjdd1V5KIXsWYH2PEN4ynTBECyvbV3qFBGY7b7G3i6nPAFrxvcgQ9
         BdUR8HUCwrIKLd+tJ8got0OP4cwngPDuo7jD1Amy1/irOxbI50+6BFYu2VIsmQtb7Fcl
         NS2CeWMl5Bdni7nE6xR4V7S2Ywvn0unsFnjhElJq58GbGll2lJvGpixH1y9qNAYcE4ji
         tYqg==
X-Gm-Message-State: AJcUukdwRHM24z1A2L8nVdj4qIOccLHE/sFoAHW7SESB4LqSG1MkYeoL
        U7mpLZo5m5VD61CqdhhQ+CLAkaFqT1JO4YRqjMY=
X-Google-Smtp-Source: ALg8bN5JkY1m/cQon+3Je4qTIUqCns1PRy7wSqDPtkx1aQq/lr6LJ3SkBE7UsuAG3vxioE1AKMPRT5667+U/NQFoX7g=
X-Received: by 2002:ac8:748:: with SMTP id k8mr10223752qth.235.1547705847795;
 Wed, 16 Jan 2019 22:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20190116220154.1026171-1-vijaykhemka@fb.com>
In-Reply-To: <20190116220154.1026171-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 17 Jan 2019 17:17:16 +1100
Message-ID: <CACPK8XdCVvUaCFsMXdEkc9KG0TQCGpYV55u-X7pY7vBLLHuQtw@mail.gmail.com>
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
To:     Vijay Khemka <vijaykhemka@fb.com>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 at 09:02, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Makiing memory-region and flash as optional parameter in device
> tree if user needs to use these parameter through ioctl then
> need to define in devicetree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Thanks! This looks okay to me. I tested it on one of our systems which
uses both flash and reserved memory and it was fine.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Can you also send a patch to update the bindings at
Documentation/devicetree/bindings/mfd/aspeed-lpc.txt ? I think the
only change you need to make is to move the memory region and flash
properties to optional (instead of required).

Cheers,

Joel

> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index a024f8042259..332210e06e98 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                 unsigned long param)
>  {
>         struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> +       struct device *dev = file->private_data;
>         void __user *p = (void __user *)param;
>         struct aspeed_lpc_ctrl_mapping map;
>         u32 addr;
> @@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                 if (map.window_id != 0)
>                         return -EINVAL;
>
> +               /* If memory-region is not described in device tree */
> +               if (!lpc_ctrl->mem_size) {
> +                       dev_err(dev, "Didn't find reserved memory\n");
> +                       return -EINVAL;
> +               }
> +
>                 map.size = lpc_ctrl->mem_size;
>
>                 return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
> @@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                         return -EINVAL;
>
>                 if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
> +                       if (!lpc_ctrl->pnor_size) {
> +                               dev_err(dev, "Didn't find host pnor flash\n");
> +                               return -EINVAL;
> +                       }
>                         addr = lpc_ctrl->pnor_base;
>                         size = lpc_ctrl->pnor_size;
>                 } else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
> +                       /* If memory-region is not described in device tree */
> +                       if (!lpc_ctrl->mem_size) {
> +                               dev_err(dev, "Didn't find reserved memory\n");
> +                               return -EINVAL;
> +                       }
>                         addr = lpc_ctrl->mem_base;
>                         size = lpc_ctrl->mem_size;
>                 } else {
> @@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>         if (!lpc_ctrl)
>                 return -ENOMEM;
>
> +       /* If flash is described in device tree then store */
>         node = of_parse_phandle(dev->of_node, "flash", 0);
>         if (!node) {
> -               dev_err(dev, "Didn't find host pnor flash node\n");
> -               return -ENODEV;
> -       }
> -
> -       rc = of_address_to_resource(node, 1, &resm);
> -       of_node_put(node);
> -       if (rc) {
> -               dev_err(dev, "Couldn't address to resource for flash\n");
> -               return rc;
> +               dev_dbg(dev, "Didn't find host pnor flash node\n");
> +       } else {
> +               rc = of_address_to_resource(node, 1, &resm);
> +               of_node_put(node);
> +               if (rc) {
> +                       dev_err(dev, "Couldn't address to resource for flash\n");
> +                       return rc;
> +               }
>         }
>
>         lpc_ctrl->pnor_size = resource_size(&resm);
> @@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, lpc_ctrl);
>
> +       /* If memory-region is described in device tree then store */
>         node = of_parse_phandle(dev->of_node, "memory-region", 0);
>         if (!node) {
> -               dev_err(dev, "Didn't find reserved memory\n");
> -               return -EINVAL;
> -       }
> +               dev_dbg(dev, "Didn't find reserved memory\n");
> +       } else {
> +               rc = of_address_to_resource(node, 0, &resm);
> +               of_node_put(node);
> +               if (rc) {
> +                       dev_err(dev, "Couldn't address to resource for reserved memory\n");
> +                       return -ENOMEM;
> +               }
>
> -       rc = of_address_to_resource(node, 0, &resm);
> -       of_node_put(node);
> -       if (rc) {
> -               dev_err(dev, "Couldn't address to resource for reserved memory\n");
> -               return -ENOMEM;
> +               lpc_ctrl->mem_size = resource_size(&resm);
> +               lpc_ctrl->mem_base = resm.start;
>         }
>
> -       lpc_ctrl->mem_size = resource_size(&resm);
> -       lpc_ctrl->mem_base = resm.start;
> -
>         lpc_ctrl->regmap = syscon_node_to_regmap(
>                         pdev->dev.parent->of_node);
>         if (IS_ERR(lpc_ctrl->regmap)) {
> @@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> -       dev_info(dev, "Loaded at %pr\n", &resm);
> -
>         return 0;
>
>  err:
> --
> 2.17.1
>
