Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 91FE4C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E959E208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1LuZHqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E959E208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeFNI61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:58:27 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42032 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbeFNI6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:58:23 -0400
Received: by mail-io0-f195.google.com with SMTP id r24-v6so6378960ioh.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qz9dx9asYfpqPveRT3qKL9SCYTDiHMd9TYDd6idML5U=;
        b=d1LuZHqOdRH27D4+TYPoH3Xzi4hsRrJ867zWFNLGPpAZN1O1a40Nucy/NEc88A0QUU
         IvtQFLcOFWJfjwXnCY5lhkaXX4T6Vw2bm95BHCsSsoLARx1HnqnVKQLVD66J7res0mIs
         L0Mj9De1EWu8ZBB/clZS5e8SAPUXXreOZAWVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qz9dx9asYfpqPveRT3qKL9SCYTDiHMd9TYDd6idML5U=;
        b=HHGtQ1rnnduqbMm/gCOl63uhCS4imaTJrx4LKDVHXriZo3DO6d4K97JQvw57dlENID
         30iq20VEBupLwBMsqUF1iTh/xl3yao1rSDRsQ1VFHn1S6LVWvKohTfX2a2BH3FMSYfS+
         VF/xFtqtSN9gJTXKKi6ADAtuY6aHMNyW4b61dA1OMbIVkgZ/lpEVTu5Dcvcemz3/9rnP
         Gxz+/sL3B4peQD7OhZrVDpvdWpyLaj56tgscq4T4foUfTDeQvEJr1cRptP/8MOmHI3I0
         DgWBeByaJESodNzyp0teW+tls6HBjv3STuusnO5A8I+bl69YARRSOYaKTz2Rp9+aOhV8
         qPvA==
X-Gm-Message-State: APt69E2bp3abLNaw0yFDyGGCYwWUDgJulnzz3AKBMY1uPaqN/SJh7i6U
        84XvnIFqstdGQh+mxJd+cSkzudkwiYmZZA9eSPb/SA==
X-Google-Smtp-Source: ADUXVKKcwTb46oR7xlJqgqkiY1sa3/TMEP/MD0epaSWbDIiQvy0KQvdptw7+EEKlGLZUrUyUn06w169pmEt0QEJmRXs=
X-Received: by 2002:a6b:1410:: with SMTP id 16-v6mr1491951iou.218.1528966703091;
 Thu, 14 Jun 2018 01:58:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:58:22
 -0700 (PDT)
In-Reply-To: <e338118bb6b9f560560887eb974eb250a6c89984.1528960095.git.sean.wang@mediatek.com>
References: <cover.1528960095.git.sean.wang@mediatek.com> <e338118bb6b9f560560887eb974eb250a6c89984.1528960095.git.sean.wang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Jun 2018 10:58:22 +0200
Message-ID: <CAPDyKFqVpfhJf3R3jbXtjGgXf+0pg=9dgALBnxM_bSyBQrQQDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] serdev: add dev_pm_domain_attach|detach()
To:     sean.wang@mediatek.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 at 09:14, <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> In order to open up the required power gate before any operation can be
> effectively performed over the serial bus between CPU and serdev, it's
> clearly essential to add common attach functions for PM domains to serdev
> at the probe phase.
>
> Similarly, the relevant dettach function for the PM domains should be
> properly and reversely added at the remove phase.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serdev/core.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index df93b72..c93d8ee 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/serdev.h>
>  #include <linux/slab.h>
>
> @@ -330,8 +331,16 @@ EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>  static int serdev_drv_probe(struct device *dev)
>  {
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> +       int ret;
> +
> +       ret = dev_pm_domain_attach(dev, true);
> +       if (ret != -EPROBE_DEFER) {

From 4.18 rc1 via commit 919b7308fcc4, dev_pm_domain_attach() will
return better error codes.

I suggest to change the above error path to:
if (ret)
     return ret;

Then continue with the probing below.

> +               ret = sdrv->probe(to_serdev_device(dev));
> +               if (ret)
> +                       dev_pm_domain_detach(dev, true);
> +       }
>
> -       return sdrv->probe(to_serdev_device(dev));
> +       return ret;
>  }
>
>  static int serdev_drv_remove(struct device *dev)
> @@ -339,6 +348,9 @@ static int serdev_drv_remove(struct device *dev)
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
>         if (sdrv->remove)
>                 sdrv->remove(to_serdev_device(dev));
> +
> +       dev_pm_domain_detach(dev, true);
> +
>         return 0;
>  }
>
> --
> 2.7.4
>

Otherwise, this makes sense to me!

Kind regards
Uffe
