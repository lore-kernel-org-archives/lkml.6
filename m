Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeC1Ng1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:36:27 -0400
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com ([104.47.38.74]:35648
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752824AbeC1NgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:36:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Wed, 28 Mar 2018 16:36:05 +0300
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
Message-ID: <20180328133605.u7pftfxpn3jbqire@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180325192328.GI3675@linux.vnet.ibm.com>
 <20180325201154.icdcyl4nw2jootqq@yury-thinkpad>
 <20180326124555.GJ3675@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326124555.GJ3675@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [171.101.210.188]
X-ClientProxiedBy: VI1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:803:14::45) To MWHPR07MB2912.namprd07.prod.outlook.com
 (2603:10b6:300:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23d0fe8a-2b19-478f-a24d-08d594b0e2e1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2912;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;3:CPotKjSI2L8rAUfe9d6Y6l7zR9Uu3axDkwFPap208ellT1+9RQcqnOwVWYBVJ00rmCPlPsaPaQnyhW0FLGScRV9QXED1d/ztLkqIr8/DPD0H34KrLkrhKJ/tNXAmpWILt5t+pse4urWnbkq4k0Ysm6rWRT/oQRoMEtJIctCxxbuEx5/xhpkIR3Fe82a89UfOvICZ7YFL23eqaqB4LWtIdiCLi3XnR52BVUuFnnDLHui4mm7fl8b3CeDDupUDLcjS;25:xTcvmeWEwE258yhrlEH7+KptqikIjrfjWaldnnDbcVMFUlPahVRfQkPOHaLxrP1ucd+bxyJHv5CDLQsQgS+nTUnCM8OBEAjt2bdcvrpkVYhfNrOn0lykUCatC089TzTEUfoUjkLEqyM8ZLYXKOsy1chBYEp56KBA46PIMZYDXuJYxBT4rV8M/ax0BOeAVePzA9uA7xamwch5azRDWWjYCjtAU0ZlsjolzB4yFGCS1qr71Y3wQuK1LRKzeousn31F3V09LfuaGGTDYF+DZJI4gpWpYiSEChwtrBle9ot2V7EYoJE0atRX7PYd1TGK/JRCNy9wVhEAgNnP6MqicA/zfg==;31:+dLq6p4jUTMF4H3cqzZWKWefI9NeEqP3avgYqt27D01voiDFFGEqCN5erQp+fcnz2Dz7RVzWUMieftAay6ZkDKlTsR297HSE0stwha3kRi+fPKAZf0o0lOGjTeX6+yt+xGPjH4bxEgiQsKu+jt66DiGoyBA9K7sfcesQ+4Wpi+8qJX68SZ3WR2OXc1vSQetAwG0lZKz7tin72+QplwzgJdR876JCun8yOEXs2ZqSln4=
X-MS-TrafficTypeDiagnostic: MWHPR07MB2912:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;20:R5E9RWRkSn9LMv6kFA5uYYxPLQKscFhfEPQ+gOAlh1RHWk2UHjn/mKH63CwKNuyj4ouKMIfyo9o7I1vl83loZR5Mis1TQEWyaTj5c4olYqDbeQVGx/bSIq0qqKzFgHhz4EfCERXRHgkzrrY5FJ89Z/pBeixsAtuLNVRlSauSTm58tsJUKyGru3dTDmjh6Jig7Qc1Z6LApFdgvovpf4mAmO54qtRoqs7Os6lQSC/EstGplhfrb9g1Q/a4LI6kLG4JOsYxY09ZwcuInk7S9W4nUhTZCSuR7y9R73QBv/VsuvQzmC8se8JQNx0XipdhUenWF9TDMLHx3b+0/892ge0FbLA+ZM14wGtGQdMnMJ4r2K+1tAlSlymhSRTsAo8AMDgtFUucy93Ie7jVUDa/pd41MUydJSWYhmofIfVjoNkVwdQxaHh7uAGWuf8W0K/xUhw/jsNJdWaHwCYEZ5iAxhraoyXvXwS3WPv+AaSnVLaydn6HCDgSuU3aQmVyMGn1AEgkOdlWm3CxCbOBtIgGVhfRU7GrARhgVFLheloMBZFnVGmLKlsO+FhGq2/+3xvw8XjOe5FBifwMcFSb/JLzqdAYyMOPp5KfOdiu5Kc1S+RfiDM=;4:qCK4fdPbgmcR8iHLdP+GdXdrw9e1ZGucEiU/b8ZIAurDAzjG8wijrmgarRWa405hQmuCeYBZy6dHDJh82hai41cBvabqp9rQLcAdklRC94isgEBB6+tGnc10puzNoweJgjS/TSsfITWVs3gcd8XGoXqrYpls7fnQLrNjgvqDhW/yz1luEtKAlbY84beK6/J2+TDGa0cNntDjl+Ad8IWlvT2SzQNrwhs/bPK3Y4Mm7i/SrgXThlssrB6P13IqH8k5TZ2eKJuetisTvxoZpv14V7aOvQcmWGFRcyz7MLPXieESNLp4LkbDYP1p1rgflPgs
X-Microsoft-Antispam-PRVS: <MWHPR07MB29122BA8817B55DA835AF093E3A30@MWHPR07MB2912.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR07MB2912;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2912;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(346002)(366004)(376002)(39860400002)(396003)(39380400002)(199004)(189003)(52314003)(97736004)(316002)(478600001)(47776003)(53936002)(229853002)(3846002)(6246003)(23726003)(5660300001)(1076002)(66066001)(6116002)(6666003)(81156014)(8936002)(6916009)(8676002)(25786009)(50466002)(7736002)(2906002)(81166006)(33716001)(9686003)(105586002)(305945005)(6306002)(68736007)(6486002)(7416002)(386003)(55236004)(72206003)(59450400001)(16526019)(52116002)(6496006)(446003)(26005)(33896004)(76176011)(76506005)(106356001)(186003)(956004)(54906003)(58126008)(11346002)(486005)(93886005)(486005)(476003)(42882007)(4326008)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2912;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB2912;23:lHAObotkOPWFbnCM0gzrlUl79EviHvu/E9VpjaxRb?=
 =?us-ascii?Q?bVmoszgGU8GQdfr5aOOJuNxuSNGq3GOcR1baXw9KmZ6pICFvDtvVvQhYwzsw?=
 =?us-ascii?Q?oPUhNng11P/FEiGQwgZ+jLOkc5aV/GddvLfS8rOvp5tmFH1qh0NUaQ8uGRSq?=
 =?us-ascii?Q?3ZwZt/OGG5hStIiLbQp5qoMehXmKIdXP4tZoNmIWAHsP4SuQ+DZkxPvt0fsk?=
 =?us-ascii?Q?bQ+iEncVhQeJI0IDSRpYPNdYHyRdL8N95rOC+hODrVfRRmnvS+q0Gyn3QKeD?=
 =?us-ascii?Q?eMcVmK2OvtltWzEuz5UkICXjN9xXwVzkwNDsDYHRmIRg+08+jeLzi0pgEtt5?=
 =?us-ascii?Q?oU0n+eIROscfVW8Nfuswtik2c5CNMP6fpkHYnahF/ikwmut8E3LVOVTWpzZy?=
 =?us-ascii?Q?if4abhfKuU9HO1dD9KrnYRo+bI9yDzpMVwoH1ggqy14UVDP9cpc24X5WGdbr?=
 =?us-ascii?Q?SU2VA27Sgejye4VUZtiGel9SOJyKExAybVgx0aL/BHMuKFAWKNj+IgNd8QLn?=
 =?us-ascii?Q?A6YOTN8WRY1TiXBGlxaMsdO7PZQRhK2bxxwYWgMCqsLxeONoZyTjJXt6O9KB?=
 =?us-ascii?Q?FXOQ+U/HGGOPNsgnhmSyFJqNmAdZdAako68LVaE7OWuy0jTDxNBfqrm3KeOz?=
 =?us-ascii?Q?uL+vFFNP2+IPr/AY8zMCFADYw2FVA0JwgpkPZlnx3K+vONr3t9schfa8sqsj?=
 =?us-ascii?Q?7aVwNS31wSUUyEIjByiPWU1m9SY3oyXaybCssJniH2Fw2AHMc6TQ4qcjGoIr?=
 =?us-ascii?Q?t1HtQ2J4Q4QXj/97wVa3nzES0dGQ8Q9JZF9BtglvyBIWpjYn3KKzfLMna4eb?=
 =?us-ascii?Q?puGSSew7DDn6ZFd7anXBpLEbybiFe63Z8REfX5WPkFa9iLss9pSsCBoYlWtr?=
 =?us-ascii?Q?gRDrbm2o/SIcDZXEoKf1CbSp8xw0ujmdOJGlTKJ6u67MHqBKIrKuZJesgAaV?=
 =?us-ascii?Q?gp2gdTqbUGecYVj4B7HZ2xqBdUuFJtB4NjK6+URZDS2cT1rRyOB9oo4Fuo8k?=
 =?us-ascii?Q?8zVURSSXCWjGBFN6byuhdPPkbJsm+fP6TPr0UNPzo71ThY1LAlki+oxsD5xo?=
 =?us-ascii?Q?CV7ElwGXEaaY60EUtmEg+1+RUgp+4mBXOa17XjR8NM4N330aF60t4FBU8ea6?=
 =?us-ascii?Q?aL7YWZACyAVALjKTpWleuXMPxq9fGbpujED5yVeLfQMA7ezwZ2nmtfan5RC0?=
 =?us-ascii?Q?mc9M2oHVGSh0Wcm/PSFl61PcMC4HEKy/SSmzUBTsX73trGKbiOv4Qvo3CV0Z?=
 =?us-ascii?Q?H2BdWPyjQep4xUdBRmPiZovnOLqJHnhfPu0hWx5QpZB5DTz+pvdepufwQeK7?=
 =?us-ascii?Q?souvKhthtSRGq7m8Dw3gSyDFGyfjBkT5SBeCcnDpc3YcVODwJzTRWgviO9zJ?=
 =?us-ascii?Q?vvn7i0wHQVyTdpbCj4IkN6O6vfG4pOuWlRWmxl2TGc+c6MCfz6WmoB69J3ii?=
 =?us-ascii?Q?AFkDhbJMI6E62HLcQG8Yb5KJx/ibHINtgwzY8zkUIwFaqlswvfQ?=
X-Microsoft-Antispam-Message-Info: Pzx4O7+/tIeZ5Dhay0U5WWMvaywX4eSaoCRF9xgtxnQYMaLGS6j/ZhI3/vkPKMmucsmjxyyvZgsd5EMtsxEdobb5Y3iQCALopROQzSBAOzaaDnQx9rZI5aSlXrLHZ338mBlRJfYr5FZXxGuXPXfpYzCzq0JpuMaLkIlQfaE+u9tgnfAzAuutDks5mmKyzqc/
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;6:G1k+za4Hr07vVQwAtbB8XywctixABY4ZXM9VPyf+eBHrNDMcFVrLtqQBNAefgDs0eW2Awty+1eELllQSG6cdb9+BupOJLHysle4L+Yvyoare+UiCwrbhLRWWx85dZ+pdTDdBpYu7NBjBGZolfU22GcpITK4GnzmZpdJuCkRLMbflCwk8FbLvgVS9jghsLPcMFncTptYGRFXpEamd1k0PaaxxRNFNXRluybP2qFCaOkQcVw7I10hiEqSgr4ALTR+0cHWeNbpCZEClx2D35ddfc4+7qBrkIVZPHEtGUz4uoKMHuwjAo6W6Vocv626Jp1/VrzcSL6Jk1CMp4r7Hljz7961lvn7VASlLe3LiCjSK+bmJao/iMF/yqpbwHBymK+ACD4uNLqN7TYeltU2ujLUcmsyITD9YgsWdB+vSyJArz4gm0xFVJi21wcjFzSy/cmPLuy+6rTA3VqCZShEYMYjY0w==;5:RXJSYb0ItsdOEncGi2H/eeR64ELWEWX+3qpEz/49xNdncLrJpAM6MGUlc2uPfNd+t1TUNNZijW65GExouMtT8XhpS10Sq8qhJM7P5uqCNqz/IheVHL1QUJYzdf+gyJQHUX+6uobCJfKffVXhHtZpveBFNGD53Fhlwcdc4BWRE8s=;24:I9bNyWhJw1EVV+/eAc7rYz0rcaMgFyVEnARxuQVDQKU0ETS/hQ4XqQYMsfteaNm9AqFgYfO6RwpHdLUuGS71OFZHqj0ujRWc4zfHCMrQJUc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;7:/WPoBjRfeuewUXo0lus0Z4x2yBcCzdMf7gJgrd5j2VetDcjA+fR513hlFhJSw2E0KQoP6SvNe4iIE9XGikTchD+aZPukQgbtRyGPyfc9poYGNxFPtN7I7SMjTRloNNqm94+PEqbCtxOrY/bllbu4tBmWETIHdQwp7KDMa0r+A2MoQlCFYWXkewTsQuKBbd+oAk7kMvEhGE2YwcrM4ydDcnWRf3kpXtrDaC+q4SfQbNs+4b5YG4sVDsSwObkf5Dee
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 13:36:17.5011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d0fe8a-2b19-478f-a24d-08d594b0e2e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2912
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 05:45:55AM -0700, Paul E. McKenney wrote:
> On Sun, Mar 25, 2018 at 11:11:54PM +0300, Yury Norov wrote:
> > On Sun, Mar 25, 2018 at 12:23:28PM -0700, Paul E. McKenney wrote:
> > > On Sun, Mar 25, 2018 at 08:50:04PM +0300, Yury Norov wrote:
> > > > kick_all_cpus_sync() forces all CPUs to sync caches by sending broadcast IPI.
> > > > If CPU is in extended quiescent state (idle task or nohz_full userspace), this
> > > > work may be done at the exit of this state. Delaying synchronization helps to
> > > > save power if CPU is in idle state and decrease latency for real-time tasks.
> > > > 
> > > > This patch introduces kick_active_cpus_sync() and uses it in mm/slab and arm64
> > > > code to delay syncronization.
> > > > 
> > > > For task isolation (https://lkml.org/lkml/2017/11/3/589), IPI to the CPU running
> > > > isolated task would be fatal, as it breaks isolation. The approach with delaying
> > > > of synchronization work helps to maintain isolated state.
> > > > 
> > > > I've tested it with test from task isolation series on ThunderX2 for more than
> > > > 10 hours (10k giga-ticks) without breaking isolation.
> > > > 
> > > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > > > ---
> > > >  arch/arm64/kernel/insn.c |  2 +-
> > > >  include/linux/smp.h      |  2 ++
> > > >  kernel/smp.c             | 24 ++++++++++++++++++++++++
> > > >  mm/slab.c                |  2 +-
> > > >  4 files changed, 28 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> > > > index 2718a77da165..9d7c492e920e 100644
> > > > --- a/arch/arm64/kernel/insn.c
> > > > +++ b/arch/arm64/kernel/insn.c
> > > > @@ -291,7 +291,7 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
> > > >  			 * synchronization.
> > > >  			 */
> > > >  			ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
> > > > -			kick_all_cpus_sync();
> > > > +			kick_active_cpus_sync();
> > > >  			return ret;
> > > >  		}
> > > >  	}
> > > > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > > > index 9fb239e12b82..27215e22240d 100644
> > > > --- a/include/linux/smp.h
> > > > +++ b/include/linux/smp.h
> > > > @@ -105,6 +105,7 @@ int smp_call_function_any(const struct cpumask *mask,
> > > >  			  smp_call_func_t func, void *info, int wait);
> > > > 
> > > >  void kick_all_cpus_sync(void);
> > > > +void kick_active_cpus_sync(void);
> > > >  void wake_up_all_idle_cpus(void);
> > > > 
> > > >  /*
> > > > @@ -161,6 +162,7 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
> > > >  }
> > > > 
> > > >  static inline void kick_all_cpus_sync(void) {  }
> > > > +static inline void kick_active_cpus_sync(void) {  }
> > > >  static inline void wake_up_all_idle_cpus(void) {  }
> > > > 
> > > >  #ifdef CONFIG_UP_LATE_INIT
> > > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > > index 084c8b3a2681..0358d6673850 100644
> > > > --- a/kernel/smp.c
> > > > +++ b/kernel/smp.c
> > > > @@ -724,6 +724,30 @@ void kick_all_cpus_sync(void)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
> > > > 
> > > > +/**
> > > > + * kick_active_cpus_sync - Force CPUs that are not in extended
> > > > + * quiescent state (idle or nohz_full userspace) sync by sending
> > > > + * IPI. Extended quiescent state CPUs will sync at the exit of
> > > > + * that state.
> > > > + */
> > > > +void kick_active_cpus_sync(void)
> > > > +{
> > > > +	int cpu;
> > > > +	struct cpumask kernel_cpus;
> > > > +
> > > > +	smp_mb();
> > > > +
> > > > +	cpumask_clear(&kernel_cpus);
> > > > +	preempt_disable();
> > > > +	for_each_online_cpu(cpu) {
> > > > +		if (!rcu_eqs_special_set(cpu))
> > > 
> > > If we get here, the CPU is not in a quiescent state, so we therefore
> > > must IPI it, correct?
> > > 
> > > But don't you also need to define rcu_eqs_special_exit() so that RCU
> > > can invoke it when it next leaves its quiescent state?  Or are you able
> > > to ignore the CPU in that case?  (If you are able to ignore the CPU in
> > > that case, I could give you a lower-cost function to get your job done.)
> > > 
> > > 							Thanx, Paul
> > 
> > What's actually needed for synchronization is issuing memory barrier on target
> > CPUs before we start executing kernel code.
> > 
> > smp_mb() is implicitly called in smp_call_function*() path for it. In
> > rcu_eqs_special_set() -> rcu_dynticks_eqs_exit() path, smp_mb__after_atomic()
> > is called just before rcu_eqs_special_exit().
> > 
> > So I think, rcu_eqs_special_exit() may be left untouched. Empty
> > rcu_eqs_special_exit() in new RCU path corresponds empty do_nothing() in old
> > IPI path.
> > 
> > Or my understanding of smp_mb__after_atomic() is wrong? By default, 
> > smp_mb__after_atomic() is just alias to smp_mb(). But some
> > architectures define it differently. x86, for example, aliases it to
> > just barrier() with a comment: "Atomic operations are already
> > serializing on x86".
> > 
> > I was initially thinking that it's also fine to leave
> > rcu_eqs_special_exit() empty in this case, but now I'm not sure...
> > 
> > Anyway, answering to your question, we shouldn't ignore quiescent
> > CPUs, and rcu_eqs_special_set() path is really needed as it issues
> > memory barrier on them.
> 
> An alternative approach would be for me to make something like this
> and export it:
> 
> 	bool rcu_cpu_in_eqs(int cpu)
> 	{
> 		struct rcu_dynticks *rdtp = &per_cpu(rcu_dynticks, cpu);
> 		int snap;
> 
> 		smp_mb(); /* Obtain consistent snapshot, pairs with update. */
> 		snap = READ_ONCE(&rdtp->dynticks);
> 		smp_mb(); /* See above. */
> 		return !(snap & RCU_DYNTICK_CTRL_CTR);
> 	}
> 
> Then you could replace your use of rcu_cpu_in_eqs() above with

Did you mean replace rcu_eqs_special_set()?

> the new rcu_cpu_in_eqs().  This would avoid the RMW atomic, and, more
> important, the unnecessary write to ->dynticks.
> 
> Or am I missing something?
> 
> 							Thanx, Paul

This will not work because EQS CPUs will not be charged to call
smp_mb() on exit of EQS. 

Lets sync our understanding of IPI and RCU mechanisms.

Traditional IPI scheme looks like this:

CPU1:                                    CPU2:
touch shared resource();                 /* running any code */
smp_mb();
smp_call_function();          --->       handle_IPI()
                                         {
                                                 /* Make resource visible */
                                                 smp_mb();
                                                 do_nothing();
                                         }

And new RCU scheme for eqs CPUs looks like this:

CPU1:                                    CPU2:
touch shared resource();                /* Running EQS */
smp_mb();

if (RCU_DYNTICK_CTRL_CTR)
        set(RCU_DYNTICK_CTRL_MASK);     /* Still in EQS */
                                       
                                        /* And later */
                                        rcu_dynticks_eqs_exit()
                                        {
                                                if (RCU_DYNTICK_CTRL_MASK) {
                                                        /* Make resource visible */
                                                        smp_mb(); 
                                                        rcu_eqs_special_exit();
                                                }
                                        }

Is it correct?

Yury
