Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbeBBSIA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:08:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54362 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753211AbeBBSHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:07:39 -0500
Date: Fri, 2 Feb 2018 18:06:32 +0000
From: Roman Gushchin <guro@fb.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
CC: Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH net] Revert "defer call to mem_cgroup_sk_alloc()"
Message-ID: <20180202180624.GA11596@castle.DHCP.thefacebook.com>
References: <20180202165754.8551-1-guro@fb.com>
 <1517594367.3715.130.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1517594367.3715.130.camel@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:200::1:e938]
X-ClientProxiedBy: AM4PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:205:1::40) To DM3PR15MB1082.namprd15.prod.outlook.com
 (2603:10b6:0:12::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c57d4baf-1cbd-4c57-9b9d-08d56a67b936
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM3PR15MB1082;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;3:6UCCYr5PCo6nuAQOTyfte2UigrqU5FDpKaIMHjq/tB0SbsMfycDAMQzxmuWCamr2Kzd5P//E9thcoyMdRdWBH5zpopPYDPzG7l/DplHSu4qXZDg6m+bYtzhV2nAFsgMIU7oNuuM4L+nqQtwcE9x7Tuie7UECPyiqAJk5nXfRnXChPpP6eMuUnoxmZsk21Ok2n9ciM2qrDwqxyXa0NljZjxM2R6pHUNhebt1gjFsYWRDADr0eCqgic2UYPEpxAIgQ;25:YWsmg2LDuXmPGBIjPnZ2wIGNEmuT1bN+DFil3Bgeh4hBvrEZH0OkYZen6kLxUrxOf1aBcuwZBHDITFapWhjn88+terGdlfX3pPaFdt0xFcYxko281KuUnZKJNUUM4t37vp/GazyByHZbJ4d+tgUjZoxORbeXDJvRaM2euvI9rfImlcZuKS3P/Dsw8ScZYkOjIAGq+p5e1SptJXa6Mq/jhF2bPQ1IbwrVDOHlupzCW5yWBC9xJy5Lt+AKJB11hoZLvUoZN0DkQT6JT1aBJke5K4iCAlGlnOhL2RPJkAM9aDq88gNVqgzR6WbtOKHSaGIc63LMtQeEwC7tOEkEccLIaA==;31:k8nrCmE2lpotTm53RpT1joCndexq7vT5GFv8LzJgK84McHAAccPvI0+5xcVa3Z8rSsZQROk1QJOVvAWTOmFF8/2vj9bEpViqvlWINoqUxY3OHkBjRSZjr392cRnY2DOSTjwoAJ6Qmy9G8+utAexiFBVvoc07XqwsYOpaWDwU8kYIpZAANlYg2GcbjdxGC2VRpa3AnWefa5zoCCPPvaiMV4ql1GiK2BjiQz+FTe7ReRw=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1082:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:mV6y7S+4UJHujE5JEqW/bcQPGhdq06NDRYU4ImDyMhlfB8vnK3M8RT9EEaAxplOCmNA6SNS5rHpZH+prWaLTXHQl6Ga9BvpMckz80rPuJZ6ZUPvBmlYjHYq3STQhr/AiSFyhTvbb5msHA5c2wLp65i36LIT02XiesW6baWwEMOsquCB6aGy2ccXi/IRe1rgcUB6//lHEI9SpPILFKKm/wHHUpGwD/pyiuaBNY+HYPT1bHf2y8LhgGyui279G43KfzoqlOpLXoJK/cjOXsNF3tS+1m8nrvklJZx9AW7VEAYKpOOG4P119s9Wn3ufoGC2r/aaq8UZnUOrvkoFBrwC/4AK5nxwXe4irQM9DbvpjJ3Qq09FCrQ/gePrLk/+kiHdOO4bbTkXDhACarudxcZbNBv00DcKiOhbA9eyW02HuZ3HXw8oXHBp4+CrnNZgNIGAYOyqB+jeiOJSJfTJBuEzeaRj2C/a1UzoPwnBSNVGmTFG6cwvAHN+HbiaMr6rc0RPd;4:pryrtvZAtbKO2QAFjQFUgFSzj4/BHrPxiIIyMhOHEzeRB2vBb2f67xoqSoJWSuoR4PnX2mJqvDJk9OIabEPx2qINOQhcg/3wwM9Pg2VWNmluZSTlXLQyLQ5ZVVGO06+HmXnKjpAAtJrDHYQLxiI+43xnvokfKWYQ2WgXqgNy6gusCe+Ok/ji9kWGO3gB00mqK3vdplaC0KkGvQ3H4mntlMVhETshwbN+tjkRxOZqzgn5l1mF16i6YMsFe15zOFZCmihvIn/B5AKeE4UHtc2sqe7WKOvoZzi05rDumyCJM2jn/SJR3vSR1HXI5wngcNefVQ54eTmTdJANEoc6fAVG44FLJAwVHwl7Uf/r9KEiDDcHO4R2Xqp/9/XmmDOArmPn
X-Microsoft-Antispam-PRVS: <DM3PR15MB1082585475648DA2679D841DBEF90@DM3PR15MB1082.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(11241501184)(2400082)(944501161)(93006095)(93001095)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM3PR15MB1082;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1082;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(376002)(366004)(377424004)(189003)(199004)(7736002)(86362001)(386003)(16586007)(76176011)(59450400001)(6506007)(6916009)(2950100002)(52396003)(25786009)(6666003)(316002)(5660300001)(4326008)(186003)(8676002)(106356001)(81156014)(81166006)(7696005)(52116002)(97736004)(33656002)(55016002)(53936002)(9686003)(8936002)(6116002)(50466002)(1076002)(23726003)(39060400002)(305945005)(16526019)(58126008)(54906003)(47776003)(478600001)(2906002)(229853002)(6246003)(83506002)(68736007)(105586002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1082;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1082;23:scL5Y0diOLE7TrKIq6Disr6K6ubxzxrQbOi09MuLa?=
 =?us-ascii?Q?o269Mwk3kMRNY82Ip00D5GWMMwhsBO/zE5VudFNveXLHxhyslHsny7AG2erO?=
 =?us-ascii?Q?UZWRssZeZda/mCYCSCVJrlW2sJGf1r9v63mLcHF6n4crFhYUdpvTvNeXMHYv?=
 =?us-ascii?Q?ICXdrWLhJPhACF4rqekFu61yA4uAxkQ57XbMQQVHK4wT/eEA9kaFXPkzHimG?=
 =?us-ascii?Q?nCTMluHbgbIC0HJERdfnZRLtK9yEJeIhLHgXuE+Pcmm7RcnjDMnCu4N8yRvX?=
 =?us-ascii?Q?Q5ERanXOJw99Bh+Gx7Mz6VUfNHOcatljyd5RX8TVeqh8UfmVWQclcz0JFcW1?=
 =?us-ascii?Q?Z0rxn0TgOwN2h7d6D7KVcLloDhrlQo6sD6IZ1BKUQJqFyk+91WAYKLKyQ1Id?=
 =?us-ascii?Q?q9eJ4/tXHFNsD9Di3eYK6fh2APDRd2tIkJroXOEfqtILpLH2gD86STd6K4+y?=
 =?us-ascii?Q?DSMaJXfz+tMTlaARL4lpfJIpGbxCiat+h2MiXfYXy7zNZnVnIlniElrrI6uN?=
 =?us-ascii?Q?6Ob9w7PFgJI+3qvYxjY60n0StWmfCZsmuHy1u30K0N8FBzcz3hzXXeT/p2iX?=
 =?us-ascii?Q?poQtJOT5/58wvZcdITelhJBC7Msj4Qd6e55Cy13HVxcZ9c8hAT9oSY3WKudn?=
 =?us-ascii?Q?XyT/GcX42ZTzJdQFXu77gOhGpvKHyWz8S8HXSZ0ZaOTjXcdPIPLnSsEJvYDl?=
 =?us-ascii?Q?NRhpHZf8bVPi03mOvEOxW0Ff484RHmRe66Ww6NcO8TBaY0qdjR3FFCS+FJxA?=
 =?us-ascii?Q?l/RLJWDdy4X+NcnvYDtc1yD2t/+92Ev6JesjyPHtpQpRmH49MSQIti6xCPf3?=
 =?us-ascii?Q?tBUBm2yRSxnJ5+Ahx3k9K+tsBoC73Rd6jcvp1hIGbfWAS6YrbUSmgs0pOf0t?=
 =?us-ascii?Q?oUqNeFspggiqFIHs4ft7+x9iukan+PhH1xmKABLQ+NrkOWYzAEueIKaVBmKz?=
 =?us-ascii?Q?ZuVpUvwG4lcfmyfrdqlMZUtoQlNL87vgb+9Jbap369Y72SeHj8Z39mTdsLSE?=
 =?us-ascii?Q?uwWrzYFz/QtsEpm4t78VaRJ0VqMpnfYnT4LGMf76Pl07Fw4RFg36EdOQOof4?=
 =?us-ascii?Q?46502W+rn4/ICQeX/o2BKCt2Gv2JtszzDjCh220TCRLBuR3GwGyg6+5Dbnl5?=
 =?us-ascii?Q?eLNwkHKeMyCcBxnwgvHnKvsJ2k6UCMM655ISDRZOrdsZ3fh8UH4kizXRMoOO?=
 =?us-ascii?Q?qfPVBBLS98aC5p9cb1JbvoErS74CS7eLr897TudO8OCXoB78C1jbfzZP38gk?=
 =?us-ascii?Q?FlCdK/8dX3CUxri9XO51IGVURFW82CovxoaiewvC6sc9YUXda6KQXpDN42IA?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;6:L08Dto3yChSVKg/IwDeM0euSOUKpWLcKvMlLN6KYNf6YIWdDsgn+o7MtBNN0RrUpgiqKn0RB52mzXIwG2vDTbcCfAqSFeB12ZK7QVFrchY/za2zEz4+SPkmT10JI/04leBfphAHoKyp54G5V1GCfj4U30xoZdOtsWGF9ylVHuoGwLg4x5edy1IfZY8mIg8D7NFA3NeVVihYsMoJpuXkmHbnwWY62INd/6VNZ6ojOb/9cFA5P2/LIt9X6j/+W2w/PPilMQTze+bXKRolpLt03xUy8nCJurvkyy+IuNRRqeuhocCelggXfq3NDaOnqmMYb+n8zHPVQiXwq84kZ2NUzwzy9qfDzu04zE9thi3jSU/A=;5:ckOzotaV1pcpggTNZptYvv8zfc3KrR8pPHnCacZlifTUCp9lXP4O8D66lLMYxFyoZRuSZZOzfQg7f3zJvUSUpyar7q++awcgsrYi8+4ejnkm+yAltB3orLtdRmol2ll6nHvAqSHzOL4kdNpE1swsv55yjXRaiWpLoZu2y2/odXY=;24:BEeInDCQNyAYbU8zGFuaEi9PagUvAZ9X7ebQafGTe5yskHRfqBz0iLUyoRylMafzVu/X8hw1CAE9WLlzh4I9sTXXGE8PwnLhIRC8cjDPKjs=;7:olf1B7i9/7mHF1NJG45Xt/zA4S760c5GIqntkDec/KvE9Bh2FVolx28IyNLyjyA7C45uPifZ1kXfVD0oyBlYLbnu20obmEQEtjK2ISOOWkwN1+sEiYwj1QZx7B8kIAbIO2/PfhhJwiZ6LbmpC77OdLQYz8mLyEi3LfEDQZIJr2ZCi5c4FkgPggMoH+Lb8s2c7FOCuCogFMZcBIhn8GfFZURJAt4FBD/L42FeZEA9IrqW/EM3qCtjtovJp/cu8py8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:REN6BwJbaVydHf9TvCnt0+TTMFy+fWVYyYx76ArpUh7t7Fi3LPM9H9Or/iSJRyJNVAGILOtMpJtyVMjyxalpoixt52M7x62oWSYC7kqOGtQATbd90UpmogWRs+lCfXcvTiXdAZwAZsJlOvTgNNvDVXLcWhD/4SYSk16CGdhgPhw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 18:06:44.8863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57d4baf-1cbd-4c57-9b9d-08d56a67b936
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1082
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 09:59:27AM -0800, Eric Dumazet wrote:
> On Fri, 2018-02-02 at 16:57 +0000, Roman Gushchin wrote:
> > This patch effectively reverts commit 9f1c2674b328 ("net: memcontrol:
> > defer call to mem_cgroup_sk_alloc()").
> > 
> > Moving mem_cgroup_sk_alloc() to the inet_csk_accept() completely breaks
> > memcg socket memory accounting, as packets received before memcg
> > pointer initialization are not accounted and are causing refcounting
> > underflow on socket release.
> > 
> > Actually the free-after-use problem was fixed by
> > commit c0576e397508 ("net: call cgroup_sk_alloc() earlier in
> > sk_clone_lock()") for the cgroup pointer.
> > 
> > So, let's revert it and call mem_cgroup_sk_alloc() just before
> > cgroup_sk_alloc(). This is safe, as we hold a reference to the socket
> > we're cloning, and it holds a reference to the memcg.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > ---
> >  mm/memcontrol.c                 | 14 ++++++++++++++
> >  net/core/sock.c                 |  5 +----
> >  net/ipv4/inet_connection_sock.c |  1 -
> >  3 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 0ae2dc3a1748..0937f2c52c7d 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5747,6 +5747,20 @@ void mem_cgroup_sk_alloc(struct sock *sk)
> >  	if (!mem_cgroup_sockets_enabled)
> >  		return;
> >  
> > +	/*
> > +	 * Socket cloning can throw us here with sk_memcg already
> > +	 * filled. It won't however, necessarily happen from
> > +	 * process context. So the test for root memcg given
> > +	 * the current task's memcg won't help us in this case.
> > +	 *
> > +	 * Respecting the original socket's memcg is a better
> > +	 * decision in this case.
> > +	 */
> > +	if (sk->sk_memcg) {
> 
> Original commit had a BUG_ON(mem_cgroup_is_root(sk->sk_memcg));
> 
> I presume it is no longer useful ?

Idk, how even we can hit it? And if so, what scary will happen?

If you prefer to have it there, I definitely can return it,
but I see no profit so far.

Thanks!
