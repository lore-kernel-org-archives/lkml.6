Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeDQLYq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:24:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751270AbeDQLYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:24:43 -0400
Date: Tue, 17 Apr 2018 12:24:13 +0100
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-ID: <20180417112412.GB28901@castle.DHCP.thefacebook.com>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
 <20180413133519.GA213834@rodete-laptop-imager.corp.google.com>
 <20180413135923.GT17484@dhcp22.suse.cz>
 <13f1f5b5-f3f8-956c-145a-4641fb996048@suse.cz>
 <20180413142821.GW17484@dhcp22.suse.cz>
 <20180413143716.GA5378@cmpxchg.org>
 <20180416114144.GK17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180416114144.GK17484@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:b7d9]
X-ClientProxiedBy: DB6PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::14) To BL2PR15MB1075.namprd15.prod.outlook.com
 (2603:10b6:201:17::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1075;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;3:oFaid3EZbf9ModlqU2FbEKj3neDt2xIHlXt0Tl5yRa/nm9e0wcw8SrvZy3lm3NHNj8Co9KMpElnBT2pJUSdwW1VaObNQ5ZzF2nd1e7NWpG7bCPSH6Ne5JvXC1VeSUP7iE+GjuYoMDjnznoo2+C4ruNLdqEZoWV2BelJXuIi7f3NsODOBABmAAGVuqbDGHmcQNb0cJw3Gp1J74rldt9vo3bar6n00BLy5L3EpnAKS9FL0l/RMmCOQI1L/60DROSUU;25:LL8lqmN02yi/TQXvIO4eZYCorxGq4Y8TGxxPF/13v2upRiZnKQIKwx9MKIuum2A08rycKLMnxboAyv9VfRHwKq12arOLpEnSdcqUxqiDJiZiCImEveMQylr/D0Dtz1MdCNayeG9JzBuarlnpCIdmiBnpNOOUVZP2PCMgFH3xn8pWdnCo5f6yfZhnqZIfrpaFhtApM8Gbdg/PivVt6VSIxPNmUP5LNqB+SnfqmTxMY4a/RoJyBtcOgZT0wQMs2BN2JFUnYd+LxyTr0/G+S9re/oV4+vdNvxzIQ/tpRFPaAtiV/kH5b9EHqUN0nRtD591yMyvhQQUf0Vgg+v87qYmvmA==;31:uxZe16pdASUnBeFTx4ZTX14JbrWGKngGwpNFyYnS0NvjdzZ/31ABGtcRtfVix6yMBIsjZliQ4S6oIrzOwLhLNee4pDpAyGnxq8Gr6nS8fd0NCAmzCQ2EHv9DT2TiEr2YiQn9xg2vbDv2ZjNLHVWdjmyIGOG0uy+wGn6eyVf6lDNNeMTEHNmUCA84UXujL7LhPG1/RAr2kzHnwVqJObzSWoiZi09ZOBLIaBvkb/eqKZ8=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1075:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;20:/uzZ/9cSnXjdbwMxqsMAr4/toU6ZZPGorCsL72S4QB25Xxr9jRvwxbaGIPSdlO0KpcxvpPYxQI5vg3q0TnkkVyrljvjqkQssKJUXuHjkcIy3urKPKbHcT/U3UWIWz54m4MODFlAmeV/s+mKbKhjf3W022VTjI6H31YUy26UTx8O185Kkn8x9Ys1l9+lEOfUkORBqeA3NacD6lLXHErV2VNY5rTcWIM1NQihRFY94pINI1lU1aoTtsCh0avbU9PfjGdbBWedZFfNh54+Tbp2pnRAKXMGwLiVhZhO/KaEescL251fvrSQOc4xqZVpcs7pDsDHtQPuURuSEkmixJbR85+52367ZsEOHm/QYe9fz694rOBl/PRnu6+2HEGNup3SxmrvtTfgRmfR32KIo9BOuEtk7DVVZV/19mz4LNtZ4PZv2ag5uDz2oEGRl00yMo8nGxRuyuoKvOmD+t+5H69KjCrWvA+Ruufwi/9VEtZ/9tim6yl7A12jN+tQv5/OYEJeS;4:CMyQ4DJUgiGtue5K3ccxt1Cmsz04t+jKKRGETrjLBC27IDXKA2w/AXkaBiYd7kD0M7IdKdji/sYpSwNQ5hyXjZSD/u/LW4yq1kvnkMpNZvsj6v84VtPjjDPSU6+dmWy8orKKZ6GW0FHXBYMa3rOJyBTVx9FbIBegn9rUuGKkMgFg/5/nkWicaxSBdf7iS3jAD6toDBmdW1mfVm9xbwjCwd35y5DLp7+K/hu60XYBq9uc8PtHbx3w29/CSLB2YjvjofA77RXdm/N80xz91o5w+g==
X-Microsoft-Antispam-PRVS: <BL2PR15MB107587F14B2997FDDFA4831EBEB70@BL2PR15MB1075.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(11241501184)(944501327)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL2PR15MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1075;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(39380400002)(366004)(377424004)(189003)(199004)(52396003)(106356001)(52116002)(53936002)(1076002)(86362001)(23726003)(47776003)(15650500001)(5660300001)(50466002)(16526019)(6666003)(93886005)(105586002)(81166006)(25786009)(7696005)(8676002)(81156014)(6246003)(16586007)(76176011)(316002)(8936002)(58126008)(486006)(9686003)(54906003)(6116002)(59450400001)(478600001)(476003)(11346002)(446003)(6506007)(386003)(55016002)(97736004)(46003)(2906002)(4326008)(6916009)(33656002)(186003)(7736002)(68736007)(305945005)(229853002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1075;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1075;23:a3eB9PEOjp0HXgoIyurClePZIQTQgGVmvx3PF8jJK?=
 =?us-ascii?Q?5VHdT9h+qQce/yITeAAY8MKduzsCJruftiC+ku/MrDIaBCI+aJNbUi6ifvIs?=
 =?us-ascii?Q?6jKBUgwEoDF/zO/muvl+Q31/f6DMnJj8QfToBr2zpx96UqnTP1YHIe8mVHmw?=
 =?us-ascii?Q?3iKMqeeNTaUQhqQuHVcN4tCaN1mwzxdTlftXy8ohlIbMfH6Nf5OzxrUFok+D?=
 =?us-ascii?Q?BDXwHAp66Xi/HqtjKfPi4sJc+/a+wmo43TcHS6TX4R9o8DReWJxL2fNwIo3J?=
 =?us-ascii?Q?CeVOc3DkG8tKXH1r0Xhe3XYvIVXXo/IyHan0l62B7Y02pJNSf3bPWmr1uwQg?=
 =?us-ascii?Q?06B20Xid9x5u0PzTjLg+oo2LSWBVUEZm0jjowh1JWbS8xJNkUNCBStLbDvPZ?=
 =?us-ascii?Q?gQyu5wdTPp7WPl+AytxjX32kOG515LtFkWhVLp4ihbZlzx/+06RqznRR5G1q?=
 =?us-ascii?Q?257Te+Pa7V3U7Pz4RdwEcXRZnkEz2acBaYAgy33rQrk7+VtSfDyQUaFOe0dm?=
 =?us-ascii?Q?AZPd3yd+9HpIqJ7ukX8exO0ApuNmcDpOwb/qIn3oQ8gvV9nMhQ1gZM2Fa3kR?=
 =?us-ascii?Q?jiEzh6O/g6vPB2S2CIG1G5svg+IaG6Z4s+uRHqfBlZ5MF6A+gySblG/EYgHM?=
 =?us-ascii?Q?L8nfDD/poC0QW6GpyzZpV2nkgPuJAMr41T1TOyJ5EvfPZzjQfurZqMenwnIV?=
 =?us-ascii?Q?c5ZSVvNqPo/MLvabpQGdnc2Pg92dh9+8o8i6sHgxVdxzIwsaSMU8DyXEllVk?=
 =?us-ascii?Q?A/etYBXFgDEKavT54K+wwB2sfsYEXU1p7TTL9tTaJyhchpdU3/ewPZJHqdoT?=
 =?us-ascii?Q?Uknee7ScZpNvSaoUv9nqSzxIuGzaQkH0me90/DNujkVSW8Z0C1lSnT9S/Vqi?=
 =?us-ascii?Q?VQ/Sbe6/P2PVDH+kR4158My8iRsyMmGSlNLw4Dmyp62eKWM9hqzv1V9MEF6c?=
 =?us-ascii?Q?cUij98dY8uLapxTlkbq6LBKBzwCJFXVO4SlQu772kuQgpz9rH0T6w2dBhUF0?=
 =?us-ascii?Q?mz8snZpMXdhvZb+8vyrDg2LwsPQ0O1yWH8X+9ZmoVyYhiJyJcBsaEa25Vh23?=
 =?us-ascii?Q?Xq65L/ZAUzYW1fZBZPdSxclVdrimn/3KrEBblURB7zh4n/pk0WWSTdTuSGrq?=
 =?us-ascii?Q?zvYRqAxB1L45dsUJcxMAI/cLolOAAS05l7/5ZMQMk7tFZH5awsjR401J8j4o?=
 =?us-ascii?Q?5bCH/Bpdbe/Ug5JRyqvy84ZtyTK0ehLXqCT6RT32PbSnOckYliALxovla5JN?=
 =?us-ascii?Q?OMqFQ+OYFKaG8IpT+IUoeJP/N7pSNKODifrk2/StX8NPEz/nNlj2yWIn+kCT?=
 =?us-ascii?Q?8TcHvg7qy1wIwVs0buJGpjdprAOQqq+A/x1Bic2HxmsJ2zwUTqEk6pEol2Xl?=
 =?us-ascii?Q?vc1dQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: C+n2NY37VdefA4+Y7wDgZKYgDLg4IsVTphAeZZgxoa4dYWUtX8B11JIaH8HTbyrKhnl0pPTjiofdMKKqKE3nLhrGHFkSUllZugMBpmBJNaZY4xCvVEhub3yRlFcQTZ8bHDOx7ZmtNG5wUJXQvDbux4MerlrUpaT4FsLgcoZnF7smx9HGT6TWO8i9zm+M/ADX
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;6:2jemywq7/baOizB5gEA8ig8eyKh4dlDRhW5OW/pvMh7TRT7pSIwOPnpRVFOP896juhsPLrG5BZG7+iOi7UieASPH+0RTau4FDU78sjBnlB5Cougm5lTYKMffCqIz3ALDiv/mmxY31oYDr2XgLtQB5rob3HUxELugZ+IDe0XXonWCCY1Q8IP3WSbqWb/AtTQ2ndx4GYcyB3fjZOrwfCda2XNy+lTx/U9smHVNTz7AfzQ3zlB3ZxFv6WecmCqu6FfZevxLE/2SVY0bnbWEDnnjEaFsVyaQ2su9cot5ELS3/+XAh+zh1JhR4PbbwACQZ0HZ2Xp+/GsV8XEuZBefmzqeH+Y+euUMU7NOxvLVNOxfXU4SIkqKQO7/3hb2lzqMtNbg2doKEdKsVAPUZUsngilJyfIqPlesC78Dd9dMSJMI51JqNfM8xbt3B+COIjqEyJ5114Lk54UIrHO4aO+bpeAGDQ==;5:1P9PC051SP1KP7GqwWjpf8gl01Gf4d4c0wpnwGQU89n2Ivk0//ghs0U3ot9LlY1AgEU+d/rIUNaDGygt7/cmK105MyNP3Ji4bHaHgYxqpD5p42hMKAyAnBIcft0QEwQgtvpe74dXrU8NCiHptLh9Za0TC8suCyE0uotJKN8AAEE=;24:IK/2f8082cw/Dz059LJmAZye1zC4DyA+NJiCxFY4sXfC9GeY89awTkCUSo3tOvCWghDibyJFE8SJL1SK89ztkcU88Zu6nh7Ch2AJN4LKIWs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;7:QTrDxOEGcQYWXhVoQ6X+ZLP0jztK+Rr3038C4ThgGwFMjbMQnYh7/hwELw63hzP6uuOfptgY34Fux6vYTYbqwarQBQ4oBKS9hkDsReZdG12y0i7FKJ0o3qA5+1R1Hm6mHE23nYzvQ1nziPS93AajhpQcMOHn2MEBwhFpCAihffIIAuFvlSO6ivE28PL0vdgQQNXABs+yp10r0xhFOzFQf63O5eUILi0EHLtroNlwdov8JGvN/w1pXzR2DkCf2a/T;20:+BK/u/eaSOeKs27UC2nVNauCaiiHBkJXJOrEcJSxu7ypsTuWE3mfv6W1+uSyV39CQxRLrU+whbGalBoMK3zdZ2xYE4aQdXdgrgNN1RuTGWOr5Vl+EsV9HTEsGbpdNrIm6p2NacCzWjdLn/QZJtBb6PfF8hiv3XX3+rkV9356XXU=
X-MS-Office365-Filtering-Correlation-Id: 49ef788f-3a1a-4a95-43d2-08d5a455c633
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 11:24:23.4286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ef788f-3a1a-4a95-43d2-08d5a455c633
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1075
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 01:41:44PM +0200, Michal Hocko wrote:
> On Fri 13-04-18 10:37:16, Johannes Weiner wrote:
> > On Fri, Apr 13, 2018 at 04:28:21PM +0200, Michal Hocko wrote:
> > > On Fri 13-04-18 16:20:00, Vlastimil Babka wrote:
> > > > We would need kmalloc-reclaimable-X variants. It could be worth it,
> > > > especially if we find more similar usages. I suspect they would be more
> > > > useful than the existing dma-kmalloc-X :)
> > > 
> > > I am still not sure why __GFP_RECLAIMABLE cannot be made work as
> > > expected and account slab pages as SLAB_RECLAIMABLE
> > 
> > Can you outline how this would work without separate caches?
> 
> I thought that the cache would only maintain two sets of slab pages
> depending on the allocation reuquests. I am pretty sure there will be
> other details to iron out and maybe it will turn out that such a large
> portion of the chache would need to duplicate the state that a
> completely new cache would be more reasonable. Is this worth exploring
> at least? I mean something like this should help with the fragmentation
> already AFAIU. Accounting would be just free on top.

IMO, this approach is much better than duplicating all kmalloc caches.
It's definitely has to be explored and discussed.

Thank you!
