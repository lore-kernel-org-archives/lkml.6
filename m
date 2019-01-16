Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A3C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA5D206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbfAPL6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:58:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61197 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388572AbfAPL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:58:30 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d6c084a77fa68dd1; Wed, 16 Jan 2019 12:58:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Don't update new_policy on failures
Date:   Wed, 16 Jan 2019 12:57:36 +0100
Message-ID: <3588039.3NVSA610fZ@aspire.rjw.lan>
In-Reply-To: <af05a5d2d3ef76402f54448a66cbd20ee98bceb8.1546844324.git.viresh.kumar@linaro.org>
References: <af05a5d2d3ef76402f54448a66cbd20ee98bceb8.1546844324.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 7, 2019 7:58:54 AM CET Viresh Kumar wrote:
> The local variable "new_policy" isn't getting used in the error path
> since the commit f9f41e3ef99a ("cpufreq: Remove policy create/remove
> notifiers"). Don't update it in error path.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7aa3dcad2175..9a5f82ef40e8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1305,8 +1305,6 @@ static int cpufreq_online(unsigned int cpu)
>  	if (ret) {
>  		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
>  		       __func__, cpu, ret);
> -		/* cpufreq_policy_free() will notify based on this */
> -		new_policy = false;
>  		goto out_destroy_policy;
>  	}
>  
> 

Applied, thanks!


