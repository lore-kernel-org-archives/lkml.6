Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDFPsv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:48:51 -0400
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:48160
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751530AbeDFPst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:48:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Jean-Marc Valin <jmvalin@mozilla.com>, airlied@linux.ie,
        alexander.deucher@amd.com, Felix.Kuehling@amd.com, labbott@redhat.com,
        akpm@linux-foundation.org, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
Date: Mon, 9 Apr 2018 13:48:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM3PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:207:5::33) To DM5PR12MB1721.namprd12.prod.outlook.com
 (2603:10b6:3:10f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ee9e9f-52af-45cb-5047-08d59bd5e08d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1721;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;3:naQyYFowvk9ih38lOcLVIk7w0UKSDxrvyAtoyDkDRUaWXtwrCL1qTYhkompvAPNj+E+WbdRHie5fphUkvWGxFqDA4R1/R/aqWxR4VuF5zJJBfUrx4uHJdh5pIjg6XTAMjJ34pM1lMjcCMIpZN514TWaEL5sb0oJMpS7jPgkbwkIKMU9HCn+E5J4ZOOCsTTIshHQpRwO+F07bWAamKzrYAEeKqfoMSHQQZKV4s0IE6hI0d5tAZJvJkdysB+PT5MV5;25:A0r4JMRiXXkNK/Wj6YLI6+LkEYhM/NEEw2QCtH+PrEw2XKrg6NXFUeAlyj04h7IwXiGBFW+UtDSPKZLizxWvFAs7xQQLiwP8ynM63jvpnwIZH2j5BwnMT562z32DTeGd+uyERL7NGEYVabmV/cEa3uE9GpmV/gwfRqOOeMbi5ev984cTBarPWbx0LRR8a8BKRbOCRg00Zrlorl3TskNYG66jagl+HgNlSGi3m8ooiyywDxiVDOG/sq6o8KS8mYPzwOt9nM6fTCmsVcEVhRhfWMM3FoZiakNu3/Ug1sh/wzHMXCzwkujJRBbU6C2o7xZGJPvwNmncuh0T0U+wxiVeLA==;31:DuATO6SPbLquRTSdGW4aCSaVW9O42V9rrMPlVslHsscO/O3EzNeGSfGkP83yXsdfIW7Ny6aK7EbMqWRbtwOqyJioWIpOIacIvR44238JNEvE2Tu0iVz41CUMG62vnIWfZZbHzEEkRT/Mw5ZiQyIut0OUJF2WuQQjEGUyYhugDNg077wzsWz8u5S+QE+lvi/w77mkFv0YhhNhC16qX9BMd54/DxYtS9HgLi06FBTznok=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;20:xiwzCKI9v36vgkNRRVOdG/XN5+HuB2LZ6/WXHq5iWOKdssvxhMkaJsQdx8GLYSXn+ZxnJYpnYmIrQwuCarMURbg73neKdO2Fx5QCX8qrwSpmMQ3MUaz2das5i/yifgUtiW4lCb56zvGss/FrgeYdunaGfeOD4AMnZgxyzYMggDiJHYi/gm7U2xtBVTY/eK3ChwepHgrwHYwAJnhhZm8fWNZQnoT53tt6xO1mBLe8FSw2657O6f1soVAIHHJxW8yKjgDS5c4taJgoKzV7kvkI79M4HWwHorsXQCa2Gx7atIgisc1rcFmLfl+Fcns46xyaYb7hs2aCvL2ydGWo2hc4Naul/FnCQTs3Qwdt01cEhnv3Gm+hXryLggu5XlD5BirczUN0Iomb/F2BZJ1p29ulYpkgpcT0t1p1fh9Ts2OxX8RcZ5Ge21AcPfc3jMPOE9FRlvzIMgPaizimnMj3BjpgYNE8NZMT+Nf0i0BxCtXmRtOqi0T52hR+qFSF+pjhz2Dk;4:LgKlLDoOgF2yHuk7nUNX3jrjsuRtcegKKKl0pHRSR0RZ9B9hN7aKceMhA+jKjAmTdVgf3RJ9K6KyCbMBqw+7Q2cft6EqMWm5uemYgXcNpOcgjUfUMinSXbo5o5Y2YaAQlLTx6Dv9hsYZ7bT4nnjCLrF7I61cYawGiD72V3EDZJXhPeriF+8TVB4cwJIAEr3sIQCxd6uSu2BQtzl4rCwd7uHnElulqEG1OoPcRwEEwNsuG8jJ3IHb4X4VcdJHmAhMqQVYguMtp5qdCdoQOx30HuG6IqhK1JUYGYm3gLcblX9+HRzKS3dX5ZM0Q1DWjdV+1H0/QVfC077WCniQ4ywqWw==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1721BBCBB22445E4CDEA125C83BA0@DM5PR12MB1721.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(396003)(366004)(199004)(189003)(966005)(6666003)(36756003)(52146003)(23676004)(72206003)(64126003)(2486003)(52396003)(52116002)(386003)(67846002)(53546011)(76176011)(5660300001)(229853002)(53936002)(6306002)(6486002)(105586002)(65826007)(68736007)(31686004)(305945005)(7736002)(2870700001)(2906002)(47776003)(478600001)(8936002)(8676002)(97736004)(50466002)(65806001)(1706002)(6246003)(6116002)(58126008)(81156014)(65956001)(25786009)(86362001)(106356001)(476003)(11346002)(446003)(186003)(2616005)(46003)(16526019)(81166006)(31696002)(316002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIxOzIzOlBnbEQzY1ZUVnNFMHFkZklkb3A3RnMyUlho?=
 =?utf-8?B?YmxIVkJFOHFxTUpSR2JybGF6Q1B2S2U3OGlUeklKWUVyZjVyV29OMmNCZU1Z?=
 =?utf-8?B?UzBSSndUMTF6amlBYXliMy9xakx6SE1KNXlzYXUwVnRCVEt0T3c3WEdhRWE0?=
 =?utf-8?B?amxFWmxyVDMyUUpNaEJzVWJKVXZEYU5wSEtHcUwwZVh3Z09zZ0E0enZYVWJH?=
 =?utf-8?B?TmhBSEpoMVkrM0hsa3ptUzBlSE1BOU8rbjlLTTJXa2NqeUhzS3RmWWdQYXpH?=
 =?utf-8?B?aFBGTTdwSWJ3TDZ1UEJOYzNWL3Q0ZzQ1U3A3WW51UkZpWkNiWndZakREMXl3?=
 =?utf-8?B?QnNGbUFxMGYyOEJXaHJ6RUFadENDdE01QVpHWm5KTXdvZ1JWQ0NDbjltT3Bk?=
 =?utf-8?B?SUIxeS9IY3ZLZ0Yyd1J3eGlYMW5WYytORnhKS3VFbFFzTjJFSVJkcFhTbTNu?=
 =?utf-8?B?WkNXcHlhczI4YnZZTGl3N3lZOTNIMkJLNUdpb3VqSWxDRzhKRVhLSzZ6eTBI?=
 =?utf-8?B?YjRxSFJ6eFlyNE9OVFYySndGaFE5bEl2WER0RU10Ty9hTnZEZGFXSEZhL2Fs?=
 =?utf-8?B?eGNaUXdwMzIvQjhKRCtBQUU5eDhjWUlKVmNiRFlaaEpybURna2ZqYWJHNGpy?=
 =?utf-8?B?RlRQaWNkcFZ5clpVQjlCM1hCQVpXdWxSVHVLWTZ0RlpYOStzdGthOHFEMjVj?=
 =?utf-8?B?ZTFhV1dKTjErRlVxbjBXM2tWYXRKMmFNMlFUSmFQdU1ZbVJEWjRXUThNVFN4?=
 =?utf-8?B?MnVkUlpXS0xLWVRqdFpROG5zTDE5aS9rT1dyMHJPM2dWWXBWYjVBaG1hWUxt?=
 =?utf-8?B?cmtIOVpTalBjU2hqMTlMaXBQUC84TVpzWEhoVVE4bnBKSy9BVDFXRWg1SzZw?=
 =?utf-8?B?YVRsb3JlYlZFL1F1dHdZTkF0TXAyZFlabDhxdksreW9PRUxLTk0vR0t6b0Iv?=
 =?utf-8?B?Q3VTcENFRndqTWhDdnQ1akEyYmpadjV6cmw4M0YwWlZGQzJLcnA5M0tpU2FC?=
 =?utf-8?B?S0krMFhSbzJBUEpBQjlNUGpqT0wzRzQrbGUwYnJZWmJwVEVxWk9td2ROWHNJ?=
 =?utf-8?B?dHlVZ3lFOWZ3VEJvRENPVWgwZjMwWUw5Z3ZvSTB0eXlwL3dDbnlmYmZtckJH?=
 =?utf-8?B?dzRSZURiNU01Q1l0YXZESmwxY1NTWGRVSTRQNTh1ckdjYU9qVkxLOFk4NEwr?=
 =?utf-8?B?QkM2OTcreUpkZGczVkI0OVJwR2VHdnQxUlpuZS84SU5jUk56SHNGSUxlbHk4?=
 =?utf-8?B?ZjhJTlVEOTBRT3NTUGxwMjJ4Y2c0T1RjUVhlc0J1UTJUOHh2cWZGaEUwU1FC?=
 =?utf-8?B?TDhTZGdrcU9oTEhHTklWWERSQmhwemNtMi9PSWtBWVlLQmdKa1Z5Z01RZ0Fs?=
 =?utf-8?B?K2hCSTlmTnlhcW5kUDZ1WTFyV2VnMmw2THZRQU4zY043aDNMOU52WUhFZFZX?=
 =?utf-8?B?STlEam9tM2JuMWRrZ3duTlVRKzJkb05ZLys2eUM5UTJYdklWQTNTbnk4VlRh?=
 =?utf-8?B?ZjZEM2tOWitMV3QySUdPSnRGd1c3Q3R2emwyd2loU1VSTUhkRlNzUnJiZXp0?=
 =?utf-8?B?bzM1cGtNNDVOTzJCd280emdzdktESW1ZdENBUW1vNDNqZ3JvYmtoczBmSTNZ?=
 =?utf-8?B?eC9qd1UvWnhYTmtwb1orVFlVRWtMN0ZjMzBkWXJOK3FhbDVJc3ZCSWRLOTJT?=
 =?utf-8?B?VXMwOGg4K3RLYzcvYUd1aVI2NjQ0NWhqWDFGZFplSzNYdUxLM3pHMGhYdisy?=
 =?utf-8?B?cHY5YjI3MldWeFIxTjZ3WHpQeHlSRFBHdVQzaHI0NkZuTTRqRGFxTStOVFZ5?=
 =?utf-8?B?QzMrWXc4VmdkZXk2b2ZHWHh5OXB4dFhsOUZIbVE5M3poTmQwczFJaVo5cHA5?=
 =?utf-8?Q?wVrnIypLZss=3D?=
X-Microsoft-Antispam-Message-Info: 3ebDjvJk5o8aWdcmSyDsy0t082UgoCq2b9QAFCE/FnaHwvgZY8GlZ/PWMnKe7yxHTjlJXeRwsNsURJ1HNDrqOhuv8qF2UXmeUv28q+zhR8gPdEeVADBasJShDW7C7nTawZcFJ3PIwh/bnNCT6gK7HqwzVZzOEOnnJ7yV0VJLVbQpJO0JbRoipbkfQ5j86ONy
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;6:RIE2bMVjBXF98/jOJS4+q/1Cld80NMycyzYNHBSw5ijE0H4i+vtgX1CzLIgzLmOF7g4/rQUOmbPsMRCEc5JZgSdM7kW7t17WKurNFStvqF3EZZyl/lxAjizPrIR7lFyVyzRGVLrisJq2qm8a9W4kvVYYb+6I+aQtrdb8gYJ8EGd2iEG8MzLW+/VZPDd/lQ9V7K8Sl6iCzygtfVptkBoHCujEil/NCnJk7KNx4KZtcPp8iQofgpT8sFwFSiKQ8aQEQhon6W+LwaOLlwajKlmyPYtpdeJmAciSDs/ljvBLMMd+lJu57y3NclEfU2oBaXQhP6JFGQpEYt3LZJJLjr7bry36RQUTKnDtN1MxK+3/ny+ob96QF87I7z097CWJ560A819EbS/MyPJk0QVuUFCYgTBbquGMQ1cEXsiD4F/FEuAVqVJfyiUQQYYmHuAMoDGpb/TJYKPfWRH5mR7rKH8Fgw==;5:9gDa2DxQubpzMXuZz7LYhN+QVWzrm1g+gGgCWMc4639Mgz/bolllthJAwub+WJklLN4xF4PSMVqZKJsFPDGNbTTM4jqq//SKF3gdqT4ewBNFB7ntE0RrAZR6Qq6jingV/9VADQXHK+woMKCOeDJWnWaIZHQtzIUgssCdGKCF2Uw=;24:9cC4N9WJjuu6kxgXkEx6tRhvOZuKJOD9cvmTVeuSMIovvLSXKEoNALaP/4y348zLrmcpgNS/zBZUUvHEUDMSamW1WT63gtNyFDsYScDGj/Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;7:VfvOAllieHLXtTF1uxDRNt/Cz36QlU1uESGFOfvkOMFGi/nH5eJXEU74eBhQP1trzpqsXlf73GZucMjgd1G44k6FWw66ebSQ5Vlf5eKgkp/yLVBnUIQp5Nu9sI+hlitO+9Qql7QqO/dwoRBDEfqw4755Dqi1QwXPZ2EKuZxSjPDJyxlxlGL5EOySKOKpVdSdBeF8mMS+D5PTvSTl299So9dvpUwqHuJjzhHTKsNyN1FHGkvRlQgKQMtEg/GxXwI/;20:/+38puk1A51jG77iQAhOzdujPTiGgNfeNYZYE1uD9SL2azLWcUxJcAQOxXujoExPm4XRA0rrQsyiFgxvBr6Dv/Td4wlRprhOjsTfdma+u2AOv5tBING808lM57/8GaSmpTaKAVZVspdfbwrTPXafGwim/K+NKvFE60k/PB53KyRnpBmfhkF7sxIO1EuBaGsun4ArTzfJZwgB3IDz/JdgamXuQkWEtzvkzpBMFk9gUQTAHfFHoI2ZPl2YPzMqFXvV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 15:48:41.3301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ee9e9f-52af-45cb-5047-08d59bd5e08d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.04.2018 um 17:30 schrieb Jean-Marc Valin:
> Hi Christian,
>
> Is there a way to turn off these huge pages at boot-time/run-time?

Only at compile time by not setting CONFIG_TRANSPARENT_HUGEPAGE.

Alternatively you can avoid enabling CONFIG_SWIOTLB which will avoid the 
slow DMA path as well.

> Right now the recent kernels are making Firefox pretty much unusable for me.
> I've been able to revert the patch from 4.15 but it's not really a
> long-term solution.
>
> You mention that the purpose of the patch is to improve performance, but
> I haven't actually noticed anything running faster on my system. Is
> there any particular test where I'm supposed to see an improvement
> compared to 4.14?

Mostly crypto mining, maybe some games as well.

> I'm not sure what you mean by "We mitigated the problem by avoiding the
> slow coherent DMA code path on almost all platforms on newer kernels". I
> tested up to 4.16 and the performance regression is just as bad as it is
> for 4.15.

Indeed 4.16 still doesn't have that. You could use the 
amd-staging-drm-next branch or wait for 4.17.

> Unlike the older hardware reported on kernel bug 198511, the hardware I
> have is quite recent (RX 560) and still being sold.

That isn't related to the GFX hardware, but to your CPU/motherboard and 
whatever else you have in the system.

Some part of your system needs SWIOTLB and that makes allocating memory 
much slower.

> I've also confirmed that neither nvidia (on the same machine) nor intel GPUs (on a less
> powerful machine) are affected, so it seems like there's a way to avoid
> that slow performance.

Intel doesn't use TTM because they don't have dedicated VRAM, but the 
open source nvidia driver should be affected as well.

> I'm not saying that what Firefox is doing is
> ideal (I don't know what it does and why), but it still seems like
> something that should still be avoided in the kernel.

We already mitigated that problem and I don't see any solution which 
will arrive faster than 4.17.

The only quick workaround I can see is to avoid firefox, chrome for 
example is reported to work perfectly fine.

Christian.

>
> Cheers,
>
> 	Jean-Marc
>
> On 04/06/2018 04:03 AM, Christian König wrote:
>> Hi Jean,
>>
>> yeah, that is a known problem. Using huge pages improves the performance
>> because of better TLB usage, but for the cost of higher allocation
>> overhead.
>>
>> What we found is that firefox is doing something rather strange by
>> allocating large textures and then just trowing them away again
>> immediately.
>>
>> We mitigated the problem by avoiding the slow coherent DMA code path on
>> almost all platforms on newer kernels, but essentially somebody needs to
>> figure out why firefox and/or the user space stack is doing this
>> constant allocation/freeing of memory.
>>
>> There is also a bug tracker on bugs.kernel.org about this, but I can't
>> find it any more of hand.
>>
>> Regards,
>> Christian.
>>
>> Am 06.04.2018 um 02:30 schrieb Jean-Marc Valin:
>>> Hi,
>>>
>>> I noticed a serious graphics performance regression between 4.14 and
>>> 4.15. It is most noticeable with Firefox (tried FF57 through FF60) and
>>> causes scrolling to be really choppy/sluggish. I've confirmed that the
>>> problem is also there on 4.16, while 4.13 works fine.
>>>
>>> After a bisection, I've narrowed the regression down to this commit:
>>>
>>> commit 648bc3574716400acc06f99915815f80d9563783
>>> Author: Christian König <christian.koenig@amd.com>
>>> Date:   Thu Jul 6 09:59:43 2017 +0200
>>>
>>>       drm/ttm: add transparent huge page support for DMA allocations v2
>>>
>>>
>>> Some details about my system:
>>> Distro: Fedora 27 (up-to-date)
>>> Video: MSI Radeon RX 560 AERO
>>> CPU: Dual-socket Xeon E5-2640 v4 (20 cores total)
>>> RAM: 128 GB ECC
>>>
>>>
>>> As a comparison, when running Firefox with 4.15 on a Lenovo W540 laptop
>>> (with Intel graphics only) the responsiveness is much better then what
>>> I'm getting on the Xeon machine above with the Radeon card, so this
>>> really seems to be an AMD-only issue.
>>>
>>> Any way to fix the issue?
>>>
>>> Thanks,
>>>
>>>      Jean-Marc
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
