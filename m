Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeCUTIh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:08:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752788AbeCUTId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:08:33 -0400
Date: Wed, 21 Mar 2018 19:08:06 +0000
From: Roman Gushchin <guro@fb.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm: memory.low heirarchical behavior
Message-ID: <20180321190801.GA22452@castle.DHCP.thefacebook.com>
References: <20180320223353.5673-1-guro@fb.com>
 <20180321182308.GA28232@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180321182308.GA28232@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:9a70]
X-ClientProxiedBy: AM5PR0601CA0039.eurprd06.prod.outlook.com
 (2603:10a6:203:68::25) To DM3PR15MB1082.namprd15.prod.outlook.com
 (2603:10b6:0:12::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f8fd5dc-c2b9-4a99-0427-08d58f5f1aa4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1082;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;3:OQ4YMahDG7F+Sog4e6NMkK9olhDZ6Iz9Jy4pyuCkcbLTV6tvkanJUWbju5sN+OZ3HBsXJRT+VTO76v+uAwssMjxeBdA+95kqAUPh9mYwGbqgVZLGpsxbIK2a8KQT1blp9l/+WVcNHQTPQp7SMVeKIi6Vuhk439Q+irx62p+fat0uE4hjoDZ2qRiL5dHcWDAXd3FZ2fgbKRPfwISFyPhqTln2+X8mrSwDGxZHoicnsUm6HYwqv7upAoBBRyIrw9f1;25:hEFPyue7DP1CS07GSz3ggCpCxjpcBXpYvTwCJtSshF1g0WZ1BfSSaT4b7Y5bEoersro6DAOPeWMAQyDtjzHLoZ1PQKyDFEbsgCsNMRIYsrM3dd/ox6f0LrA8ZizO7s+Y9O22j+qSaWli5ejODpxxH+v8HnlzvEU7/Ksz5irFnMCTe5y6dnkwmjOvSLtKNsDHXPGxcUR+NMU2QoutgycfCm7eCl2lvpMmx0cg/BkjD2RPXuGruAj2714ALRCzTvwLyGxNNyA3vhwPUaHS4oTHswFpg9sNCa75qCW+b1LMAsCWYXqXzqYGSVDRsBVChsZxMadyByjQWrjz4rXv8bc1Tg==;31:6OfAR0Nd5LJG6ANZEyTM8k0P1f8Ql22oHlLU/f4jHSxbmUG5Gud+94T82qmFm6Ukym7T0EnA3RMMdl+03wHpjZE2qWugc4IFYWscSRa3XLXXGmAYnaAdzUz/UTKcX/HPFbjdHbd+U3edD8hhJwvZGV231WpqclUZXI9KVOrs8lOHrtDut5Gq4LcfBEqY0JQwamYhxCieBFBfncWBU4oPMHrJsC80GPxUzVp1j8q46bU=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1082:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:estx9P2S+MKxxNi23BXm7AHjZkFrxDjZVuXElquZn9Jp5hx4BoEEf/ihKC/R9iQ5WerIYG2igeeYFXRiH1DIGP52sEsZPltr/Xi8EneYDbjP1w/Kk7hWTnVafhtHEyeyzjn444gUlPq4I72wEDKpyjBpnAZZu+RHjnHPVYHheqPG+LHP/OBDjTsdpGQ9NHSLGXhkgIURpfPdUbJCWNY+2IxzsFr1TttdShWv6glyXq8Fc6op8QPYsF2GCwPmli3HftA1yrRYBdI9wQ7Oy2m50O08MNb3LCgql6/pw/02jjS7Qsb2z4EZ57/YqIcKc7qmh5MrQzhyb/a4EwayfSW2o9xUj6IdgaBNEJTuRYluf0svkgqG+QDRPmk8Us6E3x2RctzRHL85Nvlj5oY+UwfPCObvSbAoDonqEEkTTdhp7QXrYqS1vHj+3MpiDQuCfboyZDuRuYEMsTvB9Oc7EehAH4/f5Gf69SyfF/XmB9GFMKzRC+KwX/H84anV+KFKwNgE;4:+FOX15Jrsz/ntSsXQmPfVuvNdr1ScZwCA9fp0zxA+jSBMypS/PfsKAoV2zRqzd3a/x0F0Z1TEk2B6iDOP5rc2e9QXB28HffyBu+i0foV7mPRXPBwmeIv1we/uYaqDUfHO8yDR4aUl80CvNcj6EIV1UrvqS+xb66/BHKygv170Q34yLUD0DNgfI0cvV9MJ2WsYS1gEXjArFtP632aKQz36Cx1+AFMp3/bskWlx246n609nRQeqJpGvWJVguDgFOcSjYBRKb1FgOlEZWEVcunwSw==
X-Microsoft-Antispam-PRVS: <DM3PR15MB108283DDA5A0D381025FB5A4BEAA0@DM3PR15MB1082.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(11241501184)(944501326)(52105095)(3002001)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM3PR15MB1082;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1082;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(54534003)(189003)(199004)(8676002)(305945005)(50466002)(7736002)(33656002)(39060400002)(81156014)(478600001)(2906002)(4326008)(1076002)(25786009)(16586007)(446003)(9686003)(105586002)(58126008)(55016002)(47776003)(6246003)(54906003)(53936002)(5660300001)(52116002)(76176011)(8936002)(6506007)(386003)(81166006)(59450400001)(6916009)(52396003)(106356001)(7696005)(68736007)(2950100002)(6666003)(6116002)(229853002)(46003)(86362001)(345774005)(97736004)(23726003)(316002)(16526019)(186003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1082;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1082;23:m2ODZ71kZ+AIXaMqWOMiqikdkYDuVOqIW9GaPivXw?=
 =?us-ascii?Q?G0DLFrwqBZiJcLe6w1kPzYemVVwbby3OmlseebQ4wwZdzVPl2JZCcUtgpvat?=
 =?us-ascii?Q?Q+0jX35GHXT6wANJ5JX66aJhuz1eIHqbsnkq1omXAnDB5VoByMemeToFgCNS?=
 =?us-ascii?Q?vHacwrIFneBhruVgSYBe8Xj0ejoH/f7wRtjwzAdOIxQr50daMppca0eewC7q?=
 =?us-ascii?Q?ty4ywPYS5ZzJ7y9jRf33wCZ+U9MDnyC9RboeujrUDd9zCRUy771v3M+DQ9Xl?=
 =?us-ascii?Q?JDfIlcv2vHUMVxT4pQpa5pOWCBkkU6MOqaKJeYzZmhzu9HDM2sTe+v8yHnN7?=
 =?us-ascii?Q?I8BxwMtJXem8/QZo/SSfw9D+K7mFmKOlovw8jOCgInqG7yvqQSISDe5jFOS4?=
 =?us-ascii?Q?2DRPb9+aj/vyrsJQFaT0sMgTbEth0HNtsxp3pYYFgPIMtUau0NQxBSFhRRD9?=
 =?us-ascii?Q?Lkk5W3yN5pEoyKBLHbhCNTmUBFTWvmXwmBJtVNaS4UJLLZ5zO/wC4qwpMmcc?=
 =?us-ascii?Q?UbSvxJYBYM/07PK0Ic9gAMwykevYIlpukzhm6EtBN/ZiQPyxvTjraK3oO9gl?=
 =?us-ascii?Q?bSw2v0AjUY6Eou5qOs2jYBoqYlIszeodtvXduHBwrewwd9y9hpq+OWESDas7?=
 =?us-ascii?Q?ujtFRmuIrodx4+wubvshzUneB7IIko8mjVD3lDj79mhSKda2/fPTNVQtFd+g?=
 =?us-ascii?Q?ghP5fC6Pvbfz3kJUvveXt0LjAgnHG4NVub290d/CrPhrsFc58Agu2GBcNPm7?=
 =?us-ascii?Q?4jGUTofK0be4sb0+jfVlafOQHyo+PZWXtYXjXrpfj2jSD/NsGFwFKsmIyS6h?=
 =?us-ascii?Q?amwwYRfrezLPXxQg0nKtm+v/HA96lUZkfPgsltE2vZyB2bOYTuVzaj9fMI3i?=
 =?us-ascii?Q?02AujJgy0HLEhWQimat9U/WT7fynVEnem9FmDAMH1CL6to2aBjhx7TRz+rEm?=
 =?us-ascii?Q?P2ls0dPm6Vd/4mIbU2PxHxHbEWqRDNMBnMSlba55JkVhiqLLGCWBt9+R/Ex4?=
 =?us-ascii?Q?oTWZODD1VBg8JH5zSoau6W/mqPSD284kFw4c1TxlfBOBPFDUD08FyCKgOzMh?=
 =?us-ascii?Q?oNCotGuP7HwVnpR+czflhyPbl3VnkeqDrLtyDPKs5FCP/2m+g2iq+Iy9UtR/?=
 =?us-ascii?Q?R7cohSkpsJKqHVdgwk6I06tmRAstMvT20A0jZ69YRqBQuKzwZmAVKrZElmmJ?=
 =?us-ascii?Q?7JmbZEOkIIhpTDobutTKuESNbQlkgi3NmI7mQ7lH7B9dBADyMyfbGqmWQpZL?=
 =?us-ascii?Q?PlZyInWihoCIykxad6J3GlyiWUdjukEd8p2FTbxhnuWhH5yKRADjpEUVbwd+?=
 =?us-ascii?Q?5Ugv9eittrZISKLSSJx3nY73CSGFjpuenHXoBpvqVQq?=
X-Microsoft-Antispam-Message-Info: KbuskpmAyLgQtlxq4fov+Wlf7UzEnMZtKOClyN4QqvDV5pOwOBeVIavnzKQa8yXG5ouj3UpgWXQGi9+2Wngp2brvVzEw6HDn3h7Z0L+S1SzcUFxvzmUDSDTZCeSG6RnGAYtBxQbkrI7kgn+3MBAFohayhggVnEXg6oYCzknSKhWtLzG0/oV6IDlf/W6HBHh+
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;6:4iPRMWCQCsYvA+jTMt5ftqGbA56R//vdfhAww+0Gvahtft4TMNthCA7rFBJA8uAJhaVZvYv/4O1ay6LkkGYKo16C0cJKN/OcjYPpf1VXrWwrFTuvh45SBwcLZfhOTD2K1sh0hWccTTFOu55uQwi+MGhN1rguc/uFuMsCc81jwDrGW4qmexE4EkI0x6P7lxT0XAyYRyB2yOLSJozT9zlMUV8u1NvX/8MSxsN9Kb1LDh37Z23yMRTwlM7b9dPT9B8HoHYS1gPfkJq2Ca/u41RVeNhLmjR8cwn+FQDt4XstGHedwE0BapPMs+iJ1m0hD1VUREaS2YwgmjhJK3kutkAdOiaBMJuabUFWOGby+IVHJCc=;5:O2ILcP+O30GhJxXGAQH9SfpqALpiNE2QZ7ZKFiRS4dztzyOKl/lAIjmyL2jNB7qagsgdKRtQmsTVkbkGdKGv3GDxSdpApyXViLeWMm5XpLszumlSKQK41rGZjU+NDiCUh61azcJ8XBeZgkbl9lszL9zqYrD9WlAE4zC8ovBl748=;24:53nuWdksvf7ntXmj/ADuYBCSdPzv5qTp66c5WUTNeN9IeqpJFunnkWIWLB8HELRFrq3xiTkNrjklOg82xHl20imfNJZlcr/zm3BCaSeKq2o=;7:6naQRTmdNlokTxuU+bJKsPV6NL+avqRKBK14XSrW/QYn7yWyv/jdDZxCco9SGDlF5WeUDpg4XG/H7AS9tVozGKhu1HiB13tz98BiCUr5WKydiyRkoKr5rC+44MW0VBZtmb/NJLQDd9kayK9xOA4E6CD3WcM6dutHQ/Z/GBMDDMoKNQs3GOLBdhnxJEWCElblGvyefVjvlNv13keBhR/dsY7pWaC6wsv5dyKPTqZoPBhmWFlt5BQ8wkQmGUrGmOA7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:NEmkQ1iFoqQz6+dF3RTAdKnT2dByzDpBaYurWsxN2Sw3FQWy7E/X/49cxSMCCT4NmrTEUh6DxScQeqs40Kw2oj5pF4E+egyETmN9DeTwUQS8Lqn1FKHOO6eDrNqv3cv3/uRTDH6O3DOA+JKbahYBS3WzBYn0cbDj+mh5uakvBs0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 19:08:15.9414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8fd5dc-c2b9-4a99-0427-08d58f5f1aa4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1082
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes!

Thank you for review!

I've answered most important questions below.
What about all other stylistic/naming/cosmetic issues, I've no
objections, I'll address them in v2.

> Hi Roman,
> 
> On Tue, Mar 20, 2018 at 10:33:53PM +0000, Roman Gushchin wrote:
> > This patch aims to address an issue in current memory.low semantics,
> > which makes it hard to use it in a hierarchy, where some leaf memory
> > cgroups are more valuable than others.
> > 
> > For example, there are memcgs A, A/B, A/C, A/D and A/E:
> > 
> >   A      A/memory.low = 2G, A/memory.current = 6G
> >  //\\
> > BC  DE   B/memory.low = 3G  B/memory.usage = 2G
> >          C/memory.low = 1G  C/memory.usage = 2G
> >          D/memory.low = 0   D/memory.usage = 2G
> > 	 E/memory.low = 10G E/memory.usage = 0
> > 
> > If we apply memory pressure, B, C and D are reclaimed at
> > the same pace while A's usage exceeds 2G.
> > This is obviously wrong, as B's usage is fully below B's memory.low,
> > and C has 1G of protection as well.
> > Also, A is pushed to the size, which is less than A's 2G memory.low,
> > which is also wrong.
> > 
> > A simple bash script (provided below) can be used to reproduce
> > the problem. Current results are:
> >   A:    1430097920
> >   A/B:  711929856
> >   A/C:  717426688
> >   A/D:  741376
> >   A/E:  0
> 
> Yes, this is a problem. And the behavior with your patch looks much
> preferable over the status quo.
> 
> > To address the issue a concept of effective memory.low is introduced.
> > Effective memory.low is always equal or less than original memory.low.
> > In a case, when there is no memory.low overcommittment (and also for
> > top-level cgroups), these two values are equal.
> > Otherwise it's a part of parent's effective memory.low, calculated as
> > a cgroup's memory.low usage divided by sum of sibling's memory.low
> > usages (under memory.low usage I mean the size of actually protected
> > memory: memory.current if memory.current < memory.low, 0 otherwise).
> 
> This hurts my brain.
> 
> Why is memory.current == memory.low (which should fully protect
> memory.current) a low usage of 0?
> 
> Why is memory.current > memory.low not a low usage of memory.low?
> 
> I.e. shouldn't this be low_usage = min(memory.current, memory.low)?

This is really the non-trivial part.

Let's look at an example:
memcg A   (memory.current = 4G, memory.low = 2G)
memcg A/B (memory.current = 2G, memory.low = 2G)
memcg A/C (memory.current = 2G, memory.low = 1G)

If we'll calculate effective memory.low using your definition
before any reclaim, we end up with the following:
A/B  2G * 2G / (2G + 1G) = 4/3G
A/C  2G * 1G / (2G + 1G) = 2/3G

Looks good, but both cgroups are below their effective limits.
When memory pressure is applied, both are reclaimed at the same pace.
While both B and C are getting smaller and smaller, their weights
and effective low limits are getting closer and closer, but
still below their usages. This ends up when both cgroups will
have size of 1G, which is obviously wrong.

Fundamentally the problem is that memory.low doesn't define
the reclaim speed, just yes or no. So, if there are children cgroups,
some of which are below their memory.low, and some above (as in the example),
it's crucially important to reclaim unprotected memory first.

This is exactly what my code does: as soon as memory.current is larger
than memory.low, we don't treat cgroup's memory as protected at all,
so it doesn't affect effective limits of sibling cgroups.

> 
> > It's necessary to track the actual usage, because otherwise an empty
> > cgroup with memory.low set (A/E in my example) will affect actual
> > memory distribution, which makes no sense.
> 
> Yep, that makes sense.
> 
> > Effective memory.low is always capped by memory.low, set by user.
> > That means it's not possible to become a larger guarantee than
> > memory.low set by a user, even if corresponding part of parent's
> > guarantee is larger. This matches existing semantics.
> 
> That's a complicated sentence for an intuitive concept: yes, we
> wouldn't expect a group's protected usage to exceed its own memory.low
> setting just because the parent's is higher. I'd drop this part.
> 
> > Calculating effective memory.low can be done in the reclaim path,
> > as we conveniently traversing the cgroup tree from top to bottom and
> > check memory.low on each level. So, it's a perfect place to calculate
> > effective memory low and save it to use it for children cgroups.
> > 
> > This also eliminates a need to traverse the cgroup tree from bottom
> > to top each time to check if parent's guarantee is not exceeded.
> > 
> > Setting/resetting effective memory.low is intentionally racy, but
> > it's fine and shouldn't lead to any significant differences in
> > actual memory distribution.
> > 
> > With this patch applied results are matching the expectations:
> >   A:    2146160640
> >   A/B:  1427795968
> >   A/C:  717705216
> >   A/D:  659456
> >   A/E:  0
> 
> Very cool results.
> 
> Below some comments on the implementation.
> 
> > +static void memcg_update_low(struct mem_cgroup *memcg)
> > +{
> > +	unsigned long usage, low_usage, prev_low_usage;
> > +	struct mem_cgroup *parent;
> > +	long delta;
> > +
> > +	do {
> > +		parent = parent_mem_cgroup(memcg);
> > +		if (!parent || mem_cgroup_is_root(parent))
> > +			break;
> > +
> > +		if (!memcg->low && !atomic_long_read(&memcg->low_usage))
> > +			break;
> > +
> > +		usage = page_counter_read(&memcg->memory);
> > +		if (usage < memcg->low)
> > +			low_usage = usage;
> > +		else
> > +			low_usage = 0;
> > +
> > +		prev_low_usage = atomic_long_xchg(&memcg->low_usage, low_usage);
> > +		delta = low_usage - prev_low_usage;
> > +		if (delta == 0)
> > +			break;
> > +
> > +		atomic_long_add(delta, &parent->s_low_usage);
> > +
> > +	} while ((memcg = parent));
> > +}
> 
> This code could use some comments ;)
> 
> Something that explains that we're tracking the combined usage of the
> children and what we're using that information for.
> 
> The conceptual descriptions you have in the changelog should be in the
> code somewher, to give a high level overview of how we're enforcing
> the low settings hierarchically.
> 
> > @@ -1726,6 +1756,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
> >  		page_counter_uncharge(&old->memory, stock->nr_pages);
> >  		if (do_memsw_account())
> >  			page_counter_uncharge(&old->memsw, stock->nr_pages);
> > +		memcg_update_low(old);
> >  		css_put_many(&old->css, stock->nr_pages);
> >  		stock->nr_pages = 0;
> 
> The function is called every time the page counter changes and walks
> up the hierarchy exactly the same. That is a good sign that the low
> usage tracking should really be part of the page counter code itself.

I thought about it, but the problem is that page counters are used for
accounting swap, kmem, tcpmem (for v1), where low limit calculations are
not applicable. I've no idea, how to add them nicely and without excessive
overhead.
Also, good news are that it's possible to avoid any tracking until
a user actually overcommits memory.low guarantees. I plan to implement
this optimization in a separate patch.

> 
> I think you also have to call it when memory.low changes, as that may
> increase or decrease low usage just as much as when usage changes.

Yes, you're right. There will be likely not much difference in practice,
but you're totally correct. Will fix this.

Thank you!
