Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B039C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80B627ED9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dm8nafGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80B627ED9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755422AbeF2MWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:22:21 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32886 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755318AbeF2MWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:22:18 -0400
Received: by mail-io0-f195.google.com with SMTP id d185-v6so8287048ioe.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQLT0p3ApAqByZyVYt5S0S3E1qcNzeNej3ERsbiIcpU=;
        b=Dm8nafGerrrQjYDif/VLxpRQ86D4No83Tw6uX9hpR7YtecIXNpGZ5vyQ5f6MiuQaKp
         1hT4ph9+qTIoIVE9xblMggmQMDOA5MIw/+86liGdRGyIs8wIrbC2jp0xigp8jn0yUsa1
         m/f6AF7DCVF6knWniZLaui2skZ3A1T+tMRB20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQLT0p3ApAqByZyVYt5S0S3E1qcNzeNej3ERsbiIcpU=;
        b=hGRe6P/URTK1SeP16zV5Fw6sr/cPsbjUxxxkVwD4hW/hVmOKzNBDzfcHSvoH8OyHiN
         XoGYUv7Z6Bq32WqBPnz/j+5sBjjDmvgn+bU/4LaCg6hD1+1JuKLjkFJJkdWoXMFqI/Nt
         X6Iay35tw2erjPr+7BlK7vd1gfMiaqOxBwzC4717QaJfJYKI2RkFcIbSXZ5C5tqzA03I
         GQolJSNG6PvUp7tHHy3vlih8iLC77y9EFXZxJJgkwt3BzLsiTF5ER/gU7KH4G7+l6y3L
         3fFJNxLt6cUcZqd3YmIkLckUVpCxU6Gvn4PT1IzbTXoO58MNLdsgbhsg5KE7bTWtARSV
         UcOA==
X-Gm-Message-State: APt69E3s3Xntr53ZvTqs3Dx41T2mfcytt/MBddiYqIwEwK61JqxjBanC
        xuQ3D3gMolUdXaQaxhVT900xj4FJBCsFpxqv1wGL3w==
X-Google-Smtp-Source: AAOMgpdAkChb0jrTXfpQIKx4zt7Jfn+Ww3RPzozEVqlW3HzpKWaV+sgUsywMEZ2Dn0At2tBXnkSE0hKjrt4mgf5jnP8=
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr11835641ioh.175.1530274937817;
 Fri, 29 Jun 2018 05:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <031d7dd666390aaf1b0566476c9661e6e674cae8.1529639050.git.sean.wang@mediatek.com>
