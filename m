Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93008C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3301A20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN4QaI4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3301A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIJNlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:41:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37172 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJNlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:41:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so20442702wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZyibKuh6j7Nc+r6le/aQUwQX1ul7HkC70olL3Ml83Q=;
        b=PN4QaI4J+cJ4NQLmKimPibUiwxkBwf++Lex30aDRK9WvNJANjGZotvEHPVi758jlpH
         SXNc5zsgi9aw94T0GUR75I61+VTY7+hEvm92gqmHfpLHvj9lhS60eTlRsZzZZkweWTXv
         plBRGFsJY8H9EE5tfPyMl6Fpr5eR5d/2syxwHZBaETPYOveyJgNumoKxv3MnqbHhOxYl
         hxt89hw19hGshKzCtYmzf3/G8+gpjosW4V/SZC+dPqPKXGNnF3FUCas/18zb6WaD8FXU
         Odk4hJ/a1LM+OUctjpdsCmLYaRcwdR3UCLLpcCqPxMux7H1z47Sq9XjMcrsM779TVzad
         Mysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZyibKuh6j7Nc+r6le/aQUwQX1ul7HkC70olL3Ml83Q=;
        b=Ws2xzGbQQmqfK1ShzumG3cc2xdiKgp5nvuh70hFYO20xCiltELyXLQv8V3vcxLo9i+
         tZ73gi9f68hC9fKqHSbCHDIfu+RwU5QEfVVDiYyZ702BzDf9aDvmGsSMk2TFMqmnAO8d
         J/L/UrtEnVSTTdUNHeRfxE/IIdYXXO0vlVSHRKT8/bt7VkamgHJGZeme8eLtTnmZ+6g1
         gZzWjZCntC9ptwv5T2AP9YSjIrYD44p+TMUlKU1B7uTdqZZuObabzEYxQWgUCB0rT1DW
         VTNRRebiaLgX08/VUS8vghJlaKZjKwqb4DMlc8xWSfilMyUWESJW79rXzFcBtIRJ9Gsq
         PY6Q==
X-Gm-Message-State: APzg51CkMYYeimCw6lSUWzp23XsF4xb48yONKT1RP2SLVjsRHzenvMwQ
        U5RKNsRrGkjvEH+wG6f0JbE=
X-Google-Smtp-Source: ANB0VdYdQtqRwhUktWzrPQQva59zLdpw8mv1/8Niwy4tYE/IZWIRb3uxhUcQbD9FSLOuZrH4s70Deg==
X-Received: by 2002:a1c:6a06:: with SMTP id f6-v6mr11726469wmc.159.1536569291112;
        Mon, 10 Sep 2018 01:48:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j6-v6sm11442188wru.64.2018.09.10.01.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 01:48:10 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:48:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/6] sched/numa: Reset scan rate whenever task moves
 across nodes
Message-ID: <20180910084808.GE48257@gmail.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533276841-16341-6-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533276841-16341-6-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> Currently task scan rate is reset when numa balancer migrates the task
> to a different node. If numa balancer initiates a swap, reset is only
> applicable to the task that initiates the swap. Similarly no scan rate
> reset is done if the task is migrated across nodes by traditional load
> balancer.
> 
> Instead move the scan reset to the migrate_task_rq. This ensures the
> task moved out of its preferred node, either gets back to its preferred
> node quickly or finds a new preferred node. Doing so, would be fair to
> all tasks migrating across nodes.
> 
> specjbb2005 / bops/JVM / higher bops are better
> on 2 Socket/2 Node Intel
> JVMS  Prev    Current  %Change
> 4     210118  208862   -0.597759
> 1     313171  307007   -1.96825
> 
> 
> on 2 Socket/4 Node Power8 (PowerNV)
> JVMS  Prev     Current  %Change
> 8     91027.5  89911.4  -1.22611
> 1     216460   216176   -0.131202
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> JVMS  Prev    Current  %Change
> 4     191918  196078   2.16759
> 1     207043  214664   3.68088
> 
> 
> on 4 Socket/4 Node Power7
> JVMS  Prev     Current  %Change
> 8     58462.1  60719.2  3.86079
> 1     108334   112615   3.95167
> 
> 
> dbench / transactions / higher numbers are better
> on 2 Socket/2 Node Intel
> count  Min      Max      Avg      Variance  %Change
> 5      11851.8  11937.3  11890.9  33.5169
> 5      12511.7  12559.4  12539.5  15.5883   5.45459
> 
> 
> on 2 Socket/4 Node Power8 (PowerNV)
> count  Min      Max      Avg      Variance  %Change
> 5      4791     5016.08  4962.55  85.9625
> 5      4709.28  4979.28  4919.32  105.126   -0.871125
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> count  Min      Max      Avg     Variance  %Change
> 5      9353.43  9380.49  9369.6  9.04361
> 5      9388.38  9406.29  9395.1  5.98959   0.272157
> 
> 
> on 4 Socket/4 Node Power7
> count  Min      Max      Avg      Variance  %Change
> 5      149.518  215.412  179.083  21.5903
> 5      157.71   184.929  174.754  10.7275   -2.41731
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a5936ed..4ea0eff 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1837,12 +1837,6 @@ static int task_numa_migrate(struct task_struct *p)
>  	if (env.best_cpu == -1)
>  		return -EAGAIN;
>  
> -	/*
> -	 * Reset the scan period if the task is being rescheduled on an
> -	 * alternative node to recheck if the tasks is now properly placed.
> -	 */
> -	p->numa_scan_period = task_scan_start(p);
> -
>  	best_rq = cpu_rq(env.best_cpu);
>  	if (env.best_task == NULL) {
>  		ret = migrate_task_to(p, env.best_cpu);
> @@ -6361,6 +6355,19 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
>  
>  	/* We have migrated, no longer consider this task hot */
>  	p->se.exec_start = 0;
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +	if (!p->mm || (p->flags & PF_EXITING))
> +		return;
> +
> +	if (p->numa_faults) {
> +		int src_nid = cpu_to_node(task_cpu(p));
> +		int dst_nid = cpu_to_node(new_cpu);
> +
> +		if (src_nid != dst_nid)
> +			p->numa_scan_period = task_scan_start(p);
> +	}
> +#endif

Please don't add #ifdeffery inside functions, especially not if they do weird flow control like 
a 'return' from the middle of a block.

A properly named inline helper would work I suppose.

Thanks,

	Ingo
