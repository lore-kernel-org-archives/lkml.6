Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409F62177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfBSKVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:21:39 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64237 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfBSKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:21:39 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 4034a995d08c4900; Tue, 19 Feb 2019 11:21:36 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Replace double NOT (!!) with single NOT (!)
Date:   Tue, 19 Feb 2019 11:20:12 +0100
Message-ID: <2245714.fz2rs2yT5a@aspire.rjw.lan>
In-Reply-To: <e0ea5fc21f9d3bd38eb4eb678d39359d66c8e79e.1550141092.git.viresh.kumar@linaro.org>
References: <e0ea5fc21f9d3bd38eb4eb678d39359d66c8e79e.1550141092.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 14, 2019 11:46:21 AM CET Viresh Kumar wrote:
> Double NOT (!!) operation is normally done to convert a non-zero value
> to 1 and keep zero as is, but that isn't the requirement in this case.
> All we wanted was to make sure that only one of the two routines isn't
> set, i.e. either both function pointers are set or both are unset.
> 
> This can be done with a single NOT (!) operation as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 55e9795801a4..ad4e9991c3cc 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2505,7 +2505,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  		    driver_data->target) ||
>  	     (driver_data->setpolicy && (driver_data->target_index ||
>  		    driver_data->target)) ||
> -	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate) ||
> +	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
>  	     (!driver_data->online != !driver_data->offline))
>  		return -EINVAL;
>  
> 

Applied, thanks!


