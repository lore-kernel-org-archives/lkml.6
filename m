Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeFDLza (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:55:30 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38600 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbeFDLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:55:27 -0400
X-Google-Smtp-Source: ADUXVKKrrAhhqaKTu8Jo6WV4sNd+II0DyFAMUcKTMbLrDF4QLc/VX68gFnFa96hfox/2MHFPx0HSbsO5sVq+2RaSsZk=
MIME-Version: 1.0
In-Reply-To: <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
 <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au>
 <adba0545c06cd6c67e26c433990d036b0d7e968c.1527909627.git.fthain@telegraphics.com.au>
 <166b4c3a7347fe27f12bda86d50533cd01ee11b9.1527909627.git.fthain@telegraphics.com.au>
 <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au>
 <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 13:55:26 +0200
X-Google-Sender-Auth: gN_FXG0o8ipFKCzzV6Mf_zy7tzo
Message-ID: <CAMuHMdVheowFa8bx0fg-_Dvx+TMZhPbvouTs82Y3tq1gtSpRMQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] macintosh/via-pmu: Replace via-pmu68k driver with
 via-pmu driver
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sat, Jun 2, 2018 at 5:27 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> switch over to that driver and remove the via-pmu68k driver.

Thanks!

> Don't call pmu_shutdown() or pmu_restart() on early PowerBooks:
> the PMU device found in these PowerBooks isn't supported.

Shouldn't that be a separate patch?

> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c

> @@ -477,9 +445,8 @@ void mac_poweroff(void)
>                    macintosh_config->adb_type == MAC_ADB_CUDA) {
>                 cuda_shutdown();
>  #endif
> -#ifdef CONFIG_ADB_PMU68K
> -       } else if (macintosh_config->adb_type == MAC_ADB_PB1
> -               || macintosh_config->adb_type == MAC_ADB_PB2) {
> +#ifdef CONFIG_ADB_PMU
> +       } else if (macintosh_config->adb_type == MAC_ADB_PB2) {
>                 pmu_shutdown();
>  #endif
>         }
> @@ -519,9 +486,8 @@ void mac_reset(void)
>                    macintosh_config->adb_type == MAC_ADB_CUDA) {
>                 cuda_restart();
>  #endif
> -#ifdef CONFIG_ADB_PMU68K
> -       } else if (macintosh_config->adb_type == MAC_ADB_PB1
> -               || macintosh_config->adb_type == MAC_ADB_PB2) {
> +#ifdef CONFIG_ADB_PMU
> +       } else if (macintosh_config->adb_type == MAC_ADB_PB2) {
>                 pmu_restart();
>  #endif
>         } else if (CPU_IS_030) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
