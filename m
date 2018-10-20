Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B311BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628BE21523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovKTnUEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628BE21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJTT2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:28:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35350 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeJTT2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:28:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id k3-v6so5387478qth.2;
        Sat, 20 Oct 2018 04:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hlCNvZ/28psHN4d+dk92f51LGhmIVK65Y9zhDtQS0k=;
        b=ovKTnUEfNkdkCowwz2SZslgbV6hm7spraTzYMN4KdgUsAzylggfEmHDVFkLCseRG+o
         by7tLdJ5ozYExSKJOP9vszYUexGCM8y3SPp8/d+nrmHPrkX5v1vfriD+8T0zX0aSp34O
         6vaS6C707Eri1Irm4VZWmwhdSlPrKeCxcKl3a3K3FNJ5PrIkzj+riCgx/FR7W2S+36zy
         Iur+ut3Nz180CXhPg1JAImS1maqpWFzI+WFAidKHP4jUDJk3mB+KdKg0Yomo2Q7kulCa
         M9a8F549ObAJuW06w4+bRIKHCGGocg0MMqYV+lhvZwj7lx5KSsjxoWxuug07ZEirlQZc
         rasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hlCNvZ/28psHN4d+dk92f51LGhmIVK65Y9zhDtQS0k=;
        b=oxtOT+D3N0sl8rPZ1g8GHzxtcFXQxqQ+Vg9TTgzdBXGBB8Muq92LWO+MOr78JGyRU/
         7a3n6gT/OB6aMG1hwxGdsRYlbNDIDYrcwS/2v/GG+MD8JITENXcySmTAzI9BmXLb8aR7
         dumGOTgEPpWhJTfW5cqAdOpZqWgii78OUnJ+pMtstoYHYZpJePGV8Xz/wtNJiScTQtsL
         W8fUAJTmeTVjv1rLEdDFeQgRLDRQYKOrbzODJ0+NML2Ha25+aiuN8I7Kv7kvg24pY8vA
         rVUlav06K/Myb5R6/kZu6+Gm5lYLteoh1n6QKDj2euErCqioRJhgg0SCiRKLuuNZ6Fmv
         McHw==
X-Gm-Message-State: ABuFfogES/5PzWyQtgUjK8NjqS/YdvXzIY8VQepquqkqRiVnaHiZyAIv
        R2hKLH6aWJ6pQ3m9o9hS5LythWvR/Hidq3cJuH4=
X-Google-Smtp-Source: ACcGV60PaBqmxjpe1mCCQFnMqdr5WQyKzteHLqWoT9258bY6ltM6u40DJmvHx8Wh9VNzPChgNqdcz5HSMgmjPRv+/4U=
X-Received: by 2002:ac8:6784:: with SMTP id b4-v6mr37022887qtp.373.1540034290304;
 Sat, 20 Oct 2018 04:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180421085009.28773-1-javier@emutex.com> <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
In-Reply-To: <1539969334-24577-3-git-send-email-dan@emutex.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Oct 2018 14:17:58 +0300
Message-ID: <CAHp75VcOxBFvr4MSd=y61t7eFAv=9pFzMsumd7=2jbW3aZ4O4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
To:     "Dan O'Donovan" <dan@emutex.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        carlos.iglesias@emutex.com, Javier Arteaga <javier@emutex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 8:27 PM Dan O'Donovan <dan@emutex.com> wrote:
>
> From: Javier Arteaga <javier@emutex.com>
>
> Allow userspace to use the on-board LEDs as "upboard:<color>:".



> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/upboard.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/acpi.h>

For better maintenance keep this ordered.

> +       adev = ACPI_COMPANION(dev);
> +       if (!adev || strcmp(acpi_device_hid(adev), "AANT0F01"))
> +               return -ENODEV;

Why do you need this part?

> +       if (led_index >= ARRAY_SIZE(upboard_led_names))
> +               return -EINVAL;

> +       if (!dev->parent)
> +               return -EINVAL;

...I think this check will cover cases when driver is being probed standalone.
Otherwise it's caller's responsibility not to instantiate it if
platform doesn't have this LED feature.

> +       regmap = dev_get_regmap(dev->parent, NULL);
> +       if (!regmap)
> +               return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko
