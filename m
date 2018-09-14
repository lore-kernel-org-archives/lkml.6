Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C74FC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35F120866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35F120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeINNrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43958 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbeINNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:21 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id bb5f0e0b729c8dd6; Fri, 14 Sep 2018 10:33:55 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
        Igor Stoppa <igor.stoppa@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: remove unnecessary unlikely()
Date:   Fri, 14 Sep 2018 10:31:14 +0200
Message-ID: <2593189.gyA7ZCrH2V@aspire.rjw.lan>
In-Reply-To: <20180907160955.23291-1-igor.stoppa@huawei.com>
References: <20180907160955.23291-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 7, 2018 6:09:55 PM CEST Igor Stoppa wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
> into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f53fb41efb7b..7aa3dcad2175 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -403,7 +403,7 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_transition_begin);
>  void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>  		struct cpufreq_freqs *freqs, int transition_failed)
>  {
> -	if (unlikely(WARN_ON(!policy->transition_ongoing)))
> +	if (WARN_ON(!policy->transition_ongoing))
>  		return;
>  
>  	cpufreq_notify_post_transition(policy, freqs, transition_failed);
> 

Applied, thanks!


