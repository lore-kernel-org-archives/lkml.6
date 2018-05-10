Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965392AbeEJOEt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:04:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59008 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965325AbeEJOEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:04:45 -0400
Date: Thu, 10 May 2018 15:04:16 +0100
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/2] mm: introduce memory.min
Message-ID: <20180510140410.GA11693@castle.DHCP.thefacebook.com>
References: <20180503114358.7952-1-guro@fb.com>
 <20180510133003.GH5325@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180510133003.GH5325@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:8d39]
X-ClientProxiedBy: AM5P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::11) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:GKzvvdmufUkeRQSK9S0egNfXBzkju0Id4O6GUZbuunarw9/7W36ENaMNK5i6ksbO4guiUgnr9Jt92ZllXXIdG3u8CywsfTCX4R6h8LnB1b1f2omDaoWw8PyUhZ9oLJzPMSIoOPWJqKY7srvgz6d3jxSPsghjTTUBIbkynBvf6jEu+4yMB5CwEHwwQ3NALR4Lntv5rO0P8Ny9x/PeO+jJ00EJt03OH8dm5+I7VTvB/uGtcQQW8w75Erll+dCt9u1w;25:Rbdiv4L7cST8RMXFYDGOcelVLNsY1Nodiw1rx9z4OjnuJCnSpbeJJFv+MuK01HHf45jpVekAIaKRircNbXDSu82B4WsGyhBcDYiJY8gZupQg4UdPDZZqiH2sF+EJyyDhLCzA7X9V9ALF7+mj86tr6UZytPi3aBt9IPX3OMTsILuhfOO04Pa2wPA3UVwejU4nJn/+r7Khmj8SSwq6Agp/V5FoAcuBXMxklhBeXfWBpCNfpsALTnP6UH2uWbI7xpwnXSezByTzEn/fcUpiKCXPqifecsARQttXFMfyRG1T4CdvuaHeI/OGpPFmJXXcOiYHzHNDw5FSqsMftt62ljEqmA==;31:7OFUIZjik6wWkewIjILRxreSrfhuaZELdVq1M1iwjRmBxdr5FGgRnMhfqcSwfKX005gBWj7h9xdqCwTwFH67SgzlD4zIXjobA2CwYwE6QU5be6mjrv6jvHg/MawgjiMzdvbLJ92zNW7i3ykjhQqSUzUUmM+yleOLthc0C3NN2/hYYJtHCLsVLBSlEB2VvwWraP2HjHJybYIaIjuPKKPteVbqqljCxaTVvA5OxTW7EsQ=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:UJ5ioUBqxCI66f3saZuQxMw/njc04sZcnsy1BL3U07VX3j4u/t3mUzWlDyuGOd4mVH8Aey3OsheBlDKHW6pIiUv5fr2Xd27SEhEEcY1mDPRHW2RFCq4llEoQadj1x2OE6yNQhO7Pwkn/zI7UTo6OKAWvxWhUYE0yZHxwYwt0zicocFuwnxAff5av15rNftPld1pmcpyclm9zXN2YoKOr47ZIXOIa8W9KJfkMp445K8Tow9qzSNa468/Lrqd6Qbjgb4uX+aOnwujYxql+EoqMJEaSB0ZhIRTh6q2UmOHmhZ8habcEZvzfK8B1K0/hn4GzqhJF33g9anfpSfdYy3NvNq3L/afWFUcRJ7iVf4GTpz0J/VjYFIMTiWaykgea2m8em0E2Xej/1AZrV3yudC5TX957bJpwrXUdJlFdtgeQeSZ3HxTtFf3yH2fevDTFYTSKOfdA7oPN3wPHKb/InzDqq8rHJxGp/fXFRYcaGcQk3A6ji9uAp+H8MRJFRAnwVHO6;4:5Ij4ov4vTZ4M1tyeHoyedbzQnTZsC/dzYUVx0y8tS9gNlGdVEV6gdreolV6t8M1vlNJWGsjPG3v9Y1GC5Cr/HlawsQSc00oLC2ZjV90cBA4gRxhgOrDisIEgME+y8kYooO3PDrJ2ElvXrlSp8i2O3Wrp0+3QmC6kq6T1VHTILFZ7fedYik8Liasm1Q//RRSvIQ2smfEbP1L2iFd6wsGunHo1tx2iiU1qPuglwr+5Rn2tER4/9vvEkKPmAE0mObHPXYcts9niDbBRrLIYcNlSRA==
X-Microsoft-Antispam-PRVS: <CO1PR15MB107878868E3B3AC63AC77614BE980@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(11905935001)(189003)(199004)(377424004)(6666003)(6916009)(81156014)(8936002)(81166006)(8676002)(5660300001)(476003)(7736002)(305945005)(16526019)(186003)(11346002)(4326008)(446003)(486006)(966005)(478600001)(50466002)(25786009)(1076002)(33656002)(46003)(6116002)(55016002)(53936002)(39060400002)(229853002)(86362001)(316002)(52116002)(6306002)(16586007)(2906002)(58126008)(54906003)(6506007)(68736007)(23726003)(386003)(47776003)(52396003)(7696005)(59450400001)(6246003)(76176011)(9686003)(106356001)(105586002)(97736004)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:ATsYnlJIb4fTD46rtFhdyH/6wCQ6BohL5LlGD6hza?=
 =?us-ascii?Q?3jY8aPlUu6JSkOHN5gSKSNjJVyvl2UCqLbkoO8vBRMBquG9zknytcEtHwyLB?=
 =?us-ascii?Q?L5/RuXXs1NqCZTzX5Zps+62CiiHXZEB2laFCZMoEqvyzzQQ13DwFWMB6Gbq7?=
 =?us-ascii?Q?3SR/3bXtp5d/O/Ja8DSGqbl9tuglAlt5rLch67+jTxEoRW4Xk2aYTbEcdHAw?=
 =?us-ascii?Q?+iIwPHz8kAVzbvCMflfNGALGSaaYUyfSoUWjkSLPwsEe1Tcx9cqXTkIrK/qJ?=
 =?us-ascii?Q?ZSQsSHxXB1U+Gl8a+l7TnfNnZ+uMWGCF6mj4PX2chr4zfGxES9PRg5mV2qT/?=
 =?us-ascii?Q?H0KHI+mP7Vjl9pBkKObiWvR3SuhkXjr4BoxNMUXOsjouSeJEB2an4fdm010t?=
 =?us-ascii?Q?z5RKW8K8JXs68YmdjjdsgPX8w6/Xzib+oH0tUGg2b/uD+WE2exj7CIO5TnpI?=
 =?us-ascii?Q?Jonf0Dr4Am941TGJVc2X2Ykkxr+pRBDDxhXWTGPX53MgJTr1KpJQvWNooKGZ?=
 =?us-ascii?Q?8DgbWDUzqxpDowZHLpS/yZELLeulgHQ/1BbldhwOZ4LjERNeKhVOn0YdmEjR?=
 =?us-ascii?Q?9JVOAfD7JUlIw3bq/opP7Ef/VQ4o8rkLlZWBnIw8PFvOGQIG1p+GPudX6lQX?=
 =?us-ascii?Q?aSsWMfDrOHtWVqALfOXWfvIqMm5m8NTsszBZIBgIxiwoReSLGbmBtMmDvRke?=
 =?us-ascii?Q?B1B7JNmCPgXgTsXMLc1IxN7sOOJbjE8NRIIBB0x4GwatQ8GBX2+mU2BKX63W?=
 =?us-ascii?Q?4zDr/DCStj29FN2CCKEBqt7lbdLnw/l0ShGspOruwnCKHX0zT8SYhWZmpNYa?=
 =?us-ascii?Q?Twn8xJ5Ja4DKkWgwokD8r956t0nu73vfM/w6bWGCsug/kBlSM5hcxJLHmvv1?=
 =?us-ascii?Q?1VMz4sOHEZlMt4ZC12U2K91BsiLwN44LmivLwOan4ZC4wanl0h/gmp8EaLQT?=
 =?us-ascii?Q?pS8wO12WPQsLMh7lfQy3zOoL1QNkUYE1db6cgXCeXwaelf0qs1Hg4mj5P6P5?=
 =?us-ascii?Q?tsPakt/QVM5um+gm+uNa+2DfOO+BqClKxcRpufs6vl8BIR5bpZ3hNF+Tiu/C?=
 =?us-ascii?Q?+aY/cv4djHpxeIvSlSiTz4NKH5JQFUYzQ3NfZCFuYWOxqlgBrHsFY8TeJ2Sz?=
 =?us-ascii?Q?DLv6IqqcvD9lZdfGhwOiGdiQUcAcNUsJLp8GWlUovh4snjLJfxnxtkJAZVwQ?=
 =?us-ascii?Q?6LFShAME1BXO+0kV8+9a0ENfTPkyFlYPQ9hKcVlnft+EWUScwiy3UD3Yfgkf?=
 =?us-ascii?Q?8PU1qSaQPJmaLmAePZj0CrAUavOyWpMbnHj8oOZm+DJ77Uc7EqKI22ER6iho?=
 =?us-ascii?Q?zWtHXMNm3Ci9dOuIHLP/LHf0td467LPhzt4l9Dlt4S7Va8rhDKshlu6rVu++?=
 =?us-ascii?Q?d1CXhaxMpTEF1BobBpIDv5Zmnepj1Zb9Lw2djn6vSsse6dp?=
