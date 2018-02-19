Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeBSVUk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 16:20:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60265 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753676AbeBSVUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 16:20:39 -0500
Date: Mon, 19 Feb 2018 22:19:54 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 11/22] x86/intel_rdt: Associate pseudo-locked
 regions with its domain
In-Reply-To: <216ad1ef8314dc578a900ff8b06248464f5aa2ee.1518443616.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1802192218370.1853@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <216ad1ef8314dc578a900ff8b06248464f5aa2ee.1518443616.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Reinette Chatre wrote:

> After a pseudo-locked region is locked it needs to be associated with
> the RDT domain representing the pseudo-locked cache so that its life
> cycle can be managed correctly.
> 
> Only a single pseudo-locked region can exist on any cache instance so we
> maintain a single pointer to a pseudo-locked region from each RDT
> domain.

Why is only a single pseudo locked region possible? 

> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/intel_rdt.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
> index 060a0976ac00..f0e020686e99 100644
> --- a/arch/x86/kernel/cpu/intel_rdt.h
> +++ b/arch/x86/kernel/cpu/intel_rdt.h
> @@ -187,6 +187,8 @@ struct mbm_state {
>  	u64	prev_msr;
>  };
>  
> +struct pseudo_lock_region;
> +
>  /**
>   * struct rdt_domain - group of cpus sharing an RDT resource
>   * @list:	all instances of this resource
> @@ -205,6 +207,7 @@ struct mbm_state {
>   * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
>   * @new_ctrl:	new ctrl value to be loaded
>   * @have_new_ctrl: did user provide new_ctrl for this domain
> + * @plr:	pseudo-locked region associated with this domain
>   */
>  struct rdt_domain {
>  	struct list_head	list;
> @@ -220,6 +223,7 @@ struct rdt_domain {
>  	u32			*ctrl_val;
>  	u32			new_ctrl;
>  	bool			have_new_ctrl;
> +	struct pseudo_lock_region	*plr;

Please keep the tabular fashion of the struct declaration intact.

Thanks,

	tglx
