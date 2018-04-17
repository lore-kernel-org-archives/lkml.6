Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeDQLHX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:07:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35098 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751345AbeDQLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:07:20 -0400
Date: Tue, 17 Apr 2018 12:06:49 +0100
From: Roman Gushchin <guro@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Shaohua Li <shli@fb.com>,
        Rik van Riel <riel@surriel.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: allow to decrease swap.max below actual swap usage
Message-ID: <20180417110643.GA28901@castle.DHCP.thefacebook.com>
References: <20180412132705.30316-1-guro@fb.com>
 <20180416013902.GD1911913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180416013902.GD1911913@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:b7d9]
X-ClientProxiedBy: HE1PR0701CA0045.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::13) To SN2PR15MB1087.namprd15.prod.outlook.com
 (2603:10b6:804:22::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1087;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;3:x3gF/ZO8D8nxZeke7oH3BA3VxzjhNwmjZ4MElKYmPjpVpnGN7EZ5x4nhKbzwQ2dzk7y1ppTPfJch9DULmG5MezfxlLtOj20e1t/wWvDDdZ9XBoIJyrBkIvZfECnQioOEvZ8zN3w32CYntUMdBCILwnlvqHYDlFcVuP5jue+k7XOs6pIjadC5FgUCQYe+23+ipySNXPcWqYHHQoaE3C1+0gMUDo6McFI0/mXcc8M+EDKMj/wfMFAXl6gnQWmjNGdv;25:yNi97klgCoE/Bo1m0pW7IOAj11jvshLc+AcmNOWMrDk+vyLQgN71y/yBIMJwZy0OlVLo3ehlBPBD/s9dsE6jHfH7d8hulJhyYm30Mbs1YS2HcO9w6YxIcRtC5K2wo2Kq2C9nnUPcMi1t49PJltTjYFcLsnL+mpooy0CtmkA03a64j9UytLaXX8NwmRQjJ7c9qEOjXWrweeNGgXFJf4tCzQi3fGVm8bq/2GAxDyVGZ/22IZQCzw2qkZx+hMKPbL/3b8W2af1ESXbFeWlQOJ0bNv3bDbGeD8UT/EBFgW6iW8vP0iwPKQQ6YMCznWAvyBbfsFHluoWkaL0s3tfjB92/JA==;31:R+N94gI3bq78fW+vI7ZedtdcoZpQpSvVsLnVNndSqmry2FTbVwXk21TIj9HNuFDXU+m1rWe/GHgSAKf6RzxCAICx+V/BhttUz+1bOG2Qmcvcwi3sWEx9gZwWw8x4lxa4zsCE7lTTBvJNgvM+31bl71+ZQFmfrdkTPD3oFtN6N2bwNbDpyFsnFnq0n9Kv/onKwnH4dSwy4BSXH0NuPR8ynYli4zjGeLhdUVYbTmDdIeY=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1087:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:sC0hCspRoWcmPQhLX9avT2Crw4FRJr1QGw7ZRG+ujZLeTKRZM2XT73yl7lzsHxaYkon7UL42oyx3rd1lF2xP3Q7k9mJ5oSZge2FYsNJ1b2r/awPJn2ktBpXlhzMCsBCbCjYPX4opOmsKUk7VkTVf0FemsUh4om553W4IYl/spb9kfRBvHBPrszOntYdepHy4gPzkXlAmSGwljJCAJnB8O7GFlxwlUzuPeM9pWDztCekeNeXUtQdcX4blyPxMbcRggYxwV60NYFDEK2wVwMDKUyxDcVaJ4I+rAm2vrA1Mc0WCWlle4ETnS/Q5Q4Gb0S4fkejzFgLgN9Aj0zLAz6mUNoEadOu4ZblSmETpDIGJ5401MqBA+W/6HYJsq/Ow+kMPcJQ5/H15kUuqr+a9lzyibMh7DSGvBVUf8PXuHQER9b002Me5x2vVlyVBbCjFYwylmfu3ELkMJvDw88NTAwalAYnf4qoOv94dH+81UoTPRUdVT1vht4d7LQTWQ/2at0uG;4:uPMwk3N4jwp+yA8qIR8sQaAueo3/5HfG+jcmSfpfdkdc2dUnvrH2e1AYaA3lhmDTZa9bMGW8gY7wb+oeqJewwXRfaB/WZBFgfC6CdLbhJ0OHFZK1w/roq7rCcJkiUiCGriJoXKPMNGsUTTW50e752+1Ai0TaIUQ9cOpxbzp7PLi30Aw7TLyO3LG5er9nrMmKEcwiIWcyOIWPd1gmC+njnvYT6IZT5zTbwUKCv0hMK6Ui+ZddUh7Wrll4QNshboqCdTtWg4xZj7mofwbe1YEqDpCPFhxVJkBD2lo/qQ6K7wsi8AcjwXZjfWOoI3sx0rdqdttEjtny0Q8SrNCxb8gWqH9or+9+lA8S7qnTleiWzvk=
X-Microsoft-Antispam-PRVS: <SN2PR15MB1087EA27E7CF3A5EE92BBE10BEB70@SN2PR15MB1087.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(11241501184)(944501359)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR15MB1087;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1087;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(52314003)(189003)(199004)(486006)(86362001)(446003)(11346002)(9686003)(106356001)(478600001)(4326008)(46003)(50466002)(5660300001)(16526019)(305945005)(55016002)(53936002)(33656002)(229853002)(7736002)(186003)(6506007)(476003)(59450400001)(386003)(76176011)(52396003)(52116002)(6916009)(7696005)(6246003)(6666003)(8676002)(47776003)(105586002)(54906003)(2906002)(25786009)(81166006)(81156014)(68736007)(97736004)(316002)(1076002)(58126008)(23726003)(6116002)(16586007)(8936002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1087;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1087;23:yuV1iDC5Luf8kuhFV38wJWmcn8PfPGmL9Gdn/Ezd2?=
 =?us-ascii?Q?aZo/wNCACK/PZy652eIddBjvS+0KGaQNUC1HwxLHGOqiJS2a/YfrnFHojENs?=
 =?us-ascii?Q?VZyX1XFZ13ec0+q1gT6f+1Q7Yc3H/dMgNNR50S6KfBEUAEmCG5GyhtSaH7U4?=
 =?us-ascii?Q?6sXdQx1NO4QyAYJ2kdZqYpCunfwAA8PJ08fJDZ5nkK7sFcPi9IrGAIIl3LA7?=
 =?us-ascii?Q?5TA/KCALLEdZcpxGeifZsLcx1zQIHBywHGH1IS6HB5PTcUep2lAG3C4oN4zB?=
 =?us-ascii?Q?oQOh2fymwKXt2Fk8mPNvuGJI7eKdyIkvR1jyaSYvwuBjVBl4zAVJFu5zXwVh?=
 =?us-ascii?Q?x7DnbjpviC5RR/orvO5nwtgqEEf4X5B+UqxXcDlmmJbpPzRdQQt4rIVlJzZR?=
 =?us-ascii?Q?alMZIW8zhO1RTTl441+sv6TjMM71bvWDjdbXxt2o8yzrP/AaKg7Ocbo4DA/7?=
 =?us-ascii?Q?VK+oIra48tvfFynp7vk8a/KgEafElKL3MVGZlnHst2IPddwsmV3ZRc3Ql+gu?=
 =?us-ascii?Q?+9OgrSD0kXJg5Q9cPptMjEk5sMUIc9F7pJF/q95YrB6My055XgyoQcrncHdm?=
 =?us-ascii?Q?/xCQTSO/4c8EWZ6BOUK9dMJ248oOANxw1EA4g5rGIaskxlJWvwHqQqz5ySF0?=
 =?us-ascii?Q?h25V1P3BRGK7iGv8W7x75K3untCBUxhRk1BV6ypcldHvwZ9lmJ0y4XVhglNL?=
 =?us-ascii?Q?Ef+25mkb1kmK4TFzHkBtXzDAGxmzcg0oHlE1p4r47lqrCCEyqcTpXR4Bn8fD?=
 =?us-ascii?Q?G2k7mUdulLB4RMt4Ago3xa2SZ5Nkfo4Mf2sJkHXdNadSAgEBu/RlcayW88op?=
 =?us-ascii?Q?Z6lGVTKwV6h4RNhZ1AilPCWMbt3C9CxCZuHvFEbfqQoT7VBCW126V2QqiMTb?=
 =?us-ascii?Q?c7OBKJgNMCJlABg47RfcVwgtl4BgGzexwbUZhTrZ/WIvPXwKrH9Yv49G7pKx?=
 =?us-ascii?Q?mZeiz7475q/9+9/sj7MemSzQW8UqxFXR1RnW467wmNSazODQG2zVsoCC+WMW?=
 =?us-ascii?Q?aYsHeV8e5JDuGWD/5jg3ErxJ6zLEskEwOf398iP4K4TkSoJHmpEtZ6PZW1rK?=
 =?us-ascii?Q?vgLmvJj7/lmycudx5HpPCMZda5P1OUVW+0OxxW1qg+PtDmfFLjQoq5DIUi4G?=
 =?us-ascii?Q?3tRn1GaOjvmGB7S70xRSc7a4Bh8HSaQERd7MPzQ9AnbPtC+WRnyVCRgf7kIC?=
 =?us-ascii?Q?0ntlaIh0DWEW16YeTZG8WPZlCYhfv1G5M85gWR+QWsl45E3CYjzLWMB9g7ze?=
 =?us-ascii?Q?wVEXAEKcGSbrbmnI3AgftX+FyCVSgogjKCNAMd3XaUwetD/eXEBA2PZ5p/qH?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 1b0nIRqXy977+LojxZWguNxTzA9Ya8cJx5UmONN5r1kWhrcYBjNk2fMXqEZeq3MBhl4d7bbw+cNd71p0xNYsuaBp3GIXtTx+542h9J99C4L9DZZHquTM4vCxolul1lZ1xgW/NJB+TVWAas5YbyN1+sblbG5kl+aY92DDFm4fxTwigqXs/Me7tFlxO4bNykay
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;6:KAQ8gxxZ8NB28nSjoVETiuq/fskKfZU5HDWdsQ3TQoscXj5S2F9OvvcapFFt89UIFiq2Ue+HseZFbyCAsJ5Gs2ToT5u+DkBz5M7/x0s1O2OmlCBmi9/GOcDaZ/cxcQ512Lo5Em0I0YBBvqjopesMd0lTdkeTq7SDzR2hjFVJ1rlCSeHiu4BMNgpWAYfp62q0r3/goaB9VveB6hsILHLoBbk138VvR+nWMihx8ymOvbIVFIPq6IIOZBH8sXtNqHhNFcS3EIP9d+KTfW87gfwc6rAAVTWpMKujZgoH5gtQlLsv43EPSi3AcEWP4VV6to1aYocnkVJn2s5I30X7j1AhdipDEDHpHXA52S3Yv2gExpxvpzESHmZDIeodi3xyqWBn9wkecrPdqM1P8zo0/xZKcBbgZQPdRASYux+e94QXPYfGr6DmDQMy3DtVlOp2z+6g75+815MQB5jrq8Shx4o7aw==;5:fmbvhxfjTBhTRJORkVdOY+6m91rowusgOo00HsVYS6759yosfWd82lZEcCR8ZzH14O6dAvdgFgS2TsR/5u/uEpCfuu0fzD7jeoUx5Ezb9H7fXf1gktQr8FdCaUc4YePWZoUoA36lEIoDO5cnpAleVep/HLpWGz8/Yr4FIRmMc4c=;24:/f8S3PcQ1uYuOkORXHBZmkWlvjhIZQp3Qz50PVGqMaowzMG9NjtRYqiHUNJBO+8M2i3cwtA/130ayVAuInMQe6MEQKVZn6TD/eeL+YfDhBk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;7:eVcbYaW9bqXTGQUQKbfSZGeIZLOV1Ynj9VpawRoxF9/FYXwJKHlg87b6cAl+GilCr1TQGpmEK/2FoGhZfwNQbEU34bs7u0RVLHd+Vef46upb5GZIgopsLoTXNp8kqYDn5efvuAiJxuOUhfZ1O3sWpnSa44YjLP7MK54veRALWWUrqCtN8q6qFnBX6lTdZw0M/dsnkVpvt41POjb6+taxkMdENOeW8iVGxQg4BZEQrsDQg25boeu7LOFamkq5BeDq;20:hw7YAE9+lsJptnAarpTHLB+AWnovCaAjKl9w+J+oEkniMm2o6R90LSsOkR4aQQVEfTFDHfbcWvAuTyckOsePDgxr8807z2gAncsLoXzdovrcrdAdUqyRSHksN/ZCYr4mMEd0he6H7N5MWGxK7FajqIReTF6SmP54C5D8xhfOSVs=
X-MS-Office365-Filtering-Correlation-Id: fbf98222-ba1b-4f7b-6ce3-08d5a45359a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 11:07:01.5462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf98222-ba1b-4f7b-6ce3-08d5a45359a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tejun!

On Sun, Apr 15, 2018 at 06:39:02PM -0700, Tejun Heo wrote:
> Hello, Roman.
> 
> The reclaim behavior is a bit worrisome.
> 
> * It disables an entire swap area while reclaim is in progress.  Most
>   systems only have one swap area, so this would disable allocating
>   new swap area for everyone.
> 
> * The reclaim seems very inefficient.  IIUC, it has to read every swap
>   page to see whether the page belongs to the target memcg and for
>   each matching page, which involves walking page mm's and page
>   tables.
> 
> An easy optimization would be walking swap_cgroup_ctrl so that it only
> reads swap entries which belong to the target cgroup and avoid
> disabling swap for others, but looking at the code, I wonder whether
> we need active reclaim at all.
> 
> Swap already tries to aggressively reclaim swap entries when swap
> usage > 50% of the limit, so simply reducing the limit already
> triggers aggressive reclaim, and given that it's swap, just waiting it
> out could be the better behavior anyway, so how about something like
> the following?
> 
> ------ 8< ------
> From: Tejun Heo <tj@kernel.org>
> Subject: mm: memcg: allow lowering memory.swap.max below the current usage
> 
> Currently an attempt to set swap.max into a value lower than the
> actual swap usage fails, which causes configuration problems as
> there's no way of lowering the configuration below the current usage
> short of turning off swap entirely.  This makes swap.max difficult to
> use and allows delegatees to lock the delegator out of reducing swap
> allocation.
> 
> This patch updates swap_max_write() so that the limit can be lowered
> below the current usage.  It doesn't implement active reclaiming of
> swap entries for the following reasons.

This is definitely better than existing state of things, and it's also safe.

I assume, that active swap reclaim can be useful in some cases,
but we can return to this question later.

Acked-by: Roman Gushchin <guro@fb.com>

> 
> * mem_cgroup_swap_full() already tells the swap machinary to
>   aggressively reclaim swap entries if the usage is above 50% of
>   limit, so simply lowering the limit automatically triggers gradual
>   reclaim.
> 
> * Forcing back swapped out pages is likely to heavily impact the
>   workload and mess up the working set.  Given that swap usually is a
>   lot less valuable and less scarce, letting the existing usage
>   dissipate over time through the above gradual reclaim and as they're
>   falted back in is likely the better behavior.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shaohua Li <shli@fb.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> ---
>  Documentation/cgroup-v2.txt |    5 +++++
>  mm/memcontrol.c             |    6 +-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -1199,6 +1199,11 @@ PAGE_SIZE multiple when read back.
>  	Swap usage hard limit.  If a cgroup's swap usage reaches this
>  	limit, anonymous memory of the cgroup will not be swapped out.
>  
> +	When reduced under the current usage, the existing swap
> +	entries are reclaimed gradually and the swap usage may stay
> +	higher than the limit for an extended period of time.  This
> +	reduces the impact on the workload and memory management.

I would probably drop the last sentence: it looks like an excuse
for the defined semantics; but it's totally fine.

Thanks!
