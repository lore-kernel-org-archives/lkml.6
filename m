Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeCWMkD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:40:03 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:62528
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751793AbeCWMkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:40:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH RFC] xfs, memcg: Call xfs_fs_nr_cached_objects() only in
 case of global reclaim
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20180315230313.GM18129@dastard>
 <6628c551-f607-367b-1ee6-f458266c1d92@virtuozzo.com>
 <20180316213910.GF7000@dastard>
 <18a031f3-2136-4ef9-6ede-05f5b835661c@virtuozzo.com>
 <20180320001827.GB1150@dastard>
 <ec116ce6-c22b-66e1-0e01-55f895997c7d@virtuozzo.com>
 <20180320143452.GT18129@dastard>
 <5eb88165-c108-5989-3cb5-1f260cec5e53@virtuozzo.com>
 <20180322050152.GA18129@dastard>
 <3320c962-35c5-c5ed-2a9f-0acb2b875579@virtuozzo.com>
 <20180322234613.GD18129@dastard>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c1fc50fe-25e7-a92a-a2a8-3e40e7de9b0a@virtuozzo.com>
Date: Fri, 23 Mar 2018 15:39:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322234613.GD18129@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0102CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::43) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afe984db-ccdf-4bb0-5d74-08d590bb2ede
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:NWnmQ5n0WxGmxv7YjbfZ13Uj7S+1g5lkcH7ID07XuVL1LtQ8rou6/dycBD8UVGhIqrBiwRGqHGl361cBtywsmIdHEDFNQ/UvgcRlHWq/VKVcYUePtBEMpbJ900gy2vVptctNnHK9r2IBZpwW75VEMpXZaHLni1VgXym9R5idfS1I+5+urKx12YSrnKZaavdSr+Bu+681JtbbZNJYysvHkS745WeffoVmtGpewH7O0y3IP/r/gKG+Sc6bwrU2IHIx;25:BywydzJoZdPBKTyLbbyZEpvq1Yzmrg6T4IOuaKaQ7eyjZOFf+yiF229YGxlS3YbpbQ72G3opkvQFRzbkql76oeMnzgrT1BXESUycqkc/rb0x0V8Cfs+cpaJ+btmPftx9Uog3DDNLfTugvYRY1FpVI66BS4d26LfB1q8u9MkCDO7GwrLAKdDn0Q+GrXX9FfxYAecHr9cDeu7UkQOcJ1P+/XPfFMYxyg/lSpMDhI+bNTCJO6YyXDhXEzt5usxakinPoiTJUpdg4BPEzPhevNDS2xM/ebiYTQtCx277jm1jLKiHpToRYGUm4orIVq4JwiYHGEeK7XJGe9aVLUjNLoNhvw==;31:Ey0Bz4evSjozJ5rhV5W4JhQS+jbHKcR9kyFsG1hiygzEt5Oe/Pnf4KogQny8Thql6UxBgGC2sOFmqAw24wZaxD4peOyRkNfMSu8oX+tHh13Lqr/imIVo4rpKC072c4wNYZkFNgn6tGzdLlIMkq1cFArwgDc3NR5WHYvOiEyw8fLV5Wauq+eg001WIksM/At0mlhQfksbi+X2eT3tbZbGKAXf9qkU29SN+fNrk7VLRzk=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:LzdBEc0Bp8NIGB5CDTQslQNKttIyHEEAz6RC+4T7XKw6oV/2mZMLrlr9zj/1OCgonEBCWWanFBtANSBGrGys/gbZ3Cs9BBnuDzbrozxwj/zSKaVavWBvYaePX3tjacfJgZHVPNoAMf6EgGKLBCIYEnR+RbSOL7s0X4MlJIgCNZGJwUlhl6AwlcoNCCl6Ub6sADESWgloJCOG7X+FJK1ftIoK9/bbjlYzbO/n9yH9xLhygoMmAPxOY7Qsv+royO2Vqt0IWX51HvxSCZW5styksttoPzefRKcsFt2LYW1CUxtNxIpEV5Cn+ypLfgKfcvpreA6imuQeDYEygt5OjFYcCkOz9uG/vw6bqkcehsShc3jdncdlZHw4LdtPnTEeGJgNsHcEAFUVQQKXJvNfciQhdf6cY7YcIHnOfQtpys0UVr5pEbfI3zxtZIcEeIkl6mc9vsrWNikLNZ3c1Lah/47CMVBlTet1pl9ClXiEuQq7e4k3lYK3SVCWyaJboregM2v3;4:RBFExDxD9Y7yUyfTsxRUSQb8ap8Evf5TDgxqqO5yYJJ0Z4HST9/vb5r+lsFHv5PMY5YM4P5o74aNI7Rjpo7T6dh8vWYBs4lBNkufLCeRlNY11fH0dBX6S6VN25TCbfGN4b7hqRIw3g+EZupcfBp+KHZVgvgGu7G+BI4E3tMc39FJ425fRq8JfGmCcxL3tk+U7R7ys40TwB9RoiuGLw/SAthI4GKl6pPsiIg60kq+/Xp5BM1svA+kFZWYB2hWIA0/Ogsa/qKbl5eLWcfaNrrRIA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133889C8A0AA17F4EEAC139BCDA80@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(39850400004)(366004)(39380400002)(346002)(199004)(189003)(77096007)(52116002)(76176011)(23676004)(31696002)(52146003)(64126003)(6486002)(106356001)(105586002)(446003)(6246003)(2486003)(8936002)(3846002)(68736007)(6116002)(230700001)(86362001)(966005)(25786009)(11346002)(59450400001)(26005)(7736002)(93886005)(305945005)(31686004)(478600001)(386003)(97736004)(65826007)(16526019)(58126008)(186003)(5660300001)(229853002)(53546011)(81166006)(316002)(16576012)(81156014)(8676002)(55236004)(36756003)(47776003)(6916009)(66066001)(53936002)(65806001)(2906002)(4326008)(6306002)(65956001)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6ei81RXl0WDN0N1JlYmFVYU52b3psd1Fl?=
 =?utf-8?B?dE5RYmh6bjBscXhtR0t3WERsMU41dThxRlpHK3ZYb1QxUzdIUjRlbnI4NjlM?=
 =?utf-8?B?RlhxZWVNZi9TNHVIbEp0RkpVZHBiMzl2cXczS29WZkFKNzJuZVVvamJzSHpZ?=
 =?utf-8?B?cFdkRGRqcXFac2FtamZHSEZ0RndFNERhZVNJMHgvblpFL0MzWlFFRzdVaUdw?=
 =?utf-8?B?dTJqNFVQT2xmZUhWTXUwK2hnZndOaTlGcmZEcjM3L08wK01GUWVnMnRud0gr?=
 =?utf-8?B?NWRTdktYRlpqbXc5QWNadlRPSzFKa2dYVnBkcG5TOWwxM1JEaUh4OXJ4TzJJ?=
 =?utf-8?B?WGhVUGVaYWFpd08zaVFQOU1MVklYQ0hKOUE0R3VVMjRsYzhmTlJLOFRtMkpa?=
 =?utf-8?B?Y1h3cnFRWlF3WGswVEJ3R285ci9jQXprdzNldEJXMDVYZzJWOTYwZzJCT3ND?=
 =?utf-8?B?Z2NFM3V3TmJZUFFsaU9HNG92K0MxU1hKcVJQQXluL3doWDAwcGZsR0F4Rzd3?=
 =?utf-8?B?NmRzbkdxK0dSbDVDZFlPTVBWdFpPN052dWtob2hGcG92UVVNaDJXb1Vidmh6?=
 =?utf-8?B?QVhBeE5ReDN2MHN4YjFKeDJzYzRNQVcxdGRPY0c5NnYwNXlFNUE4eUxiSEY1?=
 =?utf-8?B?cGdTWW9sZ2I2cWU5SG9IK25RcHExOVkvYjlKMjg0U3QrQXBQSGZNVGxFN01U?=
 =?utf-8?B?RUFucVY3K2NteTRQdU5DVmZtZzNGUitoZHh2U2UrUm8xcjVKYkJBZTFsaWdj?=
 =?utf-8?B?dmFUbHl0dUdOdFpBOE9udlVoMjNQVXVMSkRYa0tKTEdQVjkzT2xQSkZuVW8v?=
 =?utf-8?B?LzN6MDBxOWNlOU9EaVY0dG92c0NSRDFZSVdaYWhJRWZScm1Pa3lTTGFGTDdi?=
 =?utf-8?B?UDcrUnB1TDdqeDBHSWlEb3FXYi9LcUg0VGt0b0JOR2pyaVVUVFdUT1NSK1R5?=
 =?utf-8?B?V0VYY3NacWpoM3RLdjV0UDdpNE1qai85VWZ0MFBjbmpLY2tZUENGNjZhbnJD?=
 =?utf-8?B?THR5ZlBLNFBsV0VLK1FrYWNOeURLQVkrYlZqby9YSU9oUHVaaHNzTEFybGQ0?=
 =?utf-8?B?WWxVZkozRUxwZlNTa2loUFl2anQrMkt1WFZ2NW12bnNTNnlzdXAyTXBLNGpU?=
 =?utf-8?B?YmZqdDVuOEJoc0N5WjN1eXBpTElqSHNMUE83alZ3V1NydHNUTUlEVkxmdVVm?=
 =?utf-8?B?Snh3T1VaQUpzeUo4R08yZE1SalZSSHFtMHlzdXp1cXR6N3BWUWVTVjdIeDR5?=
 =?utf-8?B?RWJxZnltZS9UclNyeW9SL0NhZjE3VjhqMFVBdG9yZ0JkeTRIVlc5anFiZEYv?=
 =?utf-8?B?S21NellWTnVINFVmNWNHYlM1UkE3S2NqeFJkeTJUVWRwQ2w0NWVoS2J2NmRK?=
 =?utf-8?B?WFhreERnd1FqZFI3Smlxd3k3ZVVISnR5VHluOHRmNUZpM3RjMzEwZEVrOE5w?=
 =?utf-8?B?MTJIWk9wNjhUNEQxU2N3TGk3Znc2T1RSbUtETmdsMmtXeVFuSjVPZ0RLYW1B?=
 =?utf-8?B?Qjdzc3cyVTk1aDRrM2tMV3Zob0xJR1hBbUxZNFhFUlVVbjV0THJsL29BS2VT?=
 =?utf-8?B?WEFXQVJUQkRKdjR1SFlpMk1KZnVwNU0vZFY2bnIxKzVCS0tnRlRBeUNyWU5M?=
 =?utf-8?B?amZKRlhDSUdrZnFrTXBKT1FOZWd5ME12VlcrMjZFa1JHQ1FCMDNqQXNWY01L?=
 =?utf-8?B?b1FYRVFnckVjaldCa1VjRGplZVlWREdUWXllT0FBM2pIaEpDWDdHdHBzak9q?=
 =?utf-8?B?L2FMMGZOY2ZvTVdvVG5icTBlbWI3ZTZoL1pEM0ZuU29ZeXlHaGdhdkl5NSsy?=
 =?utf-8?B?ZUhFN2V6YW1ma2RGbzA5ejJWODRraFZ5Y01XK1BPU2crRHR5ZTBiTmxSdTZq?=
 =?utf-8?B?LzVSYkIzVU5Id1l4Qm5tTTBLM3IzVS9CUmF4T1h4UHViL3lIUGEyZ05VN3Yx?=
 =?utf-8?B?Mks2UDhFWXZGVHc9PQ==?=
