Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeDALLa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 07:11:30 -0400
Received: from mail-by2nam01on0058.outbound.protection.outlook.com ([104.47.34.58]:56864
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753407AbeDALL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 07:11:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Sun, 1 Apr 2018 14:11:08 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Message-ID: <20180401111108.mudkiewzn33sifvk@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180327102116.GA2464@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327102116.GA2464@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: HE1PR06CA0153.eurprd06.prod.outlook.com (10.170.251.40) To
 BN6PR07MB2898.namprd07.prod.outlook.com (10.173.28.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99217bb9-48dd-4732-1945-08d597c14f30
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2898;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;3:J8MKOyn+m6Z4zrABdM3qSKsvjnO8XwzGC0osa1c/FJvSTrdzBuDRxJg3mJxgt3VXZ2loWrX6IFj2ktoQN2IXSAWnYR7FvWYriKbN3BE4Z9k25FoVMe3OtZJtLs5/Y1EvU2O0QwOVsJzZtxN7YiKtXbAieFGftMMBz+mcB1VtQLOxZ5NWZezrsCMyX/psrpbPj1B/VcEHLuIhrD+k+F5GzBZc0yuRwLv1tTX3MKVcsWzIFM7sawUQoSm945YNLj/o;25:6lVTz/jiHQoDRPAx7vKP13Xnwett5r0K5F8I6IS6yZZlb2NIhfpcdGdCzkqEYEy8ofTzYXo7BIMMBmibiAk41/cLjNuKlJmUyK9AyT4FzhwFaVQW6oGJhXpcZVyNhWGQyXYFIIj8saH2lL6OHU99sxEEDpPmhJa9D/x0otNhTM/LUE554i6KvneMQHXplncTtDEphsF4BFq84ArStp+LilALD/Hs/igGFmfUM/RTkkxkFm8OCwwm58MMdjH//HXuVO6aNKO0gF6sb9YGAwN64thdtEg1SfzuVZJ0AXNaUuwzHrjfID+fX/ED1XRiDarqEzNvU8R+x8HzQIGJ8HyIeQ==;31:dOIR00P+m9BKKkvVr9oHJfoPyZY0GUIuFHfydyt/swb4PPXMhXq3/Ie+FQV8YbBrGRZc/4wO3OFQo6zNkg4QjvSAcuKdoojHPC3eeYxTdxecXWpPd0A2QQWc2GFTSk51CBcl55JdvaxdgWZ3G9JakyZLIZgC6MNLoRyDy3NGj4BBZOahvYhLDl6ggPQQgPvGVwTLQyT7ulWnu6SxRx6eBiMoMeXGrCM9dMS6X65Kn7A=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2898:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;20:VaI8bSFaQ91/avCjZjD51OcuCJTjCcXZGRdBN60Zve7eHTg7T0actfiLJ56rb++bkVZeuuMYrmkyF0eV8sn6pwWAEqdbbjnh91EBL8lVQGM42zTqWWrM67C35BErbhPzhe+VGMfzGFnfFHsNqxrTnittCtVfVgXhBby0zUt+zHHPmdLWtwJwazZhb34Az/u6zRm8QEsJUAtSTqeet6VF8yz6ZNiHpsXTKlW5Bj6jgTP81dif1DvWSJWsltnwk9GDAAea7LXzEf6lrYDX7dKZecpa+qNvV/Hb9VQosOUeeUI6Vpp216ZnJbyY1pogICX42iUUe3p14CXYjg0mlDCM+y/xTNgGWdnh/wAJbhsnMvyGJ3UpZzxQT99ckr0HJ9xjA/LxtXMm4vIm0fK2uuKvAyLZXlHb1WdaZ8SgifHlsNbvFAFWeS75kgefMt18xzVCETBlBxOG7/LBhQkcKkJAddaBExdYrQDrFQWO4CD45KZD/Yw2SG5nA4e4eLPYIYYlXnxQ5TRnoOmR953K51qRSa/0XaWpW4N631stTBpnmJFlxq4HukdRh74BQWpqrT+M/eMomk8RiS2o0Ery+JVJe4tflCEZW7Sdrh02lhsjM2I=;4:Ie1q306T/jLujr0bD7xK6BTn9dJfE15HHDUCNzSYl/sKFO2IsNdX1QsMJ91EpKDB782RLhZqV+5zdPWxCtVNOb/Bu8Hmedc22KlQdo/AmROqZuB81qcPmGu4AViWlTWs9U65knQNQ80z2asOsSvEEb9p9N+szldx6hm3aGvV4GZOn1fxVshdCxGyNAeidQJHwuS6tF10s94KSUsDJFfgQ2oYfP4yM56UIeAH0/G6z4QMJX8e1zCq4awO51603ZnjQQkxo7vJe0gSTAM3xA3ekQ==
X-Microsoft-Antispam-PRVS: <BN6PR07MB289827210E1DF98A6AA79EB1E3A70@BN6PR07MB2898.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR07MB2898;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2898;
X-Forefront-PRVS: 06290ECA9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(396003)(39380400002)(366004)(39850400004)(376002)(346002)(199004)(189003)(486005)(476003)(6496006)(33716001)(5660300001)(446003)(8936002)(575784001)(956004)(11346002)(7736002)(33896004)(52116002)(305945005)(6246003)(97736004)(6486002)(76176011)(50466002)(2906002)(6306002)(478600001)(1076002)(316002)(7416002)(59450400001)(486005)(16586007)(9686003)(81156014)(81166006)(25786009)(229853002)(3846002)(23726003)(186003)(16526019)(42882007)(4326008)(386003)(54906003)(6666003)(6116002)(58126008)(8676002)(26005)(6916009)(72206003)(106356001)(68736007)(66066001)(47776003)(76506005)(105586002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2898;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2898;23:1aMho3eJACJO6n1cWPb0ZPJQGD/nXxmPpm7Fy0m78?=
 =?us-ascii?Q?JWV5PsNAaK8AvIucQL0CRkc2ZjSYdAwR4BKIj5JTt2dE5nb1uCxDmvwdcYGV?=
 =?us-ascii?Q?NUy62XugNqX4uUZz0cCOuVz+tNJM1FZpIojadZPU/kAnuOA+0K70uyNh/ZrO?=
 =?us-ascii?Q?sqYgJ+2r5Sk5DyKyI/X73xILW37uoFl8w6O/7vkK9NXm4WjzZ/DwPhqJvbvF?=
 =?us-ascii?Q?mp8zap4QqOoefnN6XrCcpifITZRQXQmiqIeKNy3aj2Ah7w7Drn+tuGn0pNI3?=
 =?us-ascii?Q?jizr/gEiJgxNaBNRI9rKLiAIXHRdxR+L6xgJ0BEo84tXAZqAnAdNc+N+IjA8?=
 =?us-ascii?Q?BehHpjDRyfJNgw1FL5W1kf6kRsBR6AXsp2TLCAxQLvI2CCA0dynkndDJ5n8p?=
 =?us-ascii?Q?TU8b0wUG89HcBaW6lG25uX8G++GKvPJAITmOiBipR/Sw8slULXz+85wrLE2S?=
 =?us-ascii?Q?RSVEo4E4loNnyS+kNsuWsTr4UJ5al8psUx/0fJdpkePzXmBskMlJbAhp+wlm?=
 =?us-ascii?Q?p6Qlw8RF5ivVSV3jNykhICPpbLfoY9nCegj85d686E+GI1EvQ+F93E5SdZCG?=
 =?us-ascii?Q?3Yhzd9BXQuos0D+FM/Nmzs8TAL3jMhv57SMTtp0DpcGdopqLT4ttwXwkM80P?=
 =?us-ascii?Q?Jr1NNlacqF/GvA3ibzKbCRT5QlpimDt8ifKs7tzXqdaQECEnhYX+oJrguZqy?=
 =?us-ascii?Q?Y0VHWZavcov7RKDZ1OeasMxEF02BpCSlD0WQmcEA7eGLl4SnDt5B0SHzKXPK?=
 =?us-ascii?Q?iMM/Pwh/lLP28tj58VJ0v1BE2ANt/PqgnmX+M2B4sJX3rwT9Hi+E7QDV/2lR?=
 =?us-ascii?Q?yAOGIBd5BdgPO9fgpZecJMrSDYdug3FEBfn1PwIMM5UQ6LSDjYiB4GLFwGah?=
 =?us-ascii?Q?6K/xCDT5iHAK+v+W+rZBxOUhnKXyq+GoymM2gr50nEJJ/ChTkDeNhbDty2vh?=
 =?us-ascii?Q?phdII/l2NaXGXesrEhmo5IyBmIgEnLfrgz/EUlT1H6XwO0xD6TQV7lUL8hIz?=
 =?us-ascii?Q?OrOz/ZkZBB4HpFDe2Gz1+dWp3AbEGeGPKkSuYQWLIVc6i2lbMSTc/P049ZtC?=
 =?us-ascii?Q?4pKYfHVshZIS4rwD21V7PscBHkjlRYNlcfkzVWMSjCwtLbtzFr1fPXT5iqJ9?=
 =?us-ascii?Q?uWxbRTCHuwGbU5DEKOavrGXVx//pxnMIfgFy7W8CuZE7QNLV4WpkMrickyh7?=
 =?us-ascii?Q?iv1Vy3yy8WI1d+jheKh8UY9C6oe5z15KU4+ZdlXDuFA6iQISjFBRL/ksT9KM?=
 =?us-ascii?Q?1yNdSoK9WinyZT16+L8QTgsZdg2/yD6HRyNikp1g1OrsrOA6YB4syXGhIEZ3?=
 =?us-ascii?Q?3K0yea6iR7F8kYVIpy900PpE52BUHpol2HApc/p7a3lWipSfERgDfOdvdbfL?=
 =?us-ascii?Q?UIlGWkQwTkCzAuhSrYEhr2gKkbEb8WLfSpUQoxGqc98YAxTIP7sSQgw9pn2N?=
 =?us-ascii?Q?28Gsh7Q0Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: tqdXmgs0MoUt9bAzr5Aa2vxLzRau2E2X+WQW4kVXsrY87XgbBn3PpYn9r6sGa0c1U7sYncRz1Qnh8xTFOpZctFpTSTrVKvJnfVfnNmqVz2PK8/SS6HMC+NEIeWnZJfRGNLy0bBJt4+A5Qu3bLXH3tt/8naMNgMfmnyqY5aq9YCfp2VKNnCTxMMWwM7Xurz6S
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;6:gQF2HEDwDMqkHKbYmhD/5MbaJeq2PpAxBALKQpbGDeEcJw2RC6+2KdV8fH0HmfcQM6dBQP9aqMOQVK3ejX5rqZW88fpggwa+83PkX4azJxYOJqizju1B4yA4OXPCqEu6JXi7/17YKmj2NJVYR50+FQO5MaQI6wKSlGS9FWS3zInv4FvCoZVo6DSfaGGkY55uEOa/yGPRjIs2OTMYVeeNqqTzVKzjroyNFyHGFHzercOEwH/mpXZgq/OR2lY3/JsDzQo/nTOKNiduBGtT0UYzrd8iRntjZsICQiUUXZ5gpzwyTjSprRb1yvtzIykDtlsmEDXgW0n8XTcQh/MvLxzaxUZQcX9YQpt3Llc4JPk8q/FzofxJx799rX2AzqX3xHQWXDkuXi4OPxHcg1xmsgfeTLON00ELShjF7jwwcS2bwKIcT/EOgqRdBafEl6wC31BhZHBED8ZgUWXbDyGViQmGIw==;5:XfCkZwa5gx3AzGI9YkDVNvJQwIsChcxhXAhoKRxqQ8ZRJNIay7sY9ZOiZ47wbYWhMuT6ERzx4abBPSGdY7dkHt2UCa+9hHc5NQ6dJ8Q3Zs3Pu5LcZTY0+2JsGq64hDQxs7CyIj1QJ7WGgCNTFXDXa0+6Rc6w2VSEsCLSLvNhb0k=;24:zacSZ6Z/OHF7W1yIWd9zG91ZR/rKiU9noXi2wEWSi2b08q4X9wjFSohPwBYGe17gxXCpwmIDxAFzoDVkegmSE65jQVQCCTboXL7WzrH2sf4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2898;7:S0ag+IhhAQYImreemBHHXmXiVjIqsP+1aKg3Fn+HggZKSRwNuP9Gplz3+MagXye8PgsXBJNf7o+0mE04DmYuIv9bmF/WgUDFNbq+TivSP2HYrmcAF8O7qu0zwW8LjMpbpn0JKLFVpAwX7KD08EbHjDtAqrBwvoakyO/dvbHk22LPJmY6Z9IkYEO0xifYyKUD6Xc+fkL1942RxgDEvWwKLAFBtOtbk+TriNg5EqdDvJI4T5zHFXev8XY0zWqYcn2d
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2018 11:11:24.5238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99217bb9-48dd-4732-1945-08d597c14f30
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2898
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:21:17AM +0100, Will Deacon wrote:
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
> 
> I think this means that runtime modifications to the kernel text might not
> be picked up by CPUs coming out of idle. Shouldn't we add an ISB on that
> path to avoid executing stale instructions?
> 
> Will

commit 153ae9d5667e7baab4d48c48e8ec30fbcbd86f1e
Author: Yury Norov <ynorov@caviumnetworks.com>
Date:   Sat Mar 31 15:05:23 2018 +0300

Hi Will, Paul,

On my system there are 3 paths that go thru rcu_dynticks_eqs_exit(),
and so require isb().

First path starts at gic_handle_irq() on secondary_start_kernel stack.
gic_handle_irq() already issues isb(), and so we can do nothing.

Second path starts at el0_svc entry; and third path is the exit from
do_idle() on secondary_start_kernel stack.

For do_idle() path there is arch_cpu_idle_exit() hook that is not used by
arm64 at now, so I picked it. And for el0_svc, I've introduced isb_if_eqs
macro and call it at the beginning of el0_svc_naked.

I've tested it on ThunderX2 machine, and it works for me.

Below is my call traces and patch for them. If you OK with it, I think I'm
ready to submit v2 (but maybe split this patch for better readability).

Yury

[  585.412095] Call trace:
[  585.412097] [<fffffc00080878d8>] dump_backtrace+0x0/0x380
[  585.412099] [<fffffc0008087c6c>] show_stack+0x14/0x20
[  585.412101] [<fffffc0008a091ec>] dump_stack+0x98/0xbc
[  585.412104] [<fffffc0008122080>] rcu_dynticks_eqs_exit+0x68/0x70
[  585.412105] [<fffffc00081260f0>] rcu_irq_enter+0x48/0x50
[  585.412106] [<fffffc00080c92c4>] irq_enter+0xc/0x70
[  585.412108] [<fffffc0008113a64>] __handle_domain_irq+0x3c/0x120
[  585.412109] [<fffffc00080816c4>] gic_handle_irq+0xc4/0x180
[  585.412110] Exception stack(0xfffffc001130fe20 to 0xfffffc001130ff60)
[  585.412112] fe20: 00000000000000a0 0000000000000000 0000000000000001 0000000000000000
[  585.412113] fe40: 0000028f6f0b0000 0000000000000020 0013cd6f53963b31 0000000000000000
[  585.412144] fe60: 0000000000000002 fffffc001130fed0 0000000000000b80 0000000000003400
[  585.412146] fe80: 0000000000000000 0000000000000001 0000000000000000 00000000000001db
[  585.412147] fea0: fffffc0008247a78 000003ff86dc61f8 0000000000000014 fffffc0008fc0000
[  585.412149] fec0: fffffc00090143e8 fffffc0009014000 fffffc0008fc94a0 0000000000000000
[  585.412150] fee0: 0000000000000000 fffffe8f46bb1700 0000000000000000 0000000000000000
[  585.412152] ff00: 0000000000000000 fffffc001130ff60 fffffc0008085034 fffffc001130ff60
[  585.412153] ff20: fffffc0008085038 0000000000400149 fffffc0009014000 fffffc0008fc94a0
[  585.412155] ff40: ffffffffffffffff 0000000000000000 fffffc001130ff60 fffffc0008085038
[  585.412156] [<fffffc0008082fb0>] el1_irq+0xb0/0x124
[  585.412158] [<fffffc0008085038>] arch_cpu_idle+0x10/0x18
[  585.412159] [<fffffc00080ff38c>] do_idle+0x10c/0x1d8
[  585.412160] [<fffffc00080ff5ec>] cpu_startup_entry+0x24/0x28
[  585.412162] [<fffffc000808db04>] secondary_start_kernel+0x15c/0x1a0
[  585.412164] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.0-isolation-160735-g59b71c1-dirty #18

[  585.412058] Call trace:
[  585.412060] [<fffffc00080878d8>] dump_backtrace+0x0/0x380
[  585.412062] [<fffffc0008087c6c>] show_stack+0x14/0x20
[  585.412064] [<fffffc0008a091ec>] dump_stack+0x98/0xbc
[  585.412066] [<fffffc0008122080>] rcu_dynticks_eqs_exit+0x68/0x70
[  585.412068] [<fffffc00081232bc>] rcu_eqs_exit.isra.23+0x64/0x80
[  585.412069] [<fffffc000812609c>] rcu_user_exit+0xc/0x18
[  585.412071] [<fffffc000817c34c>] __context_tracking_exit.part.2+0x74/0x98
[  585.412072] [<fffffc000817c3e0>] context_tracking_exit.part.3+0x40/0x50
[  585.412074] [<fffffc000817c4e0>] context_tracking_user_exit+0x30/0x38
[  585.412075] Exception stack(0xfffffc00385afec0 to 0xfffffc00385b0000)
[  585.412076] fec0: 00000000000000b1 000002aacd702420 0000000000000200 00000000000001f4
[  585.412078] fee0: 0000000000000000 0000000000000008 000002aabec9af17 ffffffffffffffff
[  585.412079] ff00: 0000000000000016 ffffffffffffffff 000003ffe7619470 0000000000000057
[  585.412081] ff20: a3d70a3d70a3d70b 000000000000016d 2ce33e6c02ce33e7 00000000000001db
[  585.412082] ff40: 000002aabec7d260 000003ff86dc61f8 0000000000000014 00000000000001f4
[  585.412083] ff60: 0000000000000000 000002aabecab000 000002aacd6e2830 0000000000000001
[  585.412085] ff80: 000002aacd6e2830 000002aabec58380 0000000000000054 000002aabebccf50
[  585.412086] ffa0: 0000000000000054 000003ffe7619540 000002aabebcf538 000003ffe7619540
[  585.412088] ffc0: 000003ff86dc6410 0000000060000000 00000000000000b1 0000000000000016
[  585.412089] ffe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  585.412091] [<fffffc0008083498>] el0_svc_naked+0xc/0x3c
[  585.446067] CPU: 68 PID: 0 Comm: swapper/68 Not tainted 4.14.0-isolation-160735-g59b71c1-dirty #18

[  585.412038] Call trace:
[  585.412041] [<fffffc00080878d8>] dump_backtrace+0x0/0x380
[  585.412042] [<fffffc0008087c6c>] show_stack+0x14/0x20
[  585.412045] [<fffffc0008a091ec>] dump_stack+0x98/0xbc
[  585.412047] [<fffffc0008122080>] rcu_dynticks_eqs_exit+0x68/0x70
[  585.412049] [<fffffc00081232bc>] rcu_eqs_exit.isra.23+0x64/0x80
[  585.412050] [<fffffc0008126080>] rcu_idle_exit+0x18/0x28
[  585.412052] [<fffffc00080ff398>] do_idle+0x118/0x1d8
[  585.412053] [<fffffc00080ff5ec>] cpu_startup_entry+0x24/0x28
[  585.412055] [<fffffc000808db04>] secondary_start_kernel+0x15c/0x1a0
[  585.412057] CPU: 22 PID: 4315 Comm: nginx Not tainted 4.14.0-isolation-160735-g59b71c1-dirty #18
    
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e1c59d4008a8..efa5060a2f1c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -35,22 +35,29 @@
 #include <asm/unistd.h>
 
 /*
- * Context tracking subsystem.  Used to instrument transitions
- * between user and kernel mode.
+ * Save/restore needed during syscalls.  Restore syscall arguments from
+ * the values already saved on stack during kernel_entry.
  */
-	.macro ct_user_exit, syscall = 0
-#ifdef CONFIG_CONTEXT_TRACKING
-	bl	context_tracking_user_exit
-	.if \syscall == 1
-	/*
-	 * Save/restore needed during syscalls.  Restore syscall arguments from
-	 * the values already saved on stack during kernel_entry.
-	 */
+	.macro __restore_syscall_args
 	ldp	x0, x1, [sp]
 	ldp	x2, x3, [sp, #S_X2]
 	ldp	x4, x5, [sp, #S_X4]
 	ldp	x6, x7, [sp, #S_X6]
-	.endif
+	.endm
+
+	.macro el0_svc_restore_syscall_args
+#if !defined(CONFIG_TINY_RCU) || defined(CONFIG_CONTEXT_TRACKING)
+	__restore_syscall_args
+#endif
+	.endm
+
+/*
+ * Context tracking subsystem.  Used to instrument transitions
+ * between user and kernel mode.
+ */
+	.macro ct_user_exit
+#ifdef CONFIG_CONTEXT_TRACKING
+	bl	context_tracking_user_exit
 #endif
 	.endm
 
@@ -433,6 +440,20 @@ __bad_stack:
 	ASM_BUG()
 	.endm
 
+/*
+ * Flush I-cache if CPU is in extended quiescent state
+ */
+	.macro	isb_if_eqs
+#ifndef CONFIG_TINY_RCU
+	bl	rcu_is_watching
+	tst	w0, #0xff
+	b.ne	1f
+	/* Pairs with aarch64_insn_patch_text for EQS CPUs. */
+	isb
+1:
+#endif
+	.endm
+
 el0_sync_invalid:
 	inv_entry 0, BAD_SYNC
 ENDPROC(el0_sync_invalid)
@@ -840,8 +861,10 @@ el0_svc:
 	mov	wsc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
 	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
+	isb_if_eqs
 	enable_dbg_and_irq
-	ct_user_exit 1
+	ct_user_exit
+	el0_svc_restore_syscall_args
 
 	ldr	x16, [tsk, #TSK_TI_FLAGS]	// check for syscall hooks
 	tst	x16, #_TIF_SYSCALL_WORK
@@ -874,10 +897,7 @@ __sys_trace:
 	mov	x1, sp				// pointer to regs
 	cmp	wscno, wsc_nr			// check upper syscall limit
 	b.hs	__ni_sys_trace
-	ldp	x0, x1, [sp]			// restore the syscall args
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
+	__restore_syscall_args
 	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 2dc0f8482210..f11afd2aa33a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -88,6 +88,12 @@ void arch_cpu_idle(void)
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
+void arch_cpu_idle_exit(void)
+{
+	if (!rcu_is_watching())
+		isb();
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 void arch_cpu_idle_dead(void)
 {
