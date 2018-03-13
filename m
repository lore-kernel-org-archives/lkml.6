Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934436AbeCMPhk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:37:40 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34976 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932486AbeCMPhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:37:34 -0400
X-Google-Smtp-Source: AG47ELv426y2jyCNwT30p2hdjJa1nZVh9fYbN+JZhg4sWe+WEGMRCv5yOUL7U48OcZF+WGGhsuLY3upHev2NC+HFjEY=
MIME-Version: 1.0
In-Reply-To: <1520949014-21468-4-git-send-email-yannick.fertre@st.com>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com> <1520949014-21468-4-git-send-email-yannick.fertre@st.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Mar 2018 09:30:37 -0600
X-Google-Sender-Auth: M_zgEqmvy9DJgbav3QiecSsgQZM
Message-ID: <CAPnjgZ3NF9v8YZxWS4BQEfy2YC41w0Fp1ogNkWt7Z19DRxvyPg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] video: add support of MIPI DSI interface
To: yannick fertre <yannick.fertre@st.com>
Cc: Vikas Manocha <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
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

Hi,

On 13 March 2018 at 07:50, yannick fertre <yannick.fertre@st.com> wrote:
>
> Mipi_display.c contains a set of dsi helpers.
> This file is a copy of file drm_mipi_dsi.c (linux kernel).
>
> Signed-off-by: yannick fertre <yannick.fertre@st.com>
> ---
>  drivers/video/Kconfig        |   7 +
>  drivers/video/Makefile       |   1 +
>  drivers/video/mipi_display.c | 807 +++++++++++++++++++++++++++++++++++++++++++
>  include/mipi_display.h       | 257 +++++++++++++-

Please add function comments for the functions in this file,
explaining args and what the functions do.

Shouldn't DSI be its own uclass? We normally separate drivers for
different peripherals in U-Boot.

>  4 files changed, 1071 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/video/mipi_display.c
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 2fc0def..1981298 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -75,6 +75,13 @@ config VIDEO_ANSI
>           Enable ANSI escape sequence decoding for a more fully functional
>           console.
>
> +config VIDEO_MIPI_DSI
> +       bool "Support MIPI DSI interface"
> +       depends on DM_VIDEO
> +       default y if DM_VIDEO
> +       help
> +         Support MIPI DSI interface for driving a MIPI compatible LCD panel.

Please expand out what MIPI stands for and what it is, same with DSI.
