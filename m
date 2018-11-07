Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751A220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h80+3mxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751A220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbeKGTae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeKGTae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:30:34 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534652086C;
        Wed,  7 Nov 2018 10:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541584856;
        bh=OouFcYJmMkmY+cyBU+G9f3cRVEUbCRaRrpDj4jTJf9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h80+3mxnic2FmWFHP8cV32XrROk4seQWcDvKMUow/iB17S06bTM/Hifcil7QgjNNQ
         Zwlizc1IApYq/CMeVhglh55jdckDD+Lgf9fELNDF42l82uV+UTgWck300bWbftbv/H
         IIoY9H2CfJKlZAwzDMOwfpwPyhk9kXTBtIsEGQ+Y=
Received: by mail-wr1-f49.google.com with SMTP id r10-v6so16685549wrv.6;
        Wed, 07 Nov 2018 02:00:56 -0800 (PST)
X-Gm-Message-State: AGRZ1gKVc/mpatMdEOTj4n/FgFTjQs0af1L5AAj4AFpgAcNZCm4oi+XL
        v/vXIZ0Tbwipx/3T7iRCswr1XLOn+KwHcDZMHZ0=
X-Google-Smtp-Source: AJdET5eyW66mzqMrsrX/lEgi0y096zOqpqP03gI8r6LJ/JOtBYomnt7gDI/N2vI5dl3QwcNqM79+wlgRUwQ3T4zYbnc=
X-Received: by 2002:adf:fac4:: with SMTP id a4-v6mr1276510wrs.202.1541584854771;
 Wed, 07 Nov 2018 02:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20181102025728.963-1-olof@lixom.net>
In-Reply-To: <20181102025728.963-1-olof@lixom.net>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 7 Nov 2018 02:00:43 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzq3rgNs=uuXDVTurwgGrCjDQg=rje0rpetbzeMX7U-XLg@mail.gmail.com>
Message-ID: <CAGp9Lzq3rgNs=uuXDVTurwgGrCjDQg=rje0rpetbzeMX7U-XLg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Fix dependencies for EINT_MTK
To:     olof@lixom.net
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the catch.

Acked-by: Sean Wang <sean.wang@kernel.org>

On Thu, Nov 1, 2018 at 7:57 PM Olof Johansson <olof@lixom.net> wrote:
>
> Fixes the following config-time warning:
>
> WARNING: unmet direct dependencies detected for EINT_MTK
>   Depends on [n]: PINCTRL [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && (PINCTRL_MTK [=n] || PINCTRL_MTK_MOORE [=n] || COMPILE_TEST [=n])
>   Selected by [y]:
>   - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && OF [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n])
>
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 9d142e1da567..50efc9cc8ee7 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -3,7 +3,7 @@ menu "MediaTek pinctrl drivers"
>
>  config EINT_MTK
>         bool "MediaTek External Interrupt Support"
> -       depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || COMPILE_TEST
> +       depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
>         select GPIOLIB
>         select IRQ_DOMAIN
>
> --
> 2.11.0
>
