Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F084CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CE320C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CE320C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeHTM2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:28:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64507 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHTM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:28:03 -0400
Received: from 79.184.253.33.ipv4.supernova.orange.pl (79.184.253.33) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 5fb2511932ddb9d1; Mon, 20 Aug 2018 11:13:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: acpi: Remove some redundant code
Date:   Mon, 20 Aug 2018 11:10:57 +0200
Message-ID: <1630840.jvZHOqyeXS@aspire.rjw.lan>
In-Reply-To: <1534760111-31614-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1534760111-31614-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 20, 2018 12:15:11 PM CEST Ding Xiang wrote:
> For single statement blocks,braces are not necessary.
> And "else" is not useful after return. So,remove these code.
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index b61f4ec..0751a0a 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -423,9 +423,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>  	unsigned int next_perf_state = 0; /* Index into perf table */
>  	int result = 0;
>  
> -	if (unlikely(!data)) {
> +	if (unlikely(!data))
>  		return -ENODEV;
> -	}
>  
>  	perf = to_perf_data(data);
>  	next_perf_state = policy->freq_table[index].driver_data;
> @@ -521,11 +520,10 @@ static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
>  		}
>  		perf->state = perf->state_count-1;
>  		return freqn;
> -	} else {
> -		/* assume CPU is at P0... */
> -		perf->state = 0;
> -		return perf->states[0].core_frequency * 1000;
>  	}
> +	/* assume CPU is at P0... */
> +	perf->state = 0;
> +	return perf->states[0].core_frequency * 1000;
>  }
>  
>  static void free_acpi_perf_data(void)
> 

So what exactly is the value of this patch?


