Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86D0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9499520817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwqNny9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKKALM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:11:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38951 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeKKALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:11:12 -0500
Received: by mail-qk1-f194.google.com with SMTP id e4so6564955qkh.6;
        Sat, 10 Nov 2018 06:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LcE2adSJucsMwRTkQ+T53klNwHwBlLjS127GR/0JzY=;
        b=JwqNny9iaKJUyWkpzRU2ddHnsZqMcxcl8T1PjzCGbxxTtcY4OnoBfIIHC32b6RVXnd
         Ig3IOcdXdLG3j/1QLFI6qtSzwb1ARpR8S9nN+eLUi1Z15H+5pBno1heEvHkntKtjINcx
         cCQvk0kwJUb9iBa7xcHey8s9RxE7ipgBkMVK+vgWkqs9TBrfVjBOHtmh7ttLPaq8j2w6
         zMhP/OyjrzUbsdVlR2ekDkhQYOlV0yniQSBEqru6NFPyWaHwWFpiANiMzJ1cHoz/jNv7
         QsF9uaD0rZ4femFvK0bvyTQg/4/2DdP+HQBd06LHEZ1lgB5ZrBbGO94gDitCNbo+UwXX
         ga6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LcE2adSJucsMwRTkQ+T53klNwHwBlLjS127GR/0JzY=;
        b=GH3vu4StcGDrQvG1LsBgBfWGSJhBMqqAGEpXzM31xTt8oKU+39SQHLnFVWSixHJ7od
         Qb0vucKfOvtKzTBTsa02ovueF7uFodtTBgrV3W2YgIF+5t9/diDYBWaL93vg4lXnF7Ki
         zhVdTaw0dR6Tk275NFyMsXgwniwEw3dcgKlJWxRgw6okbQMLT/gRyess5kM6P09HUlXQ
         nvMZ/IbYhQXRt++Or1a5YQ9ykFYQ6lo3c64i9umH2aB5WsfIx1o+ZDi/LEouuSnH+UB8
         5lUykejLtK5cnHrhBTMH5uYziUtIA5HKEZxZIMsN5ysd4OwaKDtU4FEfdSuAP/UXdMqe
         WFSA==
X-Gm-Message-State: AGRZ1gIhuv8HZZ31Eu4suB/0N0X0aL0Qpd4fbYCXak+4E9qlTiUPHa9D
        5q+j/Wd8FsY3zENchBhTH5MbCYI3gOVSUndzwCU=
X-Google-Smtp-Source: AJdET5eTaYZ34LwL7obaEXW7sap6PcfwJWF42brHugRfFQ1f9YRKdceHPA0/G33XnR+8CbamxKRQMK+IAkGgA6legzs=
X-Received: by 2002:ac8:6151:: with SMTP id d17mr9658425qtm.194.1541859960748;
 Sat, 10 Nov 2018 06:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20181109234526.4280-1-ayman.bagabas@gmail.com> <20181109234526.4280-2-ayman.bagabas@gmail.com>
In-Reply-To: <20181109234526.4280-2-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 10 Nov 2018 16:25:49 +0200
Message-ID: <CAHp75Vc0H6Cd=knnx3Sv2zLXfqPp2J48VQDFBo4miLo5vMVftg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] x86: add support for Huawei WMI hotkeys.
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 1:45 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> This driver adds support for missing hotkeys on some Huawei laptops.
> Currently, only Huawei Matebook X and Matebook X Pro is supported.

>  drivers/platform/x86/huawei_wmi.c            | 215 +++++++++++++++++++
>  include/linux/platform_data/x86/huawei_wmi.h |   9 +

So, please use a de facto pattern, i.e. <VENDOR>-wmi.c, so for *.h.

> +config HUAWEI_LAPTOP

This better to be consistent with the module name.

> +       help
> +         This driver provides support for Huawei WMI hotkeys.
> +         It enables the missing keys and adds support to the micmute
> +         LED found on some of these laptops.

Here we usually put a line how module will be called.

> +// SPDX-License-Identifier: GPL-2.0

You need to choose proper license either here, or in MODULE_LICENSE()
line. For now they are not in align.

> +MODULE_LICENSE("GPL");

> +       /*
> +        * MBX uses code 0x80 to indicate a hotkey event.
> +        * The actual key is fetched from the method WQ00

Period is missed.

> +        */

> +static void huawei_wmi_notify(u32 value, void *context)
> +{
> +       struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *obj;
> +       acpi_status status;

> +       struct input_dev *inputdev = (struct input_dev *)context;

No need an explicit casting.
Also, move this to be first line in the definition block.

> +       status = wmi_get_event_data(value, &response);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(&inputdev->dev, "Bad event status 0x%x\n", status);
> +               return;
> +       }

> +}

> +       err = sparse_keymap_setup(inputdev,
> +                       huawei_wmi_keymap, NULL);

Would it be one line?

> +       if (err)
> +               goto err_free_dev;
> +

-- 
With Best Regards,
Andy Shevchenko
