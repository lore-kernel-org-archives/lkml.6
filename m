Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeA3MN5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:13:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55864 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751391AbeA3MNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:13:54 -0500
Date: Tue, 30 Jan 2018 12:13:22 +0000
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [patch -mm v2 2/3] mm, memcg: replace cgroup aware oom killer
 mount option with tunable
Message-ID: <20180130121315.GA5888@castle.DHCP.thefacebook.com>
References: <20180125160016.30e019e546125bb13b5b6b4f@linux-foundation.org>
 <alpine.DEB.2.10.1801261415090.15318@chino.kir.corp.google.com>
 <20180126143950.719912507bd993d92188877f@linux-foundation.org>
 <alpine.DEB.2.10.1801261441340.20954@chino.kir.corp.google.com>
 <20180126161735.b999356fbe96c0acd33aaa66@linux-foundation.org>
 <20180129104657.GC21609@dhcp22.suse.cz>
 <20180129191139.GA1121507@devbig577.frc2.facebook.com>
 <20180130085445.GQ21609@dhcp22.suse.cz>
 <20180130115846.GA4720@castle.DHCP.thefacebook.com>
 <20180130120852.GA21609@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180130120852.GA21609@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:200::1:f5d0]
X-ClientProxiedBy: AM3PR03CA0062.eurprd03.prod.outlook.com
 (2603:10a6:207:5::20) To BL2PR15MB1074.namprd15.prod.outlook.com
 (2603:10b6:201:17::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bdaf0f7-e56a-4e23-8395-08d567dae34a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BL2PR15MB1074;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;3:oaH107KLDKEROAYLFJ3SjPgQvBPEBMLNBne2Viu+Mi6pc0BuTz5PmqMsdp9PHkpYwyO4HsPAT+/T0AEiI11uqschDVmEzI3hi/gJ/Mh8tsc4A6n2UHZOvYQkAdslnkXu8KSHypTWhLdDRv8i+b9xZG3GUzbovFC6LqI8E1SmjcaGSIYo52bVUxsn7KFdqC9F+H/3hfmdAxn8z0ko7QF3Qh97yGpQDBGwnSW27AchMXccyBpmWFpnaGzCaBMvKde8;25:0Bf/pTNx6lwOGSrLFpNZoqIeACO3A7lpVp3BNM8pcnTH3OTge9QSwHIbtdMZbgQDamXkkiHWNI2n41dsyVqBlO77SY5aHgcjLlK848Of99jnzLDZ+Fd6vhO8fya55kQQ18VKXOwd2Hs3m2kObSwGGa+1RxjHLZY5eNd4BWTZPzK6FifGDxpf27ZgxjQbLFSMRAABtFn/pLQfMpuX2JspS85FpsrQz6fAIXTK09CKiifQCaqIYAiZ7CbyOCo2l1Nkq0L29RBFMtBfqa5JasZvZcH/pUJhGguU3XiECW88ToB7o9GLjE6Zo9iLFZiO5GG+iknQEY7iR2RbsjgG0SQe6g==;31:IowWaGtN2U8Q3JEDjX96nIzmBDgxEETRJS621B/7Me6PrEO4nrwd5n02ulbBZI5WrKZyO2yis3Acyad1V/yXFzxUtsC+wjDGLjr4OW6dJj5wZlJLw9bF08Hp8afodlR8N1VxFAfXyVqW2EbK43EckTtAnpdg90PtfX70k1Af/9UVukj44PXEEeDsdw8usE4iLhr/5v4iN0TPoeGuMpa7Wmv6FyM5ClB4htsOWa4cpWI=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1074:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;20:8LLLlh3b6ax4YI95dHNXOdg8nllkwNRRHCiH23gn9fx/vddvfA2rhzvXy9uiK2bfvfUBC97O508OxuNKfHBy9Bh+UAbPwKfNvWCMd15JeCrxTw9n3DVSoGqoogBzc8UTNRyMWiz/9j4uZC8gMVkVQdi1T53eEBS7hiGpK9ZKCiCY72oQQbKmKjxXfNDzGyfFiYsZLQo6IYVfcEjmaRtfioQKyAHr8qKS/w+lnLUMwv5t7ehJTULshqWZ23dy9RZpd27Lqyy7QINkPccgOOPva5Wawv/ASH43Q0RX1e0JAAatqnmZv5S45ZFyp8+1b1WZ02Av3m9exm29TgSrH66BESmVSfo6LpPMwCvSmFEjFONbBp9nn7eNs46Pqz9B8oz8pLhsKLE2HOdFFNuIBeg/S8E3Jmi90UHbOMlgc4Mx7q8LscP5g2cE8diEwbHhL0qVOSX/JdsYeHQ6JRlbefJoNNFbT0MB/e8pm0suWkAH0xa+7T9rsx3Vn/8zXRp53CkY;4:pTZ+vdTmvEqubYhTiXCr2TV0LcsbS31YQx1ciEoOE5eecCP3c7yvqIsZnmY/WA/FMlTv+4xRSMlm1u04b/kye/mLWiOamBumejfyD1AvVwtP9/uqRcM7fPouUPrZmeR7nrBQGnQiOa4gtk7j/95DcKzKYX1mcWUWK9rFPSK46vT3imkAbQAXA1zAycbU3593wed+ZmkghrmLGSmT2sKwzAQWR05o3G1BlDIJZLnprw1I/OXwKxe4+v0xVApkMKXhig7glMt7rDW2QkfwenCJ6aAYZJNR2zv9xw8DZXQ0QfJO9630gg8DQmjYXhKwIXh3wpa+OHIdukLYGd1zDhAwuw==
X-Microsoft-Antispam-PRVS: <BL2PR15MB107489A3F41F728AF71B2BAFBEE40@BL2PR15MB1074.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(11241501184)(944501161)(93006095)(93001095)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL2PR15MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1074;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(39860400002)(346002)(377424004)(199004)(189003)(6116002)(23726003)(6246003)(93886005)(39060400002)(1076002)(105586002)(50466002)(25786009)(8676002)(2950100002)(33656002)(81156014)(316002)(81166006)(47776003)(68736007)(4326008)(8936002)(9686003)(7696005)(52116002)(478600001)(6506007)(59450400001)(386003)(7416002)(229853002)(58126008)(16586007)(305945005)(52396003)(6916009)(53936002)(76176011)(97736004)(86362001)(6666003)(16526019)(55016002)(2906002)(186003)(83506002)(7736002)(54906003)(5660300001)(106356001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1074;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1074;23:IHgMZF/xkBRPkf5jiscUF/Uqr+q7At9yuBhcO0cOD?=
 =?us-ascii?Q?dKMhPIGmoGkU2zVCSBk8hu7qlRQOTLL0QB7hIJmu0BlxozTt1yEGUBNQ9b7M?=
 =?us-ascii?Q?Eol3o15OLmqpX8hy1nUh4dd7bObsFrcjDpTOMToiSXr/aVOUN+1HvlWbvJvw?=
 =?us-ascii?Q?edFBqrgJlNwUHQaL1hi3T4JxpJzoKako5bkKoaA5mxDOX5RFUudumipYh7xR?=
 =?us-ascii?Q?bkPE40KyOhVvXt7ki/KR9T7eOy8+SvOUKn420SXWNdMZnwXohGbNmmZRwrIM?=
 =?us-ascii?Q?cUy1+I8zb5KXDzHNcAJr6ICl8JXPG+45PSkwd8w/zD+3iFQbJ2Me6NXc5kLS?=
 =?us-ascii?Q?gzrbTRoUZ5dCa09EWswp3T+MuGLSfUHWuaNJmeTDmasR9IqrgXsUu9IvT7AB?=
 =?us-ascii?Q?ZHVrj+1PgA3DpvdgnvS1NQBjwv13PhPOS1HdAsIMaVihv6UiYkbnbw44iYL/?=
 =?us-ascii?Q?QirZ9rmfbm50vhGhI8HrDG6fMeNhop1NlsGBAtuwt+M1h8t97S3bZHf24bcV?=
 =?us-ascii?Q?GbLLDdsLO0ZudCbQ38gsXPipVuJ9GB19NPrIXEJOK3omoDdH3KPxyY7nNreS?=
 =?us-ascii?Q?leYHYzLRKYKozsDlhUMpd+PeUrABssgPbKFi1jD7QxnovcDsVctfqnw6LYTC?=
 =?us-ascii?Q?OO81jrPzrDbaYlgeORP05wnRLN7Ew5qIQGUOIXTpIwvJzJjnSZ00XjHzX6Bd?=
 =?us-ascii?Q?phYAWpBAx3wAkHA/2LdBDETCf92tOhY3Dzltygfj1x7R5qkISup6IsUnfC/S?=
 =?us-ascii?Q?0D7Pnl491jpcXnKRuaaIhLds7jLNoF/ljymxEtTlgi6jVenjp5EZYVM5oiNH?=
 =?us-ascii?Q?zttux1j0RmePnZVo4IYcL2YvRCGXtnLRSP7ltV4SsENk7Ooid/M3urKWL6kB?=
 =?us-ascii?Q?l/SbZm2v0l9TcU+3hV4n58/jWCvUeaFsAI2mtvgaZVAOUKubk9lIpssQcpl8?=
 =?us-ascii?Q?3b24sZ9yJA9vUHcAQmubxHKTeasV9OtbEzy8GbZk1CJkJcVmMy329ok8JdrY?=
 =?us-ascii?Q?Ux5lV7BxuEO+PJKuZP4AZBUuNrS/saoGE3vfhiL+kAu8gR0YEBW03QoQNSsG?=
 =?us-ascii?Q?TarQ6xpwQLPtd/s6AEb197Lg5vyzIt7EovOc5KWRac2S087wcqLOaMYOC/pz?=
 =?us-ascii?Q?YSMN+KLOhLU2Y0iIH6foYmxmTHMESbR+K1eemWpp5/j5KeYPumBG4eNLcZp3?=
 =?us-ascii?Q?3nr3sMoMaKvWwOefNUJpKiOU/PVYJF/OI+LGQpGBiXzWVLKgr/ydbybojwjp?=
 =?us-ascii?Q?kAdjVFErJaM+qKLljMQxTywgCb3x/IlDS/rN+DOBn33+BNtUvWBJlybMUOv3?=
 =?us-ascii?Q?vhEKiadVKBvlT8gEPCBDl19iH0wAw3cKtC3Z8SA7sgz?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;6:qSQIGeoHmLfacmNeiSHrAVmcBOiOm0x9rpsoePjP+xIuL2skm8emQyzw/jqmebQlC8PWTfc0ROK2wzjmPvLO1Ny8tTw0qvLeUmPFstAi/RRHeSjdcWg9oPBEaaY2PfG4BhBu3KDxZzG2qae0mgijQP1wpPKT9f9XLLYCIZ6BywPyGb8yiZllPzNALdLDN9fBQbMIA7kOFOdA8y1dk1zcljg2mQh2kqh85JE4/qtRr0v5LPHyVLjICA8zYs3UuzV1WQnEM1TAwzIf0j79UknpxmroMq4+a+shcn1KaP8QnNR3mZ9UxvXJs/paUaE5QnQTtaJ4fAvtLB5ZLXmt/M8+5FFtUpm3n7dLT+VDEfeBboM=;5:kKiapE3EHVCm5j6JwTR0zUt7VosJI703ItAiZQTpVQOngRwF4W83YFbhZyZSlKoT+0WQCTCnWrwnhZcHYPHy6TF5lXouFaU8YMMzY7cjYPfFN+67XuKAM79ro3ARvXEz3mFWaBbIbbMJzTpArAo2IVzdS4PmnrEAcDcJPVIWQ8o=;24:mZ7/O3w41gSsFE/b2r4WOXvPOsZ6XYrIVadxsLhiYFaX+Z44IY0iIl6ZC3bS/idogGkGZIAfbsEOUV3Wl5WxymE3ayLSvasQKIQgYrQSulE=;7:dEdSInQSutUJeUWFh7S1kD/SyxfRMfWZC6aw3PALJtH+RKn7pWHBFFeh3KgAbdGLi20AcTeaN9bLK2Umy/nvP6dqAOrcDU8nBLg8IYMtu7ySG3pTZWC/yuTbKCUyvd6+6f7PBmPOj7IpRVQ1u1+D7HDtncGxxqyulf3GIgcgW3pXE/m4DoGXZj5iAgEzRs92DkEdnCamJi9fg8N66MIf69LqGFRcDAM36Xt8+zqAVQniZdp7DlKP7yrraoiFicm6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;20:HGH5w3Ul/PVIScfrdHIt0jq43Fz/O+PTIVI9pg/1tE8nJa2jMeyKX6ABer8CLGIckFlf1GKpSIkLP8XQ+0PbOOnm88W9TstLhztIhb2BXPEC4QXINOmEO+pN+ppMh8ZrZj7QIHUlJpOoDUTCxJNla0M33WR9MNpOGazyka+P1GM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 12:13:33.7572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdaf0f7-e56a-4e23-8395-08d567dae34a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1074
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 01:08:52PM +0100, Michal Hocko wrote:
> On Tue 30-01-18 11:58:51, Roman Gushchin wrote:
> > On Tue, Jan 30, 2018 at 09:54:45AM +0100, Michal Hocko wrote:
> > > On Mon 29-01-18 11:11:39, Tejun Heo wrote:
> > 
> > Hello, Michal!
> > 
> > > diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> > > index 2eaed1e2243d..67bdf19f8e5b 100644
> > > --- a/Documentation/cgroup-v2.txt
> > > +++ b/Documentation/cgroup-v2.txt
> > > @@ -1291,8 +1291,14 @@ This affects both system- and cgroup-wide OOMs. For a cgroup-wide OOM
> > >  the memory controller considers only cgroups belonging to the sub-tree
> > >  of the OOM'ing cgroup.
> > >  
> > > -The root cgroup is treated as a leaf memory cgroup, so it's compared
> > > -with other leaf memory cgroups and cgroups with oom_group option set.
> >                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > IMO, this statement is important. Isn't it?
> > 
> > > +Leaf cgroups are compared based on their cumulative memory usage. The
> > > +root cgroup is treated as a leaf memory cgroup as well, so it's
> > > +compared with other leaf memory cgroups. Due to internal implementation
> > > +restrictions the size of the root cgroup is a cumulative sum of
> > > +oom_badness of all its tasks (in other words oom_score_adj of each task
> > > +is obeyed). Relying on oom_score_adj (appart from OOM_SCORE_ADJ_MIN)
> > > +can lead to overestimating of the root cgroup consumption and it is
> > 
> > Hm, and underestimating too. Also OOM_SCORE_ADJ_MIN isn't any different
> > in this case. Say, all tasks except a small one have OOM_SCORE_ADJ set to
> > -999, this means the root croup has extremely low chances to be elected.
> > 
> > > +therefore discouraged. This might change in the future, though.
> > 
> > Other than that looks very good to me.
> 
> This?
> 
> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> index 2eaed1e2243d..34ad80ee90f2 100644
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -1291,8 +1291,15 @@ This affects both system- and cgroup-wide OOMs. For a cgroup-wide OOM
>  the memory controller considers only cgroups belonging to the sub-tree
>  of the OOM'ing cgroup.
>  
> -The root cgroup is treated as a leaf memory cgroup, so it's compared
> -with other leaf memory cgroups and cgroups with oom_group option set.
> +Leaf cgroups and cgroups with oom_group option set are compared based
> +on their cumulative memory usage. The root cgroup is treated as a
> +leaf memory cgroup as well, so it's compared with other leaf memory
> +cgroups. Due to internal implementation restrictions the size of
> +the root cgroup is a cumulative sum of oom_badness of all its tasks
> +(in other words oom_score_adj of each task is obeyed). Relying on
> +oom_score_adj (appart from OOM_SCORE_ADJ_MIN) can lead to over or
> +underestimating of the root cgroup consumption and it is therefore
> +discouraged. This might change in the future, though.

Acked-by: Roman Gushchin <guro@fb.com>

Thank you!
