Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969832AbeEXMOh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:14:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50802 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965900AbeEXMO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:14:28 -0400
Date: Thu, 24 May 2018 13:13:52 +0100
From: Roman Gushchin <guro@fb.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 0/5] kmalloc-reclaimable caches
Message-ID: <20180524121347.GA10763@castle.DHCP.thefacebook.com>
References: <20180524110011.1940-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180524110011.1940-1-vbabka@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:f33c]
X-ClientProxiedBy: AM6PR0502CA0020.eurprd05.prod.outlook.com
 (2603:10a6:209:1::33) To BL2PR15MB1073.namprd15.prod.outlook.com
 (2603:10b6:201:17::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1073;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;3:I9Yq3FZr5Oj5Z+CImMXU7d4oUPsG5rjmZmAZPlFYAygoc4rIKcMpE6knzlAhMMJxlYEBcpNXQN+MuvSJcD8aOCPBs5JWp7yq8QWXKIxb+Sf7LLNcG/g8oll/aEZG1qjDOoeTvygR++0720oXK/JcCiwCHFHqP4k0A/Tst29+2K2Egiban3Fzr0mEmVp9W3dTzBz+h3CqodJptQImRPxxYiOj+nsLeo+QgRI6f/9gjgPFZjoiJYb2i2Tqojhn58ZL;25:cXF5zdB3lNM++EZctqB++GNRfJZz+CRU5EfXozm30tTMmOsIYXa1jAAq7GmUajA91Qb7I5eeoyGUJn58mWv86aEKMZFvOsSk4e6yr974OhWret7EPbp2FtUcyYK6jdE3zp4fmoSmVfnLX665QayYgqdWVR3zrpiQzCnZ2keXv5d5FhiEV9rVqR+om2Kra8lnhj2dsQr0yWdY4H2isSpWdjBdBQ+x1j0EpMb/sr96pChr3wE14cglNEHJ1kvfJWvJCs47TCN5woIARXhS/9s507cdDQgvMJeD9Vrlakd/25soHJ9R5z9SJKOgAzYb65rgIel6zEskdyiALjIDeBBDKQ==;31:bETWMW221++42CDJpU5nu4MWm5R8yi6/J6LzRl2HIjgCDLvoBklwFNW9xfgumK1DDSs4ssb9cEol0Tcoao76F0ycP8co8OrEC/p98UNrIheG0xswCsz309sHbYZuV4RL5B3L0QS941hg6PfdsyHLACcOMYLWWfLH3sEQbjf+8OBxMPll3iw/I9Tui8VHr38lrMwhUKHJZ1XwaboTLQlLw/uk86sokceji5PnKi/ekTo=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1073:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;20:PhSc8sZ7o8dIFY6z32M8NezQXwNabu0AlAbEeFTjEdzUP0BWRqgEWlcEWeTrasBZxrMh9YZiwEDbCtkx4cK6vBSyGO6yBTt2ERfw9K05JN1wt7GTKugk3/ghw04J9EZV9bVqUNktNMtguvKqlCtvQu81bL9Bq4sr93qvBLfaVql1SoPdi3gWA2TG2KruONcG9zfQI50NyWB0w307mI7A2vEMPi+CIUBnEEzoJgBe/hleKurdKNLoTWLkAlV5D7iQXyBKzN+s5+216yB9jbCP6r/Ch7pTJGp0yRhD/lNuJxdoJ6FF9Js+tKT1dfoGGwzllsURjx3P4x36a17Cw4uLvVQvsVmcf5ERtoKTOTy+jo8bC6X1G13eIwUHqjAfuyxBrlMlQPXt2Y9MLlBuHU0S+a6qojqnhzX+UwoXkoAfi1PXTe59D+oHsRuDz8+ojCPb37fAYx3pNTB36aF/zoLpjwONmzBmlLz1vdRCrNBNNjcQUhcYQK6gXLgK+dQPGutf;4:6/i0NUgtwVYUo0tGo6DLxqt2BMVW/1nAZHz0nRXcVinmAkxOarXQdAZj2zPRUhqVsIzSwFAkYhN3uBVXaGksqb7el4ggyV5Zk053fW8v2LQkj/WzrKC81V8ueC5ka+4aiT4JhEIKBKCTIEHRBMTXKylPuYixUuiRaxM0kpS4v+RM5+3nQY9E9q5OxXcHd5m0UiYKXaEiRv2GXoNYEQ1XGKh3ya1WveH55EFhopam1WJ9yYwfGNdKqjoPXW8oY8LNGc63KR8PBtIthPJjqlfQ+w==
X-Microsoft-Antispam-PRVS: <BL2PR15MB10739744847694798440FADCBE6A0@BL2PR15MB1073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL2PR15MB1073;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1073;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39860400002)(376002)(39380400002)(189003)(199004)(6306002)(9686003)(2906002)(4326008)(86362001)(47776003)(52396003)(53936002)(478600001)(25786009)(7696005)(476003)(58126008)(76176011)(55016002)(52116002)(316002)(486006)(97736004)(11346002)(16586007)(229853002)(6246003)(50466002)(966005)(54906003)(33656002)(305945005)(6506007)(386003)(5660300001)(106356001)(68736007)(8676002)(16526019)(186003)(7736002)(46003)(446003)(6666003)(6916009)(8936002)(1076002)(105586002)(81166006)(81156014)(23726003)(7416002)(6116002)(18370500001)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1073;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1073;23:b0RRW96aIvTyoasvAlVhPug+BK8Q0ZcsircA/n0gb?=
 =?us-ascii?Q?ofCNCdKeC9dmOnrizv8XCWr08A2Mye6UzqLcx6AsI+J50yoNDcUFJpINE/PK?=
 =?us-ascii?Q?ZAWK8/XHeQ6CKbVphGQM3DwJ/4uSFTwGMl2VLkYZDSIhvCew6q11FoYpdDhx?=
 =?us-ascii?Q?vw0Y+FTh7uJ/bIEvb+JXrMVeJ38MnTzyi4e68BMXPMpQNLIPFOp+IlhQd+Xr?=
 =?us-ascii?Q?291G/d3HJLHRjpQlidKBViLLEs5ZEdhkfL9eG7kobuQsTr7Exb6Bs8Zz1jQ3?=
 =?us-ascii?Q?qdjmGo7XccRP8xzmGqlXDyxHIUxkjJH2uhGRvwHIZN/dncVW4GWqgx9jgT+7?=
 =?us-ascii?Q?8VP9c3yLKgzx9htqrw+0ecqoIzB7BZq6/+jA4RYVf8QXtGRAqD38JgY13k0M?=
 =?us-ascii?Q?BgyHT5Iv2Fn0nuJl+fgITZKPXphIItSka1sSWUsy3fS3YJYb631N67yqyBA3?=
 =?us-ascii?Q?0Go99ElRtKZWQg79Cnkl7Al+TeR7w/bHjkV45v0sXx0426b2DnNaglFwU7ps?=
 =?us-ascii?Q?kg5gmGipirtAD+l9lx5t+rfAS36Hl4I6Kw4sz1qpd0Sgvz0xj1hOFfnI0le+?=
 =?us-ascii?Q?F4bG8y4aT9Uh4jtGqja0yJ9nMDdafc7QH01N6Xu57GQzD+Cwucr8x/IM6wvX?=
 =?us-ascii?Q?pjHHfWpge4kGBBy50U+1ub3ivgxh4WDJyAeUj7L2vdX9JcTMzDIppQFgUCme?=
 =?us-ascii?Q?2RuB6QAglB6iSZXt5pW7WHSFBsvZYmLxt7BkJSNYSUg0+eO244fqLeTDcG6d?=
 =?us-ascii?Q?xDxdG69jHFGmDRoriAS+0ZwYYcbCfJvqsJqLTOCRe8Flro2DsOAnVjQT81xF?=
 =?us-ascii?Q?ymTUyLGhXmNGkpNZGx90Xw2bX1/goFQGop5fbNFWX4ocnUY4tUyNHKGUNSv5?=
 =?us-ascii?Q?LvIRbGgkOzab/BDUT92GrmTIPO1X22YmzDCaPD2xGPpR+vYpkpUJ846eQbNF?=
 =?us-ascii?Q?SRYz2tuoOPRiJBYhX+sviHzGeHFW3yU6Os24B4w90pi1EVcOBkWT8pXVOkU1?=
 =?us-ascii?Q?yW4/Z/E/BZ1pSNwnoFOxiR/erhmIguqkPgoGjkyuUMm3Gieq1XJRvqfF4Jrt?=
 =?us-ascii?Q?9I7dFbmz6SIncXUY3LZbqFjWvDhBjz68m7Ea9S18JIPxGk3+p97FHIwKkI0Z?=
 =?us-ascii?Q?w3k9VwPpevaFueWj5TIuMcCNB6orHQhTL6wOpnvI2clVN+90vwvcp8zyVG6G?=
 =?us-ascii?Q?d+FhqXKZEGefUroHMbCgmivpYMtUUXVKBwujp/Afu8RGYre/Aazn38DMely1?=
 =?us-ascii?Q?BvmWjt4VBFA0AthSURPeBUwWYwTNg+RtKPWkppgwpuul8q/p2WdWirCD2dJe?=
 =?us-ascii?Q?dxS6IVwAmUt5A0rsMRkbQwin7gVnrylAhQDya5VhYoq?=
