Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1397C1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A122087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oNJTYYuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfARWGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:06:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42037 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfARWGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:06:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so15745185otk.9;
        Fri, 18 Jan 2019 14:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUSvv6gyP/U0jb8swx6kbJOKJ75Cx8i7+Ck6/NBHcX0=;
        b=oNJTYYuO/R2XMxoEYLVk3BuofcbSO2Jal56gIgxesN3nRoMwa8kQQeoALeU/jcioAY
         0BMPTGKc0jxuJfvJiBGXy4FEh6QOa1vNE4KfNVWxsjr/OuF0lw7BOPhf/Tjh1939Hesr
         R7bO1MgW1JlIatvJsLhiYDd0HRb7GXE2SVUDiS+lpkAM/2ZGbLZSVPXQe79lFwJsd43Y
         1gjHPxFRAsvqbYyVis5tnL0yFoQwyl6X5di/X0GfxZXh3YpaNjiMZSiqYiL8M/vpmJYb
         EaPDBANJvfwULOAitQgiNU6/ViUEoOaksobKoQgUi3BbeOchsHJrlDyBA/z0SMchOtIE
         jS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUSvv6gyP/U0jb8swx6kbJOKJ75Cx8i7+Ck6/NBHcX0=;
        b=ufDq/hn+auHcNWSNGyztQ979o8VhgyAK5yQRe2a4mQ/K0wXbj3LGRP0eg/817BQcJE
         ru2rijdKQtrgN73jOFdrxxtmB69Kz4mMldj9SDupHnKeoi0CZfiOGLLN9Ivlz+VBibD3
         uWw6EdtepS+Bk5k+MnrKixniOQgztRWKDvoZWgh1avvjW6CNqlGDdeVExfK/HWSKxT1X
         AFcXhMcGFp3dRJ/RcqOktmztgjA9ODjnKwIN4KZIrRUJKjT2ibZrAcEyVlWldwmbqYKV
         NUfvy7FIMZAtDAwOlrrPRv+NyVLxE67EZKPhgGdoJIVYXLl5DGlBc2PAqb09a+ABIncv
         dabA==
X-Gm-Message-State: AJcUukehr4s4rPtPiijIyTIUo3Ycyb+8X6Re6BymeWEjPV8JBTPCMra7
        RFmNpQmE5GCdXeI9ZXbb4WH8MgDaMDNXKIqRaO8=
X-Google-Smtp-Source: ALg8bN7xKjfGKRIT4sZ8SnCLXx+7BK9Umi6LGxI5bTxrXMe+VPJ0gK6OA0ZF+r82cglIYKY8bNcJWselXYRCDrFlTFw=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr12918180otg.308.1547849207355;
 Fri, 18 Jan 2019 14:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com> <20190113181808.5768-2-linux.amoon@gmail.com>
