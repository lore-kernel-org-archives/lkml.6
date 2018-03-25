Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCYUM1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 16:12:27 -0400
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:56875
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751835AbeCYUMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 16:12:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Sun, 25 Mar 2018 23:11:54 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Message-ID: <20180325201154.icdcyl4nw2jootqq@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180325192328.GI3675@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325192328.GI3675@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [36.84.65.149]
X-ClientProxiedBy: HE1PR02CA0107.eurprd02.prod.outlook.com
 (2603:10a6:7:29::36) To DM5PR07MB2908.namprd07.prod.outlook.com
 (2603:10b6:3:9::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 586dbce9-6af0-4196-0536-08d5928cb6b2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB2908;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2908;3:5JE4C1IPvQ1z/Yf+7uJdPEeW50gCbL25RlpziQyaZ1XbNhJJOpx9tqUjUVIhun816l+hof5QfZwdilb+etb9md43H+0I8nlBIzkFG87ytkFUdby3na0dtNpO8c4kY+z0CZ/WD5w6ukrfy5rK12/QVmlYQDIX7rvPBOzBkGkUSuBV6gZkDrAIeusofq6/GchHepJBfh9uPNIT/PdO8MRAmT1T73bhn5zPBVVDyOtwCb5D83B3sKWqIJvtx2jxdTak;25:xvqWQqIThYURq0OTByULrkFOBg0GXuyLgah6zk42SHFtGIU7vUCvLXVC1Oua6rrwWucY3lPE0yP3SZJnUhceYlDXgwdOb9m0KpNES79Ei9JXi4eg7L5o37px8sRDRw965Cm3qvS9EdFOpTEiWyKyBqNWLwXyShDtT5u3aefPxwCHwxkHDVHAknllA7vpTKEYbYbSzL743JsZGPMbjpv9/w0zSX5u9T0KZaF7uCZAVZrfKLa9CkYqHqS9byBHFyIhtuj+Vli4SSVzeU3kUXN/1NFWVUODh3497BefyJKeLTEnS6VhAKU7zPl1QCAHeZSrL0EgkCd82qVqvUgfyVHVVA==;31:AE4XReYCWbxtfc1uFaLhuZVhBu4CzchfZepj6JD01NYdAyZPjqwxWlX7jjR9Sny0sZRecz1S6pxIju+5U31QshZ7bGu4q7Cgy1MLDbrm7PDPjCLGjIUSnE180oJTgD1z7ZqpgdTNKvury1Ig7WdHVgxeiqVZm8nNeWegOJNbCP7I92LGJQX0bXkV7P/bW/u+0anUq1sDKSIye0AkmWsrZ1aw5n/bn3QruDeyroXhRGc=
X-MS-TrafficTypeDiagnostic: DM5PR07MB2908:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2908;20:gGtlgtp6r5xTla58WrpwrJdeXLF+Rb+lLydqc1qgnw7UrC14ztJ6t82JL9YJevM+z4vy/sRhMslI+J/wNp1Zfj+0xu2XCkc0uBGwML/fv7Ljww8rq9tcdWvLtbcYVEt93FmzVd+wTuG3v1qrHp3yyc8Toc2nCCqHaSHEVyxzfSClxAHM3d55X9BdJ6xbgsKmoqwqiXj1dH7ehc1DWsBAWro9TtohqdNYSe9r9ZYmD2nJHYSBlTnzSNcb+cNVrjjwWjed3Jx95mZtvtStnGYhNzWPYXUfs/YyYAVg2+ntNq/1NxRNN4g0h9G8KugWDSDPnQjgN3eKOPZo0QyYGYwBYrZyNZQ1/sIkPMtjs8omdQ/9pzo1UoYZ6H/pwd7lirvu9KEoUxp86qGZEcJ8cSXoLF58Dg8tEta3SBtHOla0X/sXG6rDCemWJixdV7+PexX7n0UVMDHNVXB3JmMYQPYkG5jluWvOPDnUEbJ+qg/4a7pHOvqSjPiMi7KlcDX5cDlgWYqxIR7Jw/ibr5OweN1Wt0o9zAZKdOqhWj8vcx09BQtw5CoxCrG1ZkmeaXFjGc6oidZKNiuQCUcZLzg5FW2EtdUtRKkzFPqiUAS5/qgrytc=;4:1fCy12fQyNfq505UFGeNuwEZXGnn23HZI7DiLR/R8nU/3/Wjy9zgO4kKaRekWw2ar/uju3JsN00bBumskC9/fKyLGA6UkGVtIpPQq0pECRiIAu2MrF35ir/rdbvJiK/30BknMwnqRPlOYKndkR79lSvCjZE0YTgya8BxR3Rezxot11ECriEyRXca6XVStltO9pIrLGpkYCD5A0NOqVDi2VAzXT6MTKOMUAhynUj71QdM6ryBtOCUgopggZrgHlguxHc/Vpaidtqi/JDCLonZzg==
X-Microsoft-Antispam-PRVS: <DM5PR07MB2908CF1EE167BA709441E944E3AE0@DM5PR07MB2908.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB2908;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2908;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(396003)(39850400004)(346002)(376002)(39380400002)(366004)(199004)(52314003)(189003)(23726003)(1076002)(16586007)(54906003)(229853002)(33896004)(6486002)(47776003)(59450400001)(66066001)(106356001)(52116002)(956004)(2906002)(6496006)(7416002)(8676002)(5660300001)(76506005)(7736002)(4326008)(76176011)(58126008)(68736007)(305945005)(6306002)(81166006)(33716001)(105586002)(26005)(81156014)(478600001)(6116002)(186003)(16526019)(3846002)(6246003)(72206003)(50466002)(6916009)(8936002)(9686003)(316002)(446003)(25786009)(11346002)(53936002)(42882007)(6666003)(55236004)(97736004)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2908;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2908;23:3If1rTqM2iqpzexYja9x7r66u+93biWZgbT/klKaV?=
 =?us-ascii?Q?lYLUAitnjcZ2aOmogf7OJnznN4shS03zTHWbcAMXK0tyYZsmcv1EdrQpmEK6?=
 =?us-ascii?Q?9/6XvC70v3c1bEEctbtlzhs2wBxFXfYOwGveCRRzQe8JGE0LPhjFXe/Yi5RD?=
 =?us-ascii?Q?/TWvEO891qK95m9Xn0eoL1a80Wpn52Uyr3Rumteqxj47TwoD52UZatbO4dhZ?=
 =?us-ascii?Q?ftF3Jr+wG9bu7ByTwOEDaCT0qM3O5hb2DH5lCWpopKU1MiXOp9yPhsGXDkWL?=
 =?us-ascii?Q?CVQlzGAGw/NKtUmCLollgh2mtKwkdfLu0nShJMe43IdIiTGd+kUhdHbSG5Hc?=
 =?us-ascii?Q?KxriTRIZrZ8oUSfHOhTjhUZbNo3aWF8goTe9XZSMnqr5I4K0ua6ro/KVhJ+9?=
 =?us-ascii?Q?VICHHq/4R4xOsmLZBn4YQjx6HYopvF7JPlqmZNS1Q3IT0yIW0RlWDDiTTtZD?=
 =?us-ascii?Q?fDgUUDMlfGyTyzXPuQwX+YnrnwLhvjY7sAsFqU2vv4K15R097Ij6p7uBPWH2?=
 =?us-ascii?Q?lVrDRnfATO/Aq0Q6lQqkLl6Dzlq6Q5hwXt+riOMGI7Ue3AH0YHuNOtlglwgN?=
 =?us-ascii?Q?MElkPNEit1Ns9L0SZ3zhpV76qFGdAM0LOuAkkp5u1CRWe2uLOoFmP1aZyNKY?=
 =?us-ascii?Q?ZUcEldOmu79NawCd0gwXginCkqCJN5pdiIKSMczXITgJ3EMs4NE36gYnMacz?=
 =?us-ascii?Q?Z7HjKXaKZdPM22nYmA3wHnpRK9pRx0dVT8WZO4nCHkzfTPYCtKd56KXYcPJm?=
 =?us-ascii?Q?80wTw2Bf5YrX5fzOGsHVpTa7X79nFpsVp1mCi4sp6ok3QgIOlTn1kxjnF/ND?=
 =?us-ascii?Q?S01UG8d6MbWOZ1ZErJuAS2AV+5xE3EDhPr3fknD/G4/aRKw8tYxst/+34ws/?=
 =?us-ascii?Q?Ua7NAmkm3t4Hnh3GvQOpyI0jNsnjVJtr9FRjczU0Y52mUf2lE2u5ED3epHvb?=
 =?us-ascii?Q?xJNB24K+MC6chPsAB6AtFls8Gkn6n/Tew0pu8s8sZ1Od2ESr+1TSQtxpccG+?=
 =?us-ascii?Q?w7L5vkBcEYV2z1/gBBOD51tSBXfdaNBgWcc9yA+KuD+qImRM7lyHPfc7wmsh?=
 =?us-ascii?Q?DR5iBOEyJWvzfcPwyWs98YVbVGPBQvKp3UAM7lDFeb0UsNobvhXr835agcKJ?=
 =?us-ascii?Q?sGY8HUelTlsFhmZXjLSDP7u+NB/880PLv9RSsonxR8buOhwaWmFW0lNtmJZY?=
 =?us-ascii?Q?hfc09y8otwAlIsLMwXhguaLXw9IgzwWPfH8rLSw7zVrpjQlo5qtGw750Qu0n?=
 =?us-ascii?Q?dB+CPY59gkgqBx6+gZklQjTGX21qCAlMem4EUTUySySUovwMg4eGFqXA39Aa?=
 =?us-ascii?Q?l4cRgwQ53yuUZzMraYENO/5o/K+pkzmXZ9z5GaLEQ5nXfpjZ/icsfpot2KmX?=
 =?us-ascii?Q?CDenPZyPX+12LHR4wMw4wdkKVL77uQ7BoKgpKL6gTtw55l4?=
X-Microsoft-Antispam-Message-Info: hCK3woHq+Wdgrns3hISmTtVn/tUfPkf2R+ZFSEeUmrZwLUfoiIrSm+CcG1YqZebRVc/5y4Ds5KEFiq/Id+RdhRr5OtNhm3AOcDk1TKjv9b3pRdn0ERl74PGdDnDY8jQGr7BFo+QFfcoq1qLxS5KTUh2a1OsmDAQQ5rExu5fiysrYYi5NUEhnrBFl0lCpVj6Z
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2908;6:0J83pq2FJsBAGN3m42hUY3H/3jQ9Fgw0+kVYumn+C9FEfmZQVqr5T9kj4JdD2YptIncryk8AFeTKrF3ZNN8S9Uz/3QplDBAubXYzGvTLMJbGpf4lN0amsXBNRrazAas+X7yj2rxbVEx95rD7LS9/J77hDD9XMp2n0FOMGs6qKzdQH6koeFBqMY367k78MssfnoFa8O7ZyGQSjqb32E/CSqRmcbrjQIUoONyCtbeQHHrkFa9pROy7m8dvOsdZTHfuIn9YoYdpT0pXds0mVXVp8/O0X1t1ZG8U/48bEbrjQvB7ahPueX6lLlP7osGgQHuZYgc+d89P4H55Vl/2Af02x/7u0x3PClxt3uURA4dyEHMC70PD/uM+unZfhvMlvxmtMwJdQo4jQHOAXm5v/BqSWonsqPHrz+xaoTpCJymg0FBUiL9ANmLFqW+gpZAoNI1xwgtr2EcTaDG4qoNmsr/gtw==;5:KL1IrzSmWBAaY7Hc+NCWqHebWionx79GVebVOmg6JOX7gF01ZwXeMlRR5uzVAaR33I6S4hJHOd5Z01pXl5Cd5vvlO5weMu5Awx9Yc8ls1Rvrbs5JFeu1xemiyLrnJfgK2SQtCjPwBTNyQaHffv+f7VknjjaxA7fi1j1oJK3K94Y=;24:xDfgVKUjhai0ta70fONZsm1Zle4NRA8W2jwFdGa6NuUtEy8TAfumZrixjTH+fsuFq5Oi0fdu0Q8GeKmDX83rQgS6ii016Ld8NaMpzxmpjgI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2908;7:g0ZdMgUeLuIbNw0pAvipsl6JjgDes3Qd0dbsvRq/eZG1eVq+Q4GF7Hmsw73oL2LP9mwbJQdt0t+EptZieKoywUSTTqJR4oF7sNpzxsW1LUjhtA/EZK7/l0MG7DOYpuTfLeY4j8md4pceA3uDjHaQSVdCu/hpnOclVMXpcdppe1Hs3BC6F902Ti+6b1d9ygti4VVGNjIgW/MfU83P2NvmxtMTWnGW2kLkV1xY/VHHz135junfeN6nCvmev9Ii0RnW
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 20:12:18.3333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586dbce9-6af0-4196-0536-08d5928cb6b2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2908
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 12:23:28PM -0700, Paul E. McKenney wrote:
> On Sun, Mar 25, 2018 at 08:50:04PM +0300, Yury Norov wrote:
> > kick_all_cpus_sync() forces all CPUs to sync caches by sending broadcast IPI.
> > If CPU is in extended quiescent state (idle task or nohz_full userspace), this
> > work may be done at the exit of this state. Delaying synchronization helps to
> > save power if CPU is in idle state and decrease latency for real-time tasks.
> > 
> > This patch introduces kick_active_cpus_sync() and uses it in mm/slab and arm64
> > code to delay syncronization.
> > 
> > For task isolation (https://lkml.org/lkml/2017/11/3/589), IPI to the CPU running
> > isolated task would be fatal, as it breaks isolation. The approach with delaying
> > of synchronization work helps to maintain isolated state.
> > 
> > I've tested it with test from task isolation series on ThunderX2 for more than
> > 10 hours (10k giga-ticks) without breaking isolation.
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  arch/arm64/kernel/insn.c |  2 +-
> >  include/linux/smp.h      |  2 ++
> >  kernel/smp.c             | 24 ++++++++++++++++++++++++
> >  mm/slab.c                |  2 +-
> >  4 files changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> > index 2718a77da165..9d7c492e920e 100644
> > --- a/arch/arm64/kernel/insn.c
> > +++ b/arch/arm64/kernel/insn.c
> > @@ -291,7 +291,7 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
> >  			 * synchronization.
> >  			 */
> >  			ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
> > -			kick_all_cpus_sync();
> > +			kick_active_cpus_sync();
> >  			return ret;
> >  		}
> >  	}
> > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > index 9fb239e12b82..27215e22240d 100644
> > --- a/include/linux/smp.h
> > +++ b/include/linux/smp.h
> > @@ -105,6 +105,7 @@ int smp_call_function_any(const struct cpumask *mask,
> >  			  smp_call_func_t func, void *info, int wait);
> > 
> >  void kick_all_cpus_sync(void);
> > +void kick_active_cpus_sync(void);
> >  void wake_up_all_idle_cpus(void);
> > 
> >  /*
> > @@ -161,6 +162,7 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
> >  }
> > 
> >  static inline void kick_all_cpus_sync(void) {  }
> > +static inline void kick_active_cpus_sync(void) {  }
> >  static inline void wake_up_all_idle_cpus(void) {  }
> > 
> >  #ifdef CONFIG_UP_LATE_INIT
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 084c8b3a2681..0358d6673850 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -724,6 +724,30 @@ void kick_all_cpus_sync(void)
> >  }
> >  EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
> > 
> > +/**
> > + * kick_active_cpus_sync - Force CPUs that are not in extended
> > + * quiescent state (idle or nohz_full userspace) sync by sending
> > + * IPI. Extended quiescent state CPUs will sync at the exit of
> > + * that state.
> > + */
> > +void kick_active_cpus_sync(void)
> > +{
> > +	int cpu;
> > +	struct cpumask kernel_cpus;
> > +
> > +	smp_mb();
> > +
> > +	cpumask_clear(&kernel_cpus);
> > +	preempt_disable();
> > +	for_each_online_cpu(cpu) {
> > +		if (!rcu_eqs_special_set(cpu))
> 
> If we get here, the CPU is not in a quiescent state, so we therefore
> must IPI it, correct?
> 
> But don't you also need to define rcu_eqs_special_exit() so that RCU
> can invoke it when it next leaves its quiescent state?  Or are you able
> to ignore the CPU in that case?  (If you are able to ignore the CPU in
> that case, I could give you a lower-cost function to get your job done.)
> 
> 							Thanx, Paul

What's actually needed for synchronization is issuing memory barrier on target
CPUs before we start executing kernel code.

smp_mb() is implicitly called in smp_call_function*() path for it. In
rcu_eqs_special_set() -> rcu_dynticks_eqs_exit() path, smp_mb__after_atomic()
is called just before rcu_eqs_special_exit().

So I think, rcu_eqs_special_exit() may be left untouched. Empty
rcu_eqs_special_exit() in new RCU path corresponds empty do_nothing() in old
IPI path.

Or my understanding of smp_mb__after_atomic() is wrong? By default, 
smp_mb__after_atomic() is just alias to smp_mb(). But some
architectures define it differently. x86, for example, aliases it to
just barrier() with a comment: "Atomic operations are already
serializing on x86".

I was initially thinking that it's also fine to leave
rcu_eqs_special_exit() empty in this case, but now I'm not sure...

Anyway, answering to your question, we shouldn't ignore quiescent
CPUs, and rcu_eqs_special_set() path is really needed as it issues
memory barrier on them.

Yury

> > +			cpumask_set_cpu(cpu, &kernel_cpus);
> > +	}
> > +	smp_call_function_many(&kernel_cpus, do_nothing, NULL, 1);
> > +	preempt_enable();
> > +}
> > +EXPORT_SYMBOL_GPL(kick_active_cpus_sync);
> > +
> >  /**
> >   * wake_up_all_idle_cpus - break all cpus out of idle
> >   * wake_up_all_idle_cpus try to break all cpus which is in idle state even
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 324446621b3e..678d5dbd6f46 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3856,7 +3856,7 @@ static int __do_tune_cpucache(struct kmem_cache *cachep, int limit,
> >  	 * cpus, so skip the IPIs.
> >  	 */
> >  	if (prev)
> > -		kick_all_cpus_sync();
> > +		kick_active_cpus_sync();
> > 
> >  	check_irq_on();
> >  	cachep->batchcount = batchcount;
> > -- 
> > 2.14.1
> > 
