Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeBGI5d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:57:33 -0500
Received: from foss.arm.com ([217.140.101.70]:46994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbeBGI5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:57:31 -0500
Subject: Re: [PATCH v5 1/4] cpu_pm: add syscore_suspend error handling
To: Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-2-dbasehore@chromium.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <04ebd1d9-b45b-df87-d59e-1a3df97f3371@arm.com>
Date: Wed, 7 Feb 2018 08:57:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207014117.62611-2-dbasehore@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 01:41, Derek Basehore wrote:
> If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
> will put the CPU in the correct state to resume from the failure.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  kernel/cpu_pm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 67b02e138a47..03bcc0751a51 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -186,6 +186,9 @@ static int cpu_pm_suspend(void)
>  		return ret;
>  
>  	ret = cpu_cluster_pm_enter();
> +	if (ret)
> +		cpu_pm_exit();
> +
>  	return ret;
>  }
>  
> 

It is unclear to me why we need this patch as part of the ITS series. I
probably fixes something for you, but I don't see the connection with
the other patches.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
