Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BBFC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2224A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfA1THi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:07:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:41526 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfA1THh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:07:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 11:07:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="270591510"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.136]) ([10.24.14.136])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2019 11:07:36 -0800
Subject: Re: [PATCH AUTOSEL 4.19 059/258] x86/resctrl: Fixup the user-visible
 strings
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Babu Moger <Babu.Moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        David Miller <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Safonov <dima@arista.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Joerg Roedel <jroedel@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pu Wen <puwen@hygon.cn>, qianyue.zj@alibaba-inc.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rian Hunter <rian@alum.mit.edu>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, xiaochen.shen@intel.com
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-59-sashal@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <c9c45e03-aef3-e1be-2c81-d903a1669499@intel.com>
Date:   Mon, 28 Jan 2019 11:07:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190128155924.51521-59-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On 1/28/2019 7:56 AM, Sasha Levin wrote:
> From: Babu Moger <Babu.Moger@amd.com>
> 
> [ Upstream commit 723f1a0dd8e26a7523ba068204bee11c95ded38d ]
> 
> Fix the messages in rdt_last_cmd_printf() and rdt_last_cmd_puts() to
> make them more meaningful and consistent.

It is not clear to me why this patch is considered for stable since it
just changes user visible strings to be more consistent.

If user visible string consistency/correctness is of concern and is what
prompted its consideration then please also consider to include upstream
commit
456824896de2b68df40b3ea5777ef49dc6cc8fda "x86/resctrl: Use
rdt_last_cmd_puts() where possible" that fixes two typos that was
introduced in this commit. This may introduce difficultly though since
the file layout changed between the kernel versions these patches are
found in.

Reinette

