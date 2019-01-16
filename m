Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B17206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfAPW4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:56:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61499 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfAPW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:56:13 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id c0ea1eb4b00dd76d; Wed, 16 Jan 2019 23:56:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 03/10] cpufreq: Replace open-coded << with BIT()
Date:   Wed, 16 Jan 2019 23:55:17 +0100
Message-ID: <2392396.AI7Hxg4e4v@aspire.rjw.lan>
In-Reply-To: <e1984eedda04ca44a44b4972708855702f5d91e4.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org> <e1984eedda04ca44a44b4972708855702f5d91e4.1547481320.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 14, 2019 5:34:55 PM CET Amit Kucheria wrote:
> Minor clean-up to use BIT() and keep checkpatch happy. Clean up the
> comment formatting while we're at it to make it easier to read.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Can you please do this cleanup as the first patch in the series, so it
doesn't depend on the other patches in it, which isn't necessary IMO?

> ---
>  include/linux/cpufreq.h | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 70ad02088825..ea303dfd5f05 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -351,14 +351,15 @@ struct cpufreq_driver {
>  };
>  
>  /* flags */
> -#define CPUFREQ_STICKY		(1 << 0)	/* driver isn't removed even if
> -						   all ->init() calls failed */
> -#define CPUFREQ_CONST_LOOPS	(1 << 1)	/* loops_per_jiffy or other
> -						   kernel "constants" aren't
> -						   affected by frequency
> -						   transitions */
> -#define CPUFREQ_PM_NO_WARN	(1 << 2)	/* don't warn on suspend/resume
> -						   speed mismatches */
> +
> +/* driver isn't removed even if all ->init() calls failed */
> +#define CPUFREQ_STICKY				BIT(0)
> +
> +/* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
> +#define CPUFREQ_CONST_LOOPS			BIT(1)
> +
> +/* don't warn on suspend/resume speed mismatches */
> +#define CPUFREQ_PM_NO_WARN			BIT(2)
>  
>  /*
>   * This should be set by platforms having multiple clock-domains, i.e.
> @@ -366,14 +367,14 @@ struct cpufreq_driver {
>   * be created in cpu/cpu<num>/cpufreq/ directory and so they can use the same
>   * governor with different tunables for different clusters.
>   */
> -#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY (1 << 3)
> +#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY	BIT(3)
>  
>  /*
>   * Driver will do POSTCHANGE notifications from outside of their ->target()
>   * routine and so must set cpufreq_driver->flags with this flag, so that core
>   * can handle them specially.
>   */
> -#define CPUFREQ_ASYNC_NOTIFICATION  (1 << 4)
> +#define CPUFREQ_ASYNC_NOTIFICATION		BIT(4)
>  
>  /*
>   * Set by drivers which want cpufreq core to check if CPU is running at a
> @@ -382,19 +383,19 @@ struct cpufreq_driver {
>   * from the table. And if that fails, we will stop further boot process by
>   * issuing a BUG_ON().
>   */
> -#define CPUFREQ_NEED_INITIAL_FREQ_CHECK	(1 << 5)
> +#define CPUFREQ_NEED_INITIAL_FREQ_CHECK	BIT(5)
>  
>  /*
>   * Set by drivers to disallow use of governors with "dynamic_switching" flag
>   * set.
>   */
> -#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
> +#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
>  
>  /*
>   * Set by drivers that want the core to automatically register the cpufreq
>   * driver as a thermal cooling device
>   */
> -#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
>  
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> 


