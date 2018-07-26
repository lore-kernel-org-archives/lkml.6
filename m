Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD8C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD532083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NyhgSpuP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hxetfhya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD532083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeGZIlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:41:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeGZIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:41:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 720F160B77; Thu, 26 Jul 2018 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532589933;
        bh=g5D9699AWGaKZ5SM6P0P6DAbbsimiJYaEh+fQttOU9o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NyhgSpuPFpAL5U8zYZfoGe96/wUHedmCNjv0Ius3FeKcDMrZkDAjFjeSytm7j3POk
         n+1HLCBGppyi2MGtchDLg3CWBxv348nOoxw4Nn9HeyMe0LC6wWrDYNsBCs4cmyF5QZ
         EdRIDXyA0/X91nCW4n7VEgt/WvboqQjxmhuhIKro=
Received: from [192.168.0.227] (unknown [182.74.96.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: architt@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D31A9607B9;
        Thu, 26 Jul 2018 07:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532589931;
        bh=g5D9699AWGaKZ5SM6P0P6DAbbsimiJYaEh+fQttOU9o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HxetfhyaE0rju30SPIbCv+V959vcsnOSvMpVGIECEXp9u0kb8LSOFO1cMm3opNKuW
         PLd13x/a6ZWltU86apD3LCSz7Zmxe5BNfx9OuRwry7K1bRuG6E+xlbqH7M1PFE9xjv
         oBbUrag3J7HPehGAQ67sRc4TytrBE3p6E7Jwg4DU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D31A9607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v2] drm/msm/display: negative x/y in cursor move
To:     Carsten Behling <carsten.behling@googlemail.com>
Cc:     Carsten Behling <carsten.behling@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Steve Kowalik <steven@wedontsleep.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <201807170504.KBRX6Bew%fengguang.wu@intel.com>
 <20180716230314.3527-1-carsten.behling@gmail.com>
 <99e72f0c-e753-cff9-9a58-50d919d472a5@codeaurora.org>
 <CAPuGWB9oBN4U6OS8FLDQ1m6eO3n4mT-UG3QWHdjuM9XgSLG8iQ@mail.gmail.com>
From:   Archit Taneja <architt@codeaurora.org>
Message-ID: <1763b39b-9898-bf5a-9afc-32d8e753bbbc@codeaurora.org>
Date:   Thu, 26 Jul 2018 12:55:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPuGWB9oBN4U6OS8FLDQ1m6eO3n4mT-UG3QWHdjuM9XgSLG8iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 25 July 2018 08:40 PM, Carsten Behling wrote:
> Hi,
> 
>> Thanks for the patch. Could you tell how to reproduce this issue
>> on a db410c?
>  >
>> I was playing with xrandr's --rotate and --reflect options to get
>> a rotated output, but wasn't able to generate negative x/y
>> co-ordinates. I'm using linaro's debian userspace, running lxqt.
> 
> I used Yocto Rocko from 96Boards
> 
> https://github.com/96boards/oe-rpb-manifest/tree/rocko
> 
> MACHINE=dragonboard-410c
> DISTRO=rpb
> 
> rpb-desktop-image
> 
> Connect HDMI monitor and USB mouse, then
> 
> 1.) Just boot. Wait for X-Server up.
> 2.) From my serial console:
>       DISPLAY=:0.0 xrandr -o 2
> 3.) Try to move the mouse to the upper (the rotated lower) border.
> 
> Interesting to know that your debian user space is ok. The yocto X11 
> configuration is very basic.
> There may be a X11 configuration or extension that does the trick on Debian.

Thanks, I'll give this a try.

The patch looks good, anyway. Rob's queued it for msm-next.

Archit

