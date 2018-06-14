Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 937F8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EECE20020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAzR6G7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EECE20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966151AbeFNOYb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:24:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55580 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966108AbeFNOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:24:26 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so8557881itl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=90/nexj8qAYFAXTTULYFIgB3E4/jFqaJ9H5xkK5Qktg=;
        b=AAzR6G7fOqGdG4cxHKspM/XFLYQsOzVQCnsTgMb0opsje2JWjMdU7ImoeqlnwOHaVJ
         vOEZaZ5QpAqxQM2ObU1XWpQ6JN0ixbEeuIvj0zbpUNg7hx+fu1lbwVGsg5bLFlbNo6gZ
         msPE+rqJFQRiUq9n94x3NxGR6gmyCz+OAPPVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=90/nexj8qAYFAXTTULYFIgB3E4/jFqaJ9H5xkK5Qktg=;
        b=BiPKXhQ7R/1TMgvK4HFcSqfR2TlgN91rc2wFVJWuQib2R06YmUGDEZt3Hh/MVffmss
         VEHQvPkg0BrCxR6BnGN1u7tetUarZwprlwAu1/kfjEeyMlODfSc3Ncz6fhv0Ce56jP40
         HCv9yFJo2Zgol1VYGMRcg64cK57heYr6liSCbjZbXhh8o3PS0HQWaa9BvOrZjvRoBthW
         tHMsWzf/erR/H/BfCRz/V8mYUC81fFXKrczinJirvYeWAcCDKyNAKcHxw8M9NEjsIf7h
         IoqDneV+2Ehhagbuy1sAWpcVvLW9tnsjAY4MKAKOykj2cO1E6VF3AjH1PRJ79WGZ31pQ
         +CoA==
X-Gm-Message-State: APt69E2hwlRVXv46/oB6QdZR8+hlaLGyIjvUmeonwFVrWbulsu7+X4Ha
        KnfcimHTe+sek4WuEH0p2skFw7bu0yNWAB/eobXRgg==
X-Google-Smtp-Source: ADUXVKIe8iDSFt/x2TVvt5YiqZXcaxxgebL2vteHv9e74Jbsn4EqwN7Izfc/yBrladPFzwKXEzmiT70BbHqeFZ7OAhg=
X-Received: by 2002:a24:690f:: with SMTP id e15-v6mr2393869itc.70.1528986265467;
 Thu, 14 Jun 2018 07:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:24:24
 -0700 (PDT)
In-Reply-To: <6615b85997509d659358d33eab2d280e235b8659.1528966092.git.sean.wang@mediatek.com>
References: <6615b85997509d659358d33eab2d280e235b8659.1528966092.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 16:24:24 +0200
Message-ID: <CACRpkdaipxgMbUHSA-UFQ3De9AGSKE2jCBU5_SaFJS7M0=eygQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mt7622: fix a kernel panic when pio don't work
 as EINT controller
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:55 AM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> The function, external interrupt controller, is made as an optional to
> mt7622 pinctrl. But if we don't want pio behaves as an external interrupt
> controller, it would lead to hw->eint not be created properly and then
> will cause 'kernel NULL pointer' issue when gpiochip try to call .to_irq
> or .set_config. To fix it, check hw->eint before accessing the member.
>
> [    1.339494] Unable to handle kernel NULL pointer dereference at virtual
>                address 00000010
> [    1.347857] Mem abort info:
> [    1.350742]   ESR = 0x96000005
> [    1.353905]   Exception class = DABT (current EL), IL = 32 bits
> [    1.360024]   SET = 0, FnV = 0
> [    1.363185]   EA = 0, S1PTW = 0
> [    1.366431] Data abort info:
> [    1.369405]   ISV = 0, ISS = 0x00000005
> [    1.373363]   CM = 0, WnR = 0
> [    1.376437] [0000000000000010] user address but active_mm is swapper
> [    1.383005] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [    1.388748] Modules linked in:
> [    1.391897] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1+ #344
> [    1.398625] Hardware name: MediaTek MT7622 RFB1 board (DT)
> [    1.404279] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    1.409221] pc : mtk_eint_find_irq+0x8/0x24
> [    1.413532] lr : mtk_gpio_to_irq+0x20/0x28
> [    1.417749] sp : ffffff800801baf0
> [    1.421161] x29: ffffff800801baf0 x28: ffffff8008792f40
> [    1.426637] x27: ffffff800886b000 x26: ffffff8008615620
> [    1.432113] x25: ffffffc00e4dbdc8 x24: ffffff80087b8000
> [    1.437589] x23: ffffffc00325a000 x22: ffffffc00325a010
> [    1.443066] x21: ffffffc0033dec18 x20: 00000000ffffffea
> [    1.448542] x19: ffffffc00e4db800 x18: 0000000000000130
> [    1.454018] x17: 000000000000000e x16: 0000000000000007
> [    1.459494] x15: ffffff80085ee000 x14: 0000000000000001
> [    1.464970] x13: 0000000000000001 x12: 0000000000000010
> [    1.470446] x11: 0101010101010101 x10: 0000000000000880
> [    1.475922] x9 : ffffff800801b990 x8 : ffffffc0030688e0
> [    1.481399] x7 : ffffff80080c0660 x6 : ffffffc00e4dbbb0
> [    1.486875] x5 : 0000000000000000 x4 : 0000000000000000
> [    1.492351] x3 : ffffff80082a92f4 x2 : 00000000fffffffa
> [    1.497826] x1 : 0000000000000051 x0 : 0000000000000000
> [    1.503305] Process swapper/0 (pid: 1, stack limit = 0x0000000054e053bd)
> [    1.510210] Call trace:
> [    1.512727]  mtk_eint_find_irq+0x8/0x24
> [    1.516677]  mtk_gpio_to_irq+0x20/0x28
> [    1.520539]  gpiod_to_irq+0x48/0x60
> [    1.524135]  mmc_gpiod_request_cd_irq+0x3c/0xc4
> [    1.528804]  mmc_start_host+0x6c/0x8c
> [    1.532575]  mmc_add_host+0x58/0x7c
> [    1.536168]  msdc_drv_probe+0x4fc/0x67c
> [    1.540121]  platform_drv_probe+0x58/0xa4
> [    1.544251]  driver_probe_device+0x204/0x44c
> [    1.548649]  __driver_attach+0x84/0xf8
> [    1.552512]  bus_for_each_dev+0x68/0xa0
> [    1.556461]  driver_attach+0x20/0x28
> [    1.560142]  bus_add_driver+0xec/0x240
> [    1.564002]  driver_register+0x98/0xe4
> [    1.567863]  __platform_driver_register+0x48/0x50
> [    1.572711]  mt_msdc_driver_init+0x18/0x20
> [    1.576932]  do_one_initcall+0x98/0x130
> [    1.580886]  kernel_init_freeable+0x13c/0x1d4
> [    1.585375]  kernel_init+0x10/0xf8
> [    1.588879]  ret_from_fork+0x10/0x18
> [    1.592564] Code: a8c67bfd d65f03c0 a9bf7bfd 910003fd (f9400800)
> [    1.598849] ---[ end trace 4bbcb7bc30e98492 ]---
> [    1.603677] Kernel panic - not syncing: Attempted to kill init!
>                exitcode=0x0000000b
> [    1.603677]
>
> cc: Kevin Hilman <khilman@baylibre.com>
> Cc: stable@vger.kernel.org
> Fixes: e6dabd38d8e7 ("pinctrl: mediatek: add EINT support to MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
