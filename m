Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932333AbeDXKKJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:10:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756384AbeDXKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:10:06 -0400
Date: Tue, 24 Apr 2018 11:09:33 +0100
From: Roman Gushchin <guro@fb.com>
To: Greg Thelen <gthelen@google.com>
CC: Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, <kernel-team@fb.com>,
        Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] memory.low,min reclaim
Message-ID: <20180424100926.GA23745@castle.DHCP.thefacebook.com>
References: <20180320223353.5673-1-guro@fb.com>
 <20180422202612.127760-1-gthelen@google.com>
 <20180423103804.GA12648@castle.DHCP.thefacebook.com>
 <CAHH2K0bDXrs+J3jWB1X7wphRMoLgjVUTAAFNLGFarDeAfRhA7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHH2K0bDXrs+J3jWB1X7wphRMoLgjVUTAAFNLGFarDeAfRhA7Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:d5ba]
X-ClientProxiedBy: HE1PR0701CA0088.eurprd07.prod.outlook.com
 (2603:10a6:3:64::32) To BL2PR15MB1073.namprd15.prod.outlook.com
 (2603:10b6:201:17::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1073;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;3:oTyq95LNQiW74J7qJV97q+9WAR+QeFNVSFnmbHJZ/Tr4vg3EpOgBHVmGw9KK43cYv7tg2NWmH1PFM3cM4IOFLSarilFpM5c/+jJ1qE8FtxiXXpqRjiW5atjvEZzHGVZGbuIU5UJqU0L/16qIfKdQts8emFxnxfN1exd/ijsLVu57zHyRJc9m2A1mnr7vMvBFIbBtSv7P6r8wuGewFS8Voxl5trtB5GBO40vP9LSpMe2fsiyPH/XdTbb9gNItpnKF;25:ZHDglJmZC3ZBGuau6AEpth96LcKOYUsl3Vg5intSMyc/1xZNcogrQXmhhk1csiF8BPENb0n0UgQQ7IycnHI0+ID4dMG5x9X9eatc4wXe0VaySP5XjCnXG5XM47WeYlwR+C3nhia9zJ4QAEdSI+XQh3OG0pEsBAYH/s2DvdjY/ByJ/jZ/iE2U+fDRF5kZ9xB/lFZwBVcislloSJ9yfcxIYdCRU6UaAMd4vU6bRLN5i868gLoPxcGUrcL1992V771SlaJuUeRZZYGeq9u7IlrtAdZzaGVGHnJVEGf657k6n/zvH8nJeFipaGFRbw7rOMBgJQpeyphsu7hl4L8zvLd20g==;31:Z9YPuobbS4z5e6AmSAT1aE7KNOjz4enaXT1lgWUMT67mLjLEMLcW8Wwo04oKNf9Se3yZ4ZWBcqukJmldF7ANnMdhw4HKlFBahT6Z0/RIK05pgKorj8CbNlLceI8NbBHTRaVXzBULkOgvSMfApVkNNhhRIyYk87M/0byLUFeGceZecECbsvG5wNVSZKz21nzwF4ZaEfnM+PnIS2cn30k7AfKY/vwFR67jWmrGpEa51Mg=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1073:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;20:91sb2H/0rd5gtogllLerjCZ3Wf1LIM69a+t7P1pWfrlrxuvDNG0YNHHw0ngpYbdAwe4FQFexIuqww9NPo8T69c+UcI29Y+ZByz+W7B+hvWSOf76yqYrfx0TR0MwaMcDI7Et7Vl+LfsKcM2oD5LZVhX1NqYFcEWFLJ99o1rEU0kIlaxOJYnCNEJ9lsushXZm0cLdVWAhoG1Kww60daPDbTb0yW3GRAE/ZRU84dQN4hdaV64f26LrnBrVvIJ6JG2S/C4jN/pgIRaaOnA/26AthsmbGB1W7nG5YQMBoHAmse+kExgoCBQAyDzYNXFp/xC78+ebf9OCJV1oyEwLKHfKcvVTrOPKAwFlbmJHptfwtXw6ysv6zJpPwpSiP7hiGSaUNAmtv+xJoZA5rb+7dC2qSAuJRR23Ggi0YaFVIkGcsePIM48O9RLTh21Sa6hG6lCXbawQszgbvJM4b3fO4DB4ukJH3t82EPfmVrdhv4Kkz1bdwQI5lre6e6Qr6eRgCUM0h;4:evW906SKRZKCDXyXqfLfYwwflQCFJOW9peIc8eGMYwx7BS8g8uVPF3mXovUP4S7xNxdR0amfWyHd6ccIROxmzv2MoMQrHJjOIMmR8di0jfeYIuWIkRtgiF+/7D6L1LIZgWjJCyOtgjXb9hWvWxg9bdR2ANJV/YpUQM1uR3ORgxe7GiABUBeXy8EHn9gclC8RsNKuwE6NHHiZdfZMLWNac/SOCoOpzb1AVVihG6Atuw+G0cW9tESY2FP5dV8G4ePyRPPCsTnOgsv17YKRGVNxu/rKJ3sbQIy+U2ddhWrFR7AUcgksoe2JXGxA93TrwS5f
X-Microsoft-Antispam-PRVS: <BL2PR15MB1073BC433A366B9F2C4C5FD2BE880@BL2PR15MB1073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1073;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1073;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(39380400002)(396003)(199004)(189003)(51444003)(76176011)(53546011)(6916009)(6666003)(105586002)(53936002)(59450400001)(229853002)(6246003)(6506007)(386003)(33656002)(68736007)(476003)(58126008)(54906003)(316002)(16586007)(486006)(11346002)(446003)(2906002)(47776003)(5660300001)(9686003)(106356001)(55016002)(46003)(93886005)(1076002)(23726003)(186003)(16526019)(6116002)(8936002)(4326008)(50466002)(25786009)(52116002)(7696005)(52396003)(8676002)(81156014)(81166006)(97736004)(478600001)(86362001)(39060400002)(7736002)(305945005)(18370500001)(142933001)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1073;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1073;23:wg5s5ziwF2MRqE2WRon6ZPLbSWuUDrce4GIkWuTfJ?=
 =?us-ascii?Q?7wag+7H8RjEa/3+7mnKKKVqn0GIpKDQsm/RpnIS3DgmtZFtrhaw14harsVm8?=
 =?us-ascii?Q?zz5FkF6YQTrcnRTBPD3LaTgqH9K3E9RbxSKLGdS4ZvkagG1xLVdKL0iqyzop?=
 =?us-ascii?Q?WkhfN9KIjcWUflrVHJbJQsRLzhkbFUM2Nl97uPyXe6ZJwxcaanOC6CL8XRR5?=
 =?us-ascii?Q?zshtYvf8eIXsRE51ALcPiK5u1gpuXh5QZtxeD5ELUFffWt3JDdbL+nC2u48z?=
 =?us-ascii?Q?GM/a90zsrsSxTpe+GWHWKK2y6C/m5eiX7WzrXFtwa8gv7ANHIJFbGdvMHjHy?=
 =?us-ascii?Q?0kdJWGvpZNTtx9Sr4QYRDOIIgiHmVic3ElhFVpRJwQy6FBTBIvhO9cyYoz7Q?=
 =?us-ascii?Q?jJ4TXWEvcTp2zw/2Bvk4pku0CHS2gOcv4gXAqh7Bnepv979UsZusRxjAN/fr?=
 =?us-ascii?Q?sJb8ENG+vu2cCbs0FZY6n70BRfAGPh0Jpd/wg86aBCYz+XicHEVUMpisHL05?=
 =?us-ascii?Q?s5079P6GuXD7krv4xDZJMj+zIG7GzgPuoX/CfKogjkZJEPORFhN4SQVX+V8j?=
 =?us-ascii?Q?MgXBaPgR2jUX7GZZsuyw1qnr476vh0X1zEPUjPa3NJC+iNLi//1MxhujwVtY?=
 =?us-ascii?Q?s34IQeNldXc4dqJUChb78oibHZA9fvPm13gnCEq9QnpV/pzFkGQDmKi3wY6u?=
 =?us-ascii?Q?ePTYT0647MZkeiTiBJLiktYeX2TbRuRn3aCxQeXAHhO1Sk2fw1UBaucW3dgi?=
 =?us-ascii?Q?SDx59dOWenznFGbxVLe/5lgyhUIDfh5FWqlGT/bL7D4K+6na7TezlkETvw+C?=
 =?us-ascii?Q?0OZ52C20KKJK855sGXCY819giwklLDWq4vohuz9LXLmLvuglt0D8JAZJJqCh?=
 =?us-ascii?Q?YCnGthYEWNbgQ3vaZFylMvnXzuJWW5WY9cVeZHMg+93B8w9RsbscH3p/k9VE?=
 =?us-ascii?Q?/ccnn0nMskRhY6Y7BCEL9H5qyHou7WjdwCMeBT+goH1vb4QtS/Qr/sgrESao?=
 =?us-ascii?Q?d1+9Kfi1Wo0q8zzNp4GrhpDgw+wDYUEFMA3Cl9Ipzlcrk/5QSPNRXNjveX02?=
 =?us-ascii?Q?piKyWYd87ajXaJ4Neza2yjqDzLxDB7jh4tUYGShTCzNWOTORb5OwJ/023xe5?=
 =?us-ascii?Q?rh6G/HdGdz5HvKYrX54IHrvpFyxXlpjRG5CmmrYstWUTGc4YY92LqSDDJ5Kg?=
 =?us-ascii?Q?jdG40+8NbmylmJFpNuU43PS3OBWfHQ5tzNeEJd5WrFpnB5SINDYZvSIxpZrO?=
 =?us-ascii?Q?HQafABEdhTCScvJZ12ioo4mMP5sZAKwhCEysccGVxLEeNXsljXHlvPElYX3q?=
 =?us-ascii?Q?yhBGXQdlarsjZLbb+LT3l6eGHXGAW+5Aki+8eZzgF1XstNf18f0XOTMbtTat?=
 =?us-ascii?Q?9y06gROgQtR43tZxeGfgABZgwZkwsBHBsNsa9cmYbdXlg9pkCoeBnwfseceT?=
 =?us-ascii?Q?tSDkhHJXw=3D=3D?=
X-Microsoft-Antispam-Message-Info: DJTFpSHrnnsU9X5boRldnSPwIU8COw7MH/AttrsF4hBaHkBr57P7lKZobQfIUPr9/FQm/9AEU5vwOn6VlFcu+b/rP/RJO3Ia6dp5pCe/tl5Tnpcg5U4FeHZiG3j7oMwyG331VeiCA/sMcsfS0GhdiM0JonwLGJ94ZHfQlOOsdFbYVQppO7TNUUS9/j1xoNGP
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;6:RTrz2Vlp3fNLkanI9fjNUq0DYLtRVK3OhxQUS8Syb8GOSRe281uWuRILcmNWFp8j8KfQ/Ww05ErNRKGLxrXk+48LiVqolUXGSlH+tSw9+Uz0T0vyvQXTWRUo2RJcKGRCAv767upMGecY8TksJZyzBeJp2ATldD4qiqES16X/BdBZtLJhwepHrqiTkMSYgiYPt9fGQpmsvxw2m1D9OCt6KU89RtHMS/IT+HQIi8ht4sLgEUIY9+wC7Dy6mLU1ojcUtkjTC/rq/sytCGDhTdvmU3+WLKVB6rzTadKhvfIIBy7fXY69GNVrCsiNGHqPzZwqz2nWBm292YVopT1md2D4+bUmqU/677KqIzLUQcYz2YoBz8y0093yE9TS7/m8mvfxV73S2nZx7U1oHn5C5LtzjNkGWiV8/8k9sDxQdTf4nXpT8LNCf6CkOy9SDuKI3OiR8ADABMj2wm5TeTWWOsLpLw==;5:Fn1aNsqRHNgfrupEr1BjxeiznAwdVrI4sqvov7GGOWpk2NRpl4oBij9YFnLp2MsuqS6oSzdYhYBZrwZ1TGhdQZNe9iZcGRz5IwDF51TxVzHe/+dyAM8gbK7X2cwzLK38J31Tdv9c3soMqXliRj47Tff1w9IoJQ8KW/hQxNTdgUY=;24:mxMZ1LTKvO86ST7MKJOLjXYnvpi8ZVqo1A3OSPlSHF33JBdGHU0/7SZDjZFm7hKMzYCgiCHsrX7tZadafilkAVTFjkPuP/ijI/GbcHAuEVY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;7:kRJbPvCqpn5ndWkwWqr7pdDA4hCQwFFWwD/XRxcZN6ZEcaeMWgTLhy6PTkm+cr9iIf7++RCPDmea9Tb5NS0yTd4SxbDe51zlmDm7r7uUY4Ynb812XTePCtXRCnWNn1yS9AC+h7+bcVx8QxUxfy9JXxA68TQlKiLYnE+yHXS9ME/OccnjUghSw9A1cj2cACS3TZUNhQI1Ecv+4zDJxNeTbmfIXDER2Xi4t5ZIu1ZNhaC0jRfJNIu8L5Q/2bKOfu+Y;20:R12EmFF+m6H3W4lUcnzceDOGp8HCfhfnaWPhuNnnKnj3xpBDfwuwIt6L3WInviozxVp/IkZyM8wPfW6YzTeecvxPk07jogUXFqVq/5ioUUkNY0xl0pFMBL2Oy1kZyZ4LCvb/YEDh97IMxAoGgSuB+dNPn8kM9tirEUkdE0afXig=
X-MS-Office365-Filtering-Correlation-Id: 3f1ef408-582c-46c5-33cd-08d5a9cb8304
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 10:09:46.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1ef408-582c-46c5-33cd-08d5a9cb8304
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 12:56:09AM +0000, Greg Thelen wrote:
> On Mon, Apr 23, 2018 at 3:38 AM Roman Gushchin <guro@fb.com> wrote:
> 
> > Hi, Greg!
> 
> > On Sun, Apr 22, 2018 at 01:26:10PM -0700, Greg Thelen wrote:
> > > Roman's previously posted memory.low,min patches add per memcg effective
> > > low limit to detect overcommitment of parental limits.  But if we flip
> > > low,min reclaim to bail if usage<{low,min} at any level, then we don't
> > > need an effective low limit, which makes the code simpler.  When parent
> > > limits are overcommited memory.min will oom kill, which is more drastic but
> > > makes the memory.low a simpler concept.  If memcg a/b wants oom kill before
> > > reclaim, then give it to them.  It seems a bit strange for a/b/memory.low's
> > > behaviour to depend on a/c/memory.low (i.e. a/b.low is strong unless
> > > a/b.low+a/c.low exceed a.low).
> 
> > It's actually not strange: a/b and a/c are sharing a common resource:
> > a/memory.low.
> 
> > Exactly as a/b/memory.max and a/c/memory.max are sharing a/memory.max.
> > If there are sibling cgroups which are consuming memory, a cgroup can't
> > exceed parent's memory.max, even if its memory.max is grater.
> 
> > >
> > > I think there might be a simpler way (ableit it doesn't yet include
> > > Documentation):
> > > - memcg: fix memory.low
> > > - memcg: add memory.min
> > >  3 files changed, 75 insertions(+), 6 deletions(-)
> > >
> > > The idea of this alternate approach is for memory.low,min to avoid
> reclaim
> > > if any portion of under-consideration memcg ancestry is under respective
> > > limit.
> 
> > This approach has a significant downside: it breaks hierarchical
> constraints
> > for memory.low/min. There are two important outcomes:
> 
> > 1) Any leaf's memory.low/min value is respected, even if parent's value
> >           is lower or even 0. It's not possible anymore to limit the amount
> of
> >           protected memory for a sub-tree.
> >           This is especially bad in case of delegation.
> 
> As someone who has been using something like memory.min for a while, I have
> cases where it needs to be a strong protection.  Such jobs prefer oom kill
> to reclaim.  These jobs know they need X MB of memory.  But I guess it's on
> me to avoid configuring machines which overcommit memory.min at such cgroup
> levels all the way to the root.

