Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163510AbeCAXk5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:40:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1163196AbeCAXkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:40:53 -0500
Date: Thu, 1 Mar 2018 23:40:18 +0000
From: Roman Gushchin <guro@fb.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC] mm: indirectly reclaimable memory and dcache
Message-ID: <20180301234011.GA28369@castle>
References: <20180301221713.25969-1-guro@fb.com>
 <20180301145549.8ff621a708ccd8fb59d924f7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180301145549.8ff621a708ccd8fb59d924f7@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:a05f]
X-ClientProxiedBy: DB6P18901CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::19) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0cf6915-883c-4fba-8bfe-08d57fcdd3f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:of/FQmudfgH21kFPvIgOSpOp8uGS4okxDFwY8DfVzHuwx3vQql6B9LtqIH3S7hYUyhsiBBDf3XWCd1pirw59ZWsO2+M8InMmEJw+63CsvTinsGRnd02vlVuiYP4fJX8inkXLoBG8xu1hJiojb2+8TG2fu7fKec3yi+9dNEoSwTnsonkOJDcelIpKdEyouiKJmASU9AvGO5IUVrf30iuVMHPxceGOguo6ZWiPzUtCtvFomEJzyiI5a+uY/WVfo9Jo;25:D71vCkGEYoaapN4+GwpgU2hP9zKpF4l8SQxkZ9C18KFQn87/KHur8FvrMS+IOY6jLwZ55ZT4fIWOcYd1HcLsCZG5Rt0DRWTZgo0/rR2WU3Fy2oaZn9tzV0on9MSX773pshkWEkVt1lQ4kZQqcCQ/CyVyTXN+gV25rMkaQswt7HO5a4VQE9KK+xyL3gHs6E0XyLxDC4opeoa0u+vfO5QtXhR8NH+F5SEefkE9QLuK4XkJj8PtW5p6pwgt5ZHernPajWYDjAAGTRTDPjbPgxSiI8KQsdH098MBlxVRydxC6vN/vN6Q9lmtYBLZoO3P4f7EGsDUBxtsxaRvcxneJY6vYA==;31:LIqdyj+or5PRenwORMUXHrlUDjAlvnmt3Mvy2MeXJJKcenSugr7dMl7hR7qaku7trjzmx7iAzILNQbOdnD9WiDpe195o36ILvWAMOxob6rNi/B1wc93jccOd74NfZKMDcwjvokGubI0KkrR9wS8blay+mfNIFXLFSi6HL8QipjmIcplm/TSKr+0+inMjuwKgv534bxBhyoBXcVJ3t1pIFTKOUAkGxSzNL69yUyLaUA0=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:xD6tTZ/PFOPsRC274413v0hnvkbJ2sE1MHv6otIx+4mpr04Zj6fdtzZzGWh9OEOf6upLNIeyO6/X1A4/Cgmkq1QeIIMYiPP3wyeh7oiFmBKcMIaLecBYwk59AVGPwhrr2XFiMIAw5tGDD26kyk5jW3rv7foOyjdaniXjUVvYg41Sd5KjNENihkYnBTtpjz+4Z+BG4tcvafGxfi50rv6yf3ED/DiyHJdQ3C8UTIpdh8lL5MuL8/3AnfNZrxRdO2Jw2LQMYb7dWNfPe70/yE/0Ul/4OV5uG9e3nOd9jZIm7T+51on+bW2uPSebEsrEGG8+QHIun+EMUInTM3IWX/G9IrTzxdpHxPdiWP7rIAeRZxMLiVYnLibQMnAfWzgSpNHCl+JZ9nnaYkfdXaC1CVc/Nff23FAKIOtBWVu+vsAHpl0nZTmuL7bNsYi+EWfjIHFe/283tkjnUwtbyKh2EAL313gZCjn2rtaCoMjbzIeRf6KRtfkMagrkhLWpb/pks0pr;4:8gd5avRdALSooeH39+viSxVAmioWybvm23xnE9PDIkHlE42fM6eDxFWYZMx4IuIj3xXBMc5sKE9b1LmHTwoEmvgXW19/KMc5Obce3lHRQqR2Fl9u4jR/S/45mWyq5qmsfQoNRZVlQt5r8tKtVzNWH+CgVdY04OQwDZ3BX+cEnoparMktE6m3h1tiP5M1ZdAsv86ivE+y1ZZxixJMsL5B30pv6f7WG7M4IEOhP65/gAiXiw0eLz8rIATf1DyedWjL2O+WI/XAv/AraN9Ej7pcdCUf+xLf5eO6sHY6L+QEfVqDNT8tTN7/SNLFe8Hn4H+n
X-Microsoft-Antispam-PRVS: <BL2PR15MB10767B76E312C2A711D5BEDABEC60@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(11241501184)(944501224)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(54094003)(189003)(199004)(316002)(97736004)(81156014)(4326008)(5890100001)(8936002)(478600001)(8676002)(386003)(33656002)(81166006)(76176011)(9686003)(54906003)(16586007)(86362001)(33716001)(55016002)(46003)(6246003)(52116002)(52396003)(58126008)(50466002)(53936002)(105586002)(6496006)(106356001)(2906002)(23726003)(186003)(1076002)(5660300001)(6116002)(6916009)(6666003)(25786009)(7736002)(2950100002)(229853002)(33896004)(16526019)(47776003)(68736007)(305945005)(59450400001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:jHwWZwjqICr5EvuL/6aduE9F82VU5BEMdhXpllwNh?=
 =?us-ascii?Q?H8iVl8FdFfnTTN9XE4NLfeeXFGLNW5Upvwg1ZQBtnFaCG+f0KbheYeWkicoi?=
 =?us-ascii?Q?sCHxtj5Fzd2uq1lrdQr27BZinoQdGmZ94+sCSngcu+e02xC6w+Vb0h0GVy9E?=
 =?us-ascii?Q?rI7hY9N2aLfhUNalf+D4m+LjxQ8roTy8sl44GL8ah7GsOjaTy0YGDoam/QAi?=
 =?us-ascii?Q?k8IGwOZ3Q8hfauB8bokcsc41LaqwXZcLh3V6Mb5fzRV5HzmaDDMkHw2jZbZk?=
 =?us-ascii?Q?uPxAtbd7cCtsFAYnEvpVueshpd+jFVORtrQNOhTUQoXeYT1QHVbWo62GMRqH?=
 =?us-ascii?Q?YPK/qBk3/BkWqNbegt1RaKmmFm4qW+3X7F+jd29xfUiGfQ4omOPrQw37IhAu?=
 =?us-ascii?Q?5A+uKMbcBHEKghCbF6pTUYVj+VHYdEkmvK2dsv3fMUtCpTKB3rEuXC7rI0qC?=
 =?us-ascii?Q?3kQt+1qnr/hb/JnqaVKRWYpgphVNCSKliB6KAQff6bIy4gKi2ndx7lSkSJFk?=
 =?us-ascii?Q?LVo3DHpN7IwaH7VQFmm20JTeTkDQJ8b5QUWEOzmO2Ny5fn5gELEVnMKe/o1H?=
 =?us-ascii?Q?oM91Q449Q0lSH0USpxsajocRzlnbB/kLePKkR3y53R7fM3CB/19iPCYCowgS?=
 =?us-ascii?Q?3pcQKCI6U/RTrxpxgyA3vcsdnfunEKp0nBqq1fbxhDLIS/Qw2bgzAm0/BymW?=
 =?us-ascii?Q?CSJHbp2X7xfQSfxF7qGLC0nUehmS07axstkwbdP2uVl9e8koDHGGcjF4tj6c?=
 =?us-ascii?Q?/fnJaF2kSb6zFT7gQfGRexYcM1qG72hyIcj3pmW88k15byiXM3OTJbf7Ww6m?=
 =?us-ascii?Q?aCtI6bSoZBc4awZpdWTl6LUz6Q99r36GMDOUuP3/mJQhk37OE1ph8vzneFXf?=
 =?us-ascii?Q?QOI0QPj2264NIFapOTy/arEadGpwr8PkdEXHK3sR88q4X7bW4QUGwgeujjyy?=
 =?us-ascii?Q?nO05aPeq4O1eZUFfkVeHvOlx8L3vI6TDcDD63th2dSrSSPP4awsHMXZRN/io?=
 =?us-ascii?Q?dLIuV+5gnNhx3ZNGO/Yv0rgIfR3EC40zyF3kPt2Luwco5POJ03dQbRPYgjcY?=
 =?us-ascii?Q?FomlaJHyHuxuXEapmEjBykxQcY/zyDytfq/3JowW82QsQU4ojMxdKkI3sYdq?=
 =?us-ascii?Q?yaf6q6oL7/iozN2yFLkeyJTqSeS4mNT4emBQWqJUkZV8bcG9AU/W8sqyQO7v?=
 =?us-ascii?Q?KhZ8ZGOPEBBusFhElZwgEpcxBggyaCl+n5QIq4VoNUSUsUSOGtm5kRQ2cWL3?=
 =?us-ascii?Q?xx3XX4ODLLnFsBullgw+PVwdZJdbxN29eKtEvsDw6o8iSdVWJYWmaMaxMEIx?=
 =?us-ascii?Q?Y3PH6K2+TOojq2hsO536G0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:9urh2qEM5ojo5Mwim09x85dnonTOevjMeRSGGCiRlrW4ipkc/gh6w3wKUhygo+ewXsWKOigfHs+cAas+tqyhPYEcOU/V1BF8BKQMOvVRsV+Ip3TsMUlt0AKZ5Yabysy8iXPfZGWflST4VbdES5IyGzQ0aGaqbHNb35SNrHvseyKHzsavwUlKx/OBNRdobaeaOjPsvkfhp0WZleTYFDFpHnd277hMqcg3jOTCUZcpnaT8VmYqcozU5swjuj+797+8lILPsonVm0ydI48FYs+TgwkdwbGA6oJf27Gv0LIXvWlzZIsGq0YeJMb1vUXmTMKCZetrptO+SIrRsbsj+FMMPHJPJ8BLWa3pPG++U3IhuX0=;5:VoMp0lmfAAUcPLUmuCC1nCriLDvDOn2RyELVcIdiQopLfkkcaL41XSuYSe6x20dMGH/V+ThaHrFcS0s5S9e3Jef5hWvMUM8lgxavkKVWXyocQ3NxbKx9hEfQOR3I2gmtzOqFiQxgVFuL2qvCnz5bKoFUr0Z+ixRRMACtqpJPCHA=;24:NQVPRqKPu9GOE3j+dz0I/7W5zmQgPdTs+UVh42HZffhuH0RSDfluN2dioK9rwciQ211B6m9MwCGSaMVO7vwPYRzR8tav9mo7LVJ//gzwHa8=;7:d1SpwZza7SINCGzjilXaWSdN9nB74tbN1/cz78y0YEnxqiJnVD9gg6T+BE+UIfMaABmXYAe15ptk3vSgawExDhLsGkL0Zqt14CpT6mb1FnPb/RaShIyLrdvmgipz8xLFp7ybpVUlOWmPFHx3UrRmGsewQMChrw0Qblf60J0TE9m0pBT2pjxNZYHiVR5UfmcF+kXSV03TkUrHvCrr8QHzc3/fIsFPaug/6P29yhTzs6EGt2YAwofaEALxnBDgX/E8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:gofgwb6UUrwlHo7pa360DK1qZOpB+3gn8ES5RMiZ3wIGvLZl0SDW1GoONFcmgix3rAZUyn5HoO2GFOA6d17cy1SRg2oQ4QIp+GZvpp9FR3tfW2r4/vMZZteeqTUpeQR2vdC/exiuDZ/CmsFp1f4MxBkTVhZ4FMRYgiLodVnZDF8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 23:40:32.8694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cf6915-883c-4fba-8bfe-08d57fcdd3f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 02:55:49PM -0800, Andrew Morton wrote:
> On Thu, 1 Mar 2018 22:17:13 +0000 Roman Gushchin <guro@fb.com> wrote:
> 
> > I was reported about suspicious growth of unreclaimable slabs
> > on some machines. I've found that it happens on machines
> > with low memory pressure, and these unreclaimable slabs
> > are external names attached to dentries.
> > 
> > External names are allocated using generic kmalloc() function,
> > so they are accounted as unreclaimable. But they are held
> > by dentries, which are reclaimable, and they will be reclaimed
> > under the memory pressure.
> > 
> > In particular, this breaks MemAvailable calculation, as it
> > doesn't take unreclaimable slabs into account.
> > This leads to a silly situation, when a machine is almost idle,
> > has no memory pressure and therefore has a big dentry cache.
> > And the resulting MemAvailable is too low to start a new workload.
> > 
> > To resolve this issue, a new mm counter is introduced:
> > NR_INDIRECTLY_RECLAIMABLE_BYTES .
> > Since it's not possible to count such objects on per-page basis,
> > let's make the unit obvious (by analogy to NR_KERNEL_STACK_KB).
> > 
> > The counter is increased in dentry allocation path, if an external
> > name structure is allocated; and it's decreased in dentry freeing
> > path. I believe, that it's not the only case in the kernel, when
> > we do have such indirectly reclaimable memory, so I expect more
> > use cases to be added.
> > 
> > This counter is used to adjust MemAvailable calculations:
> > indirectly reclaimable memory is considered as available.
> > 
> > To reproduce the problem I've used the following Python script:
> >   import os
> > 
> >   for iter in range (0, 10000000):
> >       try:
> >           name = ("/some_long_name_%d" % iter) + "_" * 220
> >           os.stat(name)
> >       except Exception:
> >           pass
> > 
> > Without this patch:
> >   $ cat /proc/meminfo | grep MemAvailable
> >   MemAvailable:    7811688 kB
> >   $ python indirect.py
> >   $ cat /proc/meminfo | grep MemAvailable
> >   MemAvailable:    2753052 kB
> > 
> > With the patch:
> >   $ cat /proc/meminfo | grep MemAvailable
> >   MemAvailable:    7809516 kB
> >   $ python indirect.py
> >   $ cat /proc/meminfo | grep MemAvailable
> >   MemAvailable:    7749144 kB
> > 
> > Also, this patch adds a corresponding entry to /proc/vmstat:
> > 
> >   $ cat /proc/vmstat | grep indirect
> >   nr_indirectly_reclaimable 5117499104
> > 
> >   $ echo 2 > /proc/sys/vm/drop_caches
> > 
> >   $ cat /proc/vmstat | grep indirect
> >   nr_indirectly_reclaimable 7104
> 
> hm, I guess so...
> 
> I wonder if it should be more general, as there are probably other
> potential users of NR_INDIRECTLY_RECLAIMABLE_BYTES.  And they might be
> using alloc_pages() or even vmalloc()?  Whereas
> NR_INDIRECTLY_RECLAIMABLE_BYTES is pretty closely tied to kmalloc, at
> least in the code comments.

I don't see anything kmalloc-specific in the counter itself,
except that it's in bytes (which is required). It can be perfectly
used for any types of allocations, and I'm pretty sure there are
other use cases.

This is an RFC patch, so I merged everything into one patch to make
easier to understand the problem and the proposed solution.
Once we'll agree on approach, I'll probably split it into few parts:
1) introduction of the counter (and concept of indirectly reclaimable memory)
2) MemAvailable adjustment
3) using the counter from dcache allocation/freeing paths

> 
> If we're really OK with the "only for kmalloc" concept then why create
> NR_INDIRECTLY_RECLAIMABLE_BYTES at all?  Could we just use
> NR_SLAB_RECLAIMABLE to account the external names?  After all, kmalloc
> is slab.

I've thought about this approach, but it's really hard to
track reclaimable and unreclaimable objects in one slab cache,
so the only option I see is to duplicate all kmalloc caches.
IMO, it's a bit too heavy, but I'm not completely sure.
Also, it's less powerful, as non-kmalloc allocations can't be tracked.

Thank you!

Roman
