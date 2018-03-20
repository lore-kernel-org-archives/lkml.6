Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeCTNP0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:15:26 -0400
Received: from mail-eopbgr50091.outbound.protection.outlook.com ([40.107.5.91]:6688
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753019AbeCTNPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:15:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <152112607662.7371.16175767692798928059.stgit@localhost.localdomain>
 <20180315174903.GM23100@dhcp22.suse.cz>
 <c6a9bf24-50e6-8e60-94af-28e99c51f516@virtuozzo.com>
 <20180315230313.GM18129@dastard>
 <6628c551-f607-367b-1ee6-f458266c1d92@virtuozzo.com>
 <20180316213910.GF7000@dastard>
 <18a031f3-2136-4ef9-6ede-05f5b835661c@virtuozzo.com>
 <20180320001827.GB1150@dastard>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ec116ce6-c22b-66e1-0e01-55f895997c7d@virtuozzo.com>
Date: Tue, 20 Mar 2018 16:15:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320001827.GB1150@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB7PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:5:16::29) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0898254b-8e78-4fe8-9877-08d58e64a1cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:hBzW1bH7STV80zuYVkOlVJ3a2UDD3YJzLXySB61LtbjxjsvYwL1UKODDlPwD7vpGMRbkcrxeztw26wtjRkPec1wZmGTmPtqkEo9vABWmKO8OMh0NYY2C2zZP6WZmboAJQ57sItYMWqIOZcAde9UVY1SeZ1Z0RZFAUJBOIbg2TpEgQjVAepSWnIF6yHU5eAAf+78AfPRFoAiUEvj0gKhEDe29yljJV7HDutqeEO16tvL1YLelesSmv0ISDmww9gVu;25:ok2Hv81o0XwKKCpopHoNs0qP0G8qNRdbKLnC6IEX33DQLEmOn+ezFCaWT4cxaMo8DNoKzWLBoqMnoQHcn7g8xxakycVcdAkTypcMogh/Ui3/z1ZcDrk87eOCY4OAwmpuX5hFte3o0LsDVrv5SW1t8NJ5C5WtLVIljXmYtt7Um8H9XEj32UtE1KmxHUxxWU+hucVTDuYdn+PVWLWtfrSl7ZP43Or+Ci2JAPOUoELih2tRq4gkvETFupTmbofc/qdA6pyDBTq2OLMUscmWtFMWHZBnBlQgD1Lq2buHGzuVm+ch/iIivnbOCJZwHc5noiIvRtNSXxOXIvliDFSJAnh8CA==;31:Me3U+r18YPFHvQbUKoQIWI4takawpH6z8eT7QVLNitCpoi+4erDAOGskzP5A6gC9DWwjgUFpMq2l8ME8B9MwGt3H1IlHB9q0F0aRVq/xwcCkVxNjXJT035jw41L9RnL0vpIFI50C2Ci11f0VCXDuHa69Sge/i+x5TPAXCMJF+skn3IRtTLObCmulYToWNocfF7NvxQPrFVoKW7W+H+fmhQ8DkqaXviUrnHjigKO74Sc=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:3T2gvMsDl42koxPg3w3zsOLBZyBs34edSZ7kc00M7mTSVFiB6WHP1Hww0KrkUxs8ObsLKkokVP4IxvihUMEfUtBoHC4X971a9ykIVhJVB9r67O0mV4FSfyxrD2MYwCfEBubudNB2QDXdT5Gsf2kmOfO1+4ommhaEnhtz2i6tEEcc/NRbEjfgajgNCZnE5SKsX/2ufJ5o6xVlddkTZDE+fOzxSWixD6BfT+9UFEcdwBV055h5FDsH1wI9f+7rxUnE3yfrSbBkL/9AJHBUbOem/tRSYNTPtXX7G4P+BtNkxEkYf5WvE05o0Qfs02+j5i6D0vCGV2hnYi7/b/cfcLV4PHQoa4AESd9GSC79hFx8t3NBMyBT6AFjq4fCT8gJOinIVqLxUQRMrf7wa1g5QOoeaIy9UFFqrQ0wZhY/MZX4p8TSzj5bG6M3+thr04+/Wu6Cer8UrvZMlxWrUwWFNDU8Y3osWyiF3GKHcg6LJQ5h1K5SiQzWHRU5mfVHbJQQ598s;4:rEXM3OPp5Gi9WZ7MiHPaD3yLmXa3DmDEuCJLjULOAMxAbz/1sbRiZqFYXRwnNh7ldlurIDQitNIOaVCbd0/lxJgtpvkugRD4/4wqetX3RDsQlDMgXGmojqq2yBlWiUs48oT/H36YvZ07ghfG75f6/1QYZiCUpj/NtlYhTPxqDo7THdHq1seQBVJHdrKJP313DUuOD4Mn1931vKeRaN/lES4svxysWbK58R1DoAS6xudStpLR2aZ4LdnmgXwtqE7w+a1BuStDrcn6cTwoWdEUlZVpZIjedamqKme0n8L1VoHnwol1MLc0AQH9hLVm+Uh7
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341B969D269C707857C7955CDAB0@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501311)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(39380400002)(346002)(39850400004)(396003)(199004)(189003)(377424004)(478600001)(6116002)(8936002)(6486002)(229853002)(64126003)(55236004)(386003)(53546011)(25786009)(93886005)(52146003)(68736007)(52116002)(7736002)(3846002)(230700001)(53936002)(86362001)(6246003)(8676002)(81156014)(305945005)(23676004)(2486003)(81166006)(65826007)(76176011)(2950100002)(77096007)(186003)(106356001)(26005)(97736004)(6666003)(31686004)(31696002)(47776003)(16526019)(2906002)(5660300001)(58126008)(316002)(16576012)(105586002)(36756003)(4326008)(50466002)(65956001)(65806001)(6916009)(59450400001)(66066001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6Z2xiUURJVGRJSUtVREdZcUd2ZER4SFp0?=
 =?utf-8?B?cTltWG81S1hQUDUxV3l4R1hKLy9POE1Ib28wQzcwdjNmNmpncFNXY0xCQytx?=
 =?utf-8?B?OHAwd3BIL1JKS0pWMHozRzBaM2VhU3RqcVBKVnhXbVFmSzVqNnZlcmRwOGxL?=
 =?utf-8?B?cWRVa2RDeUh5OXZ2M3VOTHk0d2Q2NTJpR1hqRDZxL2M0bXA2bWpwendKMGRS?=
 =?utf-8?B?TlFWaExFOG03RFJ4Z3hHU1k4WkRqdEl5L3pBTkFyKzQ0OGZMTTFBWDNacXdj?=
 =?utf-8?B?TitlazRib0Z1bkhtbUN5QjB0azRGZmFKaGUyTWZad3l1RmdFdkxqdkpaRUYy?=
 =?utf-8?B?U1d5QWFiYXJRZXlxa1p0SjZtU3RPMlJYTFoxMTVuUUtvMUtpRjVHOHlGOW8z?=
 =?utf-8?B?OEkwQmJnUzc1OUxhRWFSVEwxRVhLeXlyKys3dzFmYkpYOVVZNWFndmxZQXVR?=
 =?utf-8?B?bUFoTDRsQXJ5WjdObk4rVDdMUVJrRytVcmpRQW42c2JSMUpVSklHak5iN3VE?=
 =?utf-8?B?cTRESGIvUlhqTW9qTVYyUXh2S2VsUE9VTXc3RkZTSkhPN0lhcjRaZE8vZ294?=
 =?utf-8?B?eGZ1Mys3REYycC8zc3d0ckppdmZzajYwQ3o2WUtKc0t2Q2piKzRTOHlNYzZP?=
 =?utf-8?B?UGZ0ZHZkdEJoYmx1YTRCTzZhRThGanVaSHRLbXFteUVacEgyNjhOblpTZURD?=
 =?utf-8?B?WlRJUWE3QVRmWjBmUnNFMTJTbHNZczJIVjlySzBCczl4czZid0lwUUJxdmlk?=
 =?utf-8?B?bXFYeGE0SVRJeXZGQXM5eVdaUm14ZnBlTVo0VzFLVWltejlwRllzbFMvdUp2?=
 =?utf-8?B?WmIzTWViYzVwRlZuN3RNbTU4YlpHVTdXUFBiSnFjYm1lZmUvU2VYNXFYczBs?=
 =?utf-8?B?VDBoNUpuWkd1aE1MQ1ZTbUlRRGtRR2Zmaldnbmg1MFBaMVhTanNCNDJpS1h1?=
 =?utf-8?B?Q0NGY3pDQmh1cEtHQ2RITWtDMmxveUtlTVZGMkhKU0JjV2pVRGhJSWV5YWEr?=
 =?utf-8?B?Qk1OZlV3c1drWlVwU09VdUVxaGtMdXZJWDRpZktISkpLMnE3dzF1ZVd0RzZC?=
 =?utf-8?B?SkZSOUJHQ1RwQkVpZzV6WmkzMjFUdXYxZnIxOGt5dmgxRVhjdnBGaDFnbTRQ?=
 =?utf-8?B?M0F2YUFYSjZNckh0U0JnL21TaGltUmQ4ZFpGZGxFa1JPOTJFVWxPQUlqTWZw?=
 =?utf-8?B?REMvVktkS1N5SUpRblNtL1lDRFVIdWIwd21GTmdRdXRybHNoL2hDRlkwcjVS?=
 =?utf-8?B?MXpJaW92V0dWREllUXB4NnBLeitTSWZqempvM0J3ZER6dFVQTS9KNlk5QUdv?=
 =?utf-8?B?b1Q2NmtFZk1YUlN2YlgyaGFEako3RG1mcWg5QW5jMSs2QkJTR25yN0xmQVVi?=
 =?utf-8?B?OWdFb1YwQ2FNWkpuZm1TZVBuTTE2OVdZaU5XZ1ZJNFpXa29ZQkJVRld2TlJs?=
 =?utf-8?B?RDI4YUt2T3RudURDU3hzRGc1N3VtM0dZcXVnQm5uUGdWSlhENTd2eTZ6QU4r?=
 =?utf-8?B?NlA2YjU0YTNxZXRib2hnTzJqU3RZVmFHVGh0NEJYc1dXNlJad0hoS1FYY0U1?=
 =?utf-8?B?S3ZNSUN3LzJZU3U4a24reHBHMld3eEhxRytEb2pEdFRwd0l2VENZZk1GMUVF?=
 =?utf-8?B?Rkh5QnJna0F5azRqVXJrSXRGblNaWGhjNjRTTnhGalJoKzhoRndEUjFVTHZJ?=
 =?utf-8?B?WGVqVFJKNVJUREFaWklCanhiMzR5bzZoYUJ3aEZOMTNCVTAzZzVtTjBoQ09Z?=
 =?utf-8?B?Ym4vN1JGMkhxb0ltSUxBTkx3SUhlM1JaWEdqYTArSU5qN3dWQlQ5djJoajFV?=
 =?utf-8?B?U2lPOHRJcklrblJhS0pXNk95Q2FJLy92b1VMNmJVQVo3VkluMFkrbS9vQzB3?=
 =?utf-8?B?Rmk0a0dETUtQQVVIZTR3MFRNQ3hYWnFrSE1uNHhPTXVnSnZJQWF0V3RJSTB1?=
 =?utf-8?Q?ccD+mHny7hkGOcT8hZE0HvJreELs4AWY=3D?=
X-Microsoft-Antispam-Message-Info: VqqSACFRZI3Pm106bfvWTQSMhJZYNqHERJMTb83ZL9cgCTtNDEE4WTFhxjPgO6lzw8Y5U67wOZJAzCwk1vM5FfothPi1cuMuMybgsP89ZtjbbPvdt+WMXnyc2ORiG2MbWht9mXMoaUs5xY3ypoUushiRXRChBviVEwqroGmXughTBNrdpMT3HgyTWWEB/Hyy
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:eyxBRHXTrtRXNSjNsxDhhAD6tTWf5R6ONmZEPu3GU3SQAOxg3CDpK+ySRve3OIZ2wNIXkjSa4PDDsREfKKIEmxb7jpeN13M4+2w+o5y46YVYFOGCHapca/kLNqcXO4/79QRNfKQCf/+mivOakyMm1RrrDDvpNRwpvlpvNe2fc3wy6zN9VP8rO5td4UnihK6eBz6f1PaD+XlQfqUadxb5MbHHOfsAOS+B+rTnqgOKdl2gbOOqre3tyZnR3tlmUOCFvfGBsI7fHXwN0dwshjlT0/YGlyAdtjmFKWrkYmBrtV8IVDpbClWJTWUippl2iprrhFH3o30X6J9PFddfFK98ZZDR8fI4VxR3y2OActGrq5k=;5:aPSDFXhK0N15l8fcxA89Gh1lr/XYnbKLlnl93ghf4aZ6Qaa19QbhomskK8rJWPOsOUQGsBe6EJASYmCgPVWvId5VaUvPaZH36cx9cGQLsqjuSBf7U2JFN4zFamNUVMHcEZSOt1522BmLQe30UxFrWp78MlFkB3Mosq4YDyF3OL0=;24:JDE0fOxrO25ULC+ZYbw1gdWlzj/7mcotPKKSZfGZjQTdAENqwR2RMuD+5wBW0dlWAPRBr+RRT71H+d3R9lCo/x22s8xRB5x/8MAk+tnX94w=;7:3/mlK+jADJjgBH2ibjjLQ2+k46o1/MoRj3Ss1lyKVwfoxRFgI9fV4G3m2spe1YM/U0R6Mvw02h/f1QYSe5ibPiK7PIbJdUdIowyXiT0pf8PP/vcE6kbrcNEsNjmLN3CGOjL+KQcP1vFG4nHMKhvuJk93OcxwOTXOEhePVlbeSxB0PXqG30ra/icBmrRIsFsnalXqzak8WVKqL5GVNWjDc6ZtlA2PKd0+yS12hhUjlsvSKHgyOcea0L3IMuObkYvZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:y1M2kuq4IFHblZttdEEDwNMt38T3/jZCQ9x9njL6hfafdeX0T4+xylfWqzBSG0oiFDDrVLIo8ailxBHHV4jHLJIfCE16LY+DdlaqH9r48A2vAr0bNy/fgeeYIlCBQc6jEbJ+dZIqW8+js9aOKNoPdyFyXCBMN64LMt6+YcKTDoY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 13:15:19.6366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0898254b-8e78-4fe8-9877-08d58e64a1cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2018 03:18, Dave Chinner wrote:
> On Mon, Mar 19, 2018 at 02:06:01PM +0300, Kirill Tkhai wrote:
>> On 17.03.2018 00:39, Dave Chinner wrote:
>>> On Fri, Mar 16, 2018 at 11:55:30AM +0300, Kirill Tkhai wrote:
>>>> On 16.03.2018 02:03, Dave Chinner wrote:
>>>>> On Thu, Mar 15, 2018 at 10:28:43PM +0300, Kirill Tkhai wrote:
>>>>>> On 15.03.2018 20:49, Michal Hocko wrote:
>>>>>>> On Thu 15-03-18 18:01:34, Kirill Tkhai wrote:
>>>>>>>> xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
>>>>>>>> So, it's called for memcg reclaim too, e.g. this list is shrinked
>>>>>>>> disproportionality to another lists.
>>>>>>>>
>>>>>>>> This looks confusing, so I'm reporting about this.
>>>>>>>> Consider this patch as RFC.
>>>>>>>
>>>>>>> Could you be more specific about the problem you are trying to solve?
>>>>>>> Because we do skip shrinkers which are not memcg aware by
>>>>>>> shrink_slab:
>>>>>>> 		/*
>>>>>>> 		 * If kernel memory accounting is disabled, we ignore
>>>>>>> 		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>>>>>>> 		 * passing NULL for memcg.
>>>>>>> 		 */
>>>>>>> 		if (memcg_kmem_enabled() &&
>>>>>>> 		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>>>>>> 			continue;
>>>>>>>
>>>>>>> Or am I missing something?
>>>>>>
>>>>>> sb->s_op->nr_cached_objects is a sub-method of generic super_cache_count().
>>>>>> super_cache_count() is owned and only called by superblock's shrinker,
>>>>>> which does have SHRINKER_MEMCG_AWARE flag.
>>>>>
>>>>> Xfs inodes are accounted to memcgs when they are allocated.  All the
>>>>> memcg reclaim stuff is done at the VFS inode cache level - all the
>>>>> XFS inode cache shrinker does is clean up inodes that are not
>>>>> referenced by the VFS inode cache because the memcg aware reclaim
>>>>> has already freed them.
>>>>>
>>>>> i.e. what the XFS inode cache is doing is perfectly reasonable -
>>>>> memcg aware inode reclaim is occuring at the VFS level, but on XFS
>>>>> that does not free the inodes as they are still referenced
>>>>> internally by XFS. However, once the inode is removed from the VFS
>>>>> LRU, all memcg information about the inode is destroyed, so there's
>>>>> nothing in the XFS layers that cares about memcgs.
>>>>
>>>> So, after inode is removed from LRU, memory still remains accounted
>>>> to memcg till the time they are actually freed. I personally don't
>>>> care, just to mention.
>>>>  
>>>>> Hence when the XFS inode shrinker then called to run a
>>>>> garbage collection pass on unreferenced inodes - the inodes that
>>>>> are now unreferenced in the memcg due to the VFS inode shrinker pass
>>>>> - it frees inodes regardless of the memcg context it was called from
>>>>> because that information is no longer present in the inode cache.
>>>>> Hence we just ignore memcgs at this level.
>>>>
>>>> But xfs_fs_free_cached_objects() returns number of these freed object
>>>> as result to super_cache_scan(), so shrinker interprets them as related
>>>> to a memcg, while they may be related to another memcg. This introduces
>>>> a disproportion relatively to another shrinkers called to memcg.
>>>
>>> In what way? All memcgs see tha same values from the backing cache
>>> and so try to do the same amount of scanning work. The shrinker
>>> accounting simply doesn't care where the objects are scanned from,
>>> as long as it comes from the same place as the calculation of the
>>> number of objects in the cache it's about to scan.
>>
>> shrinker->count_objects() result is used to count number of objects,
>> do_shrink_slab() should shrink during the call:
>>
>>         freeable = shrinker->count_objects(shrinker, shrinkctl);
>>
>> Then shrinker takes part of this value:
>>
>>         delta = freeable >> priority;
>>         delta *= 4;
>>         do_div(delta, shrinker->seeks);
>>
>> This is a number, the shrinker tries to shrink during the call.
>> Let the priority is DEF_PRIORITY. Then, shrinker try to shrink
>> freeable*4/(shrinker->seeks * 2^DEF_PRIORITY) enteties from every
>> shrinker. Equal percent of every memcg shrinker.
>>
>> When XFS shows global number of cached objects in count_objects(),
>> shrinker also tryes to shrink the same percent of global objects,
>> as for other memcg shrinkers. So, when you have small memcg
>> with 128Mb memory allowed and small number of tasks related to it,
>> you may meet 1Gb of cached objects, which were queued by another
>> big cgroup. So, the small cgroup may shrink number of objects of
>> size more, then its own. It's not fair. That's all I'm worry in
>> this message.
> 
> Actually, it is fair, because:
> 
>         /* proportion the scan between the caches */
>         dentries = mult_frac(sc->nr_to_scan, dentries, total_objects);
>         inodes = mult_frac(sc->nr_to_scan, inodes, total_objects);
>         fs_objects = mult_frac(sc->nr_to_scan, fs_objects, total_objects);
> 
> This means that if the number of objects in the memcg aware VFS
> caches are tiny compared to the global XFS inode cache, then they
> only get a tiny amount of the total scanning done by the shrinker.

This is just wrong. If you have two memcgs, the first is charged
by xfs dentries and inodes, while the second is not charged by xfs
dentries and inodes, the second will response for xfs shrink as well
as the first.

When we call shrink xfs partition of the second memcg, total_objects
in super_cache_count() will consist only of cached objects.

Then, we will call super_cache_scan() in the loop, and 

total_objects = dentries + inodes + fs_objects + 1 = fs_objects
s_objects = mult_frac(sc->nr_to_scan, fs_objects, total_objects) ~ almost equal to sc->nr_to_scan.

So, if the first memcg is huge and it's charged 10GB to cached objects,
the second memcg will shrink signify part of this objects (depending
on do_shrink_slab() priority) in case of reclaim coming.

> And because all of the memcg shrinkers walk the global inode cache,
> the overall scanning is shared between all memcgs under memory
> pressure evenly and so none are unfairly penalised by having to
> scan the global inode cache to trigger final garbage collection.

So, if there is single memcg using xfs, the rest of system is
responsible for its shrinking. Completely unfair.
Isn't this easy to understand?

> If you just look at a single memcg and shrinker in isolation, then
> you are missing the forest for the trees...
> 
>>> You've described some theoretical issue, but not described any user
>>> visible or performance impacting behaviour that users actually care
>>> about. What reproducable, observable behaviour does it fix/change?
>>
>> Strange question. Do you fix problems only when you meet a reproducable
>> BUG()? This is the kernel, and many problem may be racy. But this
>> does not mean, it's prohibited to discuss about them.
> 
> That's a bit extreme.
> 
> I expect people who are trying to fix bugs in complex subsystems
> to be able to explain what the bug is they are fixing, what impact
> it has and how they observed/measured the impact. Especially for
> somethign as critical as shrinker infrastructure - if we screw up the
> calculations we'll break systems everywhere and when we have to fix
> those bugs we need to know why those changes were made. That means
> the reasons for making the change (i.e. what problem was being
> fixed) needs to be documented in the commit message.
> 
>>>>> So, is there a problem you are actually trying to fix, or is this
>>>>> simply a "I don't understand how the superblock shrinkers work,
>>>>> please explain" patch?
>>>>
>>>> I work on some shrinker changes, and just want to understand they don't
>>>> touch anything. 
>>>
>>> Oh, goody, another person about to learn the hard way that shrinkers
>>> are far more varied and complex than page reclaim :P
>>
>> It may be a surprise, but I have to say, that all memcg-aware shrinkers
>> are based on list_lrus. XFS is exception. So, your words are not about
>> shrinkers in general, just about XFS.
> 
> Speaking as the original author of the list_lru infrastructure for
> shrinkers, you've got that all back to front. The list_lru was
> developed specifically for XFS scalibilty and performance reasons
> i.e. SHRINKER_NUMA_AWARE.
> 
> The memcg stuff was tacked onto the side of the list-lrus later on
> as it was a convenient abstraction to hide the bogosities of memcg
> accounting and reclaim from the rest of the mm subsystem.  IOWs, the
> memcg infrastructure is the exception case here, not XFS....

I don't reduce someone's merits. And this patch is RFC about the
unfairness, I described. If xfs people are not interested in this
theme, then I am not interested even more.

Kirill