> 
> Therefore, I asked the X11 people where to fix:
> 
> https://www.spinics.net/lists/xorg/msg58969.html
> 
> Best regards
> -Carsten
> 
> 
> 2018-07-24 19:33 GMT+02:00 Archit Taneja <architt@codeaurora.org 
> <mailto:architt@codeaurora.org>>:
> 
>     Hi,
> 
>     On Tuesday 17 July 2018 04:33 AM, Carsten Behling wrote:
> 
>         modesetting X11 driver may provide negative x/y cordinates in
>         mdp5_crtc_cursor_move call when rotation is enabled.
> 
>         Cursor buffer can overlap down to its negative width/height.
> 
>         ROI has to be recalculated for negative x/y indicating using the
>         lower/right corner of the cursor buffer and hotspot must be set
>         in MDP5_LM_CURSOR_XY_SRC_Y MDP5_LM_CURSOR_XY_SRC_X.
> 
> 
>     Thanks for the patch. Could you tell how to reproduce this issue
>     on a db410c?
> 
>     I was playing with xrandr's --rotate and --reflect options to get
>     a rotated output, but wasn't able to generate negative x/y
>     co-ordinates. I'm using linaro's debian userspace, running lxqt.
> 
>     Thanks,
>     Archit
> 
> 
> 
>         Signed-off-by: Carsten Behling <carsten.behling@gmail.com
>         <mailto:carsten.behling@gmail.com>>
>         ---
>         Changes in v2:
>         - fixed format specifier in debug message
> 
>            drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 51
>         ++++++++++++++++++++++++++-----
>            1 file changed, 43 insertions(+), 8 deletions(-)
> 
>         diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
>         b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
>         index 10271359789e..a7f4a6688fec 100644
>         --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
>         +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
>         @@ -65,7 +65,7 @@ struct mdp5_crtc {
>                          struct drm_gem_object *scanout_bo;
>                          uint64_t iova;
>                          uint32_t width, height;
>         -               uint32_t x, y;
>         +               int x, y;
>                  } cursor;
>            };
>            #define to_mdp5_crtc(x) container_of(x, struct mdp5_crtc, base)
>         @@ -760,20 +760,31 @@ static void get_roi(struct drm_crtc *crtc,
>         uint32_t *roi_w, uint32_t *roi_h)
>                   * Cursor Region Of Interest (ROI) is a plane read from
>         cursor
>                   * buffer to render. The ROI region is determined by
>         the visibility of
>                   * the cursor point. In the default Cursor image the
>         cursor point will
>         -        * be at the top left of the cursor image, unless it is
>         specified
>         -        * otherwise using hotspot feature.
>         +        * be at the top left of the cursor image.
>                   *
>         +        * Without rotation:
>                   * If the cursor point reaches the right (xres - x <
>         cursor.width) or
>                   * bottom (yres - y < cursor.height) boundary of the
>         screen, then ROI
>                   * width and ROI height need to be evaluated to crop
>         the cursor image
>                   * accordingly.
>                   * (xres-x) will be new cursor width when x > (xres -
>         cursor.width)
>                   * (yres-y) will be new cursor height when y > (yres -
>         cursor.height)
>         +        *
>         +        * With rotation:
>         +        * We get negative x and/or y coordinates.
>         +        * (cursor.width - abs(x)) will be new cursor width when
>         x < 0
>         +        * (cursor.height - abs(y)) will be new cursor width
>         when y < 0
>                   */
>         -       *roi_w = min(mdp5_crtc->cursor.width, xres -
>         +       if (mdp5_crtc->cursor.x >= 0)
>         +               *roi_w = min(mdp5_crtc->cursor.width, xres -
>                                  mdp5_crtc->cursor.x);
>         -       *roi_h = min(mdp5_crtc->cursor.height, yres -
>         +       else
>         +               *roi_w = mdp5_crtc->cursor.width -
>         abs(mdp5_crtc->cursor.x);
>         +       if (mdp5_crtc->cursor.y >= 0)
>         +               *roi_h = min(mdp5_crtc->cursor.height, yres -
>                                  mdp5_crtc->cursor.y);
>         +       else
>         +               *roi_h = mdp5_crtc->cursor.height -
>         abs(mdp5_crtc->cursor.y);
>            }
>              static void mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
>         @@ -783,7 +794,7 @@ static void mdp5_crtc_restore_cursor(struct
>         drm_crtc *crtc)
>                  struct mdp5_kms *mdp5_kms = get_kms(crtc);
>                  const enum mdp5_cursor_alpha cur_alpha =
>         CURSOR_ALPHA_PER_PIXEL;
>                  uint32_t blendcfg, stride;
>         -       uint32_t x, y, width, height;
>         +       uint32_t x, y, src_x, src_y, width, height;
>                  uint32_t roi_w, roi_h;
>                  int lm;
>            @@ -800,6 +811,26 @@ static void
>         mdp5_crtc_restore_cursor(struct drm_crtc *crtc)
>                  get_roi(crtc, &roi_w, &roi_h);
>            +     /* If cusror buffer overlaps due to rotation on the
>         +        * upper or left screen border the pixel offset inside
>         +        * the cursor buffer of the ROI is the positive overlap
>         +        * distance.
>         +        */
>         +       if (mdp5_crtc->cursor.x < 0) {
>         +               src_x = abs(mdp5_crtc->cursor.x);
>         +               x = 0;
>         +       } else {
>         +               src_x = 0;
>         +       }
>         +       if (mdp5_crtc->cursor.y < 0) {
>         +               src_y = abs(mdp5_crtc->cursor.y);
>         +               y = 0;
>         +       } else {
>         +               src_y = 0;
>         +       }
>         +       DBG("%s: x=%u, y=%u roi_w=%u roi_h=%u src_x=%u src_y=%u",
>         +               crtc->name, x, y, roi_w, roi_h, src_x, src_y);
>         +
>                  mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_STRIDE(lm),
>         stride);
>                  mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_FORMAT(lm),
>                                 
>         MDP5_LM_CURSOR_FORMAT_FORMAT(CURSOR_FMT_ARGB8888));
>         @@ -812,6 +843,9 @@ static void mdp5_crtc_restore_cursor(struct
>         drm_crtc *crtc)
>                  mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_START_XY(lm),
>                                  MDP5_LM_CURSOR_START_XY_Y_START(y) |
>                                  MDP5_LM_CURSOR_START_XY_X_START(x));
>         +       mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_XY(lm),
>         +                       MDP5_LM_CURSOR_XY_SRC_Y(src_y) |
>         +                       MDP5_LM_CURSOR_XY_SRC_X(src_x));
>                  mdp5_write(mdp5_kms, REG_MDP5_LM_CURSOR_BASE_ADDR(lm),
>                                  mdp5_crtc->cursor.iova);
>            @@ -932,8 +966,9 @@ static int mdp5_crtc_cursor_move(struct
>         drm_crtc *crtc, int x, int y)
>                  if (unlikely(!crtc->state->enable))
>                          return 0;
>            -     mdp5_crtc->cursor.x = x = max(x, 0);
>         -       mdp5_crtc->cursor.y = y = max(y, 0);
>         +       /* accept negative x/y coordinates up to maximum cursor
>         overlap */
>         +       mdp5_crtc->cursor.x = x = max(x,
>         -(int)mdp5_crtc->cursor.width);
>         +       mdp5_crtc->cursor.y = y = max(y,
>         -(int)mdp5_crtc->cursor.height);
>                  get_roi(crtc, &roi_w, &roi_h);
> 
> 
