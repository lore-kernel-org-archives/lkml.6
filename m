Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D14BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3C218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mogvw0en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfBAOZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:25:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32852 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfBAOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:25:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so4671635wmh.0;
        Fri, 01 Feb 2019 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xDTvjg/nXebcdXocsOOitS0hh02ek9EoczA/KSbNN2M=;
        b=mogvw0ensvu00i3tUUrhWfrSNC6zmfH1DWpCYrScFIWYO+KwLUURPAJiPzFkzJ5kkv
         3RyB+aWSWDyC5PqNQJ/JNnUcCJMCxb4P0uyS700yFNS5HGIE3BHUKoAxuCltYvfGFj4f
         +wiUGiwPjooDgvsiXCA7AkmZmPyqav5/gRheLGnnoWWnf9LT5vyV+Q+8Prrx4gSuaF1x
         bCD+PNFyCWUlewX128fZ89KfuEmHRo/mm4fTYzvwmPwiYQigls48m0UXS0NexRZH9L6F
         BcpGOQ2o2yjRT6DHptprZYH21exwjgPP8nW9bmB5cfDHa7B4qNCwxZ6g51J6V41SvNQU
         b+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xDTvjg/nXebcdXocsOOitS0hh02ek9EoczA/KSbNN2M=;
        b=H5d0r0+xC8H7Rtb415H9rrUHQk6T5FDVOm/iqGgC2Z7K2n7EVr1CNlZ71ogeRxNsrv
         d8PKKQ33is2xrRX5/GHhAy9TYIVPs9uM1mMNu4kiCvCcIimzsL2yr5bn9I4WE0lp7Yvh
         tyV70y2Xep7QOLDkyuwxFslhGzxHvtfHY6x3HADypSfsEn2iYZW3WSijEF/jKp0s3jjp
         ePVdVzZ2FxWinLPO68lVLmWD1u2NuF/4BzmXKOAJ9ctvcetcWV2IMz6UC6pAUlJ2fZHo
         XDEnGUr+VqeH/I01E6w/X2Tz4ICJ5usMKRt6OJOgS2INz9FDoOF7OZSPtt7ME26lKFIi
         uQ3A==
X-Gm-Message-State: AHQUAua4fVFJvfH8H0lhtm5jtHZPKV2N4LMz1Lbo5tExwRmL8FIEyEiw
        PWgZiMMzPpE+fSAw6Qt+khjQoX89Kl5K9dWCeXQ=
X-Google-Smtp-Source: AHgI3IaDj0CuGguYFccFtmyoqIYwTUhYEsCwJ9pXJlVkAz/9GZHcy9HS0LtdAroyG6FkzKfrcd6l1sznIKrW74WVO1s=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr2740767wmu.52.1549031155288;
 Fri, 01 Feb 2019 06:25:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:8b48:0:0:0:0:0 with HTTP; Fri, 1 Feb 2019 06:25:54 -0800 (PST)
In-Reply-To: <20181229133318.18128-5-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com> <20181229133318.18128-5-jbx6244@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Date:   Fri, 1 Feb 2019 15:25:54 +0100
Message-ID: <CA+z=w3UKrDODY964WOtq-FQhuFJWg4C2jKXn0=3QT45gJ3UG_A@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drm: rockchip: introduce rk3066 hdmi
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Beside the binding for "rockchip,rk3066-vop" this patch series
also has a new binding for "rockchip,rk3066-hdmi".
Can Rob Herring advise here? Including the document describing the binding.

This patch still has the original license text included.
Can the copyright holder (or Sandy) approve the replacement of the GPL text
by a SPDX License Identifier for GPL-2.0?

Is Heiko's test setup for rk3066 already functional?

Thanks

2018-12-29 14:33 GMT+01:00, Johan Jonker <jbx6244@gmail.com>:

> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> @@ -0,0 +1,928 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + *    Zheng Yang <zhengyang@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