In-Reply-To: <031d7dd666390aaf1b0566476c9661e6e674cae8.1529639050.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:22:06 +0200
Message-ID: <CACRpkdbeui8gB0xKw6SC=PyZq-YCNp-+VXE8Enz0Byyy01AGaA@mail.gmail.com>
Subject: Re: [PATCH 5/7] pinctrl: mt7622: fix a kernel panic when gpio-hog is
 being applied
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> When we are explicitly using GPIO hogging mechanism in the pinctrl node,
> such as:
>
>         &pio {
>                 line_input {
>                         gpio-hog;
>                         gpios = <95 0>, <96 0>, <97 0>;
>                         input;
>                 };
>         };
>
> A kernel panic happens at dereferencing a NULL pointer: In this case, the
> drvdata is still not setup properly yet when it is being accessed.
>
> A better solution for fixing up this issue should be we should obtain the
> private data from struct gpio_chip using a specific gpiochip_get_data
> instead of a generic dev_get_drvdata.
>
> [    0.249424] Unable to handle kernel NULL pointer dereference at virtual
>                address 000000c8
> [    0.257818] Mem abort info:
> [    0.260704]   ESR = 0x96000005
> [    0.263869]   Exception class = DABT (current EL), IL = 32 bits
> [    0.270011]   SET = 0, FnV = 0
> [    0.273167]   EA = 0, S1PTW = 0
> [    0.276421] Data abort info:
> [    0.279398]   ISV = 0, ISS = 0x00000005
> [    0.283372]   CM = 0, WnR = 0
> [    0.286440] [00000000000000c8] user address but active_mm is swapper
> [    0.293027] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [    0.298795] Modules linked in:
> [    0.301958] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1+ #389
> [    0.308716] Hardware name: MediaTek MT7622 RFB1 board (DT)
> [    0.314396] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    0.319362] pc : mtk_hw_pin_field_get+0x28/0x118
> [    0.324140] lr : mtk_hw_set_value+0x30/0x104
> [    0.328557] sp : ffffff800801b6d0
> [    0.331983] x29: ffffff800801b6d0 x28: ffffff80086b7970
> [    0.337484] x27: 0000000000000000 x26: ffffff80087b8000
> [    0.342986] x25: 0000000000000000 x24: ffffffc00324c230
> [    0.348487] x23: 0000000000000003 x22: 0000000000000000
> [    0.353988] x21: ffffff80087b8000 x20: 0000000000000000
> [    0.359489] x19: 0000000000000054 x18: 00000000fffff7c0
> [    0.364990] x17: 0000000000006300 x16: 000000000000003f
> [    0.370492] x15: 000000000000000e x14: ffffffffffffffff
> [    0.375993] x13: 0000000000000000 x12: 0000000000000020
> [    0.381494] x11: 0000000000000006 x10: 0101010101010101
> [    0.386995] x9 : fffffffffffffffa x8 : 0000000000000007
> [    0.392496] x7 : ffffff80085d63f8 x6 : 0000000000000003
> [    0.397997] x5 : 0000000000000054 x4 : ffffffc0031eb800
> [    0.403499] x3 : ffffff800801b728 x2 : 0000000000000003
> [    0.409000] x1 : 0000000000000054 x0 : 0000000000000000
> [    0.414502] Process swapper/0 (pid: 1, stack limit = 0x000000002a913c1c)
> [    0.421441] Call trace:
> [    0.423968]  mtk_hw_pin_field_get+0x28/0x118
> [    0.428387]  mtk_hw_set_value+0x30/0x104
> [    0.432445]  mtk_gpio_set+0x20/0x28
> [    0.436052]  mtk_gpio_direction_output+0x18/0x30
> [    0.440833]  gpiod_direction_output_raw_commit+0x7c/0xa0
> [    0.446333]  gpiod_direction_output+0x104/0x114
> [    0.451022]  gpiod_configure_flags+0xbc/0xfc
> [    0.455441]  gpiod_hog+0x8c/0x140
> [    0.458869]  of_gpiochip_add+0x27c/0x2d4
> [    0.462928]  gpiochip_add_data_with_key+0x338/0x5f0
> [    0.467976]  mtk_pinctrl_probe+0x388/0x400
> [    0.472217]  platform_drv_probe+0x58/0xa4
> [    0.476365]  driver_probe_device+0x204/0x44c
> [    0.480783]  __device_attach_driver+0xac/0x108
> [    0.485384]  bus_for_each_drv+0x7c/0xac
> [    0.489352]  __device_attach+0xa0/0x144
> [    0.493320]  device_initial_probe+0x10/0x18
> [    0.497647]  bus_probe_device+0x2c/0x8c
> [    0.501616]  device_add+0x2f8/0x540
> [    0.505226]  of_device_add+0x3c/0x44
> [    0.508925]  of_platform_device_create_pdata+0x80/0xb8
> [    0.514245]  of_platform_bus_create+0x290/0x3e8
> [    0.518933]  of_platform_populate+0x78/0x100
> [    0.523352]  of_platform_default_populate+0x24/0x2c
> [    0.528403]  of_platform_default_populate_init+0x94/0xa4
> [    0.533903]  do_one_initcall+0x98/0x130
> [    0.537874]  kernel_init_freeable+0x13c/0x1d4
> [    0.542385]  kernel_init+0x10/0xf8
> [    0.545903]  ret_from_fork+0x10/0x18
> [    0.549603] Code: 900020a1 f9400800 911dcc21 1400001f (f9406401)
> [    0.555916] ---[ end trace de8c34787fdad3b3 ]---
> [    0.560722] Kernel panic - not syncing: Attempted to kill init!
>                exitcode=0x0000000b
> [    0.560722]
> [    0.570188] SMP: stopping secondary CPUs
> [    0.574253] ---[ end Kernel panic - not syncing: Attempted to kill
>                init! exitcode=0x0000000b
> [    0.574253]
>
> Cc: stable@vger.kernel.org
> Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