X-Microsoft-Antispam-Message-Info: tLwx9drQHQkZn8nevcoK57kbGNSF6mpCWl/Z5CFtOTyoiEz8Ps6gProudRHiY/hZ0JiFytKApFZshxiy8giDWJKh2SIZTJs1gDl4vxnt8hhtABb7QPZKjltMUaGK6aLA61kyCZaeTSZMFwvfuiuCp+bHo3koLMywHUs3enx8uc5ZsizJXDux08Xq1jWO134y
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:GH+zfRYBVOI3c9kfT0tRuZrexFwHks3C68/H4o9U0tFTHI0EcYYvhwhL3EFqJwiFtLUAZ1PZCE+nKp6NhszbiW+0oXWVM3kNAT1EaHqEp7sqeSr/PWV+AD8MpM5RDpUUhouYjfaZqHIzIKlrNXTfglvj8howegYwGbgzIx+M8hlTQEFL1EKPNPluetw9339zWUEmTcue4plLfImVD35Egba/G5epPzFtKitEC3EhwAKEzqhiBkAwnNk4enhCjtgDcr6y37x3n7rU7OfUMJo8taw6Vzz060peJd653+KvKP17Sh4NzpW8haij4kYNnutQZ7PGUmUmbT8zdp909pTElXIbylpcgla1FizSsTvGDug=;5:n2dogPDdhutLNVfVXyfig93IVv2n+sHH9OlkKzwvskyLgje5d3/iCHlCYQouJVAHIibfE2nBfbqzRPxu9d0e0qpYx7tK+45uL0T9tAvrDgQ2m0EZ9r2+x7eezn4Jsrtl5O2i9M80Scd3F3MtHxF2s6ODlQeyMmhTE0VRinpcgy4=;24:Jbol5l9k76nlOdKSJ04i9egSkP+yATG99owmDlJudN+HotBZW+fSE1E/RB3wNOocTogPQ32DS/kUHkOXsjcfqiIvRPKSfAIb8j6vDV5BcOs=;7:ruRtYRULDH8r+SfLxmtuC4oyggSuu5TyVS0IodPchWHeiyxTRSezNyvlGNiFXR50maFn36g9VvU+9OmOo4bohTSWzS1rIVTEc67sWZJuckkXbd1Poa1Y9bK8OPSg15IAkZA1sJcpzYH152eFi5zh3zsZlXHbDJuoAADkFZBvX8xChkyTdSVyyeD6yCaGLE5P4t+yG/f3RgNcPPfwPaIAqzPY2xFTpfJv04Yj6UQrjJPHNRPcv2QDJ9pI76Solxxk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:S0O72vwerwJnX65u85CMhd4mnJdUcU91iR9ikRJs4nyBJL1nUuhOmRExEfKJiZFlkCOOzbtpgF+eK+SbN4LlPdI4UiA3mWqTIAm2XX7z6ppzPus3oh9kUCLF5ZsQvfV0tuieYViNU9C2re21JcivTwJJhScCOZgGTR8Bin9B9Vs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 12:39:55.9745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe984db-ccdf-4bb0-5d74-08d590bb2ede
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.2018 02:46, Dave Chinner wrote:
> On Thu, Mar 22, 2018 at 07:52:37PM +0300, Kirill Tkhai wrote:
>> Here is the problem I'm solving: https://lkml.org/lkml/2018/3/21/365.
> 
> Oh, finally you tell me what the problem is that you're trying to
> solve. I *asked this several times* and got no response. Thank you
> for wasting so much of my time.
> 
>> Current shrinker is not scalable. Then there are many memcg and mounts,
>> the time of iteration shrink_slab() in case of global reclaim can
>> take much time. There is times of shrink_slab() by the link. A node
>> with 200 containers may waste 4 seconds on global reclaim just to
>> iterate over all shrinkers for all cgroups, call shrinker::count_objects()
>> and receive 0 zero objects.
> 
> So, your problem is the way the memcgs were tacked onto the side
> of the list_lru infrastructure and are iterated, which has basically
> nothing to do with the way the low level XFS inode shrinker behaves.
> 
> /me looks at the patches
> 
> /me shudders at the thought of external "cache has freeable items"
> control for the shrinking of vfs caches.
> 
> Biggest problem I see with this is the scope for coherency bugs ini
> the "memcg shrinker has freeable items" tracking. If that happens,
> there's no way of getting that memcg to run it's shrinker ever
> again. That seems very, very fragile and likely to be an endless
> source of OOM bugs. The whole point of the shrinker polling
> infrastructure is that it is not susceptible to this sort of bug.
> 
> Really, the problem is that there's no separate list of memcg aware
> shrinkers, so every registered shrinker has to be iterated just to
> find the one shrinker that is memcg aware.

