Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeENMIH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:08:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40180 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeENMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:08:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180514120802euoutp02837f396736c0f1c48b70f124541aa464~ugXln5g341687516875euoutp02H
X-AuditID: cbfec7f4-b4fc79c0000043e4-af-5af97c1f2bbb
Subject: Re: [PATCH] PM / core: refactor PM_OPS initializers
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <9e1f4be2-436e-0d60-eb28-44c229a3178c@samsung.com>
Date: Mon, 14 May 2018 14:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514082146.4318-1-a.hajda@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7oKNT+jDFZeYLL4O+kYu8XGGetZ
        LWZN2ctkcXnXHDaLz71HGC3WHrnLbnH31FE2izOnL7E6cHj8/jWJ0WPxnpdMHluutrN49G1Z
        xeixYvV3do/Pm+QC2KK4bFJSczLLUov07RK4Mj6dv89U8EGu4tqtD6wNjGckuxg5OSQETCQ+
        bPzH1MXIxSEksIJR4n/LSnYI5wujxJ0ZPSwQzmdGiVnPlzPBtHzqnATVspxRov/GV2YI5y2j
        RMeSd6xdjBwcwgI2Eu9/a4DERQSWMkpcnvqGFcRhFmhjlLjZcJERZBSbgKbE38032UBsXgE7
        if9T9rKD2CwCqhJ73u1kAbFFBSIkmp7/ZIeoEZQ4OfMJWJxTwELi4YfLYL3MAvISzVtnM0PY
        4hK3nswHO09CYB+7xJQVi9gg7naRWPX9NpQtLPHq+BZ2CFtG4vTkHhYIu1ri5osmFojmDkaJ
        +7/boRqsJQ4fvwj2GjPQ1et36UOEbSX2rjnMBhKWEOCTuPFWEOIGPolJ26YzQ4R5JTrahCCq
        FSXun93KDGGLSyy98JVtAqPyLCSfzULyzSwk38xC2LuAkWUVo3hqaXFuemqxUV5quV5xYm5x
        aV66XnJ+7iZGYGo6/e/4lx2Mu/4kHWIU4GBU4uFdsfJHlBBrYllxZe4hRgkOZiUR3t1GP6OE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YWpBbBZJk4OKUaGB3XJ9VcXB8s
        nKS5LEm5kX/q/w9XNJh05p2ZH3NY6IJE+9btPOkNO4/czHiyr9DnmFt1o+ezziuzTXVV/i+W
        sqx8Uh+8x8uD597z9NVT/+b9/HhbcYJBxaXye4wXHFw/hCRcZRJqWdF97cjimz/4dKM3COb/
        3/eev3Hd274gn6NzsvytnC5fsVFiKc5INNRiLipOBAAOX9vjSQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7pyNT+jDH60ilv8nXSM3WLjjPWs
        FrOm7GWyuLxrDpvF594jjBZrj9xlt7h76iibxZnTl1gdODx+/5rE6LF4z0smjy1X21k8+ras
        YvRYsfo7u8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2Nimp
        OZllqUX6dgl6GZ/O32cq+CBXce3WB9YGxjOSXYycHBICJhKfOicxgdhCAksZJT6vEYeIi0vs
        nv+WGcIWlvhzrYuti5ELqOY1o8Tp2e9Zuhg5OIQFbCTe/9YAqREB6T12Vw6khlmgjVGi+VAj
        M0RDN9DQbz/ANrAJaEr83XyTDcTmFbCT+D9lLzuIzSKgKrHn3U4WEFtUIELi3vlPUDWCEidn
        PgGLcwpYSDz8cBksziygLvFn3iVmCFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYw
        sqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjMRtx35u2cHY9S74EKMAB6MSD++KlT+ihFgT
        y4orcw8xSnAwK4nw7jb6GSXEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cAkkVcSb2hqaG5h
        aWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgfEk75mVjakdl0wj77d6H8hcXug8
        6asj4y2+ajfNtNgI+XyHt4IfvkfV9vU9d02Mjr8pbCFVn9/R8+tLyUQ15wVpceIy3wTfbbm4
        UkL7NnfEC6uzQetfn5Ou/qf9Zf2SvV3WCVeqCib5eorM50idyPMs6CcDz5GnB/rP/Vz4utTj
        0jLzT8pmYUosxRmJhlrMRcWJAL/NUhnaAgAA
