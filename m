Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C293DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960862084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfAVKg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:36:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57354 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfAVKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:36:27 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 7fd8984a77e56357; Tue, 22 Jan 2019 11:36:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Replace open-coded << with BIT()
Date:   Tue, 22 Jan 2019 11:35:26 +0100
Message-ID: <3475847.8TT7FkP2ce@aspire.rjw.lan>
In-Reply-To: <2501c48872e5fa9c26f06216c19955d70b263a85.1548060067.git.amit.kucheria@linaro.org>
References: <2501c48872e5fa9c26f06216c19955d70b263a85.1548060067.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 21, 2019 9:47:37 AM CET Amit Kucheria wrote:
> Minor clean-up to use BIT() and keep checkpatch happy. Clean up the
> comment formatting while we're at it to make it easier to read.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/cpufreq.h | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c86d6d8bdfed..bd7fbd6a4478 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -346,14 +346,15 @@ struct cpufreq_driver {
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
> @@ -361,14 +362,14 @@ struct cpufreq_driver {
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
> @@ -377,13 +378,13 @@ struct cpufreq_driver {
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
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> 

Applied, thanks!