> 
>  [ bp: s/cpu/CPU/; s/mem\W/memory ]
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: <linux-doc@vger.kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: <qianyue.zj@alibaba-inc.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Rian Hunter <rian@alum.mit.edu>
> Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: <xiaochen.shen@intel.com>
> Link: https://lkml.kernel.org/r/20181121202811.4492-11-babu.moger@amd.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 22 ++++++-------
>  arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 34 +++++++++----------
>  arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 36 ++++++++++-----------
>  3 files changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
> index 627e5c809b33..79d099538f2e 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
> @@ -71,7 +71,7 @@ int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
>  	unsigned long bw_val;
>  
>  	if (d->have_new_ctrl) {
> -		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
>  		return -EINVAL;
>  	}
>  
> @@ -97,12 +97,12 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  
>  	ret = kstrtoul(buf, 16, &val);
>  	if (ret) {
> -		rdt_last_cmd_printf("non-hex character in mask %s\n", buf);
> +		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
>  		return false;
>  	}
>  
>  	if (val == 0 || val > r->default_ctrl) {
> -		rdt_last_cmd_puts("mask out of range\n");
> +		rdt_last_cmd_puts("Mask out of range\n");
>  		return false;
>  	}
>  
> @@ -110,12 +110,12 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
>  
>  	if (find_next_bit(&val, cbm_len, zero_bit) < cbm_len) {
> -		rdt_last_cmd_printf("mask %lx has non-consecutive 1-bits\n", val);
> +		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
>  		return false;
>  	}
>  
>  	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> -		rdt_last_cmd_printf("Need at least %d bits in mask\n",
> +		rdt_last_cmd_printf("Need at least %d bits in the mask\n",
>  				    r->cache.min_cbm_bits);
>  		return false;
>  	}
> @@ -135,7 +135,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>  	u32 cbm_val;
>  
>  	if (d->have_new_ctrl) {
> -		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
>  		return -EINVAL;
>  	}
>  
> @@ -145,7 +145,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>  	 */
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>  	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
> -		rdt_last_cmd_printf("pseudo-locked region in hierarchy\n");
> +		rdt_last_cmd_printf("Pseudo-locked region in hierarchy\n");
>  		return -EINVAL;
>  	}
>  
> @@ -164,14 +164,14 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>  	 * either is exclusive.
>  	 */
>  	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
> -		rdt_last_cmd_printf("overlaps with exclusive group\n");
> +		rdt_last_cmd_printf("Overlaps with exclusive group\n");
>  		return -EINVAL;
>  	}
>  
>  	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
>  		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
>  		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -			rdt_last_cmd_printf("overlaps with other group\n");
> +			rdt_last_cmd_printf("0verlaps with other group\n");
>  			return -EINVAL;
>  		}
>  	}
> @@ -293,7 +293,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
>  		if (!strcmp(resname, r->name) && rdtgrp->closid < r->num_closid)
>  			return parse_line(tok, r, rdtgrp);
>  	}
> -	rdt_last_cmd_printf("unknown/unsupported resource name '%s'\n", resname);
> +	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
>  	return -EINVAL;
>  }
>  
> @@ -326,7 +326,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  	 */
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
>  		ret = -EINVAL;
> -		rdt_last_cmd_puts("resource group is pseudo-locked\n");
> +		rdt_last_cmd_puts("Resource group is pseudo-locked\n");
>  		goto out;
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> index f8c260d522ca..caa680fb5680 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> @@ -221,7 +221,7 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
>  	for_each_cpu(cpu, &plr->d->cpu_mask) {
>  		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
>  		if (!pm_req) {
> -			rdt_last_cmd_puts("fail allocating mem for PM QoS\n");
> +			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
>  			ret = -ENOMEM;
>  			goto out_err;
>  		}
> @@ -230,7 +230,7 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
>  					     DEV_PM_QOS_RESUME_LATENCY,
>  					     30);
>  		if (ret < 0) {
> -			rdt_last_cmd_printf("fail to add latency req cpu%d\n",
> +			rdt_last_cmd_printf("Failed to add latency req CPU%d\n",
>  					    cpu);
>  			kfree(pm_req);
>  			ret = -1;
> @@ -297,7 +297,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  	plr->cpu = cpumask_first(&plr->d->cpu_mask);
>  
>  	if (!cpu_online(plr->cpu)) {
> -		rdt_last_cmd_printf("cpu %u associated with cache not online\n",
> +		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
>  				    plr->cpu);
>  		ret = -ENODEV;
>  		goto out_region;
> @@ -315,7 +315,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  	}
>  
>  	ret = -1;
> -	rdt_last_cmd_puts("unable to determine cache line size\n");
> +	rdt_last_cmd_puts("Unable to determine cache line size\n");
>  out_region:
>  	pseudo_lock_region_clear(plr);
>  	return ret;
> @@ -369,14 +369,14 @@ static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
>  	 * KMALLOC_MAX_SIZE.
>  	 */
>  	if (plr->size > KMALLOC_MAX_SIZE) {
> -		rdt_last_cmd_puts("requested region exceeds maximum size\n");
> +		rdt_last_cmd_puts("Requested region exceeds maximum size\n");
>  		ret = -E2BIG;
>  		goto out_region;
>  	}
>  
>  	plr->kmem = kzalloc(plr->size, GFP_KERNEL);
>  	if (!plr->kmem) {
> -		rdt_last_cmd_puts("unable to allocate memory\n");
> +		rdt_last_cmd_puts("Unable to allocate memory\n");
>  		ret = -ENOMEM;
>  		goto out_region;
>  	}
> @@ -673,7 +673,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
>  	 * default closid associated with it.
>  	 */
>  	if (rdtgrp == &rdtgroup_default) {
> -		rdt_last_cmd_puts("cannot pseudo-lock default group\n");
> +		rdt_last_cmd_puts("Cannot pseudo-lock default group\n");
>  		return -EINVAL;
>  	}
>  
> @@ -715,17 +715,17 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
>  	 */
>  	prefetch_disable_bits = get_prefetch_disable_bits();
>  	if (prefetch_disable_bits == 0) {
> -		rdt_last_cmd_puts("pseudo-locking not supported\n");
> +		rdt_last_cmd_puts("Pseudo-locking not supported\n");
>  		return -EINVAL;
>  	}
>  
>  	if (rdtgroup_monitor_in_progress(rdtgrp)) {
> -		rdt_last_cmd_puts("monitoring in progress\n");
> +		rdt_last_cmd_puts("Monitoring in progress\n");
>  		return -EINVAL;
>  	}
>  
>  	if (rdtgroup_tasks_assigned(rdtgrp)) {
> -		rdt_last_cmd_puts("tasks assigned to resource group\n");
> +		rdt_last_cmd_puts("Tasks assigned to resource group\n");
>  		return -EINVAL;
>  	}
>  
> @@ -735,13 +735,13 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
>  	}
>  
>  	if (rdtgroup_locksetup_user_restrict(rdtgrp)) {
> -		rdt_last_cmd_puts("unable to modify resctrl permissions\n");
> +		rdt_last_cmd_puts("Unable to modify resctrl permissions\n");
>  		return -EIO;
>  	}
>  
>  	ret = pseudo_lock_init(rdtgrp);
>  	if (ret) {
> -		rdt_last_cmd_puts("unable to init pseudo-lock region\n");
> +		rdt_last_cmd_puts("Unable to init pseudo-lock region\n");
>  		goto out_release;
>  	}
>  
> @@ -778,7 +778,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>  	if (rdt_mon_capable) {
>  		ret = alloc_rmid();
>  		if (ret < 0) {
> -			rdt_last_cmd_puts("out of RMIDs\n");
> +			rdt_last_cmd_puts("Out of RMIDs\n");
>  			return ret;
>  		}
>  		rdtgrp->mon.rmid = ret;
> @@ -1234,7 +1234,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>  					"pseudo_lock/%u", plr->cpu);
>  	if (IS_ERR(thread)) {
>  		ret = PTR_ERR(thread);
> -		rdt_last_cmd_printf("locking thread returned error %d\n", ret);
> +		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
>  		goto out_cstates;
>  	}
>  
> @@ -1252,13 +1252,13 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>  		 * the cleared, but not freed, plr struct resulting in an
>  		 * empty pseudo-locking loop.
>  		 */
> -		rdt_last_cmd_puts("locking thread interrupted\n");
> +		rdt_last_cmd_puts("Locking thread interrupted\n");
>  		goto out_cstates;
>  	}
>  
>  	ret = pseudo_lock_minor_get(&new_minor);
>  	if (ret < 0) {
> -		rdt_last_cmd_puts("unable to obtain a new minor number\n");
> +		rdt_last_cmd_puts("Unable to obtain a new minor number\n");
>  		goto out_cstates;
>  	}
>  
> @@ -1290,7 +1290,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>  
>  	if (IS_ERR(dev)) {
>  		ret = PTR_ERR(dev);
> -		rdt_last_cmd_printf("failed to create character device: %d\n",
> +		rdt_last_cmd_printf("Failed to create character device: %d\n",
>  				    ret);
>  		goto out_debugfs;
>  	}
> diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> index 643670fb8943..49ebefde9349 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> @@ -335,7 +335,7 @@ static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
>  	/* Check whether cpus belong to parent ctrl group */
>  	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
>  	if (cpumask_weight(tmpmask)) {
> -		rdt_last_cmd_puts("can only add CPUs to mongroup that belong to parent\n");
> +		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
>  		return -EINVAL;
>  	}
>  
> @@ -460,14 +460,14 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
>  	rdt_last_cmd_clear();
>  	if (!rdtgrp) {
>  		ret = -ENOENT;
> -		rdt_last_cmd_puts("directory was removed\n");
> +		rdt_last_cmd_puts("Directory was removed\n");
>  		goto unlock;
>  	}
>  
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
>  	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  		ret = -EINVAL;
> -		rdt_last_cmd_puts("pseudo-locking in progress\n");
> +		rdt_last_cmd_puts("Pseudo-locking in progress\n");
>  		goto unlock;
>  	}
>  
> @@ -477,7 +477,7 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
>  		ret = cpumask_parse(buf, newmask);
>  
>  	if (ret) {
> -		rdt_last_cmd_puts("bad cpu list/mask\n");
> +		rdt_last_cmd_puts("Bad CPU list/mask\n");
>  		goto unlock;
>  	}
>  
> @@ -485,7 +485,7 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
>  	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
>  	if (cpumask_weight(tmpmask)) {
>  		ret = -EINVAL;
> -		rdt_last_cmd_puts("can only assign online cpus\n");
> +		rdt_last_cmd_puts("Can only assign online CPUs\n");
>  		goto unlock;
>  	}
>  
> @@ -564,7 +564,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  		 */
>  		atomic_dec(&rdtgrp->waitcount);
>  		kfree(callback);
> -		rdt_last_cmd_puts("task exited\n");
> +		rdt_last_cmd_puts("Task exited\n");
>  	} else {
>  		/*
>  		 * For ctrl_mon groups move both closid and rmid.
> @@ -682,7 +682,7 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
>  	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  		ret = -EINVAL;
> -		rdt_last_cmd_puts("pseudo-locking in progress\n");
> +		rdt_last_cmd_puts("Pseudo-locking in progress\n");
>  		goto unlock;
>  	}
>  
> @@ -1042,14 +1042,14 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>  		list_for_each_entry(d, &r->domains, list) {
>  			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
>  						  rdtgrp->closid, false)) {
> -				rdt_last_cmd_puts("schemata overlaps\n");
> +				rdt_last_cmd_puts("Schemata overlaps\n");
>  				return false;
>  			}
>  		}
>  	}
>  
>  	if (!has_cache) {
> -		rdt_last_cmd_puts("cannot be exclusive without CAT/CDP\n");
> +		rdt_last_cmd_puts("Cannot be exclusive without CAT/CDP\n");
>  		return false;
>  	}
>  
> @@ -1090,7 +1090,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  		goto out;
>  
>  	if (mode == RDT_MODE_PSEUDO_LOCKED) {
> -		rdt_last_cmd_printf("cannot change pseudo-locked group\n");
> +		rdt_last_cmd_printf("Cannot change pseudo-locked group\n");
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -1119,7 +1119,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  			goto out;
>  		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
>  	} else {
> -		rdt_last_cmd_printf("unknown/unsupported mode\n");
> +		rdt_last_cmd_printf("Unknown orunsupported mode\n");
>  		ret = -EINVAL;
>  	}
>  
> @@ -2403,7 +2403,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  			tmp_cbm = d->new_ctrl;
>  			if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) <
>  			    r->cache.min_cbm_bits) {
> -				rdt_last_cmd_printf("no space on %s:%d\n",
> +				rdt_last_cmd_printf("No space on %s:%d\n",
>  						    r->name, d->id);
>  				return -ENOSPC;
>  			}
> @@ -2420,7 +2420,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  			continue;
>  		ret = update_domains(r, rdtgrp->closid);
>  		if (ret < 0) {
> -			rdt_last_cmd_puts("failed to initialize allocations\n");
> +			rdt_last_cmd_puts("Failed to initialize allocations\n");
>  			return ret;
>  		}
>  		rdtgrp->mode = RDT_MODE_SHAREABLE;
> @@ -2443,7 +2443,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  	rdt_last_cmd_clear();
>  	if (!prdtgrp) {
>  		ret = -ENODEV;
> -		rdt_last_cmd_puts("directory was removed\n");
> +		rdt_last_cmd_puts("Directory was removed\n");
>  		goto out_unlock;
>  	}
>  
> @@ -2451,7 +2451,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  	    (prdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
>  	     prdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)) {
>  		ret = -EINVAL;
> -		rdt_last_cmd_puts("pseudo-locking in progress\n");
> +		rdt_last_cmd_puts("Pseudo-locking in progress\n");
>  		goto out_unlock;
>  	}
>  
> @@ -2459,7 +2459,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  	rdtgrp = kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
>  	if (!rdtgrp) {
>  		ret = -ENOSPC;
> -		rdt_last_cmd_puts("kernel out of memory\n");
> +		rdt_last_cmd_puts("Kernel out of memory\n");
>  		goto out_unlock;
>  	}
>  	*r = rdtgrp;
> @@ -2500,7 +2500,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  	if (rdt_mon_capable) {
>  		ret = alloc_rmid();
>  		if (ret < 0) {
> -			rdt_last_cmd_puts("out of RMIDs\n");
> +			rdt_last_cmd_puts("Out of RMIDs\n");
>  			goto out_destroy;
>  		}
>  		rdtgrp->mon.rmid = ret;
> @@ -2588,7 +2588,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  	kn = rdtgrp->kn;
>  	ret = closid_alloc();
>  	if (ret < 0) {
> -		rdt_last_cmd_puts("out of CLOSIDs\n");
> +		rdt_last_cmd_puts("Out of CLOSIDs\n");
>  		goto out_common_fail;
>  	}
>  	closid = ret;
> 

