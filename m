Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeC1OmC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:42:02 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:6692
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752572AbeC1Ol6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:41:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Wed, 28 Mar 2018 17:41:40 +0300
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
Message-ID: <20180328144140.g4qwtciikffaescu@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180325192328.GI3675@linux.vnet.ibm.com>
 <20180325201154.icdcyl4nw2jootqq@yury-thinkpad>
 <20180326124555.GJ3675@linux.vnet.ibm.com>
 <20180328133605.u7pftfxpn3jbqire@yury-thinkpad>
 <20180328135617.GQ3675@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328135617.GQ3675@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [171.101.210.188]
X-ClientProxiedBy: HE1PR0102CA0029.eurprd01.prod.exchangelabs.com
 (10.170.250.42) To BN6PR07MB2897.namprd07.prod.outlook.com (10.173.28.143)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df9753b7-a473-4cf2-4708-08d594ba0d57
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2897;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;3:gqfbHMIAKM4ZvJeFIh7Z4A0Vv80xz2tnsiKTdzZ6EZgfcMe23ZZqzgJTHhOMUW5b/uHxzFyExQtO1YJ0X8pumSXp6Dyzrz4hrE4LrgRBvZQlvyuCOSKqaN3bGyEREZ90d0qnagkZO2UYiaijdsnbTNBBzZC8ULjKLr20AtmJrnIW+fP2a2b0d9iGYf+HbEV+ZgDgUTf9v0XZU5NZEkKp8vk9fL8EgcrdHTHoJSnkUJETN2ERncghkFKKgJ0TjIl/;25:lgXqjAAIlr0n3Xyel99U7Q0VCNy9ApcYJt1tUui5tqEz7loPrzyWMgDdJuj1274iI+75XmJC37VAcPRK9PFa2YF4k6BpjQFAAx9Etd5OKVjEKYRHGgu8UaXl7zPur2bEK7hbQNFi8gIjIiQUmp4otoSl6SNzHSWg7QOhdTBqDXH/XpYpNyVKfisDSNAKISlXGr80rIPf/pcpkLYucyEQcjUQcjaLkM+vyLrJPlGlXbfO2SXqqMhNtbxPZ9CwhnH9iNEGX4VX9XbvO2QZ+APTfC9nkRyE8pUA2lnRHC/kZMVz3H46yKOnMJn8iFFUZkCghJBsTE5nLUqiTilEdscoNA==;31:g3FcGnwJcdOa2dZ9QfqsnOlpAq6bsQK77uPtM6Voglf5x+52cAdr7gXtvdpFCPLSVAttFvZLHrjCXt4mOgj4XanxNLSFjQUjPlw/qExzM1L4HUyps39p8X45jIT3WdUBX7aglZ/gULoLRQ3E2W1f5jNim8wll2BkGzAaDRK/9McjxBtVBM+08SysiUmrzLzD/7afewRGNk9bdVRbryAhuDZhUgVusUwGAUF2lPt8HuA=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2897:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;20:Z82r3ZrF1OolMEg3VhtgrZGpn6jcB5L/fRPEvIRox4HlxzZ89OMJeGHjBRe9Dd0s3wmY8CLFDDNQkivp+xVvv/HNpSOYmAvmLhFVOzQCaS1p+ywRMm4FPex2UHJ6rE8RrfbsFODhBfsx8K77kLedzD//zXwpuFS46MgF63Vr3NMTiIQKTlXNyY6ESuKNrl+xwPHQfTnoOEWOeO7oKMuOfDF2dtaWYH2yOsmMyjSyCvnGotYA7Nwuzl3fUqU5Q8ubfHvrW+BwexOSUG0bLDBp7L+5tM1PTpYJwSmIsNe32eHT+5+b3ugJVtNzWp919Y0QDZ6LJO/AU4AJXYnJyr8ShQKJw3xzHIZzUYOI7czSJy7RDQaNcLeVFXMTU3g6WlkZFoGqdycxLGG9phVeYov2CdZvj5UnTfj7TtZm5wrohyDB18o+UeAYl4T+srEUEOiE9YA5gFPm9uAgt4le3gBpHMQnraDXh9zsxEtHQkQn7IdVj4GzyIpFKch4Puba2aNX50ActbBAc8NI4fUCk56KLFZrB5H0IdUNypWfhwmjmv0eiSGygYL+7OZdYpwGftjR2EoIJYy3wbnOYlSDClagISM86Ny6FBVPJzuDJFBmQww=;4:keyFf29+p8RS30pmMjaxvj8E3LPWF5PK72B9U1g3cw5PQdNwEpzNaRKwPgEup+UmExCXqL0g7cPldfZuPH/5j6A4pzl3bOZeoz4LGuVLbFBbTJCd5nj6o6/CwH81FF9wA3SiEauvFCwsSh1HlzMe1fjAbUOtNh2Mu1YYJMmX7SuAkFcz6726jF37B22coNQlbKRfF5JjQmbuEBmrzAchegsTkpyIaAF5y2KLPEGLqhab6uCP65aZXV4SHe/TZV/8FE8nmm2UCjpMwnaixfCO/TWN9LGTHjcs5USb9qrPnOJeSHIB4katMhwLILhXmLBl
X-Microsoft-Antispam-PRVS: <BN6PR07MB28972D4E55C5F0CCAE4CDC2DE3A30@BN6PR07MB2897.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(93006095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR07MB2897;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2897;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(366004)(39860400002)(346002)(39380400002)(376002)(396003)(189003)(199004)(52314003)(55236004)(6246003)(26005)(478600001)(6486002)(6666003)(33896004)(66066001)(2906002)(97736004)(54906003)(93886005)(186003)(42882007)(16526019)(47776003)(3846002)(386003)(6496006)(53936002)(52116002)(9686003)(6306002)(76176011)(6916009)(76506005)(59450400001)(316002)(6116002)(16586007)(23726003)(1076002)(50466002)(58126008)(81156014)(4326008)(229853002)(33716001)(305945005)(68736007)(8676002)(956004)(106356001)(486005)(446003)(7416002)(81166006)(8936002)(486005)(105586002)(7736002)(476003)(25786009)(5660300001)(11346002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2897;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2897;23:GGkB9HSdN26DYOPDZ98TU/ZRei635yjtT3guM1Ndj?=
 =?us-ascii?Q?/wCk8O3k8ADjkR1mEQ4QbBUli0AM7+wwivjxXqmABEECFgS7atpAdUTfVmNc?=
 =?us-ascii?Q?ZhNGn1zA30P0RXRfGoTCdgMOJZoifP5L7esdg6eVGV5R4GOdH6Kp2u7nxpW9?=
 =?us-ascii?Q?4YWoOfUl8mEyLkxX6h2YC40G/AZ9XtLCvj8s9Y2lOREOoPeCa7lpoFqIT91+?=
 =?us-ascii?Q?vbV0VyVDuA4NtB3TwmFgiP1H1BA934oS78Q7KxGl4tc4uW5jx9skZSU4DxIf?=
 =?us-ascii?Q?p72ix+6i42nYAq1Crk90DM4M3vttuYamOIm8NWadl/cv8H7/ejR+GZ4FKkSm?=
 =?us-ascii?Q?3EksvB+d9Dcqljss0sT1MVkqfYBgPe7F4BJSWJ9BNAvkQYijc4eHrSPstE8X?=
 =?us-ascii?Q?f+ETOVM5tlKIueiq/k07sHbHwDBLkoFeeJZXClU/cVWDRS7OlwAwqKG6ozfO?=
 =?us-ascii?Q?I9RGrGI6+qXW2T1mEp/Uz0tHVlN2ivFBUC9D2rCuE1eg7jzza4jI0ZOc//2V?=
 =?us-ascii?Q?0pAo0/m08+lncJF5oX0sRBLzuyjbjk1XLefr35J+r5Efr17Kvsv0iUPkAYiO?=
 =?us-ascii?Q?kfmHq2AnP/dLW1lwtIfvrkN/4Vzxg3VdKpYkFRYSQTrss3qgu4Hv+ErLNeTd?=
 =?us-ascii?Q?13IkJ6pasMn3Kf1qygycuQAgkZYY1WNr2Gq7GtaF7LncZ7M7OJzKhZWqrjKF?=
 =?us-ascii?Q?AaAiz1KYVTyw3Ebu+zyVsOFHee9S9PkK2LVXGgC4t7N9akRD0k9RtQd/flmp?=
 =?us-ascii?Q?OtbjKwz0pW1UrKQFgz61drATaBiv5mbcQhQk2ombx+SMC3oLqgAsPUwRGu30?=
 =?us-ascii?Q?AkyORKs/iTiBXKFad5QKXZPWd9NYyYNnOEn5OzS3DJ/9OVDjtE9MWsZyujo3?=
 =?us-ascii?Q?NffZy35WBznHWtaACpX3qxCOR57BsP2SnLO1h3a1/iA1riK57oUdjpUBJCE6?=
 =?us-ascii?Q?YrLaC5IfopW5MUftxhRvPqcipuYccjLC+UBFZ5bpVFgeOMorQpmW9kYnpMzp?=
 =?us-ascii?Q?wL1K5UXrT5142COWaqe1+3mEg4/jjNVOXkGyEWgA11FsrOVnpshurREhs6R5?=
 =?us-ascii?Q?zSyE4NQNayPjRv3Onjp9E8VhTppLwP+9cdgFi8NM4mz2C6P5ydDFZEwLcia8?=
 =?us-ascii?Q?xN8rjElsn8/1fyWw86DlEiYV8eqc5XTHsSZ9oS3T60wbfWyQhY7K0XX4WIzy?=
 =?us-ascii?Q?XomL4pRhyAcXm1L5Q9d3/gFAV3JQCqWBy+h9n4uruf4WXDZ3JDB4XkmBhZlO?=
 =?us-ascii?Q?geSvSDo58jKotVpwBQ3cr4DTHXmrNx+zgRKnwEcOFm6foSSPuOx0RgfoDV0t?=
 =?us-ascii?Q?ZRCE2XD6yGU872AleRbOVeTG3bABFv9hPj4SXCVu+RBRr1PvOOdQzSzRskSI?=
 =?us-ascii?Q?vx8WUgjbfiMwTGMUPebduu/NwbvXt4gIROVtzZZVX12qx7Ns4+jz1bzo1mDE?=
 =?us-ascii?Q?jn1zuJIN1V5Zga5sjZx0Y/zsF2d4bHV1BcoabEWTdRPDu6Frgbf?=
X-Microsoft-Antispam-Message-Info: oJLNriFPhb8GtL/KqZjjb56PReQ9ixlfZnhREp27dng+t4atGBZEgD4r0nYUM4tXUlro8VN/jzu18CeDh9pETd/0tzxQwS95/mhSE861VlI2FL269qUaVvIJ1t66qV6+n3626l/PkFOspHEQRhgzz8aftVmcQIZBmzw4X/wx2+b1t0xymF7zjOMc+ZAPlmGx
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;6:Qkcg7stHi10eXhg8WBoJ4nhhJKNS/Ny+XcOQqvEO0QCA+KSaG4y8khrc+ITSl9SGmtWmDxf7XpVNesExR1KtATgsA0+bN/mE/EvjIuFiuCo4muhDv5lf8TasaZc6Ja5y/nJ06IakEp4WElKkSDNpLLs1X7miyd+xaj+uid4bxJPx8vS5bPI0Z62xBwQDqUlq+lMPF6r375jrEPcNxvaPbCTYU8Xpzec1xpEPJmlbHMEhDukU3HEi4vtpU/7pIST5s2d0lGCeqKDyfcT/jAMUnzaNeGyJScmkoYAUPzhGzJTNF+WXdWVxbsNqPganq89hJTT9E05r+0QKuWlpQBfOCSkghzTfz/a1T8NZgs/onG18zjMG1wMnLv6YBIIzJRwUXEJ6LdOjZBZCX8dvk1K7ZkbGhDzl7xhpp/FSmI1/YIw8Kmbat551HLfblMv9prrC5J4dls1EL/BG6iYKp4Jnzw==;5:KVTgu6Qamje86TZN5/6dTI+N9skJIpG+73TyZHvyFHWVVcsuX4WnY1ss/eLytrly6x6L47/sfhuh3g8eXgasKWP+OFU5R3wH/HUZYCoWM7EjemN/ux3OiJE2lSQ6mq7e1Wi8f1HFQvoTQb9TQbDpaZcKd1tZRhZMqfOh6WIP4oE=;24:VWp7oZzE3hR6PbXyLJYblx790fGyIY/eGgGmwo0DMq5VqFDkGLtGCXwxDLkKWUEhvfapfMThOGu+3pngc8edRjBUBIxmpl+YVvTucLWxhRU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;7:Hr4LGBjAhhujeAi6dZinsG8wIzfzhQR2bzHg6yRZ/7khtvJgr8qnVhZnaGsBxKfaCyLQSMrMJkaLNRiCRhn/Z4VK2/nm0TF64ZnHoZncE1Fkk/6nnlZeNHpQV8dEiAoByIWgkDPJHBbEu2ZjZ8/RHlYyToRtQ0rOLzyO0lnAGPVhswUk2xAepNvtMxr0QuI/VhCTMjMXvPZt8iwZlBDjwGlnojbtzqboCqPaDTmbMimsRPT9305PNBbbuDjCwEJs
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 14:41:54.2367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9753b7-a473-4cf2-4708-08d594ba0d57
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2897
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 06:56:17AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 28, 2018 at 04:36:05PM +0300, Yury Norov wrote:
> > On Mon, Mar 26, 2018 at 05:45:55AM -0700, Paul E. McKenney wrote:
> > > On Sun, Mar 25, 2018 at 11:11:54PM +0300, Yury Norov wrote:
> > > > On Sun, Mar 25, 2018 at 12:23:28PM -0700, Paul E. McKenney wrote:
> > > > > On Sun, Mar 25, 2018 at 08:50:04PM +0300, Yury Norov wrote:
> > > > > > kick_all_cpus_sync() forces all CPUs to sync caches by sending broadcast IPI.
> > > > > > If CPU is in extended quiescent state (idle task or nohz_full userspace), this
> > > > > > work may be done at the exit of this state. Delaying synchronization helps to
> > > > > > save power if CPU is in idle state and decrease latency for real-time tasks.
> > > > > > 
> > > > > > This patch introduces kick_active_cpus_sync() and uses it in mm/slab and arm64
> > > > > > code to delay syncronization.
> > > > > > 
> > > > > > For task isolation (https://lkml.org/lkml/2017/11/3/589), IPI to the CPU running
> > > > > > isolated task would be fatal, as it breaks isolation. The approach with delaying
> > > > > > of synchronization work helps to maintain isolated state.
> > > > > > 
> > > > > > I've tested it with test from task isolation series on ThunderX2 for more than
> > > > > > 10 hours (10k giga-ticks) without breaking isolation.
> > > > > > 
> > > > > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > > > > > ---
> > > > > >  arch/arm64/kernel/insn.c |  2 +-
> > > > > >  include/linux/smp.h      |  2 ++
> > > > > >  kernel/smp.c             | 24 ++++++++++++++++++++++++
> > > > > >  mm/slab.c                |  2 +-
> > > > > >  4 files changed, 28 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> > > > > > index 2718a77da165..9d7c492e920e 100644
> > > > > > --- a/arch/arm64/kernel/insn.c
> > > > > > +++ b/arch/arm64/kernel/insn.c
> > > > > > @@ -291,7 +291,7 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
> > > > > >  			 * synchronization.
> > > > > >  			 */
> > > > > >  			ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
> > > > > > -			kick_all_cpus_sync();
> > > > > > +			kick_active_cpus_sync();
> > > > > >  			return ret;
> > > > > >  		}
> > > > > >  	}
> > > > > > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > > > > > index 9fb239e12b82..27215e22240d 100644
> > > > > > --- a/include/linux/smp.h
> > > > > > +++ b/include/linux/smp.h
> > > > > > @@ -105,6 +105,7 @@ int smp_call_function_any(const struct cpumask *mask,
> > > > > >  			  smp_call_func_t func, void *info, int wait);
> > > > > > 
> > > > > >  void kick_all_cpus_sync(void);
> > > > > > +void kick_active_cpus_sync(void);
> > > > > >  void wake_up_all_idle_cpus(void);
> > > > > > 
> > > > > >  /*
> > > > > > @@ -161,6 +162,7 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
> > > > > >  }
> > > > > > 
> > > > > >  static inline void kick_all_cpus_sync(void) {  }
> > > > > > +static inline void kick_active_cpus_sync(void) {  }
> > > > > >  static inline void wake_up_all_idle_cpus(void) {  }
> > > > > > 
> > > > > >  #ifdef CONFIG_UP_LATE_INIT
> > > > > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > > > > index 084c8b3a2681..0358d6673850 100644
> > > > > > --- a/kernel/smp.c
> > > > > > +++ b/kernel/smp.c
> > > > > > @@ -724,6 +724,30 @@ void kick_all_cpus_sync(void)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
> > > > > > 
> > > > > > +/**
> > > > > > + * kick_active_cpus_sync - Force CPUs that are not in extended
> > > > > > + * quiescent state (idle or nohz_full userspace) sync by sending
> > > > > > + * IPI. Extended quiescent state CPUs will sync at the exit of
> > > > > > + * that state.
> > > > > > + */
> > > > > > +void kick_active_cpus_sync(void)
> > > > > > +{
> > > > > > +	int cpu;
> > > > > > +	struct cpumask kernel_cpus;
> > > > > > +
> > > > > > +	smp_mb();
> > > > > > +
> > > > > > +	cpumask_clear(&kernel_cpus);
> > > > > > +	preempt_disable();
> > > > > > +	for_each_online_cpu(cpu) {
> > > > > > +		if (!rcu_eqs_special_set(cpu))
> > > > > 
> > > > > If we get here, the CPU is not in a quiescent state, so we therefore
> > > > > must IPI it, correct?
> > > > > 
> > > > > But don't you also need to define rcu_eqs_special_exit() so that RCU
> > > > > can invoke it when it next leaves its quiescent state?  Or are you able
> > > > > to ignore the CPU in that case?  (If you are able to ignore the CPU in
> > > > > that case, I could give you a lower-cost function to get your job done.)
> > > > > 
> > > > > 							Thanx, Paul
> > > > 
> > > > What's actually needed for synchronization is issuing memory barrier on target
> > > > CPUs before we start executing kernel code.
> > > > 
> > > > smp_mb() is implicitly called in smp_call_function*() path for it. In
> > > > rcu_eqs_special_set() -> rcu_dynticks_eqs_exit() path, smp_mb__after_atomic()
> > > > is called just before rcu_eqs_special_exit().
> > > > 
> > > > So I think, rcu_eqs_special_exit() may be left untouched. Empty
> > > > rcu_eqs_special_exit() in new RCU path corresponds empty do_nothing() in old
> > > > IPI path.
> > > > 
> > > > Or my understanding of smp_mb__after_atomic() is wrong? By default, 
> > > > smp_mb__after_atomic() is just alias to smp_mb(). But some
> > > > architectures define it differently. x86, for example, aliases it to
> > > > just barrier() with a comment: "Atomic operations are already
> > > > serializing on x86".
> > > > 
> > > > I was initially thinking that it's also fine to leave
> > > > rcu_eqs_special_exit() empty in this case, but now I'm not sure...
> > > > 
> > > > Anyway, answering to your question, we shouldn't ignore quiescent
> > > > CPUs, and rcu_eqs_special_set() path is really needed as it issues
> > > > memory barrier on them.
> > > 
> > > An alternative approach would be for me to make something like this
> > > and export it:
> > > 
> > > 	bool rcu_cpu_in_eqs(int cpu)
> > > 	{
> > > 		struct rcu_dynticks *rdtp = &per_cpu(rcu_dynticks, cpu);
> > > 		int snap;
> > > 
> > > 		smp_mb(); /* Obtain consistent snapshot, pairs with update. */
> > > 		snap = READ_ONCE(&rdtp->dynticks);
> > > 		smp_mb(); /* See above. */
> > > 		return !(snap & RCU_DYNTICK_CTRL_CTR);
> > > 	}
> > > 
> > > Then you could replace your use of rcu_cpu_in_eqs() above with
> > 
> > Did you mean replace rcu_eqs_special_set()?
> 
> Yes, apologies for my confusion, and good show figuring it out.  ;-)
> 
> > > the new rcu_cpu_in_eqs().  This would avoid the RMW atomic, and, more
> > > important, the unnecessary write to ->dynticks.
> > > 
> > > Or am I missing something?
> > > 
> > > 							Thanx, Paul
> > 
> > This will not work because EQS CPUs will not be charged to call
> > smp_mb() on exit of EQS. 
> 
> Actually, CPUs are guaranteed to do a value-returning atomic increment
> of ->dynticks on EQS exit, which implies smp_mb() both before and after
> that atomic increment.
> 
> > Lets sync our understanding of IPI and RCU mechanisms.
> > 
> > Traditional IPI scheme looks like this:
> > 
> > CPU1:                                    CPU2:
> > touch shared resource();                 /* running any code */
> > smp_mb();
> > smp_call_function();          --->       handle_IPI()
> 
> 					   EQS exit here, so implied
> 					   smp_mb() on both sides of the
> 					   ->dynticks increment.
> 
> >                                          {
> >                                                  /* Make resource visible */
> >                                                  smp_mb();
> >                                                  do_nothing();
> >                                          }
> > 
> > And new RCU scheme for eqs CPUs looks like this:
> > 
> > CPU1:                                    CPU2:
> > touch shared resource();                /* Running EQS */
> > smp_mb();
> > 
> > if (RCU_DYNTICK_CTRL_CTR)
> >         set(RCU_DYNTICK_CTRL_MASK);     /* Still in EQS */
> >                                        
> >                                         /* And later */
> >                                         rcu_dynticks_eqs_exit()
> >                                         {
> >                                                 if (RCU_DYNTICK_CTRL_MASK) {
> >                                                         /* Make resource visible */
> >                                                         smp_mb(); 
> >                                                         rcu_eqs_special_exit();
> >                                                 }
> >                                         }
> > 
> > Is it correct?
> 
> You are missing the atomic_add_return() that is already in
> rcu_dynticks_eqs_exit(), and this value-returning atomic operation again
> implies smp_mb() both before and after.  So you should be covered without
> needing to worry about RCU_DYNTICK_CTRL_MASK.
> 
> Or am I missing something subtle here?

Ah, now I understand, thank you. I'll collect other comments for more, and
submit v2 with this change.

Yury
