Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA964C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CCD2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HopL6lEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CCD2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeJXVlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:41:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36842 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeJXVlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:41:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id q184-v6so3074042qkd.3;
        Wed, 24 Oct 2018 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TTgfZexPF4tbTxTsDxIB/fYN6LR4U1y7/B9NKb3n4o=;
        b=HopL6lEVq7bC4AL9lP3791oCmXR0NAE9HzZCdrdUa5XDg5gObrxnTCNuw9+cvUly1f
         NI/SIf3vriTXWhRXuhnii+5T0ZKS1kNgtXepwS/9xjCzUusK0qKdsV8TOAHHYMPZibyk
         u2yfVibOOrxgbOwjCmTYyCM41f7URhrR+rd1f7Df3zMAQKojsjh3rJ2xIBK8Jf9h0d2l
         PjTenlStz8iRcLbvuwNvXiuaNIYVw11bCErxsryhWFvzRPsXg/aho33Lt06oxsfOTDmZ
         X8bD96dMhRX2itPOxLlrlMZ+urND7OFOM/9M56KGVPomrVvIgarJEJ6+GguYn43PnNpK
         y4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TTgfZexPF4tbTxTsDxIB/fYN6LR4U1y7/B9NKb3n4o=;
        b=ah5KswLWzkhyXzeKREPyDhTEYNO9IBICT2DmJaWeBFLj+qpuNbj6DJTQRKca6Et5My
         2N3/EKlfzrMtBF+kNZcHWG+VpFaGu9BVM9S8q30ndJHc/eIk0xUBeikgBYViNE+OL7z9
         dp8noz16WO5uV9tyuQ/Z3klAkA5djxAPMFs3YSMqCBWEO+DGxFXifUTZrY7YkBaVs20g
         JZCBEKFeSeOlGGnuuj+0u9oVR5lUKEnJeScwOgW8s9fmQvfFQFy5Md67i4W0ZzzbjyZ0
         AQFjr9Zhbdaato87axZLAC9xjFjxwpRa3FzJLrhaBbYkmwjoBWECogj7m1SnwAWUlxbZ
         1tCQ==
X-Gm-Message-State: AGRZ1gISzVUZe2e5x5743cjSleo1eRwjF1Bx2jrHwtzFHKXFnLlnd8mL
        sSOaM9ohvcnHIDCjZsK+YUSC6UqbGBkhN6la2WU=
X-Google-Smtp-Source: AJdET5ceeH0NHiSf2it4s+nZJ0vxC8T+b3nBfXyGwMYQlde+mnYlU3VGb2saopnONXti4bStKWbKljg6To7fPzMA9F0=
X-Received: by 2002:ae9:f40b:: with SMTP id y11-v6mr2320193qkl.137.1540386780292;
 Wed, 24 Oct 2018 06:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <1540401136-78500-1-git-send-email-peng.hao2@zte.com.cn> <1540401136-78500-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540401136-78500-3-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Oct 2018 16:12:47 +0300
Message-ID: <CAHp75VfQQEsn8J_PWsET_ux-SagOVzavwo6Gy6EHQxuRD=78AQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] misc/pvpanic: add support to pvpanic device
 information by using FDT
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:02 PM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> By default, when ACPI tables and FDT coexist for ARM64,
> current kernel takes precedence over FDT to get device information.
> This patch increases the way to get information through FDT.

>   *  pvpanic.c - pvpanic Device Support
>   *
>   *  Copyright (C) 2013 Fujitsu.
> + *  Copyright (C) 2018 ZTE.
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License as published by

This hunk would be a separate patch which includes switch to SPDX and
removing the file name from the file itself.

> @@ -25,6 +26,10 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/acpi.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>

> +#include <asm/virt.h>

asm/* goes after linux/*

> +#include <linux/platform_device.h>

Better to keep sorted.

> +       if (!mem)
> +               return -EINVAL;
> +
> +       if (!devm_request_mem_region(&pdev->dev, mem->start,
> +                                    resource_size(mem), pdev->name))
> +               return -EBUSY;
> +
> +       base = devm_ioremap(&pdev->dev, mem->start,
> +                           resource_size(mem));
> +       if (base == NULL)
> +               return -EFAULT;

devm_ioremap_resource()

> +static const struct of_device_id pvpanic_mmio_match[] = {
> +       { .compatible = "qemu,pvpanic-mmio", },
> +       {},

terminators better w/o comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
