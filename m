Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A162C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69F124718
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTlPFlHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69F124718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeGCWtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:49:21 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36176 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbeGCWtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:49:19 -0400
Received: by mail-vk0-f68.google.com with SMTP id y9-v6so2051914vky.3;
        Tue, 03 Jul 2018 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jS+vMyroQMEbULqchU512EKlRNxArORGrYSpkK1HPH4=;
        b=KTlPFlHQ5d18pZarTNLx8jJammCo23R8N/I3sPfRzNYRHA/yS7vQAXHdtFCJ21ONal
         6QvLkNXFnAgQsxLiL7OOck91apGqzvpGoTAh2GTgfq11rCldzoki++fW+eu/AAKiGJfA
         8PK2aaB3+5nhZKHPG66Wr7Ar1usYmf7JXMx1S1r+j0iqr1H5TPvq0fE7V+tDJf6WFjLC
         fnFw6EDWZsYtRxbsoy0fMmoxnhYIJTItGDOb7GOVHkhsIdAFd7Pm/4fkJd/QQzuCbEqp
         PAwc/LSf9g9K7gTQ8UL0nlgxQBuF2nI7O58YyJSaf2m8pCHufn8WHY+wB+Cc7HD0zelx
         6ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jS+vMyroQMEbULqchU512EKlRNxArORGrYSpkK1HPH4=;
        b=nwccj7T5kLdzC+xC8ZuAi3fi3SpRwKdTFeshnYacWc1PJ2vdnJJCiA35XweM1bTysH
         QqdzOMQLfDwBXthnt/DGFp0QgWC2f8Gzi4wJw7xMdML2+Ziu6eRhcYvB8ZSm+FI4uZ5j
         iye1RcheACIN6h44s8kM1P6JpPhpjSqvQy2kRvKfh2nveks2Ay21MXVbaLEGj5eA0ejN
         3eCTJ+mmT3OO3b7bGy0ZXTDiXLeiTGuLzoBBNWXFjHEcKCv7bgTm1AQT5J32Kka9/nlc
         Y2DbpAwbWwWAxRQvNe6p6xOTzb40KXJU9+2V8EZAwVkYk0i9aCv3Agn47DzPfsJig9DI
         Mnsw==
X-Gm-Message-State: APt69E2Ur9KTahB/dQw/37vxwBiJ8ZQeMjH5I546FykvvulIDThkiKmK
        E987h8jdqakrIpI3/OF0FRWIAz02Nvn8kBPBLsk=
X-Google-Smtp-Source: AAOMgpfZYjr7/FME+ZnQbp534VmVpnIhaptV8zsRehRRBgRwTvi/MO5vBdtQ1aZ+7l5mRtbQ1x4D+eh7Bw0geHqM7Hg=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr17540902vkg.176.1530658158837;
 Tue, 03 Jul 2018 15:49:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 15:49:18 -0700 (PDT)
In-Reply-To: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
References: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 01:49:18 +0300
Message-ID: <CAHp75VcHDWFpxupECf+tgn7S1esJ6SyPtCXeKG93LDVKRv91mA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:

Thanks for the patch, now I completely got it and agree on approach.
Few comments below.

> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
> of_device_id table "compatible" strings in DSD, a pointer to the

_DSD

> corresponding DT table entry should be returned instead of a null
> pointer. An acpi_device_id match still takes precedence.

>  const void *acpi_device_get_match_data(const struct device *dev)
>  {
> -       const struct acpi_device_id *match;
> +       const struct acpi_device_id *acpi_id = NULL;
> +       const struct of_device_id *of_id = NULL;
> +       const struct device_driver *drv = dev->driver;
>
> -       match = acpi_match_device(dev->driver->acpi_match_table, dev);
> -       if (!match)

> +       __acpi_match_device(acpi_companion_match(dev), drv->acpi_match_table,
> +                           drv->of_match_table, &acpi_id, &of_id);

Perhaps,

bool match;

match = __acpi_match_device(..);
if (!match)
 return NULL;

...
> +       if (acpi_id)
> +               return (const void*)acpi_id->driver_data;
> +       else if (of_id)
> +               return (const void*)of_id->data;

Actually (dbesides redundant 'else') there is no difference in which
order you test these.
Thus, perhaps

if (of_id)
 return ...of_id...;

return ...acpi_id...;

> -       return (const void *)match->driver_data;
>  }


-- 
With Best Regards,
Andy Shevchenko
