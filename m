Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4522DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CABD2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKrYfFrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfAXNyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:54:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43711 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfAXNyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:54:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so3008512pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wb/YXWmYAbDllmzB/CA9nQcPQKTJqYfmjzcC3nPPS/c=;
        b=IKrYfFrCXUTAjLQCzNT+wloMK2B39o753UKIzu4a1nNAUfdVXt5oONy/HsaOcjvniX
         zHxssqETiMoqGtbutYCNZNlYXQ3RFws3YQEjTet0EJDhNgPCMBpQSZFnaRiqjEQXP0zs
         GQuiw9ymbXhwgweJErN0p6fKHT8BG+s0RXFu/F6367ClWuroGxoKKEPHhEr0aUsjDAIO
         C9MIC34qAL+c3x+g7zbnvZg6HbGQ1pQSV+pxwvmkBCxtsO6a8r+1A4SmVm9B39PvNnUj
         l2rBQlEG5G8F4om7xsIyoQ4xvl6xzO2DnP6YjjTcMGHTwCp/sUZJSxmOF/ZsBCsO28o/
         mOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wb/YXWmYAbDllmzB/CA9nQcPQKTJqYfmjzcC3nPPS/c=;
        b=b2X0RZvdO5HHIb+QnCl48iWFg6t5ykM9CFE5QcZZmfHx2yEdOdRbwmebqRaIiBZojG
         /UkeLUsvWsgOM60bB44BUr0H+7jPvRuHA8OBZwARfO/6zRwm+RTTetIUEQvNpJExgChx
         XCHrzNP75cmRWx2C321SIO2/ZqbhJ4IU37g3mydLYs3tVGCTMZMWT3jYBPZbiUmpWqfw
         atzaJRtAziUmELbzOtYCyBJvgj6mls6Ic5AaprCuVa1qF3VjOATy042kAcVvgjLj5K0L
         9OPzm0ZVrEBwZ/5HRwjdVsKjBVB1wqBUN4Cq9cChSA364F1BL9r2BYA+5AFIRVrtjeJc
         drtQ==
X-Gm-Message-State: AJcUukcDhD6NG7cJw2Fd9SlLwVFfvx1P+JdZX84dR7h3sTBsKD/Yh9hq
        czoXPliv/PcRjjN2AtR//PDKf/lDpdfYVb4Snzs=
X-Google-Smtp-Source: ALg8bN5nDyRJun11p8Z/dw7/IYKL3CjQSaqFBuLe5Txhij3F7mL2Dg/3Eu1hnPRIxAsN7QvHESvE/SySVBhDt4fD1sk=
X-Received: by 2002:a62:d005:: with SMTP id p5mr6570174pfg.175.1548338062640;
 Thu, 24 Jan 2019 05:54:22 -0800 (PST)
MIME-Version: 1.0
References: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn> <1548348038-69560-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1548348038-69560-4-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 15:54:11 +0200
Message-ID: <CAHp75VeB=-zBw+FvKdXrMYQB4b8D3q96NTU1hgKekWJ6W_8khA@mail.gmail.com>
Subject: Re: [PATCH V4 3/6] misc/pvpanic: add API for pvpanic driver framework
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:17 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Add pvpanic_add/remove_device API. Follow-up patches will use them to
> add/remove specific drivers into framework.

I'm not sure this is the best way to instantiate the drivers.

Code with platfrom_device_add*() is related to platform which
instantiates the necessary set of the drivers.
In case of OF it should be done in Device Tree, in ACPI case you would
have some device description for that in DSDT table.

> +int pvpanic_add_device(struct device *dev, struct resource *res)
> +{
> +       struct platform_device *pdev;
> +       int ret;
> +
> +       pdev = platform_device_alloc("pvpanic", -1);
> +       if (!pdev)
> +               return -ENOMEM;
> +
> +       pdev->dev.parent = dev;
> +
> +       ret = platform_device_add_resources(pdev, res, 1);
> +       if (ret)
> +               goto err;
> +
> +       ret = platform_device_add(pdev);
> +       if (ret)
> +               goto err;
> +       pvpanic_data.pdev = pdev;
> +
> +       return 0;
> +err:
> +       platform_device_put(pdev);

> +       return -1;

It should return proper %-ERRNO code. I think to achieve this the
following can be used

return ret;

> +}

>  static int pvpanic_platform_probe (struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct resource *res;
> +       void __iomem *base;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (res) {
> @@ -59,8 +96,10 @@ static int pvpanic_platform_probe (struct platform_device *pdev)
>                 base = ioport_map(res->start, resource_size(res));
>                 if (!base)
>                         return -ENODEV;

> +               pvpanic_data.is_ioport = true;

You better allocate this on a heap and put as a pointer to the device
driver private data.

>          }
>
> +       pvpanic_data.base = base;

Ditto for entire pvpanic_data instance.

-- 
With Best Regards,
Andy Shevchenko
