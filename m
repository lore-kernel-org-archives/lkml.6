Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A917C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BF221741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545303875;
	bh=O9Rc4MsAAGaWrt2dZvTPHAYSNa8d7N7oOmtHgO58pto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iA4V2e1Xw1UaEnS384dsF585pqSfPP8mretPQ1LK19xHEVzUIyZ5EJx6pDHj78OnM
	 XTy54zb1qCvgstZoz0BNcyJsMIushXeFXjRC/9hNfrnPaScPJvY31nowXYreFxxDBa
	 amf9MGu3s8m4nzkgkDfLRaSclE8F9uz35p2KgFQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeLTLEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:04:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39156 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLTLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:04:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so1228377oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 03:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ir0envVVH0hSP6+Lnkse77QqFdAXZk5hEs4bcky0ZQc=;
        b=pL2rX2JasPNc9SPIuuhqvUI7/Xi+/87HwvZBVEfa4Drap9JWccwOpCjJ5vLiD7lp38
         MitquKjyMpWNObHdqAtd/4Fc1pXLJr4hWmQRJv3tee0Qyv7fAz8gt9N05EVshHN0CFmY
         lMrydhi4Aq6Yuj3TC+/jQTzl6FfA5y/EhhpMH4UqyVDrEX36njk0x5D3lKA5L1AJ2Mms
         e4Iao1M74yeSOV8MBlQXs4Vjc/ahkB/SYdMjARmVZRHep3NESt1BkM1iECHdnxX7X5hu
         Eo9oREkIj2g0ongbsBWo5HMZ/XlNOpeqJHv6Cpt4NaaVACF57u5hwNLzo2QFS20ZjlMn
         Nw/g==
X-Gm-Message-State: AA+aEWas6NHXMeI6qEgLAu4I3B8soqQB4LBi1kTmwVPFIoJl/ZkMzMVG
        uiYuX3b8uHWavaahNZmdsHXXMjtPS9oLDydWwgs=
X-Google-Smtp-Source: AFSGD/XBMKcRLYfmek0EtOz39gnxt7uxaPRa/MPzaqACkHxZjnEDaMkSx5Bdv12Ubh/SRyLGHUnndQC7xHmit1C1R8E=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr1730457oic.33.1545303872421;
 Thu, 20 Dec 2018 03:04:32 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a@eucas1p1.samsung.com>
 <20181220102247.4911-1-a.hajda@samsung.com> <20181220102247.4911-3-a.hajda@samsung.com>
In-Reply-To: <20181220102247.4911-3-a.hajda@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Dec 2018 12:04:20 +0100
Message-ID: <CAJZ5v0jW3qu+ctS8h3BwZeQBD_6sF+yCPoQ1P-hEBidmOyWRkw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] driver core: add deferring probe reason to
 devices_deferred property
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:23 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v4:
>   - removed NULL check before kfree,
>   - coding style tweaking.
> v3:
>   - adjusted deferred_devs_show, to accept newline ended messages,
>   - changed conditonal check to positive,
>   - added R-b by Andy.
> v2:
>   - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
>   - use kasprintf instead of bunch of code,
>   - keep consistent format of devices_deferred lines,
>   - added R-Bs (again I hope changes above are not against it).
> ---
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c |  9 +++++----
>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>  3 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..effbd5e7f9f1 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -75,6 +75,7 @@ struct device_private {
>         struct klist_node knode_driver;
>         struct klist_node knode_bus;
>         struct list_head deferred_probe;
> +       char *deferred_probe_msg;

Many drivers will never use this, so is the memory overhead justified?

>         struct device *device;
>  };