I don't think the logic is difficult. There are generic rules,
and the only task is to teach them memcg-aware shrinkers. Currently,
they are only super block and workingsets shrinkers, and both of
them are based on generic list_lru infrastructure. Shrinker-related
bit is also cleared in generic code (shrink_slab()) only, and
the algorhythm doesn't allow to clear it without double check.
The only principle modification I'm thinking about is we should
clear the bit only when the shrinker is called with maximum
parameters: priority and GFP.

There are a lot of performance improving synchronizations in kernel,
and they had been refused, the kernel would have remained in the age
of big kernel lock.

> So why not just do the simple thing which is create a separate
> "memcg-aware" shrinker list (i.e. create shrinker_list_memcg
> alongside shrinker_list) and only iterate the shrinker_list_memcg
> when a memcg is passed to shrink_slab()?
> 
> That means we'll only run 2 shrinkers per memcg at most (sueprblock
> and working set) per memcg reclaim call. That's a simple 10-20 line
> change, not a whole mess of new code and issues...

It was the first optimization, which came to my head, by there is no
almost a performance profit, since memcg-aware shrinkers still be called
per every memcg, and they are the biggest part of shrinkers in the system.
 
>> Can't we call shrink of shared objects only for top memcg? Something like
>> this:
> 
> What's a "shared object", and how is it any different to a normal
> slab cache object?

