Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCTWfv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:35:51 -0400
Received: from mail-eopbgr20094.outbound.protection.outlook.com ([40.107.2.94]:63584
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752084AbeCTWfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:35:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIG1tL21lbWNvbnRyb2wu?=
 =?UTF-8?Q?c:_speed_up_to_force_empty_a_memory_cgroup?=
To: David Rientjes <rientjes@google.com>
Cc: Michal Hocko <mhocko@kernel.org>, "Li,Rongqing" <lirongqing@baidu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>
References: <1521448170-19482-1-git-send-email-lirongqing@baidu.com>
 <20180319085355.GQ23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C23745764B@BC-MAIL-M28.internal.baidu.com>
 <20180319103756.GV23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C2374589DC@BC-MAIL-M28.internal.baidu.com>
 <alpine.DEB.2.20.1803191044310.177918@chino.kir.corp.google.com>
 <20180320083950.GD23100@dhcp22.suse.cz>
 <alpine.DEB.2.20.1803201327060.167205@chino.kir.corp.google.com>
 <56508bd0-e8d7-55fd-5109-c8dacf26b13e@virtuozzo.com>
 <alpine.DEB.2.20.1803201514340.14003@chino.kir.corp.google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e265c518-968b-8669-ad22-671c781ad96e@virtuozzo.com>
Date: Wed, 21 Mar 2018 01:35:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803201514340.14003@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.47.128.244]
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c7ea99-4f14-49d0-24ec-08d58eb2ea08
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:e2YQweoZgyDYqh+ewjEPfYbJmRQbtRErG//5x5+SF1fQFrF7feQ2tMOc1FRigvDFpQVyM+gRAa6EUKjFrO1a6sAWMEWY8lhqdwBq8cKzEYmiDsvxoAufV6XD3hDWM85YZT7FzH8bxswt8J+EP4C2mGH9zRDnEZ7/ZbKO+mmuVlQCMYGl4g6hxYEmZKmGhktMlQvrbCg5HCDxssoWzq6hBpWxj5Zvuuvlc3YoQ5x7KADhBfA2i6nppvOCAkiAevRd;25:dZo654RXJk5v0Duap5Eiwhsk+BeC2yllEgvCZ0nEDDlTKvAUz4iK1TEN3GNOGHhwc2uwfSUs50A8TvyLuHTW2wz14RxKbTsl9yaz9UJXys7EW7DTfCMi5c2R9SpFOFPfTpOg70VmKmY1t/KqWwkos7mVJau/np/fiKKBwaG8jeCOdc00w9iXG99usVIbeEQnUa7zsHXb3z+iEIelJJiTdiTgQY02BhMDgv+6j8IDBEGnXNCSmZqe1p3ENVMDX7KTNyRy95JgsWBAKpvDMhikHHg2OLyXqItg8mWSUSBBbm57GMypSu/l1q2hpE9HGd6RQR+4IS04WkCvbbtew4gbvA==;31:NajbuJdi6jvOkwkJ0Zz54xqQvlCA9eEE7qh+HAwZJYRFzokFVIsYNkbyW1p7aZ8eFkcudN1l4TgQOksWzFQZxMFhAdJRCe+At+JFtxvUn/Orz3nYwFMO4zdM6SxBYRrWKkAAIwNd3gMEpicvgOejkpTq1k7DToY0v80aCDOlHzx2fJTcYzqAXvUSKEtI098o/WH5f4/0fGEwgX45mJe/l9/pYTsGzi1uVmf1rw8VhKA=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:lYvyeiRe20kvblyaYqPpgXo5vftOMGOdhzDv5kK8IwW2fIMDnyhzzHnnOSNJ7v9JIjMWuEIcCJcRvvyVg4cPtyraL7+hSMVW45dUxe5gSr3IbOTPiXvmk4wY7ZdM5VlPR0QXB7nErFb3zlKVCFc6tUoqWj9neNDz7yVNvkNxSP0WVzDTLEqFbb+Gx/j1RzUGRIGU3Ospn586qt0ei47wcfbGq8nqHRYIT1GjBTnUwz05KlXMho34T7ChOTQ/57XpKS/GaYIRJoMEr/Zorh0V58glA6UMCKB3HjqlRRuGjbRa7wrWF8a/CeJwlq0dfHslO9Ah86Rz8Ty5qj1tFDMRSxHEBeIb/p3rRQgvPMnIhCzVbSowH0P6MZlPS5rVwiuajlNUd+FGaAFDHuxBejmk5Xqu10jZYianZunmZqnTCzNJCcLw2chFTZST0AIk+zl7jX7vKK6p4bcykiZF7DiPEu1PI6BLcGyG0+mDy2lopYhCy3YQ0ybg9qA8dIa2igMA;4:Mb4VrdeyDY758ZH3Csk/PIcMWacugM2qybvcjwT5dUkp1UvzGJu7x+NkM0k7GeID//1pLE4ALuhdkoMJnPVLXBsGiqoboue/S1yIf6VRJzA8xCyeFV6L1ZGcSpXxrshUjg3VtW74FOVqs7dhhdWg5FEVBhA2LCNhyMGRzAF/M/yo2nRP7fQ82NGoWLthHCxMW8p/UCPW4wImvSUtGEY7F2TFU229ot0LK+SmxBwynZrJ9VfzxHQG9ooB2ZYhVkzvol8CbtTHWP256JslJbZNM5sExzxbFgWZN8etJvktbKlObYYON773ls50I9ZB/YfP
X-Microsoft-Antispam-PRVS: <DB7PR08MB3258E13E6C875AADE69AA9E3B0AB0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(39850400004)(376002)(39380400002)(396003)(189003)(199004)(86362001)(2950100002)(6916009)(230700001)(36756003)(16526019)(316002)(6306002)(186003)(26005)(77096007)(53936002)(6116002)(3846002)(229853002)(6246003)(6486002)(31696002)(54906003)(2906002)(6666003)(52116002)(52146003)(23676004)(16576012)(2486003)(58126008)(76176011)(966005)(47776003)(59450400001)(53546011)(7736002)(97736004)(65956001)(65806001)(66066001)(105586002)(68736007)(8936002)(65826007)(50466002)(81156014)(386003)(81166006)(5660300001)(106356001)(224303003)(478600001)(93886005)(4326008)(305945005)(31686004)(25786009)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[10.52.82.105];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOnFOVjVEYzg2V3NwWEJ1K0NmUFF6c283dHpZ?=
 =?utf-8?B?TmlZS2p3U3pQenJUVWJIbjI0Yi8zYjF5c1JkdkY4QmZycjVqazdzR1c4OERv?=
 =?utf-8?B?bmNzaHBBbTlXemd0M2k3M3YwcHVEZGNvQmFiRTlrR0N4MnVGRUw0SExmcnlW?=
 =?utf-8?B?RzdJQUluU25OcTFDMkE2YWV4T1ZSME9VRlBIZWNBN0lZbVpBNlVTbmJScEpG?=
 =?utf-8?B?Y0hMbkpReDI0ckRETnFxdWhCQWt6ZE92RlllMkFjd1B1QmY3WXVWRU4rUklT?=
 =?utf-8?B?dS8za05IV3JzbHA1bE44cno1VVBESU4zQXR4YmJZVGNDSEQvRmNDRCt0VDBG?=
 =?utf-8?B?elgvL3JDc090TE4xSFRqZDFEZ3ZsKzJtUTJJeGl2V1BJZ1dGUHdOZjA5UEwx?=
 =?utf-8?B?SUloZ1J0eWFlRWtGVEpJZ2dyRFE4S2d4K3ZRdlkwVmdFZ0Ftc0JjVThlZnpy?=
 =?utf-8?B?aEwvd01ZM3MvL0Rwall1WW1ramlKR2lrTmtNcG1LQjZ2QS9BTUJ1d1Fod2dC?=
 =?utf-8?B?ZG5CaWNYVjluWlg5R1JUOXJDb25OcEJyMUZhb2tSdmZrYUdQSDcxYUIrWUVz?=
 =?utf-8?B?cW15RWVDVzRUVlZ2dk4xcDgvWGROZ1BIMnpwTE81ekZjamN3dnlYalRCOEti?=
 =?utf-8?B?RXdzNUpOZ2tuSDdNMHRmdkNpbUVHT3ZhUTJJVW83Y1Iwd1p2Wkg1cm5Gek1R?=
 =?utf-8?B?WE1JNEx1cmpJeHFDaERPT2I2Ym9oVEU0ZWpqVzVablh6eTFxdUFNa2p0b2hp?=
 =?utf-8?B?K3FXL1JBUHFBd2xzd1Z1MlN4VWQ4S01rcXFOTkZQNVdFcmdOZUhZQitnNmNj?=
 =?utf-8?B?d2J5V0U2am5xUDY3MnUyb1pPRDIxSmh0R2xPeVpIRGJnanZBT0lVRWtNbzRz?=
 =?utf-8?B?RHRqRWRXVWlYeVZhQjdtWXJoR3VhYWxESXhNRzFXZkN1UXg5T0xzWUdhdDBn?=
 =?utf-8?B?LzVaRENhUDJMVDhUM1ZqT3B1amFFM00ydlAyb3RsU2JRaFlrTWdDZUtkS1pt?=
 =?utf-8?B?cXMwaDVpb1lDdnNicHJZWWVBZUNVSWRmTFlXT1BESEkyNFc3cWdWMXlwbzQ1?=
 =?utf-8?B?VHhyeW1Ga1pLZTUvcHFZYStBRk1JU3pBWkN1MktqdlhvdHFMM1JFd2VXdjFh?=
 =?utf-8?B?V3hWSVRSM2xLSkZudVdBdTVBYm4wR2tJb0ZpV1J2Z2ZJZDkxSkxZUTk1dmtq?=
 =?utf-8?B?elFQcjZvS2tCWFlLRUgrd0svRGhYWmZLYXZhVFoyV0VBSE5hWXRXeTY4MS8v?=
 =?utf-8?B?YmkwZnF4SDUvbnl4WFBkSzBDS2I1OWh2R3poNVE3T04rZFpIMmlmMjV4MUhw?=
 =?utf-8?B?Mk5jbnk3Y2drVXdsUUYrMnJ5eno2TWNhWTE3bGpxRC9MRXZ5ODdyRkZldW1m?=
 =?utf-8?B?N2lyQXI3RDBIc01oMjVnSmg2TG5MMVAzUmE2eEpFM1ZKMXAwZXNUb2JWRitD?=
 =?utf-8?B?SllnUW1HVXVyNlNvNE9kLzRwV0ZzNVdQVmVGN1JUYndkTW5yQU5sWUo3bjlG?=
 =?utf-8?B?WnhXS3BQU2JxVUkxQmMxTzhURE84UnkxU29pTk5Tb2NtUnVLNmF3emxpRDRD?=
 =?utf-8?B?eEI2OEJKc1VBcU1iNDN6eU9oVXBqb2NZOHYxZGpTTnhXMHllbk1HVUVwM1Nx?=
 =?utf-8?B?VFhFSU9hLysxMzdrUUM3a25vYTdmWjZhVGNrcGtlUktqU3kveHNLcTZKaGdI?=
 =?utf-8?B?Skk4TmZwbGFlWVFZOGlsb2t5WHBXMHpFQ2pCVzEvZUpTc3ZXdUovVzIrV0lu?=
 =?utf-8?B?U0lLMkMva0IzekhIREhEeU1xeitZQnNVT3NncmhPUGNIY3BSVDZVM2JYWjB2?=
 =?utf-8?B?YnlVVWtvNFlDdEdoRjg4QktRM1ZnZlkvWWhtR29WUTRGNlNYSXhKTW9UYnc5?=
 =?utf-8?B?SmJldHlGd05Sa0ZQNURzYVNNeC9BWEZUQjljNTRNNUpUZFY2bUNpZ0RGeGVN?=
 =?utf-8?Q?6aTtL24HjSlJaSXJ6NB0FLuCrRvo8M=3D?=
