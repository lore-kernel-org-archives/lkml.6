Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeBSDos (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:44:48 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41116 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeBSDoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:44:46 -0500
X-Google-Smtp-Source: AH8x2241kRw3myiMLrvhur6o/9wVyxI5Ltgr+Po71LriiN+WfAZ5Ko44olrL73DmjJyV41raeM3TeQ==
Date: Mon, 19 Feb 2018 09:14:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qoriq: Delete two error messages for a failed
 memory allocation in qoriq_cpufreq_cpu_init()
Message-ID: <20180219034443.GL28462@vireshk-i7>
References: <650e783f-7b4c-17b5-3bc7-56e3058a95d1@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650e783f-7b4c-17b5-3bc7-56e3058a95d1@users.sourceforge.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-02-18, 18:08, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 18:00:37 +0100
> 
> Omit extra messages for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 0562761a3dec..ee3e3656485b 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -192,16 +192,12 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	count = clk_hw_get_num_parents(hwclk);
>  
>  	data->pclk = kcalloc(count, sizeof(struct clk *), GFP_KERNEL);
> -	if (!data->pclk) {
> -		pr_err("%s: no memory\n", __func__);
> +	if (!data->pclk)
>  		goto err_nomem2;
> -	}
>  
>  	table = kcalloc(count + 1, sizeof(*table), GFP_KERNEL);
> -	if (!table) {
> -		pr_err("%s: no memory\n", __func__);
> +	if (!table)
>  		goto err_pclk;
> -	}
>  
>  	for (i = 0; i < count; i++) {
>  		clk = clk_hw_get_parent_by_index(hwclk, i)->clk;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