Absolutely.

> 
> > 2) If a cgroup has an ancestor with the usage under its memory.low/min,
> >           it becomes protection, even if its memory.low/min is 0. So it
> becomes
> >           impossible to have unprotected cgroups in protected sub-tree.
> 
> Fair point.
> 
> One use case is where a non trivial job which has several memory accounting
> subcontainers.  Is there a way to only set memory.low at the top and have
> the offer protection to the job?
> The case I'm thinking of is:
> % cd /cgroup
> % echo +memory > cgroup.subtree_control
> % mkdir top
> % echo +memory > top/cgroup.subtree_control
> % mkdir top/part1 top/part2
> % echo 1GB > top/memory.min
> % (echo $BASHPID > top/part1/cgroup.procs && part1)
> % (echo $BASHPID > top/part2/cgroup.procs && part2)
> 
> Empirically it's been measured that the entire workload (/top) needs 1GB to
> perform well.  But we don't care how the memory is distributed between
> part1,part2.  Is the strategy for that to set /top, /top/part1.min, and
> /top/part2.min to 1GB?

The problem is that right now we don't have an "undefined" value for
memory.min/low. The default value is 0, which means "no protection".
So there is no way how a user can express "whatever parent cgroup wants".
It might be useful to introduce such value, as other controllers
may benefit too. But it's a separate theme to discuss.

