Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754778AbeDWKix (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:38:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55876 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754597AbeDWKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:38:50 -0400
Date: Mon, 23 Apr 2018 11:38:10 +0100
From: Roman Gushchin <guro@fb.com>
To: Greg Thelen <gthelen@google.com>
CC: Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, <kernel-team@fb.com>,
        Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] memory.low,min reclaim
Message-ID: <20180423103804.GA12648@castle.DHCP.thefacebook.com>
References: <20180320223353.5673-1-guro@fb.com>
 <20180422202612.127760-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180422202612.127760-1-gthelen@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:4fc2]
X-ClientProxiedBy: DB6PR07CA0093.eurprd07.prod.outlook.com
 (2603:10a6:6:2b::31) To BL2PR15MB1073.namprd15.prod.outlook.com
 (2603:10b6:201:17::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1073;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;3:Hfy1x50zNkV74OmUi0JgN8Ct65tyhlOD/WQyAqDftWK2wiPFpu2skw7BD5xbtJx+3R0JnwkeZdmEBfGlqwI4eti93eF6yA2TT+vYitECtrsIe9KFaCKTIZVmUobzGLhzVT2nXNprCMowLmHUCTyr7WId1musHAW8v2BvQ22vfGTJxurOP/kWqv8OCsSwLaLfZzrqNJfzDs3JIszAJqvvcdzz4Kf9zDGJMVMjUnM5BfWedjCZHbV3LgMsGq4LIAr6;25:AYI+8jHfqX4QQ6fzI++plhDLfXeFEKSl3I9YHMwOQDgETxCI2JSWTuaiLyreFD9QFAf7lAzuethZx3AbeXteZPbKJbT3/66A48MbSLnpu1bDcC3JISP4KjGgTkn55EW6Ov7y4J4SvKHqnc5won7299AUpKyTrXEFMDmhul6gJjeZ1BLgVnT1u6GpnR6WcDrTi2C62FZwB0vy7TnM9hY4ign/ncWbnbFCfIa4sYiDz4CugKANAG1tAdN6ua9ohgvh3jLgnOhz+8sg1NpMdg826h9coqnnHcKPBPwjcIYhljXQDDCZkRyE5T3FYfJlsHGak+VlCtFMhzAVavy46lpKJQ==;31:4Qw9D2TgdAeLh3rtQHxxTwrgu6t1kBkAypkoCDIsyj4gIN9MqoMS98vOfqAhXcWq4MmndhMjNo/IRJIRa5iaKCtjePmQfXvpspY5AsvcZPUtx/UNuhF/Yc+4Oaw8jKECqt15he8Xt3BjYTHYRRTjc3iBRVS/KXa0AEwDg64JmFloIz8eDRTCoZOrhybEUqXDOm09TV/ckBgC9PBGcn6gv5h0c0+nGuPNK3rx7sUkmSQ=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1073:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;20:9/dSuDY1fnK8j6vYwBfBp9Y2ef/2t2BPwaV3GduQOxoQT7age1HMvSSxy1hFyWERJIpWpCdd7BjoOLzoksq3GTeqG4Q67nnqA4cupm9w4HWNArAy37/mx/gXYYtjSHmt7MfM9W9fzo0eFJJP0CcbVx/eXcDyS7Q/mzUmBfg5AEwzcQh46xbrUMqcFWCW0iHb+dN8ercpxanwv80/KWOdOJ5JVVfEtLEf2lh0+7+U0OWzRPVD6ufXFJzUhtWE+NXt+DvNNOlM5q3Rs8kgZ2Ylo9xZ/A8OLEj1xB2xXvtwaq47/MO/GOGOEdl9QGDuZAllPz8aMjSnTqpJ6MPYc4p6o1g+/8Q2lNNIkTqHOIgQl+cbLQj3IcpbGcQBtvG+MZWLrV9xp7fW7qpsy4kMXBIsTx7xV9vsQMDsLIaXUQc60Mjf8HJj6ZGDUcbqr3wz9Hc6OUrO9xl/b7UQlvk0myqkDR5GKOCHyT9laA5abOK/cUlMJMnJ+vAToAZHhxwEDmoS;4:NSzLjU9YvjlOZAt32TOzKtmrkiVmeXVyPJuKMux2QpVnh8NdqHtviDZ6+zV08proveKTBEe0iOavJ3tfSj0GmXjXouVuQzYWXA89XF6fO3nujQRJc6AlwvI1zfLCgVKYUPUxfevBgK4aa8Z5SzCVRnRdusphrQIVfPFGu8MuJF4xc06FdxZtQZP19/okOnAp/yVgLLtGztFMD/snrZqjxSd0hdahJSQkylLkCOAsHDqMza1vxe95to9Pke9bQXt1enKy7Zk9jLgYCYTIhxLlXA==
X-Microsoft-Antispam-PRVS: <BL2PR15MB10735A495D5A9F62EC05EB22BE890@BL2PR15MB1073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BL2PR15MB1073;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1073;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39380400002)(39860400002)(346002)(396003)(386003)(6506007)(6916009)(39060400002)(6666003)(59450400001)(86362001)(76176011)(52396003)(25786009)(2906002)(53936002)(50466002)(52116002)(229853002)(7696005)(478600001)(55016002)(33656002)(47776003)(9686003)(6246003)(8676002)(81166006)(8936002)(11346002)(446003)(476003)(54906003)(6116002)(316002)(58126008)(16586007)(46003)(1076002)(186003)(16526019)(23726003)(305945005)(4326008)(7736002)(5660300001)(18370500001)(142933001)(217873001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1073;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1073;23:2HwovyU8VnEjbV7a5c7meEdvHEulewdD1DuNIsmd/?=
 =?us-ascii?Q?C1g0Y9h9LCq4FLYEaSBHinsEQqLXAqXItgcctZ55eKkEtSngsXr8/ijC3gmc?=
 =?us-ascii?Q?KRn0ngrllEqty1XFjxciwTw7HXRxe+rWHdSyTTxpdYo5cxM23nwxPy7dcIhM?=
 =?us-ascii?Q?VeoBYoJv6TTdFyZ0uA7MVJfv2NRqaQD/BVmDBL8/fExaYI+vuD5P4qu2bHNV?=
 =?us-ascii?Q?nuexcNfn3JapbGOhTa+mO9EXZN1/RwYNQVxcH2Ej+8+BmxZWLS6882lgjXkB?=
 =?us-ascii?Q?jyv1tS4pqpI4UhwpO2YakDVF0/UmD2VTjUY83SxdT8soiTNMK/54wQx6ggTF?=
 =?us-ascii?Q?W1PSwAFMUonQpCdJ5eW9B9vxkAdhEibNsAQtCYXdJ3xNuqpOCacl7HpUlaTz?=
 =?us-ascii?Q?C5eWNeariQ7ZGsBNQowFjZhCOY6F48oUb5BmNd5IiYX2bpqXJpZ1N8mn+7sV?=
 =?us-ascii?Q?Ufzrpatvp3vOKczGmI4XC9DwpwuqR0v3y7sVmSOJkMd9IdqjtNFSw0G4Xa2y?=
 =?us-ascii?Q?/1qEBGnrd40QX5SAvQNNRt7twoQGJQUGdcI2CM7o8up7S4bZOnZd6m5nfqo1?=
 =?us-ascii?Q?8lzOKaI2uoRfNluB2+lhoR9Mg01NG7DVPYWgFkhQZyM8Ldm2QW46DzF6Vz0E?=
 =?us-ascii?Q?VqG9v9HbLAvLQJFcxZKn4XVjj/iZTExQ09R6La1rqMlOYxKyleNAK3nk67Ll?=
 =?us-ascii?Q?5Dagg3CiQba+wnGitaZmI8zlnxMRZe9cPG18/loahV/w7WxEMCF9njN6wWuq?=
 =?us-ascii?Q?cG8PCMe2HSuxiHVuzEQBR6dGnt8z/OmbXT7kxYWleYZe82OkyX8hD6UjNYWw?=
 =?us-ascii?Q?TrEVUjJmFyIEQ5h3hR17ux2MAWESJMc2i0Me3ZTOGFnM8keT2cj0K/MBZ8Tn?=
 =?us-ascii?Q?Jj7oeT7KGi/2nfilFHbdkm3iH7euy1U880demkB4yjRttrj5YUY/57lvzqOI?=
 =?us-ascii?Q?hsMbPxAwtlXpdloqroLPuoigMzNIXt81VwYCLK1plT3dn1OlQ+MUlkSg2fPD?=
 =?us-ascii?Q?kXwSkZE33vUXe6fFuu36Gm12tmkCHtSVM2kAgklaRd5jIYBy1CEPceChAfWF?=
 =?us-ascii?Q?KQrXdT+ERgdNlpUjUGXNuK/UF8ua7bLSkK4si9b//cHa2vqXpWXp/jKYELA7?=
 =?us-ascii?Q?7kjU62Y8gCQnQQMo4xzG/1uttXNYdKyNG4mfvTqUn6FTDmRIfTWEyXNfUtoz?=
 =?us-ascii?Q?zBLb/8D34u3Kj0QeJ9L2whtYcOrdVt/c8xD?=
X-Microsoft-Antispam-Message-Info: p6kwFYwrOHGjhtBd7DpVVvmvp1wvFRIxujVKwxGtqdCNij3ECCUdErUUyGd+mnVd68XDD/wvJXumJOighJ3WaqT9ykCIRWwtRxvWDx3l4RDlod8pMr0aThgD5cJuDtFMtjBA4nLrWOdakDWvJWWxhWDUf+azcFNTgwHUlcnoy3jJXx2/QQDvjA6DFrnBufJi
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;6:lhREFqrp04BhOMlgUSjczSqESZbmpptHkO9Prz4e/pLWtSkAGXUf89NX2PCMCK99/F21MUJK943WjuQOzEYULc1BB0zyPQb+7/7XyXhUs7sMi146ngj2DLp7Rd/AKFt8D2rbIqCHpcyM8Itex/p+jCGjqGtqLRu2ixMu3Yw3uRn9IhhITCuDWJeT+dsIpphfdwOlvx/3djDxnmeUXvuE9oBsxk0WyBGnbfFVM2aP27gh00Hi9/0Z0isGZ5IVW058qY16+HLY1uSpCvyX71U6Uy0MRMxwfqvYw5t7pY+MXTfnL0Bu/WAHma4iLZckgXX7cQYhKHtOJFA+oQMf5afxvZLLVpTenT+YRf1RcF0Nsd6pdChxxSXyB6hYX0z/U7nuyuCf1BbUJTUT7T/dBbkygKki7EoGu5UR6CpHPooqdyucQ/QUukfBq+vFcnh5IwDK0RsAWGkstvmoRhcpKsGhkw==;5:R+IkHWs2RziftXTMtopvVdS39oFL92yOcSri5cDPbV8Cp+GVcXV9TRx4B1ZnHdtkWhoAZhKYgSq+EIouTdaeF4l1oE4QDVdjbsBufzT0RXZTwYu0PHYWYd4XS1becuSbJCB+VOGi8MPwql1Oy+cD8waUFOdoa5DHMshFvHWcahw=;24:IPfjraDj9//hWtC0HPKf+UxcQ/4H7g6/TiHxnLxnnsK4cUajZgbJzyzATu+rW9I1jLsTYqx0a7UEL+O11Leo4Z4HkANqLqm03CrKtfGZFaA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;7:/9hIQZyDkcFPQGZW8BQ74qot/ClOSDEe5ffNziVqkKR0GHqCOqV2EGUC2dMkMpi1MmXRjIsJfjCCR5gqm36534zHXc0r2PMi3RBMDPu3WT0unZxr+ilos4iUjA4KVu+d+DJfXJ3V83FkIPk6T4PrkamO86FUIA7iZls8q4WNsQoA1fm1RuIsh7Mhz5QXqUq9sZdAHJyIfmpxBNsnXT9s9t+GAkeHg47F2Jcvaiw2YXaka1FoVYKCp4ZmzDwEWZF/;20:oyebSyDs4HkjML3yI6W+idvMLo2PHcTXws7wt2EIxnO4/LvLVKn9Y6uXQr9JNscOgf8tguKYPQBX7gjrkcuDExvJrDNkx8BSy0d+L6yT84BpogsdYt8mGKDq2FUq8BYlrx8bF8pT9uUrIwJB6R751UXzKi+Ki+JwsQoPu1pZb8M=
X-MS-Office365-Filtering-Correlation-Id: 4dfe8246-7a0b-47a4-2531-08d5a906564c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 10:38:21.0789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfe8246-7a0b-47a4-2531-08d5a906564c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg!

On Sun, Apr 22, 2018 at 01:26:10PM -0700, Greg Thelen wrote:
> Roman's previously posted memory.low,min patches add per memcg effective
> low limit to detect overcommitment of parental limits.  But if we flip
> low,min reclaim to bail if usage<{low,min} at any level, then we don't need
> an effective low limit, which makes the code simpler.  When parent limits
> are overcommited memory.min will oom kill, which is more drastic but makes
> the memory.low a simpler concept.  If memcg a/b wants oom kill before
> reclaim, then give it to them.  It seems a bit strange for a/b/memory.low's
> behaviour to depend on a/c/memory.low (i.e. a/b.low is strong unless
> a/b.low+a/c.low exceed a.low).

It's actually not strange: a/b and a/c are sharing a common resource:
a/memory.low.

Exactly as a/b/memory.max and a/c/memory.max are sharing a/memory.max.
If there are sibling cgroups which are consuming memory, a cgroup can't
exceed parent's memory.max, even if its memory.max is grater.

> 
> I think there might be a simpler way (ableit it doesn't yet include
> Documentation):
> - memcg: fix memory.low
> - memcg: add memory.min
>  3 files changed, 75 insertions(+), 6 deletions(-)
> 
> The idea of this alternate approach is for memory.low,min to avoid reclaim
> if any portion of under-consideration memcg ancestry is under respective
> limit.

This approach has a significant downside: it breaks hierarchical constraints
for memory.low/min. There are two important outcomes:

1) Any leaf's memory.low/min value is respected, even if parent's value
   is lower or even 0. It's not possible anymore to limit the amount of
   protected memory for a sub-tree.
   This is especially bad in case of delegation.

2) If a cgroup has an ancestor with the usage under its memory.low/min,
   it becomes protection, even if its memory.low/min is 0. So it becomes
   impossible to have unprotected cgroups in protected sub-tree.

Thanks!