Sorry, it's erratum. I'm speaking about cached objects. I mean something like
the below. The patch makes cached objects be cleared outside the memcg iteration
cycle (it has not sense to call them for every memcg since cached object logic
just ignores memcg).

---
diff --git a/fs/super.c b/fs/super.c
index 0660083427fa..c7321c42ab1f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -61,8 +61,8 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	long	fs_objects = 0;
 	long	total_objects;
 	long	freed = 0;
-	long	dentries;
-	long	inodes;
+	long	dentries = 0;
+	long	inodes = 0;
 
 	sb = container_of(shrink, struct super_block, s_shrink);
 
@@ -76,19 +76,27 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!trylock_super(sb))
 		return SHRINK_STOP;
 
-	if (sb->s_op->nr_cached_objects)
-		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
+	if (sc->cached) {
+		if (sb->s_op->nr_cached_objects) {
+			fs_objects = sb->s_op->nr_cached_objects(sb, sc);
+			if (!fs_objects)
+				fs_objects = 1;
+
+			sc->nr_to_scan = fs_objects + 1;
+			freed = sb->s_op->free_cached_objects(sb, sc);
+		}
+		goto unlock;
+	}
 
 	inodes = list_lru_shrink_count(&sb->s_inode_lru, sc);
 	dentries = list_lru_shrink_count(&sb->s_dentry_lru, sc);