X-Microsoft-Antispam-Message-Info: WyH5s3SfWFthyqVmi/Mj6dF9hyf0eG7DCA1AzceFNxcGANE5EB8envpOjGYVdhz9m4j/Gds60vn0EQ2Cy7BbNAbNfCdLmhG2bfjCwsa/da03xQNIXdTD07IVFqqqznqyd220KLjTNw51iumoA+wF+gcSj61AmCKSUqkxdAr+aOWAOjjU6oa5tpvRQmoPVYBx
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;6:OR5RVhDZb+aN+fcq8sTi89edEwSKDpp9MaojMfddmrDNf3VUg3GsOTuym2EgzBFztFeeP33HeLeGvEDFv4W41TGefY2P6YIMhVgfXbTGUV/qBIEwcswkYF9a1xHPdneK1olbj5LeVtcCf0KCKtp/bu6OnbDLgkR9QP6X06clZdS3XbP6bez1kiHuOlJZiG81xYUC+9e9VeW3KCdBx41Ka27n2gEepyA+jwQqhIks39TLlaYT7z2ZOcGYQ/sYo/nEMulDL6AbX+Yp6/PAfTSsEU2yFkDV+7aeqZa0ZYv+VmKX6i9TBByZRm6DEIk+TW5UbbZOvRTX8FjXeMMxDGMMYsnpGEHmg8RzbG8ng4Eau2jpxH8AzE7OVwfQ3EHMIKBIBHHaVE7UEDJxPT9bSEUzk1Glpm/aNAu4Wrnfm6S04fatuQ0V5iw24CnXU04ccA1T/ZzaqGimqiLskSnoNrAiiw==;5:O2Bdj25x1y4PEF8DmhGOLwpQr+iKnpdZRIivOL9ZzCnsWj4dbK+la+W9Xln4OOcGgy6rC/SWq1JNpiAPMKl2vXFxI3Hu1ubJIlGH4gpsPTB8Rc1i2HSi8jQzdT15WxW9zYXEAlSfPYaa/sA3JabzvbERHyDqoJuRm9A1l6Ohrjc=;24:ugoZqTDdPxIJk7w81IA69+NEcr0ztBPae2A2TlcLej3A8oNJiiqDx54TvPaUVqj9bxSfpT8uYE0fm3k2jdQK9cTQW8RvsQxt4mkxf/KqhPY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;7:QGShq4IaD160Itw172IpFVNYzOI8qXl7X/7ittrlN/jTaIR4qFcLYrXExceP4zbLOFC9qZt3GZ7eQYQOkNTwF07nAhCLIS5m7m2AEb0jQrgtNJhTVKB+5ieX7ITkHlAIzkk5tH2R43kQmDYrnTnlAjM3kx00NTIrUMozHz8gFgVu/HM3iUNHs2lpcxsLyXbSGRqkEoU1usAcyieC7iFDerGo2d46CPGCPUs9nFgX069RBmsKDSV0GC2YYBoTB3fL;20:qnlsMxdyWzZlnwAkUkQXhA+KoulOzTSz36sBhicWWhZiT4Ou1J9pYcSOMqTA+a9pBwhKv4hl7oioB9EGUdVBvK3BIXDpuCOyTsSPJtzT6ALZmmrkmPbe4BCdnXIyo6tH2x9oibgPlVXHKQZ7d92pk5SOtCPm2fDTplSrxw5EExQ=
X-MS-Office365-Filtering-Correlation-Id: 2c72d5f7-4ae8-4bad-5aec-08d5c16fd71b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 12:14:01.9343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c72d5f7-4ae8-4bad-5aec-08d5c16fd71b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 01:00:06PM +0200, Vlastimil Babka wrote:
> Hi,
> 
> as discussed at LSF/MM [1] here's a RFC patchset that introduces
> kmalloc-reclaimable caches (more details in the first patch) and uses them
> for SLAB freelists and dcache external names. The latter allows us to
> repurpose the NR_INDIRECTLY_RECLAIMABLE_BYTES counter later in the series.
> 
> This is how /proc/slabinfo looks like after booting in virtme:
> 
> ...
> kmalloc-reclaimable-4194304      0      0 4194304    1 1024 : tunables    1    1    0 : slabdata      0      0      0
> ...
> kmalloc-reclaimable-96     17     64    128   32    1 : tunables  120   60    8 : slabdata      2      2      0
> kmalloc-reclaimable-64     50    128     64   64    1 : tunables  120   60    8 : slabdata      2      2      6
> kmalloc-reclaimable-32      0      0     32  124    1 : tunables  120   60    8 : slabdata      0      0      0
> kmalloc-4194304        0      0 4194304    1 1024 : tunables    1    1    0 : slabdata      0      0      0
> ...
> kmalloc-64          2888   2944     64   64    1 : tunables  120   60    8 : slabdata     46     46    454
> kmalloc-32          4325   4712     32  124    1 : tunables  120   60    8 : slabdata     38     38    563
> kmalloc-128         1178   1216    128   32    1 : tunables  120   60    8 : slabdata     38     38    114
> ...
> 
> /proc/vmstat with new/renamed nr_reclaimable counter (patch 4):
> 
> ...
> nr_slab_reclaimable 2817
> nr_slab_unreclaimable 1781
> ...
> nr_reclaimable 2817
> ...
> 
> /proc/meminfo with exposed nr_reclaimable counter (patch 5):
> 
> ...
> AnonPages:          8624 kB
> Mapped:             3340 kB
> Shmem:               564 kB
> Reclaimable:       11272 kB
> Slab:              18368 kB
> SReclaimable:      11272 kB
> SUnreclaim:         7096 kB
> KernelStack:        1168 kB
> PageTables:          448 kB
> ...
> 
> Now for the issues a.k.a. why RFC:
> 
> - I haven't find any other obvious users for reclaimable kmalloc (yet)

As I remember, ION memory allocator was discussed related to this theme:
https://lkml.org/lkml/2018/4/24/1288

> I did a superset as IIRC somebody suggested that in the older threads or at LSF.

This looks nice to me!

Thanks!
