Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B66C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA27A214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sjm+e+Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbeKUXnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:43:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47440 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKUXnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nCG+jXX8uNGqlqqoFESCKSdkKidtBODjCyXtca2k2vI=; b=sjm+e+OgG33mFjMDdbgTBF+fL
        8ZSygXW4okVCuqU4/aU0I8uReiVYSQgjBEjvVXht3qfXuiOMc54RkRlc8OPfGYjo7aysEg803z4/Y
        zIoSjdG6FHUw+kXR0r3NpqoB2mreU4y/km+jfpo2jQntY8Ej90eqDXVns3UUuvY7A6Oe8ANG2td8J
        YKotM7YZeR1SvnDhQLWgpwxuJkCtXpjK/f8TFwMIf2+5zQmhDYq5GkWQbjyS8/+asirWsQKkakg0/
        GtRDqZQfAARQYywoVqSLwemDXj04wQG8MX9YdPpX+1syurT4HQhlJU0oQYaLjd6qBmwRjBF49hzlJ
        KtdX2slwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPSEz-0006HP-JL; Wed, 21 Nov 2018 13:08:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8C972029FD58; Wed, 21 Nov 2018 14:08:22 +0100 (CET)
Date:   Wed, 21 Nov 2018 14:08:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Message-ID: <20181121130822.GE2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-10-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-10-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:18:51PM +0000, Quentin Perret wrote:

> +static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
> +{
> +	/*
> +	 * The conditions for EAS to start are checked during the creation of
> +	 * root domains. If one of them meets all conditions, it will have a
> +	 * non-null list of performance domains.
> +	 */
> +	while (ndoms_new) {
> +		if (cpu_rq(cpumask_first(doms_new[ndoms_new - 1]))->rd->pd)
> +			goto enable;
> +		ndoms_new--;
> +	}

That seems quite ugly; can't you simply return a bool from
build_perf_domains() ?

Something like the below, but less fugly ;-)

--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -299,7 +299,7 @@ static void destroy_perf_domain_rcu(stru
 #define EM_MAX_COMPLEXITY 2048
 
 extern struct cpufreq_governor schedutil_gov;
-static void build_perf_domains(const struct cpumask *cpu_map)
+static bool build_perf_domains(const struct cpumask *cpu_map)
 {
 	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct perf_domain *pd = NULL, *tmp;
@@ -365,7 +365,7 @@ static void build_perf_domains(const str
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
 
-	return;
+	return !!pd;
 
 free:
 	free_pd(pd);
@@ -373,6 +373,8 @@ static void build_perf_domains(const str
 	rcu_assign_pointer(rd->pd, NULL);
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
+
+	return false;
 }
 #else
 static void free_pd(struct perf_domain *pd) { }
@@ -2173,6 +2175,9 @@ void partition_sched_domains(int ndoms_n
 	}
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+	{
+	bool has_eas = false;
+
 	/* Build perf. domains: */
 	for (i = 0; i < ndoms_new; i++) {
 		for (j = 0; j < n && !sched_energy_update; j++) {
@@ -2181,10 +2186,13 @@ void partition_sched_domains(int ndoms_n
 				goto match3;
 		}
 		/* No match - add perf. domains for a new rd */
-		build_perf_domains(doms_new[i]);
+		has_eas |= build_perf_domains(doms_new[i]);
 match3:
 		;
 	}
+
+	sched_energy_set(has_eas);
+	}
 #endif
 
 	/* Remember the new sched domains: */
