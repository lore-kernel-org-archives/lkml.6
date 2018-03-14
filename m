Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeCNIOs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:14:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41494 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752917AbeCNIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:14:29 -0400
X-Google-Smtp-Source: AG47ELsbqPVnE6kob4hHqeU7qRHnIqyqzo8q5hT3oUfH5s4y4Z4Yf7jFJgEecn088sxo+8h1eDFkKA==
Date: Wed, 14 Mar 2018 13:44:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
Message-ID: <20180314081426.GG15832@vireshk-i7>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
 <1520924571.3766.8.camel@intel.com>
 <1521014472.2087.32.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521014472.2087.32.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-18, 16:01, Zhang Rui wrote:
> WARNING: please write a paragraph that describes the config symbol
> fully
> #147: FILE: drivers/thermal/Kconfig:18:
> +config THERMAL_STATISTICS
> 
> WARNING: Consider renaming function(s)
> 'thermal_cooling_device_total_trans_show' to 'total_trans_show'
> #391: FILE: drivers/thermal/thermal_sysfs.c:901:
> +}
> 
> WARNING: Consider renaming function(s)
> 'thermal_cooling_device_time_in_state_show' to 'time_in_state_show'
> #395: FILE: drivers/thermal/thermal_sysfs.c:905:
> +static DEVICE_ATTR(time_in_state, 0444,
> 
> WARNING: Consider renaming function(s)
> 'thermal_cooling_device_reset_store' to 'reset_store'
> #397: FILE: drivers/thermal/thermal_sysfs.c:907:
> +static DEVICE_ATTR(reset, 0200, NULL,
> thermal_cooling_device_reset_store);
> 
> WARNING: Consider renaming function(s)
> 'thermal_cooling_device_trans_table_show' to 'trans_table_show'
> #398: FILE: drivers/thermal/thermal_sysfs.c:908:
> +static DEVICE_ATTR(trans_table, 0444,
> 
> total: 0 errors, 5 warnings, 366 lines checked
> 
> 
> I'm okay with the first one because the description does not have to be
> larger than 3 lines.

Right.

> the last 4 warnings makes sense to me. I think we should rename the
> function and use DEVICE_ATTR_RO() and DEVICE_ATTR_WO() instead.
> 
> what do you think?

I got those warnings as well, and I quietly ignored them :)

I ignored the renaming part for the sake of consistency. The other existing
routines for similar purpose are named as:

thermal_cooling_device_type_show
thermal_cooling_device_max_state_show
thermal_cooling_device_cur_state_show
thermal_cooling_device_cur_state_store

for me it made more sense to follow that naming convention. And I didn't use the
_RO and _WO variants for the same reason.

Now here is what I propose now:

- You apply this patch as-is and ignore the warning.

- I will send few patches on top of that to do:
  - renaming of all such routines to shorter versions.
  - Use the _RO or _WO variants of the macro everywhere.

What do you say ?

-- 
viresh