X-CMS-MailID: 20180514120759eucas1p1875a9756c2d7cb33b39b5ac78b8beb09
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180514120759eucas1p1875a9756c2d7cb33b39b5ac78b8beb09
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180514082201eucas1p1549ae992aeeef0906a2cccb5da96533f
X-RootMTR: 20180514082201eucas1p1549ae992aeeef0906a2cccb5da96533f
References: <CGME20180514082201eucas1p1549ae992aeeef0906a2cccb5da96533f@eucas1p1.samsung.com>
        <20180514082146.4318-1-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2018 10:21, Andrzej Hajda wrote:
> With current implementation of PM_OPS initializers users should annotate
> all PM callbacks with __maybe_unused attribute to prevent compiler from
> complaining in case respective option is not enabled. Using ternary
> operator with IS_ENABLED(symbol) as a condition allows to avoid marking
> these functions with __maybe_unused.
> Solution was tested successfully with multiple versions of gcc since
> 4.9.4 up to 7.2.1. No functional changes has been observed and callbacks
> were compiled out if not used, as before.

The kernel does not compile with the patch applied if the driver defines
PM callback inside "#ifdef CONFIG_PM(_SLEEP)" - initializers assume that
callbacks are defined, even if they are not used.
So if the idea is OK I should figure it out how to make proper
transition, any ideas welcome :)

Regards
Andrzej

>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  include/linux/pm.h | 61 ++++++++++++++++++----------------------------
>  1 file changed, 24 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e723b78d8357..59f333922c15 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -313,50 +313,37 @@ struct dev_pm_ops {
>  	int (*runtime_idle)(struct device *dev);
>  };
>  
> -#ifdef CONFIG_PM_SLEEP
> +#define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
> +#define PM_PTR(ptr) (IS_ENABLED(CONFIG_PM) ? (ptr) : NULL)
> +
>  #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -	.suspend = suspend_fn, \
> -	.resume = resume_fn, \
> -	.freeze = suspend_fn, \
> -	.thaw = resume_fn, \
> -	.poweroff = suspend_fn, \
> -	.restore = resume_fn,
> -#else
> -#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> -#endif
> +	.suspend = PM_SLEEP_PTR(suspend_fn), \
> +	.resume = PM_SLEEP_PTR(resume_fn), \
> +	.freeze = PM_SLEEP_PTR(suspend_fn), \
> +	.thaw = PM_SLEEP_PTR(resume_fn), \
> +	.poweroff = PM_SLEEP_PTR(suspend_fn), \
> +	.restore = PM_SLEEP_PTR(resume_fn),
>  
> -#ifdef CONFIG_PM_SLEEP
>  #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -	.suspend_late = suspend_fn, \
> -	.resume_early = resume_fn, \
> -	.freeze_late = suspend_fn, \
> -	.thaw_early = resume_fn, \
> -	.poweroff_late = suspend_fn, \
> -	.restore_early = resume_fn,
> -#else
> -#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> -#endif
> +	.suspend_late = PM_SLEEP_PTR(suspend_fn), \
> +	.resume_early = PM_SLEEP_PTR(resume_fn), \
> +	.freeze_late = PM_SLEEP_PTR(suspend_fn), \
> +	.thaw_early = PM_SLEEP_PTR(resume_fn), \
> +	.poweroff_late = PM_SLEEP_PTR(suspend_fn), \
> +	.restore_early = PM_SLEEP_PTR(resume_fn),
>  
> -#ifdef CONFIG_PM_SLEEP
>  #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -	.suspend_noirq = suspend_fn, \
> -	.resume_noirq = resume_fn, \
> -	.freeze_noirq = suspend_fn, \
> -	.thaw_noirq = resume_fn, \
> -	.poweroff_noirq = suspend_fn, \
> -	.restore_noirq = resume_fn,
> -#else
> -#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> -#endif
> +	.suspend_noirq = PM_SLEEP_PTR(suspend_fn), \
> +	.resume_noirq = PM_SLEEP_PTR(resume_fn), \
> +	.freeze_noirq = PM_SLEEP_PTR(suspend_fn), \
> +	.thaw_noirq = PM_SLEEP_PTR(resume_fn), \
> +	.poweroff_noirq = PM_SLEEP_PTR(suspend_fn), \
> +	.restore_noirq = PM_SLEEP_PTR(resume_fn),
>  
> -#ifdef CONFIG_PM
>  #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> -	.runtime_suspend = suspend_fn, \
> -	.runtime_resume = resume_fn, \
> -	.runtime_idle = idle_fn,
> -#else
> -#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
> -#endif
> +	.runtime_suspend = PM_PTR(suspend_fn), \
> +	.runtime_resume = PM_PTR(resume_fn), \
> +	.runtime_idle = PM_PTR(idle_fn),
>  
>  /*
>   * Use this if you want to use the same suspend and resume callbacks for suspend
