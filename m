Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeAaPRE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:17:04 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35180 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeAaPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:17:02 -0500
X-Google-Smtp-Source: AH8x227m+UnEOTsxntK6IS7lDcjpKgxWTtj4e8GIMBIOhCZzivEv8pwdGTOygHv7s0JIcmWB70sFSQ==
MIME-Version: 1.0
In-Reply-To: <1517403243.14302.1.camel@pengutronix.de>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
 <20180130202913.28724-34-thierry.escande@collabora.com> <1517403243.14302.1.camel@pengutronix.de>
From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 31 Jan 2018 10:16:37 -0500
X-Gmail-Original-Message-ID: <CAOw6vbKsG=B7vV5_NcwgeAc-=guRN1Xh-dCxKytkDeOjayatLw@mail.gmail.com>
Message-ID: <CAOw6vbKsG=B7vV5_NcwgeAc-=guRN1Xh-dCxKytkDeOjayatLw@mail.gmail.com>
Subject: Re: [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp lq123p1jx31
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Yakir Yang <ykk@rock-chips.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VFH8ZI000818

On Wed, Jan 31, 2018 at 7:54 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 30.01.2018, 21:29 +0100 schrieb Thierry Escande:
>> From: Sean Paul <seanpaul@chromium.org>
>>
>> Change the mode for Sharp lq123p1jx31 panel to something more
>> rockchip-friendly such that we can use the fixed PLLs to
>> generate the pixel clock
>
> This should really switch to a display timing instead of exposing a
> single mode. The display timing has min, typical, max tuples for all
> the timings values, which would allow the attached driver to vary the
> timings inside the allowed bounds if it makes sense.
>
> Trying to hit a specific pixel clock to free up a PLL is exactly one of
> the use cases envisioned for the display timings stuff.
>

Agreed, I think we had this discussion the first time around. We
should drop this patch.

Thanks for catching this!

Sean

> Regards,
> Lucas
>
>> Cc: Chris Zhong <zyw@rock-chips.com>
>> Cc: Stéphane Marchesin <marcheu@chromium.org>
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>> ---
>>  drivers/gpu/drm/panel/panel-simple.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-simple.c
>> b/drivers/gpu/drm/panel/panel-simple.c
>> index 5591984a392b..a4a6ea3ca0e6 100644
>> --- a/drivers/gpu/drm/panel/panel-simple.c
>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>> @@ -1742,17 +1742,18 @@ static const struct panel_desc
>> sharp_lq101k1ly04 = {
>>  };
>>
>>  static const struct drm_display_mode sharp_lq123p1jx31_mode = {
>> -     .clock = 252750,
>> +     .clock = 266667,
>>       .hdisplay = 2400,
>>       .hsync_start = 2400 + 48,
>>       .hsync_end = 2400 + 48 + 32,
>> -     .htotal = 2400 + 48 + 32 + 80,
>> +     .htotal = 2400 + 48 + 32 + 139,
>>       .vdisplay = 1600,
>>       .vsync_start = 1600 + 3,
>>       .vsync_end = 1600 + 3 + 10,
>> -     .vtotal = 1600 + 3 + 10 + 33,
>> +     .vtotal = 1600 + 3 + 10 + 84,
>>       .vrefresh = 60,
>>       .flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>> +     .type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER,
>>  };
>>
>>  static const struct panel_desc sharp_lq123p1jx31 = {
