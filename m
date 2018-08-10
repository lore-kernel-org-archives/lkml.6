Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431B9223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431B9223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeHKAIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:08:51 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:41460 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeHKAIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:08:51 -0400
Received: by mail-wr1-f53.google.com with SMTP id j5-v6so9408302wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LyNZFtMNJQphQmaldV54Ai55lkL4ab+YmLYwT1zshu0=;
        b=Zhekg097OfAsC0WeluMlEKWL7Ck7axccW0cNQ0lncP63+MjY5lChSDvUfRqYEFiPoK
         qfkBTYazHI/UtIRAou0qEgQ0zM2fsGNQ6h/66cek6Yk12qHzJHmVWBlBOaCO9lYIuXb+
         HXsb1yS+xlbdpAUMLXP7LZvaUDZcFH84o6oriGJ+mYelofZHvZns7SCSNJZ5J2gmyI+r
         twRgc3siS5o7RjxG3C5YRLVjMZxS4bxI6NoZk24ARv/MZXw4qUdFMTw1XonkC7DjPhXy
         /4bDwgre3nosDTza52dB9VZXYx7aKMrNkn2mS5ALnHumKa/29mtVTHCvElf+29lbKCF5
         3r0w==
X-Gm-Message-State: AOUpUlHNMJ9ZPKA7A+YYoZUrOykcAEMhW+32CAAGbT3bAHaEUtDS4Ppd
        6Ctue8xvXlRKG6oWJv+5+ywfX9wI9XgQE9PFKDYvIw==
X-Google-Smtp-Source: AA+uWPzJfmXYSvAF6zhwBFmLIPYqsvKdLgHh2OPKcSfubdNz4Z4z8ODuqGxHst3Gyy9RNKS1COopKjQ/j4jYAtcxEPU=
X-Received: by 2002:a5d:4007:: with SMTP id n7-v6mr5322287wrp.258.1533937032733;
 Fri, 10 Aug 2018 14:37:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 14:37:12
 -0700 (PDT)
In-Reply-To: <20180807203914.2192-9-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com> <20180807203914.2192-9-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 10 Aug 2018 23:37:12 +0200
Message-ID: <CACO55tv+QLcNRj7UDK=7NnoxTxpKHWd2GqU=Eftc-suhUn4J6A@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v5 08/13] drm/nouveau: Don't ignore
 nouveau_do_suspend() ret value
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Tue, Aug 7, 2018 at 10:39 PM, Lyude Paul <lyude@redhat.com> wrote:
> Otherwise, how will we roll everything back?
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Karol Herbst <karolherbst@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index db56e9b6b6af..f79b435368ec 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -842,6 +842,9 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>         }
>
>         ret = nouveau_do_suspend(drm_dev, true);
> +       if (ret)
> +               return ret;
> +
>         nouveau_switcheroo_optimus_dsm();
>         pci_save_state(pdev);
>         pci_disable_device(pdev);
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
