Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeBBHqd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:46:33 -0500
Received: from mail-sn1nam01on0080.outbound.protection.outlook.com ([104.47.32.80]:57434
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750781AbeBBHq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:46:27 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
To: "He, Roger" <Hongbo.He@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <9ecba5f4-3d4c-0179-bf03-f89c436cff6b@amd.com>
 <MWHPR1201MB0127760D359772D5565BA3EBFDFB0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <b7dca756-b703-ff51-196c-832e5a43c63a@amd.com>
 <MWHPR1201MB0127A0AE58A331BDBF9DD34BFDFA0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <MWHPR1201MB01273A4737F27450D7E1A4C3FDF90@MWHPR1201MB0127.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <540b5f5b-5670-5653-70de-4ff42e898550@amd.com>
Date: Fri, 2 Feb 2018 08:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <MWHPR1201MB01273A4737F27450D7E1A4C3FDF90@MWHPR1201MB0127.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: VI1PR08CA0126.eurprd08.prod.outlook.com (10.175.228.156) To
 MWHPR12MB1310.namprd12.prod.outlook.com (10.169.205.135)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c13f4de-10be-4fda-9373-08d56a110f2b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1310;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;3:u/rN9edUlx2Z5kmQtwJuc2fX+uYsM79XFyS+POBpWih4IcOK9MSL7ho9rlEE1oHsa6CV7phkV/FfvyHD9bAN/ybqSmCOhPDD6mDAMFDFHuNEuSVWawnJQsfDZQZwxD8WIItUR2aDWFshj88iCWo+75ce98qkmgzFyzVMkWEepP0z9sv7fiGxAmITwdARwi9AIX7AuGeZlOHD4bTh6JfMTxWItUVljdSW/fofeoZZlpOXA8888AjfpDaxFKEildFF;25:QhlZBrBLjQkGaSEr4SWVGsIrkMsYRnbSjyxfjILlQcKhM+KbPBLEA6ntaP7JfnvlE9P+2JAXbblZu9I3wMXoq7KB3lq2w4iTYNtL1FdqttT1AvHLVV6YJFLL308FX20hKQYfmBrdMghfXAWcrd2hiMIpB+NlCriXEEjpp6jdelUgdZFcSDqt6bCEzah4PQgPDMpDXcIIEFEU4e6AfeFjtUDveaBLkLp58Mb1fNWq0lL0b8UHbPRUj8xdmtNmTN7NtFK6n+KiDYs62wo5XbGU6KiAaLZQHlKGDtH5KtlZj5qb23syjA6nDiM2bFKAF5i+pYXphEncXQ6ZiplI/+3xrA==;31:j1khF0gEWGcMOkrfwZ2sCqpDrIGYHqnbr0ax/w9l9SvnlzkP0zDReAig1yiol7oRcx6TpEmU0NDkHLwOBwjoFs2rvvMC6+AlLaNIYQ8v2QAbONhxh5baI/OGNSARD8qUa6n9EE/TN24Fsdo2rc3diF0inoCobxwhIQ3C09AWYEOaSxvqO76Is/XWjIOSvaOnaviMn4UsD+Lf6oG30WQkIEQxKiDfWo2x/Y5IuL3sBSU=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1310:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;20:lhwi8RKy7siGPFj/cdUc6HlVkLn1zzsX9/cLe0t9zfpLPJPKlMmsnT46DWbwl/KhLh7tqzlKJxfw/GQSG0Blq3cHfFV37VUH0DHQyL0avV6natSFFgw5rjYdweici8GhLzJIvE6P5CubEGjBNS3hbihNaQ7KiC72L58kH8OiwVjVWz8YXwtyuOYc850LRSly1dphyDqwBxJbA0VtuDaJcc5WiArqQZzyNjru0P2KJW9SBa1ZfbyZ8zaGnjWb1kCTkVD8t6jRnk0OwuMEw+jRUW96riU8r7H0pYqovBDEm/NasQjD2zl3ZNOYcg8/TdA+xZF6K3pSEnlzaVICw8efO/iwqClsKWUH32EoVqxjc8DI/lJ2wnSxEpwUQ36yNNJFViUcpUMTRrePhWRPRpdXNyjaP4iHmxMmbY2rU+3eJstPuT/KySWa7b8FPT/ylt1mNlkBsyrGelfEjeFywIsD9nShn6YMV97glVd642MFXC+JdipyyMXCjK4O58bB/WVh;4:A22fUJ2Ig+LSHWt+R6uYyLbiRPvbx8f2jU6Pg75p1q8tHWWLZj5gstopzrOIhhLlDC0yaMMEa5BeVdVKpfApszG1gt9xvvl5XXOLXVVhIwc2NOnuzdOuvuo56iQY6bcDfzzt6/Yzi9hnuqAbU1pcPT44es8CwbPsXQaL+cVA9SHY96ovZDCVLdMZKCVr82bWsxY/8SW0PqQs/wjHIOgT5ddM8Krk0SvnXePs8KIto//vqb0zb6LRAQ9ngNhVIEjPfOyGxfBVodwtY2k7TN2JdvN4k6rP7XRd3siABPjxn4L7lLNL6SupQ56jrpQ7vspKto1aLHQBXRoVkVpOwLOdzqviwHEGwPJlTWowZuAnf3QuTcNVh8K0P3xP/MB7klxC
X-Microsoft-Antispam-PRVS: <MWHPR12MB131085F39B1AF880581A14A783F90@MWHPR12MB1310.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1310;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1310;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(39380400002)(366004)(396003)(199004)(189003)(13464003)(5660300001)(25786009)(86362001)(229853002)(81166006)(4326008)(65956001)(67846002)(8676002)(31686004)(81156014)(47776003)(2870700001)(106356001)(110136005)(54906003)(2501003)(6486002)(83506002)(8936002)(6246003)(65806001)(6116002)(316002)(53546011)(386003)(31696002)(76176011)(59450400001)(478600001)(105586002)(52116002)(52396003)(1706002)(52146003)(2486003)(23676004)(966005)(58126008)(72206003)(50466002)(186003)(68736007)(7736002)(2906002)(16526019)(2950100002)(6306002)(93886005)(97736004)(305945005)(65826007)(64126003)(6666003)(53936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1310;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzEwOzIzOnJNaGZZUER0UFZoaXFpTlBDZGdpMVZIWkto?=
 =?utf-8?B?aUd4RVA0NGVpV2hBQ0UzcGg3R29ETFRnRUZSWkRyc2JqS1dMenRqZ3VwakMv?=
 =?utf-8?B?cXIxSnJFZUVUcnhYclNTYjVvdHd4WGZ6UytrOUlIWHF0V2dEK2Y4S3I0WTlO?=
 =?utf-8?B?MXJ5ZjlIRkRpUEpzeTZrb1N1T3NaemFudEdMakFQQjlXUk9ubVdsUGVhWHhN?=
 =?utf-8?B?ZSs2bGUrMjEzMWZ1RmdxTTdWTjFwb0lWUSsyczV5OHJDY3JGMGhyU2V0RnBO?=
 =?utf-8?B?OXppWCtqM0REMldpcWFzeTlDc1A0Vi9YUXdMd3pTOFNubnY0NjF6QkxZbmVB?=
 =?utf-8?B?V0NFZjN1OFd1WnZEOE1hNVp4N0tLcDQrampzcGYwb1Zud1RFMDZRcllGMm0w?=
 =?utf-8?B?YmtkWkZRUjFSTCt3VHkrMDZBOWZ0aEhQOUxObkdKTUtscktuelpTZFFtamNx?=
 =?utf-8?B?eFFEbnQyVmY0SFBmSnVNRFNTdUhYUnhHdkFVSjVxbWxJbE9kU1F2Z3lKTy9Z?=
 =?utf-8?B?dHBkbisydzViQjFQdlNLQjVpNTVsSG9zU2hLSWl3ajNibWs2bEkxOTFhSEhJ?=
 =?utf-8?B?NlYveHg0STBUMTJxdkxLVjM5b1p1UGxNWjk4OUpGQ2JaWUpQYUhsNGorb1BH?=
 =?utf-8?B?S1k5bkQxOTZaWnpUdGVMK1dLblhVYnduUEI3QmRyVGFPRWpXU3RydzBHNC9G?=
 =?utf-8?B?MVdWTjQ3a3RVeFg0cXZMZVcxWDd3L1lacmFab3dKdHkvMk5vV1VGMWZCSFNr?=
 =?utf-8?B?YWtaZUNsR2xydnhmVnRqalNiU2JCb3UvQ0IxNGFSbUdnaFhTbDlIMm8zMGxv?=
 =?utf-8?B?SkJoV2lsUk1KZHp2S3liQzYyMGlrV1dZM1pzRlJsMm9aL20vUDh2bmNkN3JB?=
 =?utf-8?B?Mm1EOHdpYnplQ0NCRGQ5OHYyYUNRTXg2Z2ZCNEhkZFBYaWp0ZWE5d2pyTzZx?=
 =?utf-8?B?SWxJUVpabUN0ZXNiTVYrZURiZ09iY0FLWDJmY0J6bmxiVW9uSmQ0SUhsVG8x?=
 =?utf-8?B?aFkrMVBYc2lzOTRSdWFySmFVNFlrSy9xNitQSDJYbm9SVkxnbDZXSE9wcmFF?=
 =?utf-8?B?cmZkcCs1NnhmQ29hL2IwNmJGWThMUGpBa2UyeVBkSmZ0VVFudU1PTDdDRHh6?=
 =?utf-8?B?TzJjZnd3VFd5ck4yRnZNdllIWDdVTjV3OFJLK1FlRVRxRGNRaHVHSWEvdDBR?=
 =?utf-8?B?TzN2NU5kK0hXUnRkM1ptU3lxMCtVdzNRR05lbUU1WkdWY1EveFp6Z29qdmIr?=
 =?utf-8?B?WEhFazBob1VMakJkQVFSYVM4MkdxTzRBdzZpUWdlT1dEVEo2QVc3WnVMb1Zk?=
 =?utf-8?B?b1hFaE81Wkg3TFdMVUNHSDhaRm50QW9KZWQ3VjNhclRxRlhNVGl1Nmlkang2?=
 =?utf-8?B?dTRIUG04cG9KRUlEN3VXZnBxck5GVDR4QjF2NUNCUWx0MVY1ay9taUljRTIw?=
 =?utf-8?B?cm9peFI2RXpkTTNsMmJKdWduZlBIWHl1TThsSXA4VGJlVEd1aTJ2cEwvemUx?=
 =?utf-8?B?NXFrZGJmVXBzTWdkZjBXOVY5SWtzYnoyWVNyMlZaQ0pNb2xmRlhIRk5ZWS9P?=
 =?utf-8?B?V0FGclI5MS9DOVgvKzdlcjRwL1U1ZGkwM2dkZk5ULzJ4dDFZUGswUGdEU240?=
 =?utf-8?B?ZUdjcWFsR3JoNjV4elVyWlNPcEZDMDc0V0hBUkl3Ykxlbnc4N1ZqUjlsK1Vk?=
 =?utf-8?B?YnU3d0pRaTYvTnpBV3lqOW82aUtnUzluMjlZQXcxVk1tSTQxVVhSV0NyNlZ3?=
 =?utf-8?B?OWJwdTF6b3lGV3VLUUErWWxFZys3T0xrdUFaOHFOQ3RYSGc4NWUxdE5xNDJa?=
 =?utf-8?B?SnhQbVhxUDJVdjE2dTFkYTIrMThUMkpzUkg0QWVlRVNpNnVaNUpRdnBXVmVQ?=
 =?utf-8?B?NzB6Z3Q5eWM4UzNVL3VoMWFGZ0FnQmx5WVZVZEJ3dlBWMitjVEtKdGZ5UGVV?=
 =?utf-8?B?TURVZUQ2bW5EYXBIeXZnTXUrQityWkc1SDU0am84dXlFTitoOFdTTlE1Q1N0?=
 =?utf-8?B?NXBrelNkTHQ5eXN5S3Qrd05oZ0cxaHQ1bVNLUT09?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;6:zGrW2EfRwb9sWQYz2lsHOMimmqAvvN5VMDpzOFoJLwMSe7RDeG3QCyXVm08ff7cDUy0zYQJJ5nMq3sIk6RhWbFd7uI3CuQxAsm8OtGxtiPkNzNwo00B4H9e7M0RKVfqw3qXrs2ccbxUz6trWsCpzl2391g7ZcnnaAwgi05T2grgBsgWJk1ciF0evjygga2yg36V38jLau9+RSywRaojjr1o6uiydqqyoBSkGn5x8KkV5EsQHkW5NmxpfAd/H35PTwQSLsR8AszvmDt1GyQi2z6VHMbYfyymiqWotq9ngXCQ13VUA9rpt1hnp/LBxKa+bAzGy/N3TWhiIMZ7faqkqRIwYVxnzujPZ/4S2I9H79vI=;5:jB9ZAjoVJ/uuqn9DjS4GvbkkgyfUX1Q6Ml9NXNv1of1DNyLBe7pI9RX29zue3j5r1bxhvCcaLNK/qL/g+cYyhvEHTeMCzAT8qIEcj4vPG+6RjSv8ly2KXwkEC2T3nnOL4HhGl1d4V15yuYNOb6dyHCgm4DAw0uvyMIBeyw4BAa4=;24:jJ547Tggd8dQ3zyj5aAvTOulM857RcoDWBv1RqxegMyD8K/otwcU7Lw6jdUmYYdDZ4hHTSPx00AdWZcpzrka3u5DrxjIJfKlCrdG8Kuy988=;7:0oY4EyONuSMF9NhjIMMAQCU84pkBzi4LkMcHb1/3YA4QaaJFrjroR54qyXANJMEdfYoO++MzcyjLxvC1ukdGWpvSORRKppq9dC78VKWtkBG9cQLlwtsdOnKWNNXJw5pkwm49UOvxGStslH1ypeRyXB7zd+2Y4OyZ3z7AbHFqs3Rcf/SWanjPite4M9CLqafKeyoW5fG4Li9qvctv+NjE6euy6ZGNlNxC4n/W+EMKzikY8IR0zj8IgcbrHWjU8lCh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;20:UmytAzytpk0rfRo+NDJrxEH6XqwvJSEpG5AFIiKJ0hUwL1xzvHRwOz3OJTmYu/TKTuNlZ3+Uu5BHUMCHSGhoWO/mdH32zIsp+kNlXYCE57Nop752QZOdFRekl7hxKw9x1wxZOgfp81IG+MwTpx6vQ9ZS8hrOakFjgOF4mZE/ACYFNkrVEA+Kib0WfUpGYZCJbHUr6cPxfN4lD3Hk88RStMgrMTu4DMP4+MppByH182KEvbzFp6lFK7dNFHWGp5OM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 07:46:21.2732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c13f4de-10be-4fda-9373-08d56a110f2b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1310
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try to use a fixed limit like I suggested once more?

E.g. just stop swapping if get_nr_swap_pages() < 256MB.

Regards,
Christian.

Am 02.02.2018 um 07:57 schrieb He, Roger:
> 	Use the limit as total ram*1/2 seems work very well.
> 	No OOM although swap disk reaches full at peak for piglit test.
>
> But for this approach, David noticed that has an obvious defect.
> For example,  if the platform has 32G system memory, 8G swap disk.
> 1/2 * ram = 16G which is bigger than swap disk, so no swap for TTM is allowed at all.
> For now we work out an improved version based on get_nr_swap_pages().
> Going to send out later.
>
> Thanks
> Roger(Hongbo.He)
> -----Original Message-----
> From: He, Roger
> Sent: Thursday, February 01, 2018 4:03 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; 'He, Roger' <Hongbo.He@amd.com>
> Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages
>
> Just now, I tried with fixed limit.  But not work always.
> For example: set the limit as 4GB on my platform with 8GB system memory, it can pass.
> But when run with platform with 16GB system memory, it failed since OOM.
>
> And I guess it also depends on app's behavior.
> I mean some apps  make OS to use more swap space as well.
>
> Thanks
> Roger(Hongbo.He)
> -----Original Message-----
> From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On Behalf Of He, Roger
> Sent: Thursday, February 01, 2018 1:48 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages
>
> 	But what we could do is to rely on a fixed limit like the Intel driver does and I suggested before.
> 	E.g. don't copy anything into a shmemfile when there is only x MB of swap space left.
>
> Here I think we can do it further, let the limit value scaling with total system memory.
> For example: total system memory * 1/2.
> If that it will match the platform configuration better.
>
> 	Roger can you test that approach once more with your fix for the OOM issues in the page fault handler?
>
> Sure. Use the limit as total ram*1/2 seems work very well.
> No OOM although swap disk reaches full at peak for piglit test.
> I speculate this case happens but no OOM because:
>
> a. run a while, swap disk be used close to 1/2* total size and but not over 1/2 * total.
> b. all subsequent swapped pages stay in system memory until no space there.
>       Then the swapped pages in shmem be flushed into swap disk. And probably OS also need some swap space.
>       For this case, it is easy to get full for swap disk.
> c. but because now free swap size < 1/2 * total, so no swap out happen  after that.
>      And at least 1/4* system memory will left because below check in ttm_mem_global_reserve will ensure that.
> 	if (zone->used_mem > limit)
> 			goto out_unlock;
>      
> Thanks
> Roger(Hongbo.He)
> -----Original Message-----
> From: Koenig, Christian
> Sent: Wednesday, January 31, 2018 4:13 PM
> To: He, Roger <Hongbo.He@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages
>
> Yeah, indeed. But what we could do is to rely on a fixed limit like the Intel driver does and I suggested before.
>
> E.g. don't copy anything into a shmemfile when there is only x MB of swap space left.
>
> Roger can you test that approach once more with your fix for the OOM issues in the page fault handler?
>
> Thanks,
> Christian.
>
> Am 31.01.2018 um 09:08 schrieb He, Roger:
>> 	I think this patch isn't need at all. You can directly read total_swap_pages variable in TTM.
>>
>> Because the variable is not exported by EXPORT_SYMBOL_GPL. So direct using will result in:
>> "WARNING: "total_swap_pages" [drivers/gpu/drm/ttm/ttm.ko] undefined!".
>>
>> Thanks
>> Roger(Hongbo.He)
>> -----Original Message-----
>> From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On
>> Behalf Of Chunming Zhou
>> Sent: Wednesday, January 31, 2018 3:15 PM
>> To: He, Roger <Hongbo.He@amd.com>; dri-devel@lists.freedesktop.org
>> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Koenig,
>> Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to
>> expose total_swap_pages
>>
>> Hi Roger,
>>
>> I think this patch isn't need at all. You can directly read total_swap_pages variable in TTM. See the comment:
>>
>> /* protected with swap_lock. reading in vm_swap_full() doesn't need
>> lock */ long total_swap_pages;
>>
>> there are many places using it directly, you just couldn't change its value. Reading it doesn't need lock.
>>
>>
>> Regards,
>>
>> David Zhou
>>
>>
>> On 2018年01月29日 16:29, Roger He wrote:
>>> ttm module needs it to determine its internal parameter setting.
>>>
>>> Signed-off-by: Roger He <Hongbo.He@amd.com>
>>> ---
>>>     include/linux/swap.h |  6 ++++++
>>>     mm/swapfile.c        | 15 +++++++++++++++
>>>     2 files changed, 21 insertions(+)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h index
>>> c2b8128..708d66f 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -484,6 +484,7 @@ extern int try_to_free_swap(struct page *);
>>>     struct backing_dev_info;
>>>     extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
>>>     extern void exit_swap_address_space(unsigned int type);
>>> +extern long get_total_swap_pages(void);
>>>     
>>>     #else /* CONFIG_SWAP */
>>>     
>>> @@ -516,6 +517,11 @@ static inline void show_swap_cache_info(void)
>>>     {
>>>     }
>>>     
>>> +long get_total_swap_pages(void)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>>     #define free_swap_and_cache(e) ({(is_migration_entry(e) || is_device_private_entry(e));})
>>>     #define swapcache_prepare(e) ({(is_migration_entry(e) ||
>>> is_device_private_entry(e));})
>>>     
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c index 3074b02..a0062eb
>>> 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -98,6 +98,21 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
>>>     
>>>     atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>>>     
>>> +/*
>>> + * expose this value for others use
>>> + */
>>> +long get_total_swap_pages(void)
>>> +{
>>> +	long ret;
>>> +
>>> +	spin_lock(&swap_lock);
>>> +	ret = total_swap_pages;
>>> +	spin_unlock(&swap_lock);
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(get_total_swap_pages);
>>> +
>>>     static inline unsigned char swap_count(unsigned char ent)
>>>     {
>>>     	return ent & ~SWAP_HAS_CACHE;	/* may include SWAP_HAS_CONT flag */
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
