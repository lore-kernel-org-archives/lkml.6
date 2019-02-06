Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA1EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6052218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfBFKal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:30:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50269 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfBFKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:30:41 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id aad89d2f0e3602f0; Wed, 6 Feb 2019 11:30:38 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: stats: Declare freq-attr right after their callbacks
Date:   Wed, 06 Feb 2019 11:29:26 +0100
Message-ID: <2982623.nvCWEY4x1A@aspire.rjw.lan>
In-Reply-To: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
References: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 1, 2019 7:15:44 AM CET Viresh Kumar wrote:
> Freq attribute for "trans_table" is defined right after its callback
> (without any blank line between them), but the others are defined
> separately later on. Keep this consistent and define all attributes
> right after their callbacks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 1572129844a5..941e63e3e652 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -51,6 +51,7 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
>  {
>  	return sprintf(buf, "%d\n", policy->stats->total_trans);
>  }
> +cpufreq_freq_attr_ro(total_trans);
>  
>  static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  {
> @@ -69,6 +70,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	}
>  	return len;
>  }
> +cpufreq_freq_attr_ro(time_in_state);
>  
>  static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
>  			   size_t count)
> @@ -77,6 +79,7 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
>  	cpufreq_stats_clear_table(policy->stats);
>  	return count;
>  }
> +cpufreq_freq_attr_wo(reset);
>  
>  static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  {
> @@ -126,10 +129,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  }
>  cpufreq_freq_attr_ro(trans_table);
>  
> -cpufreq_freq_attr_ro(total_trans);
> -cpufreq_freq_attr_ro(time_in_state);
> -cpufreq_freq_attr_wo(reset);
> -
>  static struct attribute *default_attrs[] = {
>  	&total_trans.attr,
>  	&time_in_state.attr,
> 

Applied, along with the [2/2], thanks!

