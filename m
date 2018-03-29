Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeC2O6P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:58:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:2874 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeC2O6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:58:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="32488877"
Message-ID: <1522335490.2964.2.camel@intel.com>
Subject: Re: [PATCH] time: export nsec_to_clock_t
From: Zhang Rui <rui.zhang@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Date: Thu, 29 Mar 2018 22:58:10 +0800
In-Reply-To: <20180328141205.2954245-1-arnd@arndb.de>
References: <20180328141205.2954245-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2018-03-28 at 16:11 +0200, Arnd Bergmann wrote:
> nsec_to_clock_t was traditionally used only in the core kernel, now
> we
> have a sysfs file that needs it from a loadable module, causing a
> link-time error:
> 
> ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!
> 
> This exports the function the same way that we do for related
> interfaces.
> 
> Fixes: 96cea33badc5 ("thermal: Add cooling device's statistics in
> sysfs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix.
can I take this patch through thermal tree?

thanks,
rui
> ---
>  kernel/time/time.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index 6fa99213fc72..97a262531f68 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -768,6 +768,7 @@ u64 nsec_to_clock_t(u64 x)
>  	return div_u64(x * 9, (9ull * NSEC_PER_SEC + (USER_HZ / 2))
> / USER_HZ);
>  #endif
>  }
> +EXPORT_SYMBOL(nsec_to_clock_t);
>  
>  u64 jiffies64_to_nsecs(u64 j)
>  {
