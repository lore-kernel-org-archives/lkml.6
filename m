Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CBEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1499B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBh1XOes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfAaNpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:45:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42676 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAaNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:45:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so3423282qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zwsoOyEGM3Zxvl29geGE7UyzLhjKAAe4O9yK+TkSX1g=;
        b=NBh1XOesEbDxYbhkx7JDLfkiCe/uWONCEDfXQIpiTra6UE0emcDBKwI3q4jxZ3VyfA
         t0594BCfIn8Je5Bqo7W2Rl2roGgF00GUKWYTbIdQwWQvh1atNXsuHf3lPnzIJzJlRkSl
         mYqbEs5Br5uM/D1ibwEngQdBmZdJxkuSU4ozIYseQZnh+UWBIrPWCxLhgIL3G91X/DW/
         +ePwjk4yDFtRQ4T+Db+uY1KuX/w/NoKddFci9YuQlqvUzivUAv16ly2+eJnK+5QCnr2P
         vk8faxsZe7O3tqZ5WdbJOZTG/6Ok3EG133UfvSSBOWm+chhTi0Azr1lfuBgoToTsAGT3
         Oclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwsoOyEGM3Zxvl29geGE7UyzLhjKAAe4O9yK+TkSX1g=;
        b=eeosmXkBF12xpEFsFGyH5vdR5XmLysB0QmLcExLGMf36ybojihKmtd+FXQq1D2L1lX
         BBqOLr1TzW4UUqScuZ8GP9f45XU1jOg/2l5pm35cgBneND3WO5vYcYGYduCQSf1pipfI
         ozKudOO0poWE48MZFTx1fX/8lZTpHPyJ5BrB/3O6A3OH/bR+cxfFzVFYsYL0TdTttPvQ
         sMjzbKHXJl+hdJ7y6ZaRd8NdcOQ4FmR1Jf6Y3qLTawuIiejm7xUZ3LPmVyx0kJ6fu2xh
         uMcv+JlLRBdFYwCC/NWzZ2EYHq/eoVNUOkR0oM27v9qGs6xxW9mQGfXdAyotTfzz5uM+
         2q8g==
X-Gm-Message-State: AJcUukffIvMi9boqqe5KEgJZFk07oqvKt/r1JBTJq9SBzRq0YhHhxI7f
        r9Jc47TBZ0Abpf3LQRq/qg==
X-Google-Smtp-Source: ALg8bN7/PoErPNkeY3hKBPo9F4NOvMcECOVJ3nKuxtb/G6BTGvk8MFTYBWUxPCTe1UNyd9ozotJMtA==
X-Received: by 2002:a0c:a9da:: with SMTP id c26mr31735665qvb.140.1548942304924;
        Thu, 31 Jan 2019 05:45:04 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id z18sm10691205qkz.96.2019.01.31.05.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 05:45:04 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:44:58 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH] sched/debug: initialize sd_sysctl_cpus if
 !CONFIG_CPUMASK_OFFSTACK
Message-ID: <20190131134457.caj7vaestug4q2l3@gabell>
References: <20190129151245.5073-1-msys.mizuma@gmail.com>
 <20190130201400.GH2278@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130201400.GH2278@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:14:00PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 29, 2019 at 10:12:45AM -0500, Masayoshi Mizuma wrote:
> > From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> > 
> > register_sched_domain_sysctl() copies the cpu_possible_mask into
> > sd_sysctl_cpus, but only if sd_sysctl_cpus hasn't already been
> > allocated (ie, CONFIG_CPUMASK_OFFSTACK is set).  However, when
> > CONFIG_CPUMASK_OFFSTACK is not set, sd_sysctl_cpus is left uninitialized
> > (all zeroes) and the kernel may fail to initialize sched_domain sysctl
> > entries for all possible cpus.
> > 
> > This is visible to the user if the kernel is booted with maxcpus=n, or
> > if ACPI tables have been modified to leave cpus offline, and then
> > checking for missing /proc/sys/kernel/sched_domain/cpu* entries.
> > 
> > Fix this by separating the allocataion and initialization, and adding
> > a flag to initialize the possible cpu entries while system booting only.
> > 
> > Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> > Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > Tested-by: Syuuichirou Ishii <ishii.shuuichir@jp.fujitsu.com>
> > Tested-by: Tarumizu, Kohei <tarumizu.kohei@jp.fujitsu.com>
> > ---
> >  kernel/sched/debug.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index de3de997e245..9c6637f3e21d 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -310,6 +310,7 @@ static struct ctl_table *sd_alloc_ctl_cpu_table(int cpu)
> >  
> >  static cpumask_var_t		sd_sysctl_cpus;
> >  static struct ctl_table_header	*sd_sysctl_header;
> > +static int register_sched_domain_sysctl_on_boot = 1;
> >  
> >  void register_sched_domain_sysctl(void)
> >  {
> > @@ -344,9 +345,12 @@ void register_sched_domain_sysctl(void)
> >  	if (!cpumask_available(sd_sysctl_cpus)) {
> >  		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
> >  			return;
> > +	}
> >  
> > +	if (register_sched_domain_sysctl_on_boot) {
> >  		/* init to possible to not have holes in @cpu_entries */
> >  		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
> > +		register_sched_domain_sysctl_on_boot = 0;
> >  	}
> >  
> >  	for_each_cpu(i, sd_sysctl_cpus) {
> 
> I change it like the below. By keeping the initial value 0 it can go
> into .bss instead of .data.

Great, thanks!
Should I re-post the patch as v2?

- Masa

> 
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -315,6 +315,7 @@ void register_sched_domain_sysctl(void)
>  {
>  	static struct ctl_table *cpu_entries;
>  	static struct ctl_table **cpu_idx;
> +	static bool init_done = false;
>  	char buf[32];
>  	int i;
>  
> @@ -344,7 +345,10 @@ void register_sched_domain_sysctl(void)
>  	if (!cpumask_available(sd_sysctl_cpus)) {
>  		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
>  			return;
> +	}
>  
> +	if (!init_done) {
> +		init_done = true;
>  		/* init to possible to not have holes in @cpu_entries */
>  		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
>  	}