> +static inline u8 rk3066_hdmi_get_power_mode(struct rk3066_hdmi *hdmi)
> +{
> +	return hdmi_readb(hdmi, HDMI_SYS_CTRL) & HDMI_SYS_POWER_MODE_MASK;
> +}
> +
> +static void rk3066_hdmi_set_power_mode(struct rk3066_hdmi *hdmi, int mode)
> +{
> +	u8 current_mode, next_mode;
> +	u8 i = 0;
> +

The function rk3066_hdmi_get_power_mode can also returns 0 with VIO
power domain disabled.
That would lead to an endless loop. Just replaced 0 with
HDMI_SYS_POWER_MODE_A to prevent a crash.
Please advise if this function is OK with you?

> +	current_mode = rk3066_hdmi_get_power_mode(hdmi);
> +
> +	dev_dbg(hdmi->dev, "mode         :%d\n", mode);
> +	dev_dbg(hdmi->dev, "current_mode :%d\n", current_mode);
> +
> +	if (current_mode == mode)
> +		return;
> +
> +	do {
> +		if (current_mode > mode)
> +			next_mode = current_mode / 2;
> +		else {
> +			if (current_mode < HDMI_SYS_POWER_MODE_A)
> +				next_mode = HDMI_SYS_POWER_MODE_A;
> +			else
> +				next_mode = current_mode * 2;
> +		}
> +
> +		dev_dbg(hdmi->dev, "%d: next_mode :%d\n", i, next_mode);
> +
> +		if (next_mode != HDMI_SYS_POWER_MODE_D) {
> +			hdmi_modb(hdmi, HDMI_SYS_CTRL,
> +				  HDMI_SYS_POWER_MODE_MASK, next_mode);
> +		} else {
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D |
> +				    HDMI_SYS_PLL_RESET_MASK);
> +			usleep_range(90, 100);
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D |
> +				    HDMI_SYS_PLLB_RESET);
> +			usleep_range(90, 100);
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D);
> +		}
> +		current_mode = next_mode;
> +		i = i + 1;
> +	} while ((next_mode != mode) && (i < 5));

> +static const struct drm_display_mode edid_cea_modes[] = {
> +	/* 4 - 1280x720@60Hz 16:9 */
> +	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74250, 1280, 1390,
> +		   1430, 1650, 0, 720, 725, 730, 750, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +};
> +
> +static int rk3066_hdmi_connector_get_modes(struct drm_connector
> *connector)
> +{
> +	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
> +	struct drm_display_mode *mode = NULL;
> +	struct edid *edid;
> +	int ret = 0;
> +
> +	if (!hdmi->ddc)
> +		return 0;
> +
> +	hdmi->hdmi_data.sink_is_hdmi = false;
> +
> +	edid = drm_get_edid(connector, hdmi->ddc);
> +	if (edid) {
> +		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> +
> +		dev_info(hdmi->dev, "monitor type : %s : %dx%d cm\n",
> +			(hdmi->hdmi_data.sink_is_hdmi ? "HDMI" : "DVI"),
> +			edid->width_cm, edid->height_cm);
> +
> +		drm_connector_update_edid_property(connector, edid);
> +		ret = drm_add_edid_modes(connector, edid);
> +		kfree(edid);
> +	}
> +

The DRM framework doesn't provide a function to make a CEA mode. DVI-D
needs a mode set here.
Adding more modes needs an extra for loop. For now one mode is enough.
Just leave it that way.? Please advise.

> +	if ((ret == 0) || (hdmi->hdmi_data.sink_is_hdmi == false)) {
> +		hdmi->hdmi_data.sink_is_hdmi = false;
> +
> +		mode = drm_mode_duplicate(hdmi->drm_dev, &edid_cea_modes[0]);
> +		if (!mode)
> +			return ret;
> +		mode->type |= DRM_MODE_TYPE_PREFERRED;
> +		drm_mode_probed_add(connector, mode);
> +		ret++;
> +
> +		dev_info(hdmi->dev, "no CEA mode found, use default\n");
> +	}
> +
> +	return ret;
> +}

> +struct platform_driver rk3066_hdmi_driver = {
> +	.probe  = rk3066_hdmi_probe,
> +	.remove = rk3066_hdmi_remove,
> +	.driver = {
> +		.name = "rockchip-rk3066hdmi",
> +		.of_match_table = rk3066_hdmi_dt_ids,
> +	},
> +};


> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.h
> b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
> new file mode 100644
> index 000000000..f4c2e2081
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
> @@ -0,0 +1,235 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + *    Zheng Yang <zhengyang@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