In-Reply-To: <20190113181808.5768-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jan 2019 23:06:36 +0100
Message-ID: <CAFBinCCNpW=m4P=dqkn4eKeDPJyi_RML07ZhPKQeFH5j7mXkkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: meson8b: odroidc1: Fix usb phy regulator
 power failed warning
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Sun, Jan 13, 2019 at 7:18 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Override the dr_mode from "host" to "peripheral" for dwc2
> usb_phy0->usb0 initialization of OTG Micro-B type.
> Changes fix the below warning for phy poweron failed --> -22
>
> This fix the initialization of c9040000.usb phy.
>
> [    1.639706] phy phy-c1108800.phy.0: USB ID detect failed!
> [    1.643850] phy phy-c1108800.phy.0: phy poweron failed --> -22
> [    1.649706] ------------[ cut here ]------------
> [    1.654273] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
> [    1.663400] Modules linked in:
> [    1.666439] CPU: 0 PID: 29 Comm: kworker/0:1 Not tainted 4.20.0-xc1ml #11
> [    1.673192] Hardware name: Amlogic Meson platform
> [    1.677894] Workqueue: events deferred_probe_work_func
> [    1.683027] [<c0312204>] (unwind_backtrace) from [<c030cb8c>] (show_stack+0x10/0x14)
> [    1.690746] [<c030cb8c>] (show_stack) from [<c0e223b8>] (dump_stack+0x8c/0xa0)
> [    1.697953] [<c0e223b8>] (dump_stack) from [<c0346334>] (__warn.part.3+0xbc/0xd8)
> [    1.705418] [<c0346334>] (__warn.part.3) from [<c03464b0>] (warn_slowpath_null+0x44/0x4c)
> [    1.713579] [<c03464b0>] (warn_slowpath_null) from [<c07df6b8>] (_regulator_put.part.8+0xf8/0xfc)
> [    1.722437] [<c07df6b8>] (_regulator_put.part.8) from [<c07df6e4>] (regulator_put+0x28/0x38)
> [    1.730859] [<c07df6e4>] (regulator_put) from [<c07df71c>] (regulator_bulk_free+0x28/0x38)
> [    1.739112] [<c07df71c>] (regulator_bulk_free) from [<c0943858>] (release_nodes+0x1bc/0x200)
> [    1.747537] [<c0943858>] (release_nodes) from [<c093f82c>] (really_probe+0x110/0x2cc)
> [    1.755350] [<c093f82c>] (really_probe) from [<c093fb4c>] (driver_probe_device+0x60/0x16c)
> [    1.763599] [<c093fb4c>] (driver_probe_device) from [<c093dcd4>] (bus_for_each_drv+0x80/0xc4)
> [    1.772110] [<c093dcd4>] (bus_for_each_drv) from [<c093f6ac>] (__device_attach+0xd0/0x138)
> [    1.780359] [<c093f6ac>] (__device_attach) from [<c093eae4>] (bus_probe_device+0x84/0x8c)
> [    1.788522] [<c093eae4>] (bus_probe_device) from [<c093ef80>] (deferred_probe_work_func+0x60/0x8c)
> [    1.797470] [<c093ef80>] (deferred_probe_work_func) from [<c035fdb8>] (process_one_work+0x218/0x504)
> [    1.806585] [<c035fdb8>] (process_one_work) from [<c0360ea8>] (worker_thread+0x2a8/0x5bc)
> [    1.814748] [<c0360ea8>] (worker_thread) from [<c0365a18>] (kthread+0x14c/0x154)
> [    1.822128] [<c0365a18>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [    1.829331] Exception stack(0xee0ebfb0 to 0xee0ebff8)
> [    1.834369] bfa0:                                     00000000 00000000 00000000 00000000
> [    1.842534] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.850695] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    1.857311] ---[ end trace e28bbc26874282a4 ]---
> [    1.861984] ------------[ cut here ]------------
> [    1.866524] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
> [    1.875629] Modules linked in:
> [    1.878658] CPU: 0 PID: 29 Comm: kworker/0:1 Tainted: GW         4.20.0-xc1ml #11
> [    1.886817] Hardware name: Amlogic Meson platform
> [    1.891513] Workqueue: events deferred_probe_work_func
> [    1.896641] [<c0312204>] (unwind_backtrace) from [<c030cb8c>] (show_stack+0x10/0x14)
> [    1.904366] [<c030cb8c>] (show_stack) from [<c0e223b8>] (dump_stack+0x8c/0xa0)
> [    1.911573] [<c0e223b8>] (dump_stack) from [<c0346334>] (__warn.part.3+0xbc/0xd8)
> [    1.919041] [<c0346334>] (__warn.part.3) from [<c03464b0>] (warn_slowpath_null+0x44/0x4c)
> [    1.927203] [<c03464b0>] (warn_slowpath_null) from [<c07df6b8>] (_regulator_put.part.8+0xf8/0xfc)
> [    1.936060] [<c07df6b8>] (_regulator_put.part.8) from [<c07df6e4>] (regulator_put+0x28/0x38)
> [    1.944483] [<c07df6e4>] (regulator_put) from [<c07df71c>] (regulator_bulk_free+0x28/0x38)
> [    1.952734] [<c07df71c>] (regulator_bulk_free) from [<c0943858>] (release_nodes+0x1bc/0x200)
> [    1.961159] [<c0943858>] (release_nodes) from [<c093f82c>] (really_probe+0x110/0x2cc)
> [    1.968974] [<c093f82c>] (really_probe) from [<c093fb4c>] (driver_probe_device+0x60/0x16c)
> [    1.977224] [<c093fb4c>] (driver_probe_device) from [<c093dcd4>] (bus_for_each_drv+0x80/0xc4)
> [    1.985734] [<c093dcd4>] (bus_for_each_drv) from [<c093f6ac>] (__device_attach+0xd0/0x138)
> [    1.993984] [<c093f6ac>] (__device_attach) from [<c093eae4>] (bus_probe_device+0x84/0x8c)
> [    2.002147] [<c093eae4>] (bus_probe_device) from [<c093ef80>] (deferred_probe_work_func+0x60/0x8c)
> [    2.011092] [<c093ef80>] (deferred_probe_work_func) from [<c035fdb8>] (process_one_work+0x218/0x504)
> [    2.020209] [<c035fdb8>] (process_one_work) from [<c0360ea8>] (worker_thread+0x2a8/0x5bc)
> [    2.028371] [<c0360ea8>] (worker_thread) from [<c0365a18>] (kthread+0x14c/0x154)
> [    2.035752] [<c0365a18>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [    2.042955] Exception stack(0xee0ebfb0 to 0xee0ebff8)
> [    2.047993] bfa0:                                     00000000 00000000 00000000 00000000
> [    2.056158] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.064320] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.070934] ---[ end trace e28bbc26874282a5 ]---
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Rebased on Kevin's amlogic/v5.0/fixes branch
> Note the warning is not getting produced on the latest kernel.
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index a49a8509b288..9d7f725cfe35 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -318,6 +318,7 @@
>
>  &usb0 {
>         status = "okay";
> +       dr_mode = "peripheral";
>  };
with this change I get the following message during boot:
  dwc2 c9040000.usb: Configuration mismatch. dr_mode forced to host

as far as I understand your original problem is the following error
from the USB2 PHY driver:
  phy phy-c1108800.phy.0: USB ID detect failed!
  phy phy-c1108800.phy.0: phy poweron failed --> -22
maybe we should fix that instead?


Regards
Martin
