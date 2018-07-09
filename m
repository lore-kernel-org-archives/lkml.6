Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D356C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B9420835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORw4XhWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B9420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933759AbeGIPvD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932862AbeGIPvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:51:00 -0400
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com [209.85.214.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C15120877
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531151459;
        bh=aRE1eWGa76jjsIJZL7ZutPrznwbKusEr7fR6eyVrgUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ORw4XhWHQD2Fzd5XcRSHdRz9ZHIFPdMfLRQfB/rcUCIUG0E7eA/LaIrOLeu+ObFOX
         yF36Qf4CRGUb9q8zqySheLzVNGshZEzdE83D2E/s4bwsmRIJKgzWIJDiWIfCq6HQqH
         niqqNTp+pS5OSXdOwuahERkLYzex+PEAFnI9zVog=
Received: by mail-it0-f54.google.com with SMTP id d191-v6so12172527ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:50:59 -0700 (PDT)
X-Gm-Message-State: APt69E2i8ZCKbeSUC4xCmMR5VP8yKobaO3YaVqf26scFrBedT/xPQTRO
        4o7Ox4Ir9LNxvFbPVeIH0d1+MWRkaR2YT1+WSA==
X-Google-Smtp-Source: AAOMgpe4enhSfvVC2c3K5TsxsrjoP5FN4qkSCmah0w0l+L3gklyhu9KNGVNB5NreuHJI0G4mlOGHkX3aDUoxHSP+yCM=
X-Received: by 2002:a24:3ac3:: with SMTP id m186-v6mr16431860itm.106.1531151459079;
 Mon, 09 Jul 2018 08:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180619214020.18608-1-robh@kernel.org>
In-Reply-To: <20180619214020.18608-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Jul 2018 09:50:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
Message-ID: <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
Subject: Re: [PATCH] ARM: at91: remove unnecessary of_platform_default_populate
 calls
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:40 PM Rob Herring <robh@kernel.org> wrote:
>
> The DT core will call of_platform_default_populate, so it is not
> necessary for machine specific code to call it unless there are custom
> match entries, auxdata or parent device. Neither of those apply here, so
> remove the call.
>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-at91/at91rm9200.c | 5 -----
>  arch/arm/mach-at91/at91sam9.c   | 5 -----
>  arch/arm/mach-at91/sama5.c      | 5 -----
>  3 files changed, 15 deletions(-)

Ping?

>
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index 656ad409a253..42583261951e 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -8,17 +8,12 @@
>   * Licensed under GPLv2 or later.
>   */
>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
> -
>  #include <asm/mach/arch.h>
>
>  #include "generic.h"
>
>  static void __init at91rm9200_dt_device_init(void)
>  {
> -       of_platform_default_populate(NULL, NULL, NULL);
> -
>         at91rm9200_pm_init();
>  }
>
> diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
> index 3dbdef4d3cbf..863a0e7ba00f 100644
> --- a/arch/arm/mach-at91/at91sam9.c
> +++ b/arch/arm/mach-at91/at91sam9.c
> @@ -7,9 +7,6 @@
>   * Licensed under GPLv2 or later.
>   */
>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
> -
>  #include <asm/mach/arch.h>
>  #include <asm/system_misc.h>
>
> @@ -17,8 +14,6 @@
>
>  static void __init at91sam9_init(void)
>  {
> -       of_platform_default_populate(NULL, NULL, NULL);
> -
>         at91sam9_pm_init();
>  }
>
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index 3d0bf95a56ae..e3a84a59db76 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -7,9 +7,6 @@
>   * Licensed under GPLv2 or later.
>   */
>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
> -
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/system_misc.h>
> @@ -18,7 +15,6 @@
>
>  static void __init sama5_dt_device_init(void)
>  {
> -       of_platform_default_populate(NULL, NULL, NULL);
>         sama5_pm_init();
>  }
>
> @@ -47,7 +43,6 @@ MACHINE_END
>
>  static void __init sama5d2_init(void)
>  {
> -       of_platform_default_populate(NULL, NULL, NULL);
>         sama5d2_pm_init();
>  }
>
> --
> 2.17.1
>
