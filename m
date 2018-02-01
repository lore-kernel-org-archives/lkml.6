Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeBAXnY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:43:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751629AbeBAXnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:43:12 -0500
Date: Thu, 1 Feb 2018 23:42:33 +0000
From: Roman Gushchin <guro@fb.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH net] net: memcontrol: charge allocated memory after
 mem_cgroup_sk_alloc()
Message-ID: <20180201234226.GA14400@castle>
References: <20180125001911.15597-1-guro@fb.com>
 <20180125.120302.1117695034222616751.davem@davemloft.net>
 <20180131215401.GA8956@castle>
 <20180201.101655.1316424669256047119.davem@davemloft.net>
 <20180201202158.GA11477@castle.DHCP.thefacebook.com>
 <CANn89iLBOUZNxNqrECvZ7ktX8uu0j3REiZaqTwr=SP-U=vAPpQ@mail.gmail.com>
 <20180201225542.GA13072@castle>
 <CANn89i+mTRsYDikt9VhfbdHo1f5F5tXbZj54679nY_Fy1QS1Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANn89i+mTRsYDikt9VhfbdHo1f5F5tXbZj54679nY_Fy1QS1Vg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:180::1:8ad2]
X-ClientProxiedBy: HE1PR0202CA0038.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::24) To SN2PR15MB1088.namprd15.prod.outlook.com
 (2603:10b6:804:22::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b09be9b-2150-4c3c-5bc2-08d569cd7fcf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN2PR15MB1088;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;3:SIfkwmlFCqW+mNh6gVfi1IaaXfDBju00k+ebU1LraQxV5GnaL2kyy0ZgoJ0FFwcfPelkbllX0AbD8jwxlfZWvLI6FDuSd4C28vlfGMtvB70sXBZan7cKvuK4uGXxlsSUDezrvB376k95grC8CxtEqckwSYFZFcjl63hBBzBgj6ebjrHE0A1nGTM17El/87Ybqeyd53J+AknYVeKbaq4ok1f/pd1H/xGhDPzDRbezakxDz5diLVklAM2Hj9/luAEG;25:G7nNpPa50cQAXvoeDlLpTu0276RHrIas84UjUjnHDuvG3KY5Lqv8fqHIR6WLbdTpaaDh/FiXtVPUOHU2gUI2kZ68cShpbnwVkSbY2RhuuxNbOWfXBNHEC1a60I+G/Gtcli/knFbMIza94BPqam4gTTevD3lncZYMJ8CV5rUYAVERHedZj2W55TzqUipD/JMF9HFcL6/2MD4EU7ePzpSv70jIUpvVMZkUo0wiwulI8LVYG46h20AK3jBd73PEtxN7asVeUcXF5aIC+O1aPmaxqMdGkqWIZMUoCB/Z+D+jx/u45S9MJwDdd9KxWLnazrTAVZK3s6TywzCwZRYz8jaloQ==;31:kMNOqwRCO8kBlrr9cpPxNoOSzAPXrolUiOenpK+UMHtU39py1S/gIdteHHlZgh9qil9GdVkXqFHB5RR3FO5cI+3ukiiwPn2hrSxpTrTxntYfLPp5nH4yRs9J1DAXTURrfd+HlWVr15tqT/aYeQHUeJlZgqqR8+QIgWkQOKkq8MkHtVLvSWSDSw0mY38FS/FCt7mMaZQ6QLfMhWqu4erXYTC1gTWzflJ3/o9fld9e5yE=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1088:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;20:PDJ16b19WzswlSQVg3SK++g2gdbBF/lIHcp13nFiUAR5Ie+4boPwXFkn8alW1ZC32r57nhfbLLVH4mH0b4OFnsoJjeGz63CE08vpeOM1NPfsCsT/EERkAfPUMOT5q4BDDdJthudw0XbM3QlkuKi9LFgfQv36EJYxpZdPtpyCE/its0pG23ndpvBjABBD1s05+0C4YZ9EtmCllg0GoT2tifrAobHYsYDMCjPOX5o6Y60wkWR12venBFxugV8ueA0ZCYfIiKnRlm59w7kUQhl/EOrBaNqRh2C285aSJP4HsQkOAhBsIqKka64fXI4ap1TVlodddCXFkBTTvfeP0Ddm72S0c3FguJK5ECizDzzoB7MDjbRcb2Ef7euGQIc7ACFcEpQz9hRxA/bEjdolat40sTfilTurFUCW3Xmk/wJgdkYNg98mP04hws49CbDZswpshf3lxzkGyG/I9qEL6CDES6NM89v7MhMU1kscSP7qF+mK9Y0cogeHHRvpfTTyYskI;4:HYBSSicWHeDq11F6KSfqcW1+wNWOw95AZiYBVHfXAMLQI6sfZrKj9z2VpI3F6LVhRdiBQjjHAH+SpzfweeAboBcNZmH6F3R2LcXKr0DJ+hrsv8Mp+Z756D6vnRX2MtQIw+JPDjLiXyD6aMqlLWpifDmnK8Kd2jgJ1n3TDy72VBP0hm/PnwX767cEze5DcqViSUl/pawm175PW+mmz60hg1Hfli0g7N8OIVU0kxvkdB8wgMA1osf8f5LMXxj8BrVUw4KiSanOsrRP30WFLtQMJjOSOd6/+p9BcZOmaXR2TrBc28BNj09ed//6SUyza+XV
X-Microsoft-Antispam-PRVS: <SN2PR15MB10885CE33D31266497FE23C6BEFA0@SN2PR15MB1088.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(11241501184)(2400082)(944501161)(10201501046)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR15MB1088;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1088;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(39380400002)(396003)(366004)(189003)(199004)(51444003)(81156014)(86362001)(33656002)(54906003)(106356001)(52396003)(97736004)(16586007)(93886005)(58126008)(6496006)(966005)(105586002)(316002)(9686003)(55016002)(47776003)(6306002)(2950100002)(25786009)(53936002)(6666003)(6916009)(33716001)(186003)(50466002)(23726003)(59450400001)(52116002)(2906002)(8676002)(68736007)(33896004)(8936002)(386003)(6116002)(6246003)(81166006)(1076002)(76176011)(305945005)(4326008)(16526019)(229853002)(83506002)(478600001)(5660300001)(7736002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1088;H:castle;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1088;23:JRKBb9rcJPvccvZwUjFsrQAxhWMkFRDEmgUxzWAeG?=
 =?us-ascii?Q?qMkvvHGIaWmBRhMsRoFi5AZdKrFoizK14UYcTfNd5c7+e2wslORjYvuxq3aW?=
 =?us-ascii?Q?ivF4OwK0yi5UgzlgGfxXiM1VO+TPLXcXg+tTYIksIgyBCvoGwPfO+zevuXPW?=
 =?us-ascii?Q?2Nf1GxIbYdLtbFpcFBcFD5lzGxvpHbtGnyXD4eRkeKXrDXJfnG2gP4qxN1kt?=
 =?us-ascii?Q?vfM9IXbYbFtKf16+zp14kDlW1aAXsE/DLHynrhyoaZV5D/lqPbrWlSeQ20NV?=
 =?us-ascii?Q?jVLUNveXCL1zuwUjirCis9KkxbKcYxYPLt7taG5/hUXujlHBp2i+pB9VAfxW?=
 =?us-ascii?Q?X9tXmz4x4pZ6ZjE1LvVAIyJX0fXac4IKHD0OrVo1q0t0MnXWzZOBhk3XXfmY?=
 =?us-ascii?Q?OYU/x5YcZo5Rnw4xLIZxlVWsqxkeKBX4Axms6QfMS1t8WlQqXt7GX5LgUQl/?=
 =?us-ascii?Q?73iv7PkPyMbedt1ZOWMVly1bgBsJpy2Q6WmnEoh3P7+fqFkYue5ovfeLN3gP?=
 =?us-ascii?Q?z/ZD+Wejmbzh/DAph42HHSRShGElNgwBV1oq2hM4/O3CLyqhbrq7LexnywuW?=
 =?us-ascii?Q?ulmz3u/ULuYmk+hsyEvWPueh57pOw2npsbR2C6NRkmEwc01JALRpzgN8Aq3j?=
 =?us-ascii?Q?3lZGljn2XR1QMqF4Gn/7TEQgQ4CP6Sf7DqGwyJ1ZvbwVRhFB+MfkzyU7SWPV?=
 =?us-ascii?Q?ZeRUWwumvJSR4To/IAiBn1E41s+U8MLihB7LTr5MY0RMaJ4nwsP1MqpuL1sK?=
 =?us-ascii?Q?EzpVhc2P5Va3YGouFT0vuln7tw7/HD+WY1dijAOFEnWP47kKgLGIeBKxzgtV?=
 =?us-ascii?Q?Q/lpt7XZ4yViw4xwYTrLNdu9jY0GRjZpqbtbMWM+vBGKe/HgQoBXidveHrwp?=
 =?us-ascii?Q?bfDQJigjWDmreB+nrH+oOh9AXgk46YQtzs+wg+tYWukDNTPC7q/x8HHVwv5x?=
 =?us-ascii?Q?dNwBBjUIyhMVfMdCbA2VaicPcnukWfSr+8yfVbZ+EIhV9XWzuF9TCfstiuae?=
 =?us-ascii?Q?GMcSfSsQYRzLN2iDRrOEUlyQvvE6VSgW8CtRVsPbyUR+nOgCBohPN6nWFrK9?=
 =?us-ascii?Q?jYrRpKvRUj9xpAje2pt6iKtFujZoDRc/UFhv3O+MlLUzCs3UAyWhXSRGaX6V?=
 =?us-ascii?Q?YWiJIlvRUTafmu11YKow1Bg/OENWE2t0fK3jFRElY5WwaFkCyB09/Zv9PK1A?=
 =?us-ascii?Q?BTalpfDBecqUhJrjmlCY4OGWGz2t5B+0DkPxQjZ+PQkz1GlK1b6J9SbGuz1a?=
 =?us-ascii?Q?yNEFSFU9ZCOHshTYxjJWLxaCTRG1hZW5xxafqfNo7zhxTEmy0IdcuK5LKqk4?=
 =?us-ascii?Q?8tIbbwPj9aesB79jO+9HYcNJFe9yMexf3v6KruIQFUZzhFNJ+4jvuKb0rgPI?=
 =?us-ascii?Q?Jb/6A=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;6:+yNGZg3mqAsuyABLg6SpLulKc56DqUjsfdBPm3ktVxvg81uEh5gv6dVWbPoGUe7PJaNNifGRJbotrNFs4CmzUq9dBdNnt0GsegwaTsM5H2MJ/UN/HseVspGSn2ZVaafncGJoUrBTQtghjvLM+tDogzh1ei8onjgyE6r01uO1HE+vfI1ALt+NNe1pQFV+Vu3PIRAniZuRl2okUI73UXuAkrMom5D0A7Pdiv+u80U+njdFOU4XGf7yRLJ3o6K5z22DToTH1bx+LD8NXiszrQ0PVeba2ODP9U7ED7mdGhMBBUAcUnjgtIbLz3hSOsA/W3uu1HLC0Hp8O2CdLenBvWqFSYEoT67Cm6pio2GE/z5BHHg=;5:p5Bp2BzZ0BvD+fST+C9gz/Rc6vXxu5LWOxVjnOlwTG9HrzaYpP9ezsvY0GmO34UYrwSmVgy9WKiql3/D7Co3t+6ngfyPuvVQ/hF1/1OEML1bwsXhtYmiFXc9DkemWdPrXH7yh2cB71YVIgvdAOBkDLxOrRU47bTJp8/69iqCW50=;24:zpxaPYvnrYWLz4fQrQSvr3WQwkba7360JRW1weNfzes+Ifb54FmRvS+1L5YyWpItgNFm1R/8GpvfIvhyiVj+nzJosj6xIpXfznUEkvjEERE=;7:bQqebtLf15YOr7ijPAThHnTq6UKxv61Hyutcbnbpr3GUZz2u4SqNJeiLOYBrQZTd/GsxtTvVcljIBKWzAWld4Ucco+ZNGYCeOsPw/u/NrgArUXx4+q/tC5JV8uLWlyk7lSgJEwJSglhdJR/8aafVA2ZUYWMBQZ3s9A1b5UVcXiaiGkLsyZw1SQ0BHJTIyvOn9msk+G5PRcu2SIUqp4pCsEQSNXi/rLj/5Y71L5XAeZLUI0x6xixo5MLWOAesp7AC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;20:0mtC69h0iSDqwrwAuhDBQl/tmaqPQuSRmOevP8tzmlBBB1PXgnBmzFg9Yd9kyZ6yL5T0g1mlBfd5ptE9X30ULaGzEUO5odXtEkuLxQ03n0+vEAwrZAuWYaUWpl1/t7s6XJ5M+hCt8u/Wtcdxib6lm0ZIavLnvnN1rYN47fvecWU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 23:42:45.7394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b09be9b-2150-4c3c-5bc2-08d569cd7fcf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 03:27:14PM -0800, Eric Dumazet wrote:
> Well, this memcg stuff is so confusing.
> 
> My recollection is that we had :
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=d979a39d7242e0601bf9b60e89628fb8ac577179
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=75cb070960ade40fba5de32138390f3c85c90941
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=c0576e3975084d4699b7bfef578613fb8e1144f6
> 
> And commit a590b90d472f2c176c140576ee3ab44df7f67839 as well
> 
> Honestly bug was closed months ago for us, based on stack traces on the wild.
> 
> No C repro or whatever, but reproducing it would be a matter of
> having a TCP listener constantly doing a
> socket()/setsockopt(REUSEADDR)/bind()/listen()/close() in a loop,
> while connections are attempted to the listening port.

Oh, I see...

Then I think that we should return memcg_sk_alloc() back to the bh context,
where cgroup_sk_alloc() is, and repeat all the tricks to avoid copying
dead cgroups/memcg pointers. Do you agree?

I'll try to master a patch and reproduce the issue.

Thanks!
