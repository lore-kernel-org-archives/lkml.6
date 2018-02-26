Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeBZOHB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:07:01 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:35607 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeBZOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:06:59 -0500
Subject: Re: v4.16-rc0: missing includes in framebuffers break N900
 compilation
To: Pavel Machek <pavel@ucw.cz>, <pali.rohar@gmail.com>, <sre@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <khilman@kernel.org>,
        <aaro.koskinen@iki.fi>, <ivo.g.dimitrov.75@gmail.com>,
        <patrikbachan@gmail.com>, <serge@hallyn.com>, <abcloriens@gmail.com>,
        <clayton@craftyguy.net>, <martijn@brixit.nl>,
        <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <arvind.yadav.cs@gmail.com>, <b.zolnierkie@samsung.com>
References: <20180226130007.GA5634@amd>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <46d9fddf-7e6d-b157-0745-6366ccd57a41@ti.com>
Date: Mon, 26 Feb 2018 16:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226130007.GA5634@amd>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.16-rc1 has a fix (b9058afcd6c7).

 Tomi

On 26/02/18 15:00, Pavel Machek wrote:
> I needed this to get -rc0 to compile.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> index 48c6500..990f1c9 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> @@ -38,6 +38,7 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/suspend.h>
>  #include <linux/component.h>
>  
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> index 9a13c35..4862b12 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> @@ -12,6 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <video/omapfb_dss.h>
>  
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> index eac3665..39014e2 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/seq_file.h>
>  #include <linux/clk.h>
>  
>  #include <video/omapfb_dss.h>
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> index 705373e..e93e7a7 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <video/omapfb_dss.h>
> +#include <linux/seq_file.h>
>  
>  #include "dss.h"
>  #include "hdmi.h"
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
