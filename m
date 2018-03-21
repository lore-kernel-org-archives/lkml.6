Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCUQP0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:15:26 -0400
Received: from mail-ve1eur01on0116.outbound.protection.outlook.com ([104.47.1.116]:21950
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751594AbeCUQPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:15:21 -0400
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
 <ec116ce6-c22b-66e1-0e01-55f895997c7d@virtuozzo.com>
 <20180320143452.GT18129@dastard>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5eb88165-c108-5989-3cb5-1f260cec5e53@virtuozzo.com>
Date: Wed, 21 Mar 2018 19:15:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320143452.GT18129@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51e5d4b4-592e-4295-441c-08d58f46efb5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:SrYcrgq/kbMQVpYQm/CTH+LtzWUkWoal3geRlHxSb/AO9WV9CQq+qxdcuat+cSdECRPKurIsRj2BJCep2uXIBm7kG5ZlBFu/sIEWe/qBBD4/VyhxTvyc8qhtBOM5wgm+3IsvPV8BN3aYxLgDPMyTUZzQmpec2VnYSQAAqG0r6T3q3IeOgoYQuraSnbRe3+GhHZcaFcyzweRjadLQ9La3yh57MulKZYn/OfOv4mbOm+wy/xikbya9VvTA+q0U/hU0;25:oeHTeiOak/9ynG9PVBB+1AJSKcG1MNWk10RU0sHXh1GC18pzRaVrM15SAgZBR/I89c9SlCHdg9EKyS/E7O5NESRLfm72l+Mde8BRexYd/KP/vc9TanDADNgpGbirXqmYzBjJS6Ybk14JGXuPaxoKzSRdRS/Da/EBkrheWqR6b2DtNuXDW0ZjnlMjxyroVk+RAo4Pi6+DRSiVSE5Y3zHD5GDz/IjeWqXr2lQRaTBSp3BOLsXo3WhWcN/sXWJjFXR0CzMlcOlqFgsDq/tKVLZAtbZZMO19VuyF4WPPSah+wgWfA62pk/36ybuqYR6z6ZC7XasanqaPrEocYPic8nmVgw==;31:DdgT3A7Vr4PRgPY0dqg/JUdC+Qm0hwksn0iBo2h8noa4vO+DRuHJtK07TssVP2aAZm1zp+A/PqNLtS7+oy2IAQdYhS2C2F3UhB0QKEXs4z9UCbmWwYb8ANDaKFjLFKbKUdpvzUIPLTZIXVCSyPpw1Oz2zlZfZJBRU6NiEQxShsZGvoFYtpfTvOGqiPOPcs3+L23IHSEpUvzV5dnPFuULwbRjpoEt7ytGjH57qDsXQz8=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:lO6dU3qOTUXcT1JSrmUCz8iUFOdRJni7t5iIFHXp1ul/ONAsuemmdu49cWgTTqFaNzKTE0W1RHBsOHhLHyqVBV9Imhp+K1xbviAFitWOI/1tUYKhI4OFtuwglKZ/EVUGa2Wt7TqxQKtQ6yYRlhEDvhJf/R5WfR/oSbBnGMSASDGeXK7PXBCFDx7+THqFkDWQ1C7gFY7iN5y72h8YFGIqkHPrt/jF9zEjqgs5bGnRfwn5EdZD3Sn98DxUZi/jLJR/rPA18TJ9fpdAOZ5Edzd2/PY8NLNfAGqJXCbwfQbj2DaIkRq2OI+o1CgzP8QQ7tkRFQBHBJZOno0f7nsX3FLm0hpyTUBipehZFjeJ2oXNHeyVZXHsoANxarXkHvKGBEpbtzfva89aF1aPlrVuGK16xJCY/UGjQsjka3vrWrNqdHReeQivrNOq4C48ZNlPL8R/4fHmstXXPA8p6G2+Vgnya55IpwpOclTV6xej6eM4rH+vilDohC8S4R73bTVwyov4;4:w2pVHA0A/P+RJ2X0GMKxROoIHF7wCOAmIpwJPY5awxefgz0mEykGW5xzGQgw22uBHp0SbyO0YrXUuXeWI/Va6vxTivqnGoWG58r09sO88YNOcM1UhlhEsxIt4n4raguCdIRRY7FBJ93USmr33HynP0615biKZ0FZPJsBYDj9rJvqmoQ2g/25Bs/yr9mInd8xyHmELLdwhR/rSbetpS1nt6BLhz12hBgtEzaby9zkX/8auysA/z/nDHV8S9Jf/Gaq+C+9Nq1D07TyWrdp1vbWemspGFc0vnTmGVO1y9iHsKGi+zr247h+fJHhqJqACl2J
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134190F2642B3FA7624EC1B0CDAA0@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501324)(52105095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(396003)(376002)(39850400004)(346002)(189003)(199004)(6916009)(2950100002)(47776003)(16526019)(186003)(65956001)(229853002)(65826007)(65806001)(66066001)(93886005)(26005)(97736004)(77096007)(316002)(55236004)(68736007)(59450400001)(2906002)(53546011)(386003)(58126008)(8676002)(81156014)(81166006)(230700001)(8936002)(50466002)(86362001)(64126003)(16576012)(5660300001)(31696002)(3846002)(4326008)(31686004)(53936002)(6246003)(25786009)(6116002)(7736002)(305945005)(36756003)(52116002)(52146003)(76176011)(6486002)(106356001)(105586002)(2486003)(23676004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6OE82SktFMCtSMUNFVTRzTEIyTURWays0?=
 =?utf-8?B?U1RicjZGYzljdzhnam12ZFpVOThWZDRUVGZkejdEWjRLS2crTDNnWWE4VXJ3?=
 =?utf-8?B?V01pRFV0cmM0cXZxdjZodmRVbXRDZ3VtOHN6bmhZVlBNTklsaDBLL0Z2Z2s5?=
 =?utf-8?B?TFZwUm83SjhZSkZPU0pwTCtjS3g4RjcxTE9GTEhtOHJrd0paeWZBcUc2KzNS?=
 =?utf-8?B?VzRXQ0tmRmZzZHNLd1JWVWE2OEFnV1g1Z0Q1UHAvNHhRYzhubFNOWkxSSHA1?=
 =?utf-8?B?b1UySTlDaG1oRXpJSlN4a1QxTWhXR3pmT1craVp4RFp1a3FxQnR5V1I5ZWpC?=
 =?utf-8?B?b2hVQ2VJZStLRUkzLy9aRVJFamtDbHF4UTRaaUNSMmRQOUljZWFmcVVZM1JX?=
 =?utf-8?B?Si9CZkpzMEFiN3NnVTU1czhzRm81cWJ2Rkk2SUZRQWRpejZ2dDVoakFNeWZ2?=
 =?utf-8?B?N3NYWDlacUVOT3JqbkN6L3VybWU3YS9oM2l2UlEwQ2g1TEd5WWlaUEVlVCtN?=
 =?utf-8?B?QlRVRzNuYWU1UlJLYkdwaEZVdHVvM1BUL1JIYW1SVTdLdUg2TFN3Yi9YR2Qw?=
 =?utf-8?B?Nnd0NEY2c1dCaGFyZm1ZTHdqVHpRcXViWFpGYThadDN0ZUtiMGhhTFYyZEdR?=
 =?utf-8?B?RUFJVFl4S3Z1cnJyYUNEZktoRFp5TXcrMmNOalU1ODBPNUpONnhvejI2OHVK?=
 =?utf-8?B?cmNleE0rcTlmcSszUE1hQWk5ZUlEc1NDbTU1V05jbm1PcldkdGV1MnR4WDAr?=
 =?utf-8?B?aFBqOWFQb25IWHU2UWpndGxYYXdCd3YrNnFCcU85Z0E5MG1OYXdqNEZFdUZv?=
 =?utf-8?B?SzBoV1VmNjJxSFhPYTJBYlRvUjBmcnRQV01zbGkyd1RmakxrbldlNW1Ebm1Y?=
 =?utf-8?B?bjZtdDh0VlBaZWRTQUNSQmh2NFpnYTFvaE1zbnY5MVRaU1ozRTlSektQQ1h3?=
 =?utf-8?B?czYyaC9Td0R5VUpyM3FyWnVzVVljVnV1NzMvLytQamxXVjBTOWgrMlNQZTBx?=
 =?utf-8?B?NFQ4U1AvOFg1OUg0eC9oOTltNFlxT3FkMm9pR0hTVW51RDJ2b0ljM2ZDZjF2?=
 =?utf-8?B?S3N4R3RRcWgxc1owRzlPUHhDTU01Tk4zV0dMbEVCT2xQdGhydGJiMElyUGk0?=
 =?utf-8?B?bDZmYlptSm5IRkFLU2dsb3FwOU83SDZHZFpqWDFTUy9WMXBLKzB4cjc3cXBu?=
 =?utf-8?B?MVpTWWdBczhOUStSQzdqdTFUcHAwRVhFTTdEWmE3Q0VJSlRteUVzN0FVVkFz?=
 =?utf-8?B?RkxKekMxeENaZEdRQjVHeU4rU0FrU0pHVUx5b0hwV256RlpyY0djeGJGckNu?=
 =?utf-8?B?TEhGWTFROE1GeldOd1pKYno2eENSTmJTT0Rab1R5bjUxamlZSUFjSThlT3pm?=
 =?utf-8?B?S2E4aDFtVVRvRzhMQ045cGU2ZVZQZ0ZoWFY2TEFEOThoNUgzSEhFajZLc0o0?=
 =?utf-8?B?OGZNWTN5azR1ejBJOW5IR21sMnhBSDJSRExIZ2dwZEsxNWZIakRONzJrY2RL?=
 =?utf-8?B?OURvUnFCTFM1VG91THY2eWU1VjB3RitKc0V1NW53Unp5cnlXUWNNUlUxQUZh?=
 =?utf-8?B?TDE5OUF6MzIrRm1GZmMwVTJaSEVIZmhPL3ZCNllOTW9EK1diWHlVNlZKQzhx?=
 =?utf-8?B?QzRacDJBT2VhTkRGeVRkU2ZEckZyc0pwVjlxQU5JT3pMMjArNW5Id2oxdktP?=
 =?utf-8?B?L0RUQVZFQytsUDJuWnBjdlVBb2tLMmxZdXBoN24xSmpSZDVJejdGYXB4RGVp?=
 =?utf-8?B?a2YvUmdOQUlDcGJjaVB0ZmtEcEpTWHlWdklEOTcyRTRSc1Fab1pvRDh6WjRk?=
 =?utf-8?B?NkNzZVNiV0ZoSy9IdFFGYTNQSlR4MmpKckE2NTNySWtJWGFSOXBSdXg3a1ZZ?=
 =?utf-8?Q?kIPGBd997CGx4=3D?=
X-Microsoft-Antispam-Message-Info: vVIWZChncBli6WPthGUfqLLhcqQMCFXnSwI5aFnbDgv9EdXTlhSEIKSQuQXaW2MDQ5C6TKlp+JEX7kR0TVyiOCkNfIqfqUNDQ/I4EXH3G3iSAjqYCGCUaNeAZGKBym4e6MgtT4yuxaSY3cfMjOJSyYp9MfUgZdoLNSofdBibcxGHpDTkrCXayWWOhpvHF5zY
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:xMrBJftcAnZN/vdk0W5CRBIg2aD5TfV1WuFDZa05Xy3h+OiAnGmLIF3YzCqq/G4K6UAhOcq3qaXnNV/ZYzUzTr+h7PXE8ibTy5X2S7mb29RXoQxHfm0X0H13GrvJXB34xMtr5VyVLu/1UN3F3qE2j3dPMaGSzdpXaAgTjgHruFfXofcN3eFrgV5wm2tWwksrmPp+DYHIFNrB0Q/CLvilQQpedT066kpjyEc7tzmDYpi5IIKtDADsn0Xcn56RZpiH98C71FrukJraXvaF3Yu6tv1L+pfwhxI2U4GKVD9teGCDum+73mdh6UaXP8RxsPzV0rAQWALjK6L59/jf6YchsjHuiP8NubxUkYw0+Rjir24=;5:QmzQknEAhbaks40oohZ/fDfGAs/Dxb4a0kKh2epKCMs1UWKwUHpGEEaGaA1zuofmxC1XaHDAIl3dP9UtgLU2wQQeugIL98PCAYlSl0bAFpo9Y8rNWkknDj74gbLFT1HdibwYzZubOabiDno+VDKtIGdjRavcLo5nw8D0LlzJcjs=;24:spqH1bvZAP2IOvunZmKN4UWyWaM02wm8l10jLT94WIpaC9Si5ze2yjcW+UAereFN1V+BLlmRHBIbOagC6nZNnveaqie4JyEpxgM7iBVbt2w=;7:qsb/E5MjCCpZPsuFy+v2NtghI0I28LND5WemqrJBcwdsdqjHNXEoa8QatR6ivdyzWcf5IXOLq0fRrRnVwqhc172ugOuB33rdO5dz7f8jVmloDIAnwqVWLvOd/cDkMYuo9W4eneVrAtMXj3MnT7qsfAu/pC6MJz23hcMX3ownTbUNupztkE9oQacBUOo3C//w/bApmm5Svz+e9fkGYXiRQ9wl5Y0O/LJygbJuE8WIgqWmqCHZVqp7eaoKAaiZ2PnS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:ydJ7C+hPD72DHkLwXycrycJKaGHCAhfksrmtUbCsSjFBY/ahAI5vrTV5d24dOwyEmSx62DwYpEkv7g/3Cb3l1xKEa+O8jDWxk4H5EDJ7qo3+LWDXA/YaXMzf0+rdjSIuL8VMp0Uu9z+ZMypPiW0wXo/5z6obWWt5bDlThoZk1lE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 16:15:16.9284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e5d4b4-592e-4295-441c-08d58f46efb5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2018 17:34, Dave Chinner wrote:
> On Tue, Mar 20, 2018 at 04:15:16PM +0300, Kirill Tkhai wrote:
>> On 20.03.2018 03:18, Dave Chinner wrote:
>>> On Mon, Mar 19, 2018 at 02:06:01PM +0300, Kirill Tkhai wrote:
>>>> On 17.03.2018 00:39, Dave Chinner wrote:
>>> Actually, it is fair, because:
>>>
>>>         /* proportion the scan between the caches */
>>>         dentries = mult_frac(sc->nr_to_scan, dentries, total_objects);
>>>         inodes = mult_frac(sc->nr_to_scan, inodes, total_objects);
>>>         fs_objects = mult_frac(sc->nr_to_scan, fs_objects, total_objects);
>>>
>>> This means that if the number of objects in the memcg aware VFS
>>> caches are tiny compared to the global XFS inode cache, then they
>>> only get a tiny amount of the total scanning done by the shrinker.
>>
>> This is just wrong. If you have two memcgs, the first is charged
>> by xfs dentries and inodes, while the second is not charged by xfs
>> dentries and inodes, the second will response for xfs shrink as well
>> as the first.
> 
> That makes no sense to me. Shrinkers are per-sb, so they only
> shrink per-filesystem dentries and inodes. If your memcgs are on
> different filesystems, then they'll behave according to the size of
> that filesystem's caches, not the cache of some other filesystem.

But this break the isolation purpose of memcg. When someone places
different services in different pairs of memcg and cpu cgroup, he
wants do not do foreign work.

>> When we call shrink xfs partition of the second memcg, total_objects
>> in super_cache_count() will consist only of cached objects.
>>
>> Then, we will call super_cache_scan() in the loop, and 
>>
>> total_objects = dentries + inodes + fs_objects + 1 = fs_objects
>> s_objects = mult_frac(sc->nr_to_scan, fs_objects, total_objects) ~ almost equal to sc->nr_to_scan.
>>
>> So, if the first memcg is huge and it's charged 10GB to cached objects,
>> the second memcg will shrink signify part of this objects (depending
>> on do_shrink_slab() priority) in case of reclaim coming.
> 
> Do we really care which memcg does the global reclaim work as long
> as it all gets done in a timely manner? The fact is that when there
> is global memory pressure, shrinkers from every memcg will be doing
> work all the time and so it really does not matter which shrinker
> context does what work. In such cases, memory reclaim is all about
> bulk throughput, and we trade of instantenous fairness for overall
> fairness and higher bulk throughput.

There is container workload, when services are executed in different
memcg to controll their resources. If there are database and mail server
in two containers, you want to make them use their own resources,
and don't want to make database shrink mail server inodes and vise versa.
You just want to allocate resources enough for both of them, and make
them not affect each other.
 
> And, well, the bulk of XFS inode reclaim is not done by the shrinker
> contexts - memcg or otherwise - it's done by an asycnhronous,
> non-blocking per-filesystem background work which is kicked by a
> shrinker scan being run on that filesystem . The only reason we keep
> the shrinkers doing direct work is to throttle direct reclaim to the
> overall background inode reclaim rate. It's hardly fair for the
> filesystem to automatically do the work the memcg should be doing
> and doing it faster than the memcg reclaim can do it, is it?

But is there another solution? Something like work queue or kthread.

> FWIW, inodes are RCU objects, so they aren't freed until RCU grace
> periods expire and that means memcg reclaim does not actually free
> inodes immediately. They are always delayed to some time after the
> memcg shrinker has run and reported it freed those objects.  IOWs,
> it really doesn't matter which memcg context does the "freeing"
> work, because the freeing of inode memory in any given memcg
> actually occurs some time later from callbacks run in a global,
> non-memcg aware context....
> 
>>> And because all of the memcg shrinkers walk the global inode cache,
>>> the overall scanning is shared between all memcgs under memory
>>> pressure evenly and so none are unfairly penalised by having to
>>> scan the global inode cache to trigger final garbage collection.
>>
>> So, if there is single memcg using xfs, the rest of system is
>> responsible for its shrinking. Completely unfair.
> 
> If there is only one memcg that is generating internal memory
> pressure, then only that memcg will be running the shrinker and
> reclaiming dentries, inodes and XFS inodes from that memcg. Nothing
> else will be running reclaim and hence only the memcg shrinker will
> be doing reclaim work. I don't see where you get the "rest of the
> system is responsible for it's shrinking" from - that just isn't the
> way the shrinker infrastructure works, regardless of whether XFS is
> involved or not.

Every shrinker is called for every memcg. So, if any other memcg meets
reclaim, it will also shrink these cached objects.
 
>> Isn't this easy to understand?
> 
> First rule of shrinkers: Shrinkers *aren't easy to understand.*
> Second rule of shrinkers: See the first rule.

Kirill
