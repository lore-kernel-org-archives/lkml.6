Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeBSDpA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:45:00 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38725 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeBSDo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:44:57 -0500
X-Google-Smtp-Source: AH8x226sYXbfDs6VssIMo2sC2UdmoWnEgBySzQTfd17RM3A7uJCUdWBZL3mFkECGkPRG9urY3v/VJg==
Date: Mon, 19 Feb 2018 09:14:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c24xx: Delete an error message for a failed
 memory allocation in two functions
Message-ID: <20180219034454.GM28462@vireshk-i7>
References: <201722ce-019d-a5b4-fc00-74679d82b64f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201722ce-019d-a5b4-fc00-74679d82b64f@users.sourceforge.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-02-18, 17:40, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 17:28:40 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/cpufreq/s3c24xx-cpufreq.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
> index 7b596fa38ad2..024afd0b9458 100644
> --- a/drivers/cpufreq/s3c24xx-cpufreq.c
> +++ b/drivers/cpufreq/s3c24xx-cpufreq.c
> @@ -473,10 +473,8 @@ int __init s3c_cpufreq_setboard(struct s3c_cpufreq_board *board)
>  	 * initdata. */
>  
>  	ours = kzalloc(sizeof(*ours), GFP_KERNEL);
> -	if (ours == NULL) {
> -		pr_err("%s: no memory\n", __func__);
> +	if (!ours)
>  		return -ENOMEM;
> -	}
>  
>  	*ours = *board;
>  	cpu_cur.board = ours;
> @@ -562,10 +560,8 @@ static int s3c_cpufreq_build_freq(void)
>  	size++;
>  
>  	ftab = kzalloc(sizeof(*ftab) * size, GFP_KERNEL);
> -	if (!ftab) {
> -		pr_err("%s: no memory for tables\n", __func__);
> +	if (!ftab)
>  		return -ENOMEM;
> -	}
>  
>  	ftab_size = size;
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
