Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935447AbeEJNIf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:08:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757185AbeEJNIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:08:31 -0400
Date: Thu, 10 May 2018 14:08:04 +0100
From: Roman Gushchin <guro@fb.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/2] mm: ignore memory.min of abandoned memory cgroups
Message-ID: <20180510130758.GA9129@castle.DHCP.thefacebook.com>
References: <20180503114358.7952-1-guro@fb.com>
 <20180503114358.7952-2-guro@fb.com>
 <20180503173835.GA28437@cmpxchg.org>
 <20180509180734.GA4856@castle.DHCP.thefacebook.com>
 <20180509153805.2a940eac8c858398fb0f4b0c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180509153805.2a940eac8c858398fb0f4b0c@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:8c3a]
X-ClientProxiedBy: AM5PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:206:2::23) To DM3PR15MB1084.namprd15.prod.outlook.com
 (2603:10b6:0:12::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1084;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1084;3:bF9s4HoOptRwsPyUFKR0xY+SuOWGdCSOgXLFhFRFFF02KN0+EFvPG+QCtu5YKO2OrNVHgOQjFFpNABIgEo2oy/UsPBs9o85h9VbHNJJo8cEesAe8LjqES8T+1dqxY1SZK2I6nU1GXLtbSNX9kKwwykp0FlFETSf/O5eyc4WAezgZqxHkV7mZ5Dts1KXbuRLIRQZWsXDNXOiFvTRShjlYN+4jVjnmKYvqYsvETQiI8jx3ODTcQ8MO382+zVUyoZHj;25:9n4RcglKK79B1mlnQeVlTExrD+1CE7v1SHRwIdpCu2CobRuwcmQ0oP47pqOI0Ez4VL1JdsxfCSaT5eyIg6bKgZJlxMgbr59SDHwdxp4mZlEQ2QVADdhsTKdp9plKeBudWxqfWVVxlGYz3uPO5l1nH5vWOAaqRi7GJjqBp1Sa3vhSogFy0VSHDY8PeZ3l+xXs1zKHlns+Dl2nZYeNQ5rhYPu9PFZYU8huM/y1qnbUVO/deCsi1+oAwJMlTQFv+xvF8e/phN3X53Ef7aQCYROakMakcAr9WFNNNu+fV44MfSEoxXO7XonKu+NDAURMgh7krQl1hBeH1FxaBJpOJ99aew==;31:k0NoakgX1GxHFbzoqzzweMWLRQ5xEhZFZHloNpd07gjhe/T60RRdSr/QziK7nh1Ryfi0+k7wgsBkGBGLJgdd+TBBnqnTi2FI0vSZeoOtK8vadsr/pA29QFVD554iRG0gUmDw2Y3o6TUqQjRlR36L64Yqw4N62n00Wa2AaxtnAEjhacgspzc+qFLC4UUj+I0M2jh9RRBSdQv40nYE1QraZ3t00GHu7KMv0er6vK1NM1s=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1084:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1084;20:7XkunjACAVr2tSWBqsE4njVdk6S95ThxWq/nmSlRh+flaum2ER10c8VvDRlmNbRXJyGTol4IRQPXZC7OKo6R8QLTe4ArXYtiOYEtf73BbwR93ci7rowHh01DubTh2meT7qpfcr2SldQEgKQHtzBcwREfzA5wd1vlnkeZD6bANqtjPlibuvakxdrM/3dBCNQOczgZub6/cm1xudvKZFxT4SqVmliJbJhTgqcLj71B5rvy0+GJg3xa4Vmz6lGw0cVmvTDpo2eCAMdGbB7arz4wCQQRLCt2J1EcMIAevJXSsuVFGd7CCX0NMjlqJh9/DjabHfUl75EdGNTO+J/FSP5786YB5F6NbDAlESvtO9gsNzWjAji0TLrOadoqW5vs/x2UJ0ewsKUFaFl8GyNf97beRQ3uhjP1H87RwXY+eYqb4bqSeZP3coztMVW/vB+7itUy0KYFz+28Fy88dv7ofbALPRXKeERDROQPMxbRZVumTTJMfAGF/cnLXpWU/eh8Jq2H;4:2LQPaQbfJZ7w9J9veulJMJlCkqKg5ICF9oJwTvMP5HvuibAnCspmMaYJFgOB1CS0ix+tJ+sy2hH2lsVFpibhdseARtW+sHVQrmfEvRR49BA46SyH/xeuEIfF/RIMxU3uW2GZxvpAbdr7JCO/D1Q1LFEZ9JM+u6/em+6YhHM7+kY/HxGOx3bZ+9h2LmhGzp7yO+vLGNyZzgUokNCOj140vD2ujQhDb13yEfjPTVlZ90t6W2ysQovkSvvqsFYfIpRgCEpSsOlc1Vakjs2VUMhcHw==
X-Microsoft-Antispam-PRVS: <DM3PR15MB108486230E6E442ECEDE361CBE980@DM3PR15MB1084.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM3PR15MB1084;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1084;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(50466002)(46003)(8936002)(446003)(6506007)(486006)(476003)(5660300001)(47776003)(229853002)(478600001)(53936002)(6666003)(59450400001)(97736004)(386003)(52116002)(8676002)(105586002)(1076002)(186003)(106356001)(23726003)(16526019)(81156014)(25786009)(6916009)(7736002)(68736007)(52396003)(16586007)(54906003)(81166006)(9686003)(316002)(58126008)(7696005)(305945005)(6116002)(11346002)(6246003)(4326008)(86362001)(2906002)(55016002)(76176011)(39060400002)(93886005)(33656002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1084;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1084;23:bZDxhoX098Wzl5d5C2PcqYLWSSLktL2VY0+UIjTWn?=
 =?us-ascii?Q?zKO5sm9VWuVS8bBfn/4U1SK7dEdYj4Xc2Mf3OrE8fi6ZMEI8EKrKv8DoXY5W?=
 =?us-ascii?Q?gnxXGvSEGJE856aU9unRgdk0ZswFC2YTmG34RvYpU9JQMeJQqK9IZLp9hCvz?=
 =?us-ascii?Q?HyFQj7H5aLpUZrWzNT+GT66Dd1IN0BpOqQnSm08EJBidfsGE7PYqOFGkcd1i?=
 =?us-ascii?Q?MEeOCgx8zQL41DWqftE8yFOL3J+RFjAc+JZx8FgyiQkrZFSyKtj0db7a63U5?=
 =?us-ascii?Q?c7tK4qOur5qKKdXVD3JKEXAt1R7cc25Q4+5fbm9Jjf9k4BNs+xHeL554X2jy?=
 =?us-ascii?Q?QDnPY0iwbnnEPan+Uf/yScR6zg23YJbDhDzaMz/g5wAtcN0Hh9Gt4kOx00Jl?=
 =?us-ascii?Q?9zHhBCUSH1/zrRCv8XC2n6YVmBLO44RU832kk3dhclR333zpO4Lke253Ot0w?=
 =?us-ascii?Q?lN4v88l905Kf1IU1F9ngnArReFgU04x7UneW4I5Vu4k0xQToKU/MDdxs0H2C?=
 =?us-ascii?Q?QErbEE/TDNVERadV+UB525Y50Xwy6lDhhb7uVCyMf0/aXD4tAQRVoS8V8r+j?=
 =?us-ascii?Q?RRaxtwynHUiq5M0KCV9WBkXkIEWhNA8IMtkvUTd7PMwN+sBBE8JKMNMTcgF/?=
 =?us-ascii?Q?L5k7bhIvI1dEoJj05B2ClBWTC1nQLVfKyrG99HJ/zTX9sSm6ywGTpRM7AIvu?=
 =?us-ascii?Q?evwQwm0G3QU3+S5tI5y0e2Chn5LfFLfOGBci4WQo53g8zGxACxnUEBannuNh?=
 =?us-ascii?Q?GTnuXX5cI0u+IR/byAG4wJOG2T1tqNJ2OptBMNEx9BEEgQnBRQ2+Zf7597il?=
 =?us-ascii?Q?O/+YYH4yw5rDCiCE8hfTqJjAB2wgyl9yeKz66P51DPf9Gchc9nsrUz7kMtJk?=
 =?us-ascii?Q?xRKRpEd9LkcwsxD/O03GQiLW8FVOL3Xeksqp3A4I357EgQ86aDvl6fz+ML1I?=
 =?us-ascii?Q?q94DdHer7WuQZFPJX1FhnvvXL23snB/eancL47ZoT+HwvpeEtrUwAv8w72Gs?=
 =?us-ascii?Q?Fms4iVGlIWmmOQuwNHo3AQG+TLTgrZ1Gn+TOzwof0Cvu+x9/xO1oQEOaZ3Iw?=
 =?us-ascii?Q?XQoPmBGqZCqeedaDeru04pNbRIRc7wy76AZVq18fDfTgxZ62Dq0hmhML72rW?=
 =?us-ascii?Q?3jEkYllNCyNscERyNykQtSQsEjCLiMOJ3cDWV061GgOes/SUHFgXZHx+jDfU?=
 =?us-ascii?Q?DuYp5qrR+W/LtqnLGpFOSO6XnGvUGCOXw3x/RNE0erA5KpTJ9/POqsephVnV?=
 =?us-ascii?Q?xgP0CTBlP1iJNKUBhx9LrS/ySBO8wUi2XV5bXEvBweKY2hhu7GPXXpPohbq/?=
 =?us-ascii?Q?8ZGrZaEqF15XYLCCcK//jtqNTMhAGiWT3yb9R1s4IOF?=
X-Microsoft-Antispam-Message-Info: u2T3g9gaDz41oz8TSctwfDtjbFsKB7lPTySGBINbYclRwjrPaIUjG049t/OCogn8VtPfj3KrMhBP05pHm1VKsES4N/YLLttZGLwuMpp2DWp57ddFTK/b4pbwL33smqNcO5NzqUrtwCyD8Fkotch25Vyp9rghRG42aR7bnYWJTShIVNJZIo7K3+rAyL777gAo
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1084;6:nrz47bFoFypnK+lOdDg+gFw9SC7x7fZUncPuI6RIetclQHZzPp9GZiIN9lX+GkXYTmGTEE1xdV9BJvhJ4tpXR0SUMslmpAY8VuHgk6PFnmGvzBWA2YZa7vlJz0XBAj9GYjT/3wHa/oxe0Tp9PjjoswkQFxd0/Jm2ffMZQ3+2X4/9eUVLSjUu9yujXn57dervC/LZ89rIGrQSGOARZfHqNWSRMS4wiizY3gWAUXtn4lE6/aeSVJ44AIYbRMeYTRCOY+0b/Ss0sjYGLB3hZ3Y7vpOoLTNPOzvdRg+0/ZrmLHRrm72YjaJ7LAVlqVyj6f6+lBPzseK+sJGpXiwempblT+9esk816W6+S4/lDgrkp1KAp+GeTxbk5cWUdig0kbhDFSmzg+6KRDVmK7CIlRVCmKpUPxKwkwvIM3RrHny7LDlCpPK3ph6wB5GPVo75dtbI6m6wKyyTiyQqTpIlXS1Nug==;5:r6ZKvMwIswYFVjfHGXBXfW627WPv+fCe9uEPBwVxjKTKxt9DOGhoiNeC/dGlIHwYY6TLXkyMHbFFSlCN/R84lp1WcWwlg6KzHoBIcwjiA9PGdo7MqbwgdIEaYIsEr3sW08vUe8wKcZQ8FyvzPjySnyW7uukOqfNFw/C6OOndQ0Y=;24:6mti0MjiNp22NIEKpVHCZESfhTBimvtVlbHrtFZqKFU5AsqF4K2s1sZ5BYPxK4Mvs+QWxXcTeOYxjvsM3bpdvrmR8t2dGMOP+UYKpBHgEGA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1084;7:7AvnurIkQb8+VSdy/4PkJxtyHCVWF/nsSwsIzXt/EXVHZ+TRkWRbb20hjSH1PFrFF4YHWnWTsgzHXAX+Z5TTQQHOd/niJsGyZVtUIL+/g12qhtCBFFKAx6YTYQbQ5dLjflz2ZwedQieF+5LWVBkwsp/w0i+dG6DbwEs+hZ+8t3MIhmgejOATD8kXbyeD8P8TpsHqdJX+9TOfjmjNWUi+kmokWpFpAPFUsiiMDv3++VZA8ClFgvwO/YBCZXEz6h4z;20:yRQ8q1LQ0j3Yo1gTqQOMg2z4lSczX0dD9E8I1/pclna6cBfQXFvp3yLJTMKU8FXDfH5CYDNN4IQtjRgDcA84KYU349YK17N8+mABmvRwFXNczD1clUsTHSVvK18pGyRW78HIdfFEeVyE0yw9CkCHc+ijBuAvZenYwpnuYWXmB0E=
X-MS-Office365-Filtering-Correlation-Id: fd2ed0bd-9859-4578-0aa5-08d5b67716c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 13:08:12.8418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2ed0bd-9859-4578-0aa5-08d5b67716c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1084
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 03:38:05PM -0700, Andrew Morton wrote:
> > 
> > Memory controller implements the memory.low best-effort memory
> > protection mechanism, which works perfectly in many cases and
> > allows protecting working sets of important workloads from
> > sudden reclaim.
> > 
> > But its semantics has a significant limitation: it works
> > only as long as there is a supply of reclaimable memory.
> > This makes it pretty useless against any sort of slow memory
> > leaks or memory usage increases. This is especially true
> > for swapless systems. If swap is enabled, memory soft protection
> > effectively postpones problems, allowing a leaking application
> > to fill all swap area, which makes no sense.
> > The only effective way to guarantee the memory protection
> > in this case is to invoke the OOM killer.
> > 
> > It's possible to handle this case in userspace by reacting
> > on MEMCG_LOW events; but there is still a place for a fail-safe
> > in-kernel mechanism to provide stronger guarantees.
> > 
> > This patch introduces the memory.min interface for cgroup v2
> > memory controller. It works very similarly to memory.low
> > (sharing the same hierarchical behavior), except that it's
> > not disabled if there is no more reclaimable memory in the system.
> > 
> > If cgroup is not populated, its memory.min is ignored,
> > because otherwise even the OOM killer wouldn't be able
> > to reclaim the protected memory, and the system can stall.
> > 
> > ...
> >
> > --- a/Documentation/cgroup-v2.txt
> > +++ b/Documentation/cgroup-v2.txt
> > @@ -1002,6 +1002,29 @@ PAGE_SIZE multiple when read back.
> >  	The total amount of memory currently being used by the cgroup
> >  	and its descendants.
> >  
> > +  memory.min
> > +	A read-write single value file which exists on non-root
> > +	cgroups.  The default is "0".
> > +
> > +	Hard memory protection.  If the memory usage of a cgroup
> > +	is within its effective min boundary, the cgroup's memory
> > +	won't be reclaimed under any conditions. If there is no
> > +	unprotected reclaimable memory available, OOM killer
> > +	is invoked.
> > +
> > +	Effective low boundary is limited by memory.min values of
> > +	all ancestor cgroups. If there is memory.min overcommitment
> > +	(child cgroup or cgroups are requiring more protected memory
> > +	than parent will allow), then each child cgroup will get
> > +	the part of parent's protection proportional to its
> > +	actual memory usage below memory.min.
> > +
> > +	Putting more memory than generally available under this
> > +	protection is discouraged and may lead to constant OOMs.
> > +
> > +	If a memory cgroup is not populated with processes,
> > +	its memory.min is ignored.

Hello, Andrew!

> This is a copy-paste-edit of the memory.low description.  Could we
> please carefully check that it all remains accurate?  Should "Effective
> low boundary" be "Effective min boundary"?  Does overcommit still apply
> to .min?  etcetera.

Except this s/low/min replacement (good catch, thank you! diff below),
the rest looks fine to me. Memory.min and memory.low are similar
in their hierarchical behavior, so most of the things still apply to .min.

Also, can you, please, add
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
(which was accidentally lost between versions).

Thanks you!

--

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 1764a627a120..f6725628bb4f 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -1012,7 +1012,7 @@ PAGE_SIZE multiple when read back.
        unprotected reclaimable memory available, OOM killer
        is invoked.
 
-       Effective low boundary is limited by memory.min values of
+       Effective min boundary is limited by memory.min values of
        all ancestor cgroups. If there is memory.min overcommitment
        (child cgroup or cgroups are requiring more protected memory
        than parent will allow), then each child cgroup will get