X-Microsoft-Antispam-Message-Info: cBqh7rDCqEEBLBjaGK+/gAQLXxxlTEI3vdzk1dn1yfjTS6TQksg3CLMXXljwWDm+3NgFPRtcFn5FXG5koFIigNSSlUb8vZyAAeWkDKO51Qnri195nnJOoEVHWUnU76QYqHZNEav2/r33qR24Nf42topX+H37isvcQON8ICEHAsyNgfZ+IS+TL1WcA9sKJEcg
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:z06hkjReKuVIq5KIF2xfuNoAFB2ZEaBQBZziMzFLklNs2iuVgoYboHJp/g05mny2XSCcuLeKxMqgdCTY0IsQAnnrNNDs8cwfqvuSsdXvrgBfpQyjnEHwLTEHLwyQ8b+cLKG7GZ6pg4k+nwPAvc0u+wqoEuK779Ebiti9gOArXRINDWKNRWHKe3ldXRYhsh5+31umCmKQVv8uidio43FMMoJzFL7ISbDVRUwvrJ+e1q3nxufGDdNy7eB2RM6MmczDrxW2zlv23NeR4Ebt90YZYSZblTXBhqwQ4G516NKC1Nx8mFyhYA5xyw4kLZDcHE1DV4g5Jlj9ewXjHNq/X/29GxUzIdSZL/JbajL8aU4gd7dkRLvazhg7O5txszvt603QPAKU4j2KYiz47l9/za8ZHAR6QHkiF/BkgisMcIp+WCj/qqqjuSkfTftTG4Vn5kt1ICS7jYVC1TnFCGxzKlKo+w==;5:Gt3DOthIYDVB3HsCgKSzH2jfKbiYRYaU4bQFhMVSr+9QzZjMJ588nwXG4cwgTjGLrV7ny8oX3LfQJop+UTIR9dX4+CrZyii/urJN5lO3hRswJynPJRX+1mq8ZZoXadrZpyfw864N1cyR46DB8sHWsAmw9jbBX3D14er7hdYZphM=;24:/hY/TjZWdi55MYQGosESWlogeDn27uDttUPfnHge7l+gz1IR7wxEFucF2ttp8+2EgfK8qQDszNX92hvN4+/1Y9EYzFPtpPKZL5ri1g4YKO8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:CxNht6AZRew0a3+zHKv7y4v43S6UGKR+IQNfBUgxM5jVqjK+kAMrSkBucwDiGldv7fq13tonECx1wcgbmP+oUi69k/Ris/SvuOfssuoaJ7LqF6Yl+roK9fgZjn08HSeYkk4I8A4sIma4E8OXugOkgyalhdUvd5scnfkGyNQL6Uq1dfaNDbrANeVJzFd+xBYCQVikFOnR4z7j/AYEbzi265cxtLonBOgsNEQtDLL4AsxbqP17yD12KEtimyOv362n;20:+cLkZcl5/RLVJk7/iBFxYUKls5qdI/Ft3hZ1ZzNYGdDAehl0LO6phCLwlnev3cNI05CIGj/sw4m8CeAr7R2Q9pxpDSaWGCsfxOo8ImT4ZogfHEEuwYQsYvt0e+3yyWpRkhZLEfwvEjdzzZ6zydTdpVv7nMhkSShiPrEIN5vIwlk=
X-MS-Office365-Filtering-Correlation-Id: 8b399aec-c3d2-4325-ff60-08d5b67ef2c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 14:04:28.2833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b399aec-c3d2-4325-ff60-08d5b67ef2c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 03:30:03PM +0200, Michal Hocko wrote:
> On Thu 03-05-18 12:43:57, Roman Gushchin wrote:
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
> 
> Originally I was pushing for the hard guarantee before we landed with
> the best effort one. The assumption back then was that properly
> configured systems shouldn't see problems IIRC.

