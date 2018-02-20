Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeBTQQq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:16:46 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:39672 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeBTQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:16:44 -0500
X-Google-Smtp-Source: AH8x225SF1kvCiiApWGcPxQK3Fs3cS8tulJsK9v7lMk2fB/SUbMfKGvWkDkRAJnWNasZ4p3ILfnZsw==
MIME-Version: 1.0
In-Reply-To: <cover.1516810725.git.meghana.madhyastha@gmail.com>
References: <cover.1516810725.git.meghana.madhyastha@gmail.com>
From: Sean Paul <seanpaul@chromium.org>
Date: Tue, 20 Feb 2018 11:16:21 -0500
X-Gmail-Original-Message-ID: <CAOw6vbLxenhYeV3axTkLn5azf7Ocr0fNqwdwLprAQUSE2e0e+g@mail.gmail.com>
Message-ID: <CAOw6vbLxenhYeV3axTkLn5azf7Ocr0fNqwdwLprAQUSE2e0e+g@mail.gmail.com>
Subject: Re: [PATCH v19 00/10] Add backlight helper functions
To: Meghana Madhyastha <meghana.madhyastha@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2018 at 11:32 AM, Meghana Madhyastha
<meghana.madhyastha@gmail.com> wrote:
> Move drm helper functions from tinydrm-helpers to linux/backlight for
> ease of use by callers in other drivers.
>

It was a long time coming, but this has finally been applied to
-misc-next. Thanks for sticking with it!

Sean

> Changes in v19:
> -Changed to devm version of of_find_backlight in omapdrm (patch 10)
> -removed assigning pdev->dev to variable dev in omapdrm (patch 10)
>
> Meghana Madhyastha (10):
>   video: backlight: Add helpers to enable and disable backlight
>   drm/tinydrm: Convert tinydrm_enable/disable_backlight to
>     backlight_enable/disable
>   video: backlight: Add of_find_backlight helper in backlight.c
>   drm/tinydrm: Replace tinydrm_of_find_backlight with of_find_backlight
>   video: backlight: Add devres versions of of_find_backlight
>   drm/tinydrm: Call devres version of of_find_backlight
>   drm/panel: Use backlight_enable/disable helpers
>   drm/omapdrm: Use backlight_enable/disable helpers
>   drm/panel: Use of_find_backlight helper
>   drm/omapdrm: Use of_find_backlight helper
>
>  drivers/gpu/drm/omapdrm/displays/panel-dpi.c    | 36 ++--------
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c   | 30 ++------
>  drivers/gpu/drm/panel/panel-jdi-lt070me05000.c  |  6 +-
>  drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c | 38 ++--------
>  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 37 ++--------
>  drivers/gpu/drm/tinydrm/Kconfig                 |  2 -
>  drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c  | 95 -------------------------
>  drivers/gpu/drm/tinydrm/mi0283qt.c              |  3 +-
>  drivers/gpu/drm/tinydrm/mipi-dbi.c              |  4 +-
>  drivers/gpu/drm/tinydrm/st7735r.c               |  3 +-
>  drivers/video/backlight/backlight.c             | 73 +++++++++++++++++++
>  include/drm/tinydrm/tinydrm-helpers.h           |  4 --
>  include/linux/backlight.h                       | 58 +++++++++++++++
>  13 files changed, 165 insertions(+), 224 deletions(-)
>
> --
> 2.11.0
>
