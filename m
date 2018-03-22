Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCVQwr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:52:47 -0400
Received: from mail-db5eur01on0104.outbound.protection.outlook.com ([104.47.2.104]:51072
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751692AbeCVQwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:52:43 -0400
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20180315174903.GM23100@dhcp22.suse.cz>
 <c6a9bf24-50e6-8e60-94af-28e99c51f516@virtuozzo.com>
 <20180315230313.GM18129@dastard>
 <6628c551-f607-367b-1ee6-f458266c1d92@virtuozzo.com>
 <20180316213910.GF7000@dastard>
 <18a031f3-2136-4ef9-6ede-05f5b835661c@virtuozzo.com>
 <20180320001827.GB1150@dastard>
 <ec116ce6-c22b-66e1-0e01-55f895997c7d@virtuozzo.com>
 <20180320143452.GT18129@dastard>
 <5eb88165-c108-5989-3cb5-1f260cec5e53@virtuozzo.com>
 <20180322050152.GA18129@dastard>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3320c962-35c5-c5ed-2a9f-0acb2b875579@virtuozzo.com>
Date: Thu, 22 Mar 2018 19:52:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322050152.GA18129@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::20)
 To HE1PR0801MB1339.eurprd08.prod.outlook.com (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36417407-1e71-476f-771b-08d590155328
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:ZcXtN1jeGpgUgGUnsc/b6vOcprq2wJUJChlFQps+IZce/84B7U0XzUQOJlMmo36b/b3oRNYzYuAPzLdstWbaXf6Um42bazVQ/9MRTYkWN8xYdrRUrEN273s9pDVxLmijpmXkERXQhR6dDCwAGlZjVz2Bl1Hx/TREDVOzac7edjPrLOy85sPMteavUwiJuOOhilqIArp9Mu9bXZgvZFdsqRZ9BMtrLXEje+H2YypB4GPvyLeLu9LzP3trgc6N2vcs;25:IfGa0ufhhlEaAUB+0GCIJQBv1dNFjoOJ0L40qRnZfP3ql+Gu8gZrR4ADwXzKLJaDhCGZBHJGijY45LFb8+doX4SXB0QoblLAIliwOA45BXuZez08ptMZVrw30ES/nRfrshQJ2it1u0MYN5l3Sr74teNDNgDWcUlxQHvj0yu8DK0w1pxvsg2OWXiSrQyyHev4T6luHXnAhgeQgp5oUp8kgu4VPCLNWKRIBt7U6tspafbx6L97TRKfHzQSNowpg+uRJfhlCHqTu//eS6x4HDmy5HWhT8+9Od44LYC0WD6OufWQJSq7P/F48qaPsbgLbwLs99z2Zz0fjWRHZ0LShev/vQ==;31:nsiletnyQZZJDiTTiSvQQMREO5t/uI5qm0zcLZNZSmZOcId1JJQsFc9VxTmQUBdPIqS9pHWS5Dgav+AIE/tOOlAWY5HQ9TB6GuWQSPQcsAI6WbCzUYmUWixSS+BPHGPlUi20N1CJ84+0+xcSmHF07bR0KLw7yLwMjhYelDgldpd4dAPzL1k8L8SYK6V4KVGtxOTZkKOiJ2UAHhXmEA3gATq+SBFTnU1XsJgSmjFM04U=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:GgBb9pr4xMa7j7m6lJ+t135MqkPI+kq3Oxk+/5RsYhMd+pMeYkfz2FCWqomYCvBqmae0StxO4gl7/YRU1NTAFfe14pYTBVWPDzzBbpAUfaOz/pEoRuhwlyg8Jt7z2UhGFmNMYac/S3DvlSO1154hpXwHIOpL8HDj7R/IEiyHOsZxJylt27wvtQkPRg32d3jkDYCmSHaLV1W1lgUvhcuVSnS5K2ugo9gfmeXyV2gsfj9zhZ448ZQK8mxCq4HN0GxJgMr4A+JDl+20lbhcgZ2PGE9LB10wTC5IZEOdYtYVpN/bYG4nyHjpQIt2juvrGxGsMaFse4SqxEZbkmUEruPI+V6sPxaUVFeMrFA2H47pQzX9OOjtpyZfFv8BOTgvxUPRknDUDwbTftysGEltWPgmcshhJl34qv1xmR66CvldzoZJfa0RtntQrMAY+OKwohT/sTaJmIvlO1SAKa6KIXcwVkk3EyeD+/O69rGN+9zqVSURL+0/E54X3E+eM+mC52IB;4:HmS3ZFkIcsf+xmy6XLOfBF23TeHEZi+R41tAguT3sJlcpSuBycbJntJw3Frx4VzxF2+EwL1msDY4yVM4kdhC+ecSMAowPKz/3E7ZNk6I1DqJwLmKsWE409r8hocLDfRs8MsBYEjGywX4wUijl2AIKuD/nAIjQ2MGDmk/+EGidIMl67nnCDI0llZrUgTxFRjHMsk8VVBSPdApL5wnaSaVS1TAf2Z36qKUlZ+dVAcq2m5svQ+foxGy4O8A0iNYWZIGcGF5p7hnY4NrI0fcxINiGQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339A8A70E5C36A6DF4AB5D4CDA90@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(366004)(39850400004)(396003)(376002)(199004)(189003)(16576012)(23676004)(316002)(93886005)(8676002)(229853002)(59450400001)(2486003)(106356001)(52146003)(86362001)(81156014)(76176011)(52116002)(31686004)(8936002)(81166006)(97736004)(2906002)(11346002)(58126008)(6116002)(25786009)(3846002)(4326008)(31696002)(966005)(53936002)(66066001)(65956001)(65806001)(478600001)(64126003)(68736007)(55236004)(551934003)(26005)(77096007)(16526019)(186003)(6306002)(6246003)(446003)(230700001)(47776003)(50466002)(6486002)(105586002)(36756003)(305945005)(6666003)(6916009)(7736002)(53546011)(386003)(65826007)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6MkVZNGJRalFQd0l5V2x4UlRjNGg3Q1Mx?=
 =?utf-8?B?OWhEYkVZMHZlektId1ZoY0JNQ0FHaVJ6dFlPcFFwYVZLOXZ5d1ZzQVQ2VjlF?=
 =?utf-8?B?OTdYN0o3bDYrK3A3ZG5EV0d4NXpuaDFEUkhoczJOYjRWbUNGdUgrNWh0dE5E?=
 =?utf-8?B?NFU3L0ZNT0VwZy92WUU3WTRQVjBRR0tIbHZJSVlrcXRSakZxd2VNMUQ3U3NT?=
 =?utf-8?B?RkdzSTcrdEczVHlkdzNzUFpVNCtrTk5OYXdBaW94UmNka1BhdTRud0UxWkcy?=
 =?utf-8?B?ZTViZTJjZFI1VkdJMm9RcCtoRXhvVGtZL0ZxeDUyU2pXbm41WU9pSTIxbFdT?=
 =?utf-8?B?ZHRNNzl5K2tpT2dqRnR5U21JMFdlcUJQQ3dadW9ab0k2dkVkcGlKcXhPcVAv?=
 =?utf-8?B?SVQvcHJGMzAxWEFIbkpLcHFPOTkzWHFNaWRUYVNoV0dwREtFUWJyaWpidzAr?=
 =?utf-8?B?NjhEbmRPbk9DNUFMMEJmOWJUS3VLOTRsSk1zbGNHZXVhNjl3ZXFkTUFvV1la?=
 =?utf-8?B?OVljOGNtSGdFZVZHaHJFWmJvazlYYUJmNElFU1Nua3JxRXExbEM5RFp0cnJ4?=
 =?utf-8?B?ejl1bHdUWitBTmJzZ1czVTNrUW5wNmJVNzBtOHlHUGhubEZZMGFtVE82cmM5?=
 =?utf-8?B?anVWRVJlM0VJR2Vodmhzd2FHa0gwUkx1c1d2UjVpUk95cW9TaHJBU0h1dVF0?=
 =?utf-8?B?b1dsZHQ4My83YUd4aDkzMCt3aDM2Yk9BTU1TbmVJdFBMN2pHYjFlWENmUUVU?=
 =?utf-8?B?ZC9MYzlKek1WbTlQcnRwdFhyS3VoNWFVNXN1RStPMUJGRUo1S3B3eUVNdHMr?=
 =?utf-8?B?dk1XWndOM3FTUzJxanRMMnRYekpwMkJXNlczU2N1ZFlrbFNZcTdiVCs1UXB4?=
 =?utf-8?B?MHVKeEdVVlJrTW1HZmYrNXNHT3lGUktXTnh6OVFnUCt1bjZxN3JxYVB3Mkt3?=
 =?utf-8?B?Q3MrK2JwdzdlNEgvcEp6V2hsaU5sWHQ2ekUreXF6Zmt5ODJQRHhub2JVdFNG?=
 =?utf-8?B?YVR0U3FmTytBRkpmM0krSkhydS9NcjhiYlFYbWFOSzdDbHJPMGR3VG5EZ2h4?=
 =?utf-8?B?SHAwYXpIVHBLZ2h3a0tPaHdRMmVlTW03QkhQM05qd0xPc0NYeTlZclpCc04w?=
 =?utf-8?B?UWNCY2s2c2pOc0pWc21iZ0VzMi96NkJsZWNUcjV1MStJL3F2Y3BZOE5wR0VJ?=
 =?utf-8?B?b3ZuNE9BM3REbUxCaVFRVHVRY0VaMnltRVlqc0YvODdXNFJZM3BiMHRYa3hl?=
 =?utf-8?B?c0dwWlFrMnc5dVFscEFPdkFGMnJpRFlUdTVoUVRVUDRhdkQyaUhGcXI3QjRu?=
 =?utf-8?B?NFlGVC9tdjF0U1ovbXovZ1ZDN0k5dmN3TUE2dzEwVWpaMWEwS1ZuTDRsWDQx?=
 =?utf-8?B?SjJNTXA4dXgvZzBtdkFZTzNsdG9NdVU2bUUzVjlkMXRCT2FIeWFFQjdTRjZw?=
 =?utf-8?B?UHVhSjZ3OThGM2JncmVpTXlXazUxU3RKS3FxNUQyUDEzM3N4NFZQUW1mdjJa?=
 =?utf-8?B?SW5NdnVpUE5iRXd1NVN6MlZUemQzUFVqYng0QVgySGorM0RVbTc3UVQ4aFky?=
 =?utf-8?B?RzloUWRTaFptWkNRMGE0WHpxWUtsUXUxcnN0T1EvRUFENkRCeDJsWWlxV2kz?=
 =?utf-8?B?UjYyZmdxb24vRmVtUldlQ1o3SGQ1MVpqREdZc3J5cXFTL3hVKy8waFJBbGYy?=
 =?utf-8?B?UGpobmVqK2phWkFZQjNGUWYyMllqSEJ0djVjdGdwdVZlaWI2TVdDVE9oVzVX?=
 =?utf-8?B?bm1PQk5hSjdyUzBqakpWenFVNUNmZ0NLRnl4NlhSWTR3UEdHWHlRWW44TjhW?=
 =?utf-8?B?N0U0OElKN0RIbmwyWGxVc1hINzRBRWU3OE5CdmhMbWN1VkVwTXRuTjkxZDZU?=
 =?utf-8?B?RCtMQjlXQ0VnSXduVkdnZVZHekd3VlRKUnJKSUdRYWczeXY4V2cybUg1eEFY?=
 =?utf-8?B?bWt0Ty9KNlBNSUU2NjNKMlV5Sk1oQUR6YlhUOUkxYnI2bVFCV0Vnc2lNcmxm?=
 =?utf-8?Q?qxnQjHj+?=
X-Microsoft-Antispam-Message-Info: EsBQ/AuI/pCOzPOZbLc78j0UVMt38LG7+iXo0koDKUGYk5z/cUtISZSX3yqDvyQaK0tsIeycdMtgvEZLk4+sXW/nmqZC4nR/Xj1D6MSuhqUWZwa1ReqWSUL1oIT27r96cyTBrVV3KXAz5lBDN69RD5Mo3wnKMVvJJSsHUAuCeAznk30nb8C4nBg8FUfXJwta
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:73MIO7ACwFMVqn3X4TSmAq3zcgpnAEFakmGpg1V+arCbZeyQc6cUlqIPQKwXDcRMyjIRtbuapIBsUHh9OirhZvpXrFAAgBSVzhdhkm7a1IqKVgCmmlc1cMUYFlrnw+981hWLAhixCewNyDM+Go7RPHzOAF8fYMzpKubtCA3D0Uc9zsUu8dQNUoAguzLgi/NYJVrZv1Tw4lZGGLnuVih2HSiYKsG9vIHh6OdZjEl9oL2J7VvjJNJ+Cq7MzF/EnHHEfGYbbJzAbeHjLIXPiFg32slHcvcUOmr8sOCCjKjzLcdn6u8gu2sfVbIXOZPExkJTmA9CCWwffiCZIRWZsftF61EgCT4g666AS/aU1Kr35e0=;5:otqvuH3oyS9rUyaUVZYrA3pSc3rBDl4l6/LAHf/FdR6ioA02GsGoy+EueeKPr6aF+Sk1KwIg/8Ybc/QAub931pHii0X5gYdRPjx5Sn51nu4YGhc/g0P/ksoQ9rFOTDnK2JpWeRDftAiOnwWzLvqowU3daZmZ2O9GBirS+wm6yAw=;24:h/ASNYRrsmyg/alXJJA4ouDr27z8jmnqdztXMDQPsmAvwtMvcn26BbnAWbgqFNwe85kuK8xGObxT75zyV12HaRpIMM0FXhAIe5K7VwB+P2U=;7:EhfOLSiKK2NCfHepkEHBp75hRe1Ty8XTsLIyHocX0B6SNQoLBt9eUWbDLlgNU2Hz9b+zRx79yezHPoWEm1d6eTwVZ6x7drrpzApRNbOsZqpmBg7UWzFtnD/LZke/OCK6kT478cyMhEKBKJZEfrbxFVgGvVMwZ9J+fdpCFe71tvlVShAiNdiLdHAz64LZ1uBGvnYJ1x47MzfsYVBxk1Dw6dB+0xRgjBk2Ho1PJOYP/wGzm6gGAbKRy7heaZ72dcHw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:53PaTWSDZxMw0eiXcqhGMEaIC+t6EcPJ3fhgEC5KwKjxYiPP0Y876K8a9gJJpTg2ir/mryocIXsY+81y5Mm8jqxEe08+kVSsVBfAFRqxcO9EamNPwBmtXpCWTtxvMSlN/QCZzLXv0XcN9ZqLsf3vFve1iaHIg2DJL0teSa1wDVw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 16:52:40.4322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36417407-1e71-476f-771b-08d590155328
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2018 08:01, Dave Chinner wrote:
> On Wed, Mar 21, 2018 at 07:15:14PM +0300, Kirill Tkhai wrote:
>> On 20.03.2018 17:34, Dave Chinner wrote:
>>> On Tue, Mar 20, 2018 at 04:15:16PM +0300, Kirill Tkhai wrote:
>>>> On 20.03.2018 03:18, Dave Chinner wrote:
>>>>> On Mon, Mar 19, 2018 at 02:06:01PM +0300, Kirill Tkhai wrote:
>>>>>> On 17.03.2018 00:39, Dave Chinner wrote:
>>>>> Actually, it is fair, because:
>>>>>
>>>>>         /* proportion the scan between the caches */
>>>>>         dentries = mult_frac(sc->nr_to_scan, dentries, total_objects);
>>>>>         inodes = mult_frac(sc->nr_to_scan, inodes, total_objects);
>>>>>         fs_objects = mult_frac(sc->nr_to_scan, fs_objects, total_objects);
>>>>>
>>>>> This means that if the number of objects in the memcg aware VFS
>>>>> caches are tiny compared to the global XFS inode cache, then they
>>>>> only get a tiny amount of the total scanning done by the shrinker.
>>>>
>>>> This is just wrong. If you have two memcgs, the first is charged
>>>> by xfs dentries and inodes, while the second is not charged by xfs
>>>> dentries and inodes, the second will response for xfs shrink as well
>>>> as the first.
>>>
>>> That makes no sense to me. Shrinkers are per-sb, so they only
>>> shrink per-filesystem dentries and inodes. If your memcgs are on
>>> different filesystems, then they'll behave according to the size of
>>> that filesystem's caches, not the cache of some other filesystem.
>>
>> But this break the isolation purpose of memcg. When someone places
>> different services in different pairs of memcg and cpu cgroup, he
>> wants do not do foreign work.
> 
> Too bad. Filesystems *break memcg isolation all the time*.
> 
> Think about it. The filesystem journal is owned by the filesystem,
> not the memcg that is writing a transaction to it.  If one memcg
> does lots of metadata modifications, it can use all the journal
> space and starve iitself and all other memcgs of journal space while
> the filesystem does writeback to clear it out.
> 
> Another example: if one memcg is manipulating free space in a
> particular allocation group, other memcgs that need to manipulate
> space in those allocation groups will block and be prevented from
> operating until the other memcg finishes it's work.
> 
> Another example: inode IO in XFS are done in clusters of 32. read or
> write any inode in the cluster, and we read/write all the other
> inodes in that cluster, too. Hence if we need to read an inode and
> the cluster is busy because the filesystem journal needed flushing
> or another inode in the cluster is being unlinked (e.g. by a process
> in a different memcg), then the read in the first memcg will block
> until whatever is being done on the buffer is complete. IOWs, even
> at the physical on-disk inode level we violate memcg resource 
> isolation principles.
> 
> I can go on, but I think you get the picture: Filesystems are full
> of global structures whose access arbitration mechanisms
> fundamentally break the concept of operational memcg isolation.
> 
> With that in mind, we really don't care that the shrinker does
> global work and violate memcg isolation principles because we
> violately them everywhere. IOWs, if we try to enforce memcg
> isolation in the shrinker, then we can't guarantee forwards progress
> in memory reclaim because we end up with multi-dimensional memcg
> dependencies at the physical layers of the filesystem structure....

Here is the problem I'm solving: https://lkml.org/lkml/2018/3/21/365.
Current shrinker is not scalable. Then there are many memcg and mounts,
the time of iteration shrink_slab() in case of global reclaim can
take much time. There is times of shrink_slab() by the link. A node
with 200 containers may waste 4 seconds on global reclaim just to
iterate over all shrinkers for all cgroups, call shrinker::count_objects()
and receive 0 zero objects.

Can't we call shrink of shared objects only for top memcg? Something like
this:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8fcd9f8d7390..13429366c276 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2569,6 +2569,10 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			}
 		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
 
+		/* Called only for top memcg */
+		shrink_shared_objects();
+
+
 		if (global_reclaim(sc))
 			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
 				    sc->priority);

"Top memcg" means a memcg, which meets reclaim. It is root_mem_cgroup in case of
global reclaim; and it's task's current memcg if there is memcg reclaim.

> I don't expect people who know nothing about XFS or filesystems to
> understand the complexity of the interactions we are dealing with
> here. Everything is a compromise when it comes to the memory reclaim
> code as tehre are so many corner cases we have to handle. In this
> situation, perfect is the enemy of good...