X-Microsoft-Antispam-Message-Info: Vgy/TbMHVCHO1RI1QxCEQLcKUN64puBXxbchTJ2ShOV3XikIo2Z6xBotMzhVxJiNelA7eadbMa7hc1XfZgWspz1xjNRqVpdfRrdiygHm0J03OUHduOfHQsEp8sr1Tu1vGC3RsbOkYTlBVSV7K0FOTQnWUAaeCn55brj61qs4jlO1jIUxx/FZNx9G5DDrlSbW
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:LvZWROI2uIupvm+p2fiZIE3pNJQ/FmQxb4PPMj8c6we3vbVecLirLpSFrTWsnAgiC7rv13QXcZTRzToh2SVRMRtogOInlU2p+xVMIgSDrWZGpREj+IWXCoAC1jFmxiVK/JpzLu7rBpyxAgFrzW/4YzznUmhzx0pgwJ7aYHBYdGPo5LyOigPQQ4NlvpKkzTOjE+9mAC8gFsASalGLR9Ra0m+GGPsNWH3b0ihRUvoVxYla8J9jXgHBZzHh5Dtrfna7+h/Sa+JaBPu/rrmEFPMiPMcu2j8nFcRyYotY+/tJ506R7zD7sxGHDDJovbBVyR9N3oU9EldbVCyqBGmpQfi03jhFqZ6ibFxznkxE0fWWDPY=;5:8dHo+rDp8qqFqfpVt1O3JG+uI4Lk5xwGSW11lQaYAy6Lpo1XDiBldwpQ6EfpEZzi2HkzIOu6ZeFakSgvSqWAR3xYJ3vxTd762Aou3y8q1H1l/noMPL0iLYLNdT2AYeWWPpQhDLotCT8sOChKwj/F7IwPQbieF8VivAIkLSPLNOc=;24:u/CXhcircXOnS5CgEBFfmQYdzBHr35u40Jty1ySnKvKKe8eG7RMYpUPswrU2l2oXVUcIhcjH5bzKeNWeU5nd0JebtQ1JU9+5+4Ymrxe19uo=;7:L/mS/HzKVEdwT0k5yHGlCGJ2k5kupQzjrta6x/+Hb5rOJAoNfYkOaKbkeV/8qn5sWV65/SbhRoRi5oxWYsjhKDGXOy0kzO8Wl725iV1Uwh2NEZ/FQ1Lj19cgS0ZLWCVTfIOvFDUJoIojTasDt6y/RwvsfSpqvhajnEQPIIXGrsuY6D5X3FuYzZYETv4Scv2d+3/OEjO4AVW+uWMLrM9MzNAbOhr1RKdj41g/IPZ+4K4PhEpRiYK+CwQ2AevfSE/L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:W9IsBLMjPY31Mwa1RPIEn1V1GjdwsIb+ES9tEHPuvvZjRqJm8hdN1BHHMDEjA4NqoWHPepS6VbwRpP5+W9wJqhHoMUryC38/HAyxDKAiWXlAEbbJndU4nEgBy1QA59hrGQeEj9C8JymEaRbFTYH8B+ChTNWr9P5+cPoTUHxxDUA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 22:35:41.8580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c7ea99-4f14-49d0-24ec-08d58eb2ea08
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 01:15 AM, David Rientjes wrote:
> On Wed, 21 Mar 2018, Andrey Ryabinin wrote:
> 
>>>>> It would probably be best to limit the 
>>>>> nr_pages to the amount that needs to be reclaimed, though, rather than 
>>>>> over reclaiming.
>>>>
>>>> How do you achieve that? The charging path is not synchornized with the
>>>> shrinking one at all.
>>>>
>>>
>>> The point is to get a better guess at how many pages, up to 
>>> SWAP_CLUSTER_MAX, that need to be reclaimed instead of 1.
>>>
>>>>> If you wanted to be invasive, you could change page_counter_limit() to 
>>>>> return the count - limit, fix up the callers that look for -EBUSY, and 
>>>>> then use max(val, SWAP_CLUSTER_MAX) as your nr_pages.
>>>>
>>>> I am not sure I understand
>>>>
>>>
>>> Have page_counter_limit() return the number of pages over limit, i.e. 
>>> count - limit, since it compares the two anyway.  Fix up existing callers 
>>> and then clamp that value to SWAP_CLUSTER_MAX in 
>>> mem_cgroup_resize_limit().  It's a more accurate guess than either 1 or 
>>> 1024.
>>>
>>
>> JFYI, it's never 1, it's always SWAP_CLUSTER_MAX.
>> See try_to_free_mem_cgroup_pages():
>> ....	
>> 	struct scan_control sc = {
>> 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
>>
> 
> Is SWAP_CLUSTER_MAX the best answer if I'm lowering the limit by 1GB?
> 

Absolutely not. I completely on your side here. 
I've tried to fix this recently - http://lkml.kernel.org/r/20180119132544.19569-2-aryabinin@virtuozzo.com
I guess that Andrew decided to not take my patch, because Michal wasn't
happy about it (see mail archives if you want more details).
