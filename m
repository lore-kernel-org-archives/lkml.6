Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755244AbeEXG1L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 02:27:11 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:10728 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755032AbeEXG1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 02:27:08 -0400
Subject: Re: v4.17-rc1: regressions on N900, N950
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>
CC: Dave Airlie <airlied@redhat.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, <sre@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <khilman@kernel.org>,
        <ivo.g.dimitrov.75@gmail.com>, <patrikbachan@gmail.com>,
        <serge@hallyn.com>, <abcloriens@gmail.com>, <clayton@craftyguy.net>,
        <martijn@brixit.nl>, <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd> <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523220254.GD2299@darkstar.musicnaut.iki.fi>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <39a1e3a3-b9ca-3aa9-eed1-7ac5ee580c8f@ti.com>
Date: Thu, 24 May 2018 09:25:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523220254.GD2299@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 01:02, Aaro Koskinen wrote:

> But turns out that omapdrm tree is unbisectable, as I get build failures such
> as (commit 28d79f3e56b2c1d5ff0fd363da3229be0962cc85):
> 
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.c:1473:52: error: undefined identifier 'dss_debug_dump_clocks'
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.c:1472:51: warning: callwith no type!

This goes away if you enable CONFIG_OMAP2_DSS_DEBUGFS.

> In file included from /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/core.c:28:0:
> /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.h:395:25: error: conflicting types for 'port'
>       struct device_node *port,
>                           ^~~~

And this goes away if you enable CONFIG_OMAP2_DSS_DPI.

Sorry about those.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. 
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
