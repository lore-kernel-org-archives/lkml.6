Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71184C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D88021902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVeItszt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390614AbfBNCOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:14:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33288 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfBNCOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:14:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so2260400plp.0;
        Wed, 13 Feb 2019 18:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S49nwl0YNs3755d0KJZ+XjIWItPxRmpsO5c1PVhWl24=;
        b=FVeItszt2WQeUIs5wrpcEtNPgvFkWSr31LWspImL/tJjzZWelRvSN4w8HWsz4+JB1q
         49FR9kFFJo9z2DNqRK8WCDh8mp8jVdMJkscajSHbh3D+kW0EoGJxPAIe2Tn8nUvJBemp
         shOJyPfT8tMz2BTXcglEO4OYLiSxqdPcq8GyTPccKwIbIIy7iFfwtqqZAlNwrkTL8KgE
         N39Hynu0xAJtFFt7KbM5mKX2MdFuLGUz8FEqUz2wP7xD0T5cqNZYPvuBWo10iWJcVdgP
         YJoLdz3KwZvMFnVkCOcIjdzwS0/ZnUZjJUptH7QktN3DhCxSR+EFaNe9AUDMSKuerhmE
         pMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S49nwl0YNs3755d0KJZ+XjIWItPxRmpsO5c1PVhWl24=;
        b=HqeZcT9EhO1tfkUEbF265v/BEAmJx1+mBipUjhCewu8qbn+5YC8PLL4dIKHbg0/h98
         vHcnIfVVil2inzNj6zt9Q8VBg9XjdtrvIODVJR7304Bep1Pv2WJUo2hIyDhW+mppEXWs
         UHpisN90HY/WmVEHGblH0xMYlCp0JtHA7VcLPK+9fCWzIcjleHaD8v2PA62oTnx0G5C9
         Qm6i6G+GbYEKT/71F1kkzbNuuAH+JXYe7B9KOCCeEyqwEXTesBQ01bqtEwGRjfTDhCaN
         ZDZ8FolnLpEcFSBAJgr8mBpbADtPXH1Ai41WZOU7hu43Lq5cvbGjb+MFChE+Bxl+aryA
         yIDQ==
X-Gm-Message-State: AHQUAuZqeb9RUiMnPZ8IWuZcUJ4n7NULAW6ed4x3mk6GIPko03SXA98l
        Sl3ESLgFaegxWLH1GMVOfLiLBd3JAHMgbrRBrEU=
X-Google-Smtp-Source: AHgI3Ibjgr/J/FqxbJHlTZAfp3sOMz7S0pRljoKbcvhWmHfEgJOwFRii6xhmCcaGOY5b1d/vQ/xjWMChe1FyE9FIfYk=
X-Received: by 2002:a17:902:1a2:: with SMTP id b31mr1512308plb.87.1550110446092;
 Wed, 13 Feb 2019 18:14:06 -0800 (PST)
MIME-Version: 1.0
References: <1550091448-28578-1-git-send-email-info@metux.net> <1550091448-28578-3-git-send-email-info@metux.net>
In-Reply-To: <1550091448-28578-3-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Feb 2019 04:13:54 +0200
Message-ID: <CAHp75Vex6dhhaUFA+5SaC45HCNVpx3gzRYJ8CQA7kz+K_NQ-cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:57 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Driver for PCengines APUv2 board's front LEDs and Button,
> which are attached to AMD PCH GPIOs. Due to lack of dedicated
> ACPI entry, detecting the board via DMI.

> +#include <linux/init.h>

> +#include <linux/module.h>

One of them is not needed.

> +static struct platform_device * __init apu_create_pdev(
> +       const char* name,
> +       const void *pdata,
> +       size_t sz)
> +{
> +       struct platform_device *pdev;
> +

> +       pdev = platform_device_register_resndata(
> +               NULL,                   /* parent */
> +               name,                   /* name */
> +               PLATFORM_DEVID_NONE,    /* id */
> +               NULL,                   /* res */
> +               0,                      /* res_num */
> +               pdata,                  /* platform_data */
> +               sz);

No need to comment the obvious.

> +
> +       if (IS_ERR(pdev))

> +               pr_err(KBUILD_MODNAME ": failed registering %s: %ld\n", name, PTR_ERR(pdev));

Better to set pr_fmt() macro at the top of source.

> +
> +       return pdev;
> +}
> +
> +static int __init apu_board_init(void)
> +{
> +       int rc;
> +       const struct dmi_system_id *id;
> +
> +       id = dmi_first_match(apu_gpio_dmi_table);

> +

Redundant blank line.

> +       if (!id) {
> +               pr_err(KBUILD_MODNAME ": failed to detect apu board via dmi\n");

pr_fmt()

> +               return -ENODEV;
> +       }

> +       pr_info(KBUILD_MODNAME ": initialized: gpio, leds, keys\n");

Noise.

> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
