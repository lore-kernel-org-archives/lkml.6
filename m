Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeCULN4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:13:56 -0400
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:7040
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751637AbeCULNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:13:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 6/6] mm/vmscan: Don't mess with pgdat->flags in memcg
 reclaim.
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
 <20180315164553.17856-6-aryabinin@virtuozzo.com>
 <20180320152903.GA23100@dhcp22.suse.cz>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <c3405049-222d-a045-4ce5-8e51817d89b6@virtuozzo.com>
Date: Wed, 21 Mar 2018 14:14:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320152903.GA23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::28)
 To VI1PR08MB3263.eurprd08.prod.outlook.com (2603:10a6:803:3d::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5b3d993-5fb5-4118-675e-08d58f1cd35a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3263;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;3:bZQJjcLksWNCnF0SIzMDcIMQ/KVdw6CYxyXm56GxtpOAn3hzqc7bWHsFR6kD0+8BygGZe1uv6oUrxmV238qQ2SB4biyqw1bEBMZ+aPbrVTxnhxKJsY777Sd8DSKMwsufUIMUSTCXhfR/Fd3vQOxumStrLLKtyb4Hogg7RnAhpuIkecBX8ARsnj7AWDyxs+oGsJQsn+WudZhKDoUsZmBUsn9y4ydUCR2iH0aLzz+VZALWAkNStYrk63OE5ZnyXV7b;25:uRq0a4yKXIw6/JlcQV6blTtQBcX/Wp9TV0jREE5Jrw1Vlti/69acNrhpCZ2qYndpumNZPlxYtV+5ik+PlwqPsvD0xw0VfJaSZ867EyWGFG/n8yDZtlrO9KNEw8s1RsEDYK+7emect/ldgDYJJDJDQg6uQtz7rXjOgsgNUTIEWDNG1hVy/vfAYuN68EZSxNUStOwxwwYuLMj2gOSYvmYj1AMAjoan2WqSkE3l+4msBjZbe3Uw2WepCGFdFZspDHKwv5jip7IuOhnYSgf00ktNv0qv1mUpYc5/SwSEh8Tck63elsGTLglbofD5FdpXp8aL0sk0McKPosvQ7c4cqrB1ow==;31:NMjwtXzP8Cd0TMVb4irGZ4rtC0dp9N798gdq4ZgGgY+BBzN6ABCqQ2uXlxSUD7dENu2m55MxtDyDmWJvw4PUXJb7jSXHRHjm9OjQl71tYibauEcD9eNpI0iaoVyIo2ttopYShPdA5aS9Q48he8lG2U5e45WfW0fK0sYj221zRdxvdRKbE0Y67r66bXWsoszplvVkpGnFDQ2sftXZArNfU2YeMuFPg2O5147C/irAVQI=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3263:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:peL4ZNNb3i6IjbPhrDBeXc2xvOVIsFFFCRUGnyGgRdqetgQCRIATD4oals9YiIbeQJt5qXkQRWvax1/RXPmUS0aVotp1PBs1FUCSJ58jxjwCSvAjISOoXKeIKRg8Lvd035hbejqdgbVGF5I7ozAt73SXxtyfU3ugA7TUeqViULzYOQpvrdlANxNn4O/pQn1h/lhjsG/HsuQOwN/xk1P5PVJliMafzQZ8usCQxIob5ukUohno8ba2AUFPESRrphBS3uSvLQ3mYGwH5jE1hLKnS9PsTFuQcg1uV/tjt74gI75WlwztVcmyhaYFuCqqr3A0hrvMddSQVE+XvjcGpgB1FclWnWr2TFEbWOkFwAdkOPa7nb9eFV4N2OkMI7s93tmNxvUmq9uooJMKGyunX58S2ZX9GJu708V8TauPy1ZngJcC56ZhHq1CKmVHonzKXQwN6WpT8iVMyh01W+K4xKIvHTN9xzgNdVZgxvETX89aKTJzoe+OILTeak2r9GLpuQm7;4:LVV0V39WSliOaZ+REI9r37ZJ5gf0Cq2sTcBnWzGhYg4f6Y+2A0UGdr+HB8tMzpcXLIR7v53Px5I5ZKxMPGbMgJ/93tgckiooCm8j03cusrBuBEQp5qXe8XfuvdhamLC/i9mNsbB02Mj4X8EAHqDGIqzK34wiw1McSddsoD7Ssy8/CDKOwHbz6jhw64FYgvZ8LTwV/yFNHN3ZTW6BHBXqTH8h6QZn8KRPKMkqvYrMgAbfFgTl1tvpaFmRvhGSnFcGXT1uFe7edBjyc0eTbSUVkQ==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3263490B87020EB47152E77DB0AA0@VI1PR08MB3263.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501322)(52105095)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3263;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3263;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(346002)(39850400004)(366004)(376002)(39380400002)(189003)(199004)(6916009)(97736004)(2950100002)(50466002)(68736007)(58126008)(54906003)(31686004)(6666003)(6116002)(3846002)(2906002)(230700001)(8676002)(81156014)(8936002)(229853002)(31696002)(64126003)(47776003)(316002)(66066001)(16576012)(65806001)(65956001)(478600001)(81166006)(386003)(4326008)(305945005)(105586002)(65826007)(7736002)(106356001)(5660300001)(25786009)(36756003)(55236004)(53546011)(6486002)(26005)(77096007)(53936002)(186003)(16526019)(6246003)(2486003)(52116002)(76176011)(86362001)(52146003)(23676004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3263;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYzOzIzOnVZQ2JEelZYMHhsdENRNU90OTdqSnRodTJl?=
 =?utf-8?B?TUh2dUNqR2lHRFhmVGllMkE5a3ZnMm9hNktLVTRQS1l2WTBaUExtRzdOQ0hh?=
 =?utf-8?B?WWZBTWFTM25kY2dueWxUaGpNaXQyMXE2RDlpZTh5NnJSTGNKTVFEVjNxN1hH?=
 =?utf-8?B?WWRTYW8yWVJVWkpVT1gzaXhwNmRqT0RpV1dxUnlDdTFzclNPV21DT2NvTVB4?=
 =?utf-8?B?UXRoSHJmRDg3TURYZWprZ3JFSGgvL25CZ0VtckkwYmJXZk1za0pmQW5RN1dE?=
 =?utf-8?B?NkY0Q0pQTmJVU0x6VkhJd2N4ZzgzM0tDK1grWmU4cTl0bXYrZFNmV04xakpi?=
 =?utf-8?B?aGcrTm1NRS9CNjlKYS9mR3dCYWJhTmhpTWYySXRzWmx5bXBPazBBUjJ4OW1o?=
 =?utf-8?B?aHRucWRlK3JBSHBNZlRhRlgwMjBHQy9Kd2ZDQ3RkbmRlMHBWTUpZTmg4Z0RF?=
 =?utf-8?B?ZmFHVHRXSHdzV2hsME5WeitMVll3aWhiMnNHL3JWa2lXNWhySnBDZk4yVVJt?=
 =?utf-8?B?TFdTOGhjUzdVMWk5UXlibHM5LzlHdEJFVjhHbWxkS3pXR1lKSkRrdTBaNFQ2?=
 =?utf-8?B?WG1rZDNwWW1UUHlRbmd2ZFNzZjVyM05FZnp5OG9sV1pnSy9jOG1yaEhlRHlC?=
 =?utf-8?B?RGxUbmZmR1J1MUI4bW43OUx0c1djT2t2ek1vSUtnTTB2NW00c1BGTFkzMUxT?=
 =?utf-8?B?MmpRL2pZczJ3QXFiTnFKbFVLeXZvMFMwZEZ1WDBlRWRldDBiMndVWGtoYW9V?=
 =?utf-8?B?Yng4TUU5TGY0SGlJZlZWbzJtUTMrak1kTk0zS2ZUYUZTSDlHaGM0Q0dyZHZm?=
 =?utf-8?B?amVKaFhmR3MvWkUwQ2N3TzNJa3huUjd3T1FCSVV6UmNoOFdhNDM1d3BhbC9G?=
 =?utf-8?B?S3h6bU50eXVUVVhOdi9ZbkRjYjVrbk1tajdWMjFnNXA0RFRKdXUvVXk3bWxM?=
 =?utf-8?B?RTVsY0xOcGpEbjZNaHdIS3p5b0htRmcyRXBuVlBHTSt0WmF6dWNaS2V5SGpr?=
 =?utf-8?B?d0J5QXBFVmpLc1BONE1xakc1OUUrR0M4ZHNzaG1sNlhvNFhJd1ZsT0dsWEN1?=
 =?utf-8?B?dGVObXZ2TVNSWW42S2FpeVlRUmcrNlo3L3dqVzlPN3RIbkdtUkxob002RHFS?=
 =?utf-8?B?UlcrMi9zeUlVRGszYm04UnEwM2RxTHpmaW5kdnlWWlM5bE1pN2o0d3FMNXht?=
 =?utf-8?B?bU0vS0VQa2xueFFBUlMyMUZGR25HakhOZyszclJ6eGZURnR6K2s0Y21kN2oz?=
 =?utf-8?B?R2xjQS9UTGJMdVlaN2h5WEFkR1Eyc2xxcVlGY2VGNCtLNVdXUG8xUFdwUyt5?=
 =?utf-8?B?VS85WFUyaFYySzVsVDcyUzJSY2R5emliSkkxUE4zSDZiWENFaS9VTnZTVysy?=
 =?utf-8?B?eTB5cU1nMU0rS0FrZ0NnYk1Tc3R4ODd3dFB6VGdPcFRYeXVhSDJFRWFtbEdu?=
 =?utf-8?B?dEE4eWowK3BZby9qaDlaTmtFS0lCbnVCR0FkQ1UrYmhCSGl3U21ocGowWU1p?=
 =?utf-8?B?MFUvbmFpU3VSYkticDZPRVpScHNrVUYzd1ZFNTREVUw5WjNrdktzTDdoMkUw?=
 =?utf-8?B?MkkrNUt0OUVjc0psT21zODlUdWc5WFNWYXZ5SDM1eFhERzh3bjhtdTdUOWtT?=
 =?utf-8?B?NVplQTJvTlpCbXdlKzVxakZpTGtYSWRkeDdnVFZEaXozVm5nWkp0K0REMEhO?=
 =?utf-8?B?dGxadk01ZzFzMmVxYmlvUjRWU0xOTTU2YWFnbS9Ka3hYcmh3Zys1WEFhQ00w?=
 =?utf-8?B?S3FVTmVhRXFSZndNeTFhaE03R0l4cWJ3cHZDSGlDRVg4OVZYaFJ2NXlaMURI?=
 =?utf-8?B?QTVCa1ArcVdEbDk2RDdIOGxBQ2hWdHQ5d0ZRT2VuR0ZqanRVUzdHUzBrUjNL?=
 =?utf-8?Q?MawTeFHT2jc=3D?=
X-Microsoft-Antispam-Message-Info: nxhy9uGM5rjPU/pGvZ5SoDNPwsWvyQ1XWCbSHHGZQRptIw2oqvilUIEBkVJy2+OSjwiVaoHgBApVzHUSMY1i/AWMmDA/j7WYrdgqoCqSvH2yMiJHYGBlbiJo7GoGWnpY0Uhqa67umni46mSwvuT4R4JTngnH083BQKcC9i30qx6RqhYE7OUhv7ywSir6uP+S
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;6:SsKvl0T8Pjx0UFwzl9QoM4Smmc81yiKSCkJ0Vzom7GR52yM1Va2bIYkoLhnr4KB225StuTmHgPjVKA9Ev9/IOossAqJfNWW4XnwGSah8U6L8myfn0Aa4ZYhzrupNmBCAe5k/SwJS6Jdgkov33apRpBo1tdn9FmMzMkUZQFztpFSvOZ0FrUNtiFKQm2Tk07MCFI3KCh9KGvqrt6M8KQf+m4vqnBaHj5o85jpS9Mq7+6dEE0RkXWLwlkd1u5tIzWXwel+CDnB0XEwUiha1VxurX5MAg4Y/ibCo6JLGwUwCReDbzyAUBdKlIOloKuLnPRtio9e7H15Fq7+9BJGWfqej7HkQowxY8hnJjNb7lyyqg3c=;5:dva08j8WGK+TlYjm0/oqDdwTMpGjHnD6PLYUZkV9cjo8+8v9IO5caT9hb408Fmb0ljbtv1kq3uvXHVb0ftdPJF1erQnXUcpWRzbhTwyKTzKHQl2+7X6dxARtkHbzNGnjXHA1Sx9VUBt3CkUcKxzWzQTUpnaOe8wKU3FSKs5lcCg=;24:7BE9ojqyQSxrlOr+ku1rtiOdx+tPbufzoLWjZT9AGYLalSnq9J5kOk3wakpd1nAHV/WXM6PXpiidg8FCQaLR7FJO2Fpm9mceL6n/PlcJEy8=;7:ryieBM53GyZG6WiJAI7EWVbvqNq2kVM924avE0oA1kKFPOmB8vzDXYRiV/Yld3Rn1kzESW6CppfJM8z4XhGhYWn4zuTqPgKPrSt7FlUKjGaitoaOt05Njgds+pyeo3rLaV/N1VP0hZ97l0IByLKDlDXsnmgAq15BmlQvKrCVgIP6U7eqEkTYqFLwibgS4L1Qkcv/20iHF5UKofh4IzX1V2owVhZtAXT2urKCF/2fh6bz7m4Sfo0Xgs1lRCursbVL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:oqIH7ioqzA2E87qfm7aDcAD9zYydGbtuzVJDjmSwhWN4k7xxbBT7uVGPCM5Hx/Pwx98r1acTYEidQ+hW6vkKnz4K5xrOmdeLKTj3ZnVFlcDbsYu0JO0L73txCxiNVR98DtMPK4E4zwjeB60sz36x4OA4aYn2AuNbcQi2p5rxRwY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 11:13:50.3535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b3d993-5fb5-4118-675e-08d58f1cd35a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3263
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2018 06:29 PM, Michal Hocko wrote:

>> Leave all pgdat->flags manipulations to kswapd. kswapd scans the whole
>> pgdat, so it's reasonable to leave all decisions about node stat
>> to kswapd. Also add per-cgroup congestion state to avoid needlessly
>> burning CPU in cgroup reclaim if heavy congestion is observed.
>>
>> Currently there is no need in per-cgroup PGDAT_WRITEBACK and PGDAT_DIRTY
>> bits since they alter only kswapd behavior.
>>
>> The problem could be easily demonstrated by creating heavy congestion
>> in one cgroup:
>>
>>     echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
>>     mkdir -p /sys/fs/cgroup/congester
>>     echo 512M > /sys/fs/cgroup/congester/memory.max
>>     echo $$ > /sys/fs/cgroup/congester/cgroup.procs
>>     /* generate a lot of diry data on slow HDD */
>>     while true; do dd if=/dev/zero of=/mnt/sdb/zeroes bs=1M count=1024; done &
>>     ....
>>     while true; do dd if=/dev/zero of=/mnt/sdb/zeroes bs=1M count=1024; done &
>>
>> and some job in another cgroup:
>>
>>     mkdir /sys/fs/cgroup/victim
>>     echo 128M > /sys/fs/cgroup/victim/memory.max
>>
>>     # time cat /dev/sda > /dev/null
>>     real    10m15.054s
>>     user    0m0.487s
>>     sys     1m8.505s
>>
>> According to the tracepoint in wait_iff_congested(), the 'cat' spent 50%
>> of the time sleeping there.
>>
>> With the patch, cat don't waste time anymore:
>>
>>     # time cat /dev/sda > /dev/null
>>     real    5m32.911s
>>     user    0m0.411s
>>     sys     0m56.664s
>>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> ---
>>  include/linux/backing-dev.h |  2 +-
>>  include/linux/memcontrol.h  |  2 ++
>>  mm/backing-dev.c            | 19 ++++------
>>  mm/vmscan.c                 | 84 ++++++++++++++++++++++++++++++++-------------
>>  4 files changed, 70 insertions(+), 37 deletions(-)
> 
> This patch seems overly complicated. Why don't you simply reduce the whole
> pgdat_flags handling to global_reclaim()?
> 

In that case cgroup2 reclaim wouldn't have any way of throttling if cgroup is full of congested dirty pages.
