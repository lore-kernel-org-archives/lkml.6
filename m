Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69958C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E49E23E63
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVwuMxqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E49E23E63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933185AbeF0IAM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:00:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38472 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932986AbeF0IAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:00:09 -0400
Received: by mail-it0-f67.google.com with SMTP id v83-v6so6091664itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y8NCbZQLRZIKhes2Leln1qXGmPc1uE94VXhJVKW8aKw=;
        b=cVwuMxqnx8odHvDT3B+Bwb0EMzW1meAb4/PvpGuePRKNnzfymcHs/qYXl1E/Nzj8FU
         XKx8DTBahIhFvGUrbAZTs4WldEc2mbSyEHiIxJIMTdckICchvC0YSYe1q9XNjt5zkINt
         Otf8hwYU6xwPRfot+6DcBfGzun1LGz+nUHyKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y8NCbZQLRZIKhes2Leln1qXGmPc1uE94VXhJVKW8aKw=;
        b=g87YJgypQBDbNPPGowEbJ3eyPaP3FF8FHiqgAfOE+NfR9t2z9tFHKbavInlFyWYS+D
         6aLVsnU9Z49+Gvx3/gY6JAhS+O9+uDtdyh2Z9kXWbYK1RIHz+ZzWO9CnfwoMXX47IAe5
         cbSWzn8sdhf2HJSxk/CL9bDBL69zWluG9YeC2syGS9VgsqoxrVXxA/9CpZH0258tVc9D
         ERWUZXzK8pYZrFg6AV2vqv5MJHR+WHj8XiqbIGKMJoJ20QfWgWxUma6/LozFuUmrST75
         hUOv9P69rvigeU4+9qzkIt/5sQwNEITyq+6WXHqPRTdLA9Nx0UvqktWawbh0peKM0lNS
         /qWg==
X-Gm-Message-State: APt69E38jG+1liqdQglZHBm3j2uFOFqrBNqUS1iAURYzNra9qJNzut6r
        49Bsc0jGrRnALHzEuWTXTRaD9GVK1EatQwGn3A1mkQ==
X-Google-Smtp-Source: AAOMgpdas4R968POhYyoySxuK6mBOseyMxkvuoQPgyMUArFe16xEybNRC4x9sDS+ygK8+y0AD+MSsGDGwuGRLde6hvA=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr4386220itc.102.1530086408571;
 Wed, 27 Jun 2018 01:00:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 01:00:08
 -0700 (PDT)
In-Reply-To: <ed497b2a9751df3b2f84cc9db6d6834816a6027f.1530004712.git.sean.wang@mediatek.com>
References: <cover.1530004712.git.sean.wang@mediatek.com> <ed497b2a9751df3b2f84cc9db6d6834816a6027f.1530004712.git.sean.wang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Jun 2018 10:00:08 +0200
Message-ID: <CAPDyKFp4kESPH4hcqgATYWBt3Kz3FhAOCpnrCc5PRSkMkBikEg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] serdev: add dev_pm_domain_attach|detach()
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

On 27 June 2018 at 07:43,  <sean.wang@mediatek.com> wrote:
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/tty/serdev/core.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index df93b72..8096138 100644
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
> @@ -330,8 +331,17 @@ EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>  static int serdev_drv_probe(struct device *dev)
>  {
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> +       int ret;
>
> -       return sdrv->probe(to_serdev_device(dev));
> +       ret = dev_pm_domain_attach(dev, true);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdrv->probe(to_serdev_device(dev));
> +       if (ret)
> +               dev_pm_domain_detach(dev, true);
> +
> +       return ret;
>  }
>
>  static int serdev_drv_remove(struct device *dev)
> @@ -339,6 +349,9 @@ static int serdev_drv_remove(struct device *dev)
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
