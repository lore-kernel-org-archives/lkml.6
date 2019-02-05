Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ECFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2506220844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3ZgolXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfBEQVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:21:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40682 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfBEQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:21:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so1680494pfo.7;
        Tue, 05 Feb 2019 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhybUiaWOUK3+Mqs5v8RsTacbBIbaFhSAp+RBUjyQzE=;
        b=W3ZgolXKpnHU/sbjgZUEaAs7ojxgTSiVuICuY+1N7IFKJElUUimAUyacGVL/JbMFV4
         /B5DK6rDlYkTiIvwTGh34/lSmyTjx53wg8Vst/3/WVv+zCrRjKnJbImrVN3ZSNQbbhrx
         Y3iEv0fONp8aIZABWHGBxHtgaKpxjoaBEnDog500XJbYVuqKagbbBpiksMoBDZmFRyR3
         fOiUOWl720Dc6CSSdTFu04Zm7r16euzTbKYbmaI+x1sxe7Zt/GQiAkRDuCXkdCRf1eFQ
         XmiHTUYEA12yL2rwrTKTAWK6WM6ZtB/e3NN9eYt7ayQ6/+9PQYWFaQLZrd4Zpm3OdxwU
         idgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhybUiaWOUK3+Mqs5v8RsTacbBIbaFhSAp+RBUjyQzE=;
        b=KWszGdF8WqimExSZxU14U1E8IxgTncMVuWA8iWXMXmwERJ+7zLQtCTMAhhrYJwmEgz
         c28WIKqcHei2x1sIOqLcgh82ZlfXdd/BJujXX4kH/Qvy2LBg4EfN4Ds5hr6o/zowzoO5
         5yT8HtdU5GXrnClm9sZ5SvHpN1b3ZB8wvPfkkvhkg69pX5NN5ZgLH8JSrmBOYJNIBOjc
         gRBmf3cuad7wJ+AcCqcUQMG/eWyR3JZV+82d3ZMYakaSvZvGao5xsZFEN4WwATK0bhrW
         CGJIKnJAxyXzxEseIjxkKi5M56KOzYR3Ij0Q+8AOlm2by+tgrTpl265RPcFqNbEL07jT
         f0Rw==
X-Gm-Message-State: AHQUAubybtSHD/QW+p3NxwwaTM0hBus7VGRoxpRgmBTMzHs7W7pmlQ6o
        2te46+V3mspiAcRUsOrpClAUcF983luBCCiRMJM=
X-Google-Smtp-Source: AHgI3IZyvcjtkf9UH6PxKiIEzhaCUuBm4DV/N6tVbXlgLm0yrgzp3DcX5oDTl5rIrA/E2gTRxO6t7ji7Pwqxpr4pUQo=
X-Received: by 2002:a62:34c6:: with SMTP id b189mr5871689pfa.229.1549383682876;
 Tue, 05 Feb 2019 08:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20181224220737.27539-1-pakki001@umn.edu>
In-Reply-To: <20181224220737.27539-1-pakki001@umn.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 18:21:11 +0200
Message-ID: <CAHp75VeT5hH+rfpndW_i1H9nEV5pJyeP=26-oHnJYcq64NE4TQ@mail.gmail.com>
Subject: Re: [PATCH] platform: x86: Add check for led_classdev_register
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 12:08 AM Aditya Pakki <pakki001@umn.edu> wrote:
>
> In function alienware_zone_init, the function led_classdev_register
> can return an error on failure. The fix checks the error and frees
> the allocated resources.
>

I'm not sure about this.
Is the LED registration fatal?

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/platform/x86/alienware-wmi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/alienware-wmi.c b/drivers/platform/x86/alienware-wmi.c
> index f10af5c383c5..63ab6a2eb613 100644
> --- a/drivers/platform/x86/alienware-wmi.c
> +++ b/drivers/platform/x86/alienware-wmi.c
> @@ -441,6 +441,7 @@ static int alienware_zone_init(struct platform_device *dev)
>         u8 zone;
>         char buffer[10];
>         char *name;
> +       int ret;
>
>         if (interface == WMAX) {
>                 lighting_control_state = WMAX_RUNNING;
> @@ -492,7 +493,17 @@ static int alienware_zone_init(struct platform_device *dev)
>         zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
>         zone_attribute_group.attrs = zone_attrs;
>
> -       led_classdev_register(&dev->dev, &global_led);
> +       ret = led_classdev_register(&dev->dev, &global_led);
> +       if (ret < 0) {
> +               if (zone_dev_attrs) {
> +                       for (zone = 0; zone < quirks->num_zones; zone++)
> +                               kfree(zone_dev_attrs[zone].attr.name);
> +               }
> +               kfree(zone_dev_attrs);
> +               kfree(zone_data);
> +               kfree(zone_attrs);
> +               return ret;
> +       }
>
>         return sysfs_create_group(&dev->dev.kobj, &zone_attribute_group);
>  }
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