-	total_objects = dentries + inodes + fs_objects + 1;
+	total_objects = dentries + inodes + 1;
 	if (!total_objects)
 		total_objects = 1;
 
 	/* proportion the scan between the caches */
 	dentries = mult_frac(sc->nr_to_scan, dentries, total_objects);
 	inodes = mult_frac(sc->nr_to_scan, inodes, total_objects);
-	fs_objects = mult_frac(sc->nr_to_scan, fs_objects, total_objects);
 
 	/*
 	 * prune the dcache first as the icache is pinned by it, then
@@ -101,12 +109,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	freed = prune_dcache_sb(sb, sc);
 	sc->nr_to_scan = inodes + 1;
 	freed += prune_icache_sb(sb, sc);
-
-	if (fs_objects) {
-		sc->nr_to_scan = fs_objects + 1;
-		freed += sb->s_op->free_cached_objects(sb, sc);
-	}
-
+unlock:
 	up_read(&sb->s_umount);
 	return freed;
 }
@@ -127,11 +130,13 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	 * ensures the safety of call to list_lru_shrink_count() and
 	 * s_op->nr_cached_objects().
 	 */
-	if (sb->s_op && sb->s_op->nr_cached_objects)
-		total_objects = sb->s_op->nr_cached_objects(sb, sc);
-
-	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
-	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
+	if (sc->cached) {
+		if (sb->s_op && sb->s_op->nr_cached_objects)
+			total_objects = sb->s_op->nr_cached_objects(sb, sc);
+	} else {
+		total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
+		total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
+	}
 
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index a3894918a436..c817173e19be 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -28,6 +28,7 @@ struct shrink_control {
 
 	/* current node being shrunk (for NUMA aware shrinkers) */
 	int nid;
+	u8 cached:1;
 
 	/* current memcg being shrunk (for memcg aware shrinkers) */
 	struct mem_cgroup *memcg;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8fcd9f8d7390..e117830f07fd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -482,6 +482,33 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	return freed;
 }
 
+static void shrink_cached_slab(gfp_t gfp_mask, int nid, int priority)
+{
+	struct shrinker *shrinker;
+
+	if (!down_read_trylock(&shrinker_rwsem))
+		return;
+
+	list_for_each_entry(shrinker, &shrinker_list, list) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.cached = 1,
+		};
+
+		if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+			continue;
+		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+			sc.nid = 0;
+		if (rwsem_is_contended(&shrinker_rwsem))
+			break;
+
+		do_shrink_slab(&sc, shrinker, priority);
+	}
+
+	up_read(&shrinker_rwsem);
+}
+
 void drop_slab_node(int nid)
 {
 	unsigned long freed;
@@ -493,6 +520,8 @@ void drop_slab_node(int nid)
 		do {
 			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+
+		shrink_cached_slab(GFP_KERNEL, nid, 0);
 	} while (freed > 10);
 }
 
@@ -2573,6 +2602,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
 				    sc->priority);
 
+		shrink_cached_slab(sc->gfp_mask, pgdat->node_id, sc->priority);
+
 		if (reclaim_state) {
 			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