In your example, it's possible to achieve the requested behavior by setting
top.min into 1G and part1.min and part2.min into "max".

> 
> What do you think about exposing emin and elow to user space?  I think that
> would reduce admin/user confusion in situations where memory.min is
> internally discounted.

They might be useful in some cases (e.g. a cgroup want's to know how much
actual protection it can get), but at the same time these values are
intentionally racy and don't have a clear semantics.
So, maybe we can show them in memory.stat, but I doubt that they deserve
a separate interface file.

> 
> (tangent) Delegation in v2 isn't something I've been able to fully
> internalize yet.
> The "no interior processes" rule challenges my notion of subdelegation.
> My current model is where a system controller creates a container C with
> C.min and then starts client manager process M in C.  Then M can choose
> to further divide C's resources (e.g. C/S).  This doesn't seem possible
> because v2 doesn't allow for interior processes.  So the system manager
> would need to create C, set C.low, create C/sub_manager, create
> C/sub_resources, set C/sub_manager.low, set C/sub_resources.low, then start
> M in C/sub_manager.  Then sub_manager can create and manage
> C/sub_resources/S.

And this is a good example of a case, when some cgroups in the tree
should be protected to work properly (for example, C/sub_manager/memory.low = 128M),
while an actual workload might be not (C/sub_resources/memory.low = 0).

Thanks!
