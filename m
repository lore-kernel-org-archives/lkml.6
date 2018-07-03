Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EAAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493302075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo2qksBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493302075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeGCVH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:07:27 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43397 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeGCVHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:07:25 -0400
Received: by mail-vk0-f65.google.com with SMTP id d74-v6so1915883vke.10;
        Tue, 03 Jul 2018 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/9RB/5mCLa3i3/vpf5O1Du1z9gOoB955j6bpXGe1Ugc=;
        b=Wo2qksBi44K/+H06tox/6MyDuyCoShwPctEaamrSMt/C1wyBSWMwXUBYvFORu3zU/z
         3dNUzPW2XDMrOT+YZcXTvrX4G8QBGJQ64XesxkXiYUU/p1ES84G9/irGutOklRmO1T9J
         Ph45oh14Y4xdUCkh+bYw9zlyZ+tLlAMLe5GgiFSVlXfiSsYhej2bCEZAMV58+P0bzdqc
         NywdiuxkidUeu+JkaifcxWnIFr36Ar/ELcUIqIKLJM8L6QeM/t/Kb+xpeZwTOFLRf6Wn
         u1sL4uWIkBbJrs3P+JJq6fKR8BNIWmRyx38HtuhdMK2Y3/mqu31t+9gE63lh8R/yP2HS
         l8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/9RB/5mCLa3i3/vpf5O1Du1z9gOoB955j6bpXGe1Ugc=;
        b=Za/Z3lC54f0ygtdghH4erB2WOX0tEnVFtEkEN8MYZ+u8NjAduVm+YtPmtywbNB1aN3
         YCFdRtb7I0jnq6r9xX1nnqxi+aQ9SpiZ/U7x6hEcUHi8tXPy6eMUEFgOJduewePGSvJs
         tNeUoR3sASBPeicm0iVYKZOI7WUHH49/FQkWbwGs29x4ybNvYpcE655ZyJS6AwD44cFJ
         gVDtHXzRHjqBGB9xgUPTBhE/9mQkWZ62WVmvJRr2vzDegUcdxOf4SOjwSlvH4AO2ptbL
         Ep02AcX2tLIsPWn9sJn6XDzyYxhglLWTgoS3qbvX6v4PZGapd9Kodax1g/3K+yGO7gXr
         b2mQ==
X-Gm-Message-State: APt69E1BwYtUDalFMjT+qk2sh8UuaXLXFvr7DuRyTW/VjPpMTSNJYsQ+
        sdyhZ5FhVMNXBQGzBynYJqgLZuDOHdVjqZXNTQK5lFYc
X-Google-Smtp-Source: AAOMgpeyTPutUt6EtI2ez6uNybxE7FebQyvgwRLcBGyOPIBJxYw3af5mSAU4r0sR3vcQvLFiNINWJ2M0NK/wF+4Abwg=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr4059845vkc.131.1530652044155;
 Tue, 03 Jul 2018 14:07:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 14:07:23 -0700 (PDT)
In-Reply-To: <1212fde5edcf360231282c9d2487712fc5b4d6f8.1530599660.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <1212fde5edcf360231282c9d2487712fc5b4d6f8.1530599660.git.nikolaus.voss@loewensteinmedical.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 00:07:23 +0300
Message-ID: <CAHp75VfjHy9=4ZMJqb-2H5iXDjMpM=vm5kvz4PVA_jTUkoSJKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] IIO: st_accel_i2c.c: Simplify access to driver data
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 8:41 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> Use device_get_match_data API to simplify access to driver data.

..._data()

But. You actually don't use it below.

> Let acpi_device_id table entries point to the same driver data as
> of_device_id table entries and uniquify access to driver data by using
> device_get_match_data API.

>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>

> +#include <linux/of_device.h>

(linux/property.h)

> +       match = of_device_get_match_data(&client->dev);
> +       if (!match)
> +               match = acpi_device_get_match_data(&client->dev);

What I meant is to simply call

match = device_get_match_data(...);

> +       if (match)
> +               strlcpy(client->name, match, sizeof(client->name));

-- 
With Best Regards,
Andy Shevchenko
