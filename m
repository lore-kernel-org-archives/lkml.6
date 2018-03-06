Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeCFRvy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:51:54 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44243 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeCFRvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:51:52 -0500
X-Google-Smtp-Source: AG47ELsPemr855QKW+cejWqv8rBMFd1f7uDmHkn+S4BPyPiKNXKI+DdvLSVW84ENgonvwsR5dP9hP+CnGr8reDh20Yw=
MIME-Version: 1.0
In-Reply-To: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Mar 2018 10:51:29 -0700
X-Google-Sender-Auth: NeZJ8MTOmHbOApkaeRSMMNRJuRs
Message-ID: <CAPnjgZ3AZbPLoPScBNOKA3RvHpP9KANLBSu2Osn_n6RRw1AQEA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] splash screen on the stm32f769 disco board
To: yannick fertre <yannick.fertre@st.com>
Cc: Vikas Manocha <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        dri-devel@lists.freedesktop.org, lk <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 March 2018 at 08:44, yannick fertre <yannick.fertre@st.com> wrote:
>
> Version 2:
> - Replace debug log by pr_error, pr_warn or pr_info.
> - Rework bridge between ltdc & dsi panel
> - Rework backligh management (with or witout gpio)
> - Rework panel otm8009a
> - Add new panel raydium rm68200
>
> Version 1:
> - Initial commit
>
> This serie contains all patchsets needed for displaying a splash screen
> on the stm32f769 disco board.
>
> yannick fertre (10):
>   video: stm32: stm32_ltdc: add bridge to display controller
>   video: stm32: stm32_ltdc: update debug log
>   video: add support of MIPI DSI interface
>   video: add support of panel OTM8009A
>   video: add MIPI DSI host controller bridge
>   video: add support of STM32 MIPI DSI controller driver
>   video: add support of panel rm68200
>   arm: dts: stm32: add dsi for STM32F746
>   arm: dts: stm32: add display for STM32F769 disco board
>   board: Add STM32F769 SoC, discovery board support
>
>  arch/arm/dts/stm32f746.dtsi        |  12 +
>  arch/arm/dts/stm32f769-disco.dts   |  71 ++++
>  configs/stm32f769-disco_defconfig  |  63 +++
>  drivers/video/Kconfig              |  32 ++
>  drivers/video/Makefile             |   4 +
>  drivers/video/dw_mipi_dsi.c        | 822 +++++++++++++++++++++++++++++++++++++
>  drivers/video/mipi_display.c       | 807 ++++++++++++++++++++++++++++++++++++
>  drivers/video/orisetech_otm8009a.c | 329 +++++++++++++++
>  drivers/video/raydium-rm68200.c    | 329 +++++++++++++++
>  drivers/video/stm32/Kconfig        |  10 +
>  drivers/video/stm32/Makefile       |   1 +
>  drivers/video/stm32/stm32_dsi.c    | 427 +++++++++++++++++++
>  drivers/video/stm32/stm32_ltdc.c   | 144 ++++---
>  include/dw_mipi_dsi.h              |  32 ++
>  include/mipi_display.h             | 257 +++++++++++-
>  15 files changed, 3285 insertions(+), 55 deletions(-)
>  create mode 100644 configs/stm32f769-disco_defconfig
>  create mode 100644 drivers/video/dw_mipi_dsi.c
>  create mode 100644 drivers/video/mipi_display.c
>  create mode 100644 drivers/video/orisetech_otm8009a.c
>  create mode 100644 drivers/video/raydium-rm68200.c
>  create mode 100644 drivers/video/stm32/stm32_dsi.c
>  create mode 100644 include/dw_mipi_dsi.h

Does this use driver model? I cannot see it.

Regards,
Simon
