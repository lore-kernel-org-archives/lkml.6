Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D0DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034F52081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034F52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeLKKte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:49:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58038 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKKtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:49:33 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id c208d9e100e89c24; Tue, 11 Dec 2018 11:49:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] cpufreq: imx6q: remove unused code
Date:   Tue, 11 Dec 2018 11:49:13 +0100
Message-ID: <3624116.FYVZqeVW1R@aspire.rjw.lan>
In-Reply-To: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
References: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 26, 2018 3:59:45 AM CET Anson Huang wrote:
> In voltage scale down path, the return value is NOT
> used at all, remove them to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index d8c3595..8cb9683 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -177,22 +177,16 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	/* scaling down?  scale voltage after frequency */
>  	if (new_freq < old_freq) {
>  		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> -		if (ret) {
> +		if (ret)
>  			dev_warn(cpu_dev,
>  				 "failed to scale vddarm down: %d\n", ret);
> -			ret = 0;
> -		}
>  		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
> -		if (ret) {
> +		if (ret)
>  			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
> -			ret = 0;
> -		}
>  		if (!IS_ERR(pu_reg)) {
>  			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
> -			if (ret) {
> +			if (ret)
>  				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
> -				ret = 0;
> -			}
>  		}
>  	}
>  
> 

Both this one and the [2/2] applied with ACKs from Viresh.

Thanks!