Personally, I'm also not a big fan of the current memory.low semantics.
If you remember, my very version of memory guarantee (back to 2013)
implemented a hard approach: https://lwn.net/Articles/540240/

> 
> It is not entirely clear to me what is the role of the low limit wrt.
> leaking application from the above description TBH. I presume you have a
> process without any low&hard limit which leaks and basically breaks the
> low limit expectation because of the lack of reclaimable memory and our
> memcg_low_reclaim fallback.
> 
> If that is the case then the hard limit should indeed protect the
> respective memcg from reclaim. But what is the actuall guarantee?
> We can reclaim that memory by the OOM killer, because there is no
> protection from killing a memcg under the min limit. So what is the
> actual semantic?

If memcg memory usage is under its effective min boundary, its memory
won't be reclaimed.

Making OOM killer aware of memory guarantees is a separate topic
(and definitely a good idea to discuss!), but let's agree on
a simple fact that there are many workloads which prefer
to be killed, rather than suffer from a too high memory pressure.

> 
> Also how is an admin supposed to configure those limits? low limit
> doesn't reall protect in some cases so why should it be used at all?
> I see how min matches max and low matches high, so there is a nice
> symmetry but aren't we adding additional complexity to the API?
> Isn't the real problem that the other guy (leaking application) doesn't
> have any cap?

My main point is that memory.low requires an userspace agent
to actually guarantee something. This agent supposed to track
low memory events and somehow decrease memory pressure,
if memory.low watermark is reached (stop some workloads, for example).
This is not always handy, and having strong guarantee makes sense, IMO.

We're experimenting with different setups, and the current approach
is to set memory.min to the minimal value which guarantees normal
functioning of a workload, while memory.low can be set to a much higher
value, which sometimes brings some performance gains.

Thanks!
