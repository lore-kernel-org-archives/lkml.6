Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeENO62 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:58:28 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40516 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeENO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:58:23 -0400
X-Google-Smtp-Source: AB8JxZrEJG2bJ+01XrgBxKAqpjLkkDfb3Ugj5u6Za9PzHyOifVmw0YSQwJyP8bFnaUyym+iboLimVw==
Date: Mon, 14 May 2018 10:58:21 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Lin Huang <hl@rock-chips.com>
Cc: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] phy: rockchip-typec: support variable phy config
 value
Message-ID: <20180514145821.GB3373@art_vandelay>
References: <1526291635-31122-1-git-send-email-hl@rock-chips.com>
 <1526291635-31122-3-git-send-email-hl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526291635-31122-3-git-send-email-hl@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:53:54PM +0800, Lin Huang wrote:
> the phy config values used to fix in dp firmware, but some boards
> need change these values to do training and get the better eye diagram
> result. So support that in phy driver.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - update patch following Enric suggest
> Changes in v3:
> - delete need_software_training variable
> - add default phy config value, if dts do not define phy config value, use these value
> 
>  drivers/phy/rockchip/phy-rockchip-typec.c | 305 ++++++++++++++++++++----------
>  include/soc/rockchip/rockchip_phy_typec.h |  63 ++++++
>  2 files changed, 270 insertions(+), 98 deletions(-)
>  create mode 100644 include/soc/rockchip/rockchip_phy_typec.h
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 76a4b58..10253ad 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c

/snip

>  
> +/* default phy config */
> +struct phy_config configs[3][4] = {

static const

Also, configs isn't a good name. How about tcphy_default_config?


> +	{{ 0x2a, 0x00 },

Can you please expand the assignment for all of these, ie:

         { .swing = 0x2a, .pe = 0x00 },

> +	 { 0x1f, 0x15 },
> +	 { 0x14, 0x22 },
> +	 { 0x02, 0x2b } },
> +
> +	{{ 0x21, 0x00 },
> +	 { 0x12, 0x15 },
> +	 { 0x02, 0x22 },
> +	 {    0,    0 } },
> +
> +	{{ 0x15, 0x00 },
> +	 { 0x00, 0x15 },
> +	 {    0,    0 },
> +	 {    0,    0 } },
> +};
> +

/snip

-- 
Sean Paul, Software Engineer, Google / Chromium OS
