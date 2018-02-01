Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBAKkB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:40:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752195AbeBAKj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:39:57 -0500
Date: Thu, 1 Feb 2018 02:39:15 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/dev 48/48] kernel/rcu/tree_exp.h:407:3: note: in
 expansion of macro 'trace_printk'
Reply-To: paulmck@linux.vnet.ibm.com
References: <201802011554.rmzK3XXS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201802011554.rmzK3XXS%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020110-0040-0000-0000-000003EC2FA2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008458; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00983434; UDB=6.00498759; IPR=6.00762712;
 BA=6.00005806; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019316; XFM=3.00000015;
 UTC=2018-02-01 10:39:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020110-0041-0000-0000-000007E19DA0
Message-Id: <20180201103915.GN3741@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 03:43:58PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/dev
> head:   32860a6da7c75039afea229ba396aeac3b708d6b
> commit: 32860a6da7c75039afea229ba396aeac3b708d6b [48/48] EXP rcu: Add trace_printk()s to probe expedited CPU selection
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 32860a6da7c75039afea229ba396aeac3b708d6b
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All warnings (new ones prefixed by >>):

These should be fixed in later commits.  Plus this is likely sacrificial
code anyway.

							Thanx, Paul

>    In file included from kernel/rcu/tree.c:31:0:
>    kernel/rcu/tree_exp.h: In function 'sync_rcu_exp_select_cpus':
>    kernel/rcu/tree_exp.h:407:16: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'int' [-Wformat=]
>       trace_printk("%s rnp %d:%d first pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!rnp->exp_tasks);
>                    ^                                                                                                ~~~~~~~~
>    include/linux/kernel.h:634:33: note: in definition of macro '__trace_printk_check_format'
>       ____trace_printk_check_format(fmt, ##args);  \
>                                     ^~~
> >> include/linux/kernel.h:671:3: note: in expansion of macro 'do_trace_printk'
>       do_trace_printk(fmt, ##__VA_ARGS__); \
>       ^~~~~~~~~~~~~~~
> >> kernel/rcu/tree_exp.h:407:3: note: in expansion of macro 'trace_printk'
>       trace_printk("%s rnp %d:%d first pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!rnp->exp_tasks);
>       ^~~~~~~~~~~~
>    kernel/rcu/tree_exp.h:407:16: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'int' [-Wformat=]
>       trace_printk("%s rnp %d:%d first pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!rnp->exp_tasks);
>                    ^                                                                                                ~~~~~~~~
>    include/linux/kernel.h:687:29: note: in definition of macro 'do_trace_printk'
>       __trace_printk(_THIS_IP_, fmt, ##args);   \
>                                 ^~~
> >> kernel/rcu/tree_exp.h:407:3: note: in expansion of macro 'trace_printk'
>       trace_printk("%s rnp %d:%d first pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!rnp->exp_tasks);
>       ^~~~~~~~~~~~
>    kernel/rcu/tree_exp.h:446:16: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'int' [-Wformat=]
>       trace_printk("%s rnp %d:%d second pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!READ_ONCE(rnp->exp_tasks));
>                    ^
>    include/linux/kernel.h:634:33: note: in definition of macro '__trace_printk_check_format'
>       ____trace_printk_check_format(fmt, ##args);  \
>                                     ^~~
> >> include/linux/kernel.h:671:3: note: in expansion of macro 'do_trace_printk'
>       do_trace_printk(fmt, ##__VA_ARGS__); \
>       ^~~~~~~~~~~~~~~
>    kernel/rcu/tree_exp.h:446:3: note: in expansion of macro 'trace_printk'
>       trace_printk("%s rnp %d:%d second pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!READ_ONCE(rnp->exp_tasks));
>       ^~~~~~~~~~~~
>    kernel/rcu/tree_exp.h:446:16: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'int' [-Wformat=]
>       trace_printk("%s rnp %d:%d second pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!READ_ONCE(rnp->exp_tasks));
>                    ^
>    include/linux/kernel.h:687:29: note: in definition of macro 'do_trace_printk'
>       __trace_printk(_THIS_IP_, fmt, ##args);   \
>                                 ^~~
>    kernel/rcu/tree_exp.h:446:3: note: in expansion of macro 'trace_printk'
>       trace_printk("%s rnp %d:%d second pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!READ_ONCE(rnp->exp_tasks));
>       ^~~~~~~~~~~~
> 
> vim +/trace_printk +407 kernel/rcu/tree_exp.h
> 
>    363	
>    364	/*
>    365	 * Select the nodes that the upcoming expedited grace period needs
>    366	 * to wait for.
>    367	 */
>    368	static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>    369					     smp_call_func_t func)
>    370	{
>    371		int cpu;
>    372		unsigned long flags;
>    373		unsigned long mask_ofl_test;
>    374		unsigned long mask_ofl_ipi;
>    375		int ret;
>    376		struct rcu_node *rnp;
>    377	
>    378		trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
>    379		sync_exp_reset_tree(rsp);
>    380		trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
>    381		rcu_for_each_leaf_node(rsp, rnp) {
>    382			raw_spin_lock_irqsave_rcu_node(rnp, flags);
>    383	
>    384			/* Each pass checks a CPU for identity, offline, and idle. */
>    385			mask_ofl_test = 0;
>    386			for_each_leaf_node_possible_cpu(rnp, cpu) {
>    387				struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
>    388	
>    389				rdp->exp_dynticks_snap =
>    390					rcu_dynticks_snap(rdp->dynticks);
>    391				if (raw_smp_processor_id() == cpu ||
>    392				    rcu_dynticks_in_eqs(rdp->exp_dynticks_snap) ||
>    393				    !(rnp->qsmaskinitnext & rdp->grpmask))
>    394					mask_ofl_test |= rdp->grpmask;
>    395				trace_printk("%s rnp %d:%d first pass CPU %d\n", __func__, rnp->grplo, rnp->grphi, cpu);
>    396			}
>    397			mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
>    398	
>    399			/*
>    400			 * Need to wait for any blocked tasks as well.  Note that
>    401			 * additional blocking tasks will also block the expedited
>    402			 * GP until such time as the ->expmask bits are cleared.
>    403			 */
>    404			if (rcu_preempt_has_tasks(rnp))
>    405				rnp->exp_tasks = rnp->blkd_tasks.next;
>    406			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  > 407			trace_printk("%s rnp %d:%d first pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!rnp->exp_tasks);
>    408	
>    409			/* IPI the remaining CPUs for expedited quiescent state. */
>    410			for_each_leaf_node_possible_cpu(rnp, cpu) {
>    411				unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
>    412				struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
>    413	
>    414				if (!(mask_ofl_ipi & mask))
>    415					continue;
>    416	retry_ipi:
>    417				if (rcu_dynticks_in_eqs_since(rdp->dynticks,
>    418							      rdp->exp_dynticks_snap)) {
>    419					mask_ofl_test |= mask;
>    420					continue;
>    421				}
>    422				ret = smp_call_function_single(cpu, func, rsp, 0);
>    423				if (!ret) {
>    424					mask_ofl_ipi &= ~mask;
>    425					continue;
>    426				}
>    427				/* Failed, raced with CPU hotplug operation. */
>    428				raw_spin_lock_irqsave_rcu_node(rnp, flags);
>    429				if ((rnp->qsmaskinitnext & mask) &&
>    430				    (rnp->expmask & mask)) {
>    431					/* Online, so delay for a bit and try again. */
>    432					raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>    433					trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("selectofl"));
>    434					schedule_timeout_uninterruptible(1);
>    435					goto retry_ipi;
>    436				}
>    437				/* CPU really is offline, so we can ignore it. */
>    438				if (!(rnp->expmask & mask))
>    439					mask_ofl_ipi &= ~mask;
>    440				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>    441			}
>    442			/* Report quiescent states for those that went offline. */
>    443			mask_ofl_test |= mask_ofl_ipi;
>    444			if (mask_ofl_test)
>    445				rcu_report_exp_cpu_mult(rsp, rnp, mask_ofl_test, false);
>    446			trace_printk("%s rnp %d:%d second pass mask %#lx tasks %ld\n", __func__, rnp->grplo, rnp->grphi, mask_ofl_ipi, !!READ_ONCE(rnp->exp_tasks));
>    447		}
>    448	}
>    449	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
