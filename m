Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeERB67 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:58:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43308 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeERB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:58:57 -0400
X-Google-Smtp-Source: AB8JxZpa5697eylKmmifG7eLLQGL4G6BemkOncwOF3XNWItkkiXlsjqWWqIsPlLO9+n1ySEeO6k5PQ==
Date: Fri, 18 May 2018 07:28:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 05/11] cpufreq: tegra20: Clean up included headers
Message-ID: <20180518015854.glj25krzacf7rnd7@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-6-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Remove unused/unneeded headers and sort them in the alphabet order.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 69f033d297e1..61f00d1cba26 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -16,16 +16,9 @@
>   *
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/sched.h>
> -#include <linux/cpufreq.h>
> -#include <linux/delay.h>
> -#include <linux/init.h>
> -#include <linux/err.h>
>  #include <linux/clk.h>
> -#include <linux/io.h>
> +#include <linux/cpufreq.h>
> +#include <linux/module.h>

Ideally you should keep all the headers whose declarations your code
is using directly. It may happen that removing above still compiles
because cpufreq.h has included the headers indirectly for you. But
that will break the day cpufreq.h doesn't need those headers anymore.

So just make sure you aren't using any of them in your code. For
example you are using bool in your code and so you shouldn't remove
types.h ? Same for init.h as you are using __init and __exit.

>  
>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ .frequency = 216000 },
> -- 
> 2.17.0

-- 
viresh
