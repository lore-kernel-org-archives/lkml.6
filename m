Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeA3KdH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:33:07 -0500
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:37632
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751592AbeA3KdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:33:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
To: Michal Hocko <mhocko@kernel.org>
Cc: "He, Roger" <Hongbo.He@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <20180130075553.GM21609@dhcp22.suse.cz>
 <9060281e-62dd-8775-2903-339ff836b436@amd.com>
 <20180130101823.GX21609@dhcp22.suse.cz>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7d5ce7ab-d16d-36bc-7953-e1da2db350bf@amd.com>
Date: Tue, 30 Jan 2018 11:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180130101823.GX21609@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: DB6PR1001CA0040.EURPRD10.PROD.OUTLOOK.COM (10.168.69.154)
 To MWHPR12MB1310.namprd12.prod.outlook.com (10.169.205.135)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df650bde-ba9a-424c-8732-08d567ccd707
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1310;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;3:fqawRhxLPxwEvFBkfnQtiXpeXyGaPi4EXZJ7jb4HQaKjzqqjkPK30Ow+fo7dUpW+mP3yKGyiA2slrn6qOxKSKPUo2Fswcn/FT12j+2Z5mOx2YO8pOzIuQe7Epmo9VHFn0TaNb4jvzghoDDENSSjBZK60kb+6oysqcsq+gHwN9yFjsHzMw9uaG9T7k34Ws94pvmcPilUZNHyff/NsoY3wvOOXSwptE1BkRVjjEwne673wz0iPMvl61Kiy5WIDzATa;25:bqmNMVcv9hJ7OYJAU5mgVRLj8bsdcnCtd1WxJsxAS6xr4tnyl4Xrj3U+qb+WZLxmKjF3krxAs7qwJS3Z7scssMNiBjinwJerHgucL2XH8oY7A2du4/H08KZq8SDxh82Rap5LoR6LNnH32bhGljY6IWr2jJeoSgl/2jJzEe3G9tYpFG8INEAMPXqWqCdd9eUbMks+jD/yGYGC3RuDoKHBd+vNoGE5xYoxRhnO1mROIcCEOlP9H3okCwmUHb3AzHLnk0vefDJ6xgtXISaFurU0IBnWvLRrlZvsPOQ1TwmPuYvuHALhuC6bHDA7q7cA/NKtSY5aq9syhK1z+D1UAN4ThQ==;31:7gGu8pLjo6f02ckLT/XXNmBchfIN6QfFg1+sPg+vcQz1WD4EG7OfGlAcPLD9HCrauzNPcBra1YwFtOM8kPxT9Adrh6DmOadZ7zjq8kB38QQokauG70ijp9PQbop2FaUFqHqwLo3/ohvcDzjAYNDrT3CZwMySm8OFxuqihKKePk4Zjg87wmuWf4Db8/Reeceen07L3dNe0jzRQ3X7/9ngVMiyooumq/m595xVlGCdRjs=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1310:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;20:Q3HEHUDBV95/1nrBcI1QADPTm0ZgfWK5Px0zdm8LqouYajooCM+ShSDFBLlpSjEvytQjb+2uv+yrK8op8R6eLgYCwL4MA89lXFW1NBpdpNVtTgNqwJFMgZ+wIu0VRhroyZpW9a5J3JC5kixruqaCcqWTWLA6+g7H010JvQK+dELAGyVI/gXeYt3awXijf/d72JaqUqmOHY/rMYbxkXhzaKyKA/LueTOfQqO7nTP0yRuLKGjRWps3pos4iep+50ha9jcPtaoF3Jb0Zfq3DAL8PQ5PdWxWhuIW7Ce2azRHPUN2iyISPJZqJ/Gg2oeF/HScu2VfJ6Dsx5IMXhkEnh8/yHBYYiyWO7gVTfXeQ7cRJq5UST2Z032T7No8LuFAGbM1u5mzzmQ62ayj/DSuC7Z/QANfdzljFcZmalrxDC4x77X9sOHB1Jf/fcqxtyAgORIjxSsPzsohXDarxO9LbI1X+oLAdT/EE7c/gRR7lZRHkLPKLguydVDxxJA/AAaocKBb;4:P7ySWod9AiP/bbDL16M8BXSFhb2F4ilBzTnyPhLKVR8ZX2mrM9HoZZs+oKNbgdGituzryODX4pyDOKpZkZC8z0Kge7ae48H183jhUaazKiPVlKUyETA32l+cj/0cuWNfmU0qJuzuMfSEGDyDWRAB29SUVjSb0rRl6h52TStHdgazGrmcyN6PCIonK5920s21Q5fNX5kycnRBDYKHz7cDqdXsJ+t3hOc1sn74PttDH0qi0Z4dFO6X1y1ZVskfbZcooYHA0g0/Qz4SgQu49uW+hwKPHox5PWvfMUzKj0/rnNtQ9iRG3WYQVcHa8pPLlM2r
X-Microsoft-Antispam-PRVS: <MWHPR12MB131053213CE4787B7376180E83E40@MWHPR12MB1310.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1310;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1310;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(189003)(199004)(377424004)(7736002)(68736007)(50466002)(31696002)(97736004)(6246003)(6486002)(4326008)(64126003)(5660300001)(16526019)(67846002)(36756003)(31686004)(2906002)(2950100002)(6916009)(6666003)(25786009)(93886005)(229853002)(65826007)(305945005)(47776003)(72206003)(106356001)(105586002)(86362001)(54906003)(59450400001)(53936002)(81156014)(81166006)(316002)(58126008)(52396003)(52116002)(8936002)(65956001)(2486003)(52146003)(8676002)(65806001)(186003)(76176011)(6116002)(2870700001)(83506002)(1706002)(386003)(23676004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1310;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzEwOzIzOitod3I5TXlsdHViRDhyUzc2Mm9URDVEY051?=
 =?utf-8?B?NkNlcTRuMTZBOGdScEM0blBrQ2pOL2ZKNnUwbUQxeE1PNTUwUFRLcGFmb1Ji?=
 =?utf-8?B?bFZKZEhGT1B1bzhqb2ZWbXR2bHR1YlJpTDN5a3VuU1U4UlZVNWRNclFNb1Zy?=
 =?utf-8?B?dXo4OUF2ZUdKNGdXcGJqRm1TYzZ0amVtVmZ4SmlFL3NOVjdEZG1xZm4rQU52?=
 =?utf-8?B?aytENHNFSGxRcE1pa3BDNjY2eTgzd2JRbGR6ejZZUjA2d2xNY3NEcW02UzdN?=
 =?utf-8?B?bHMvMHBwNmJ4MTlWQXFMZnd4OGhRNVVvUmJzVlZhRHg0VGtkVlkrMXdYRnc3?=
 =?utf-8?B?ZTcrckJpd2M0bmF5Qm1kOFY4Y2R0OEFWWmV4TlFrVDRNcWo0ckJ6Z0Jpb2c1?=
 =?utf-8?B?MmR2RkZqQmtyNVd6cHBtODRubUFqeFVQUWJpcEFLM21ZNFN1bFpkQThWTGdo?=
 =?utf-8?B?cG5jNTlJL3RRS1drSEFEeDJPd0ZmL2NDTU1OaUw2TFB3bkluNVQ5TU1DZFR5?=
 =?utf-8?B?UVB2ZTdUY0lERHk0dXZrdVhzNlRrcmhxWnRoOU5VOGpkU29jVUIwYVM5dzNU?=
 =?utf-8?B?VFdLbDY1SDNuSkdUdmVJak44ZE9FYU9jckhNUzg0VGs5K2xqNXBvVmYyaE5z?=
 =?utf-8?B?V0tFa2xoTVU1aStiWk9NSWpSbWNmbFFPS1FxNmN1MDFrR2lWWnhUUmRhTnVv?=
 =?utf-8?B?cUpPakxpNUcvcXNBWXFFeUJ6Zkh6RmIrSkZQa0ZxZ3MvdHFVcUxaR1JPSUpB?=
 =?utf-8?B?aFVpNlc2ZllLSVlwcm5oTlhGL1I1WDN1T3lCQ0hyN09oSGxGQWJCTEdYanVK?=
 =?utf-8?B?K2NUZnNLdy8zcGVKTnZGcFY4UlBVTk5ibjViaE1BN1cxdW13SnVMQWxJem1B?=
 =?utf-8?B?Y0xKcVQwWmEyRjAxYVJsSVRZSEVKWUh5YlRDREFMdyt0K0Myb2R1alNqK2Na?=
 =?utf-8?B?TUF2U3dHN05rVVdqTWc4NGNMQ2dhN2VRQi9FWWkyMEgwVVhBTWJsNG0yQzhr?=
 =?utf-8?B?NFg3eklROXd2Q0pPWjQyWFhYa294cVJmY01xRjk1VEJ5TEhxV2lzVytMYTNj?=
 =?utf-8?B?czgzdS9QOGZ3MTJPeEVGQTVhYmFrVm43NDJST1M4ZEowTUkyNEpaK2hyZFFK?=
 =?utf-8?B?RzlCVDhSL1NpM0MwbEpXKzRoc25TT1RadUtZNURSdFE2SHMxL2xtNTFxL1lj?=
 =?utf-8?B?Y3BrVHNQSVJwZkNlSTdKc0dRMVFaakxnaEQzaUJ1WG95TDluRmh6VndyblB5?=
 =?utf-8?B?WExJVC9QbVRvTlNKYlV4a0liVS9rc0IvUm5YK3krdCtvL1FxU3pyMkU3NzR3?=
 =?utf-8?B?WVBPQzhwbjFxcXBhZUt1WFdNd3lkVmFQeEZPcUZmSlFnQXlFdE0rVE5ocDFZ?=
 =?utf-8?B?TzN3bTlQQWhQbFh0d3VWK3NUc1R5K1FQTWpnU1pYb3hYdTBlYjhnQVVqTmts?=
 =?utf-8?B?TlZDdkVVMXFtZzQxZjBya2NqZ2Y2UDR1Njl2TTUxaHBxR0xKejVadUZnUkU5?=
 =?utf-8?B?cUVoM09JbktvNU1JaHVQVkppTDdkR1JJbXQyUWtvNG1BMWw2MlpUZ3FzdnNM?=
 =?utf-8?B?SlRLd2J6Tm1pdXdPc0V3VGtPYnZqQ3M3RFNyOGdWY0h5K3RPcG5kdWdtMy9L?=
 =?utf-8?B?aWh2Z3VNc0J6Tmg2ZTBNRkNYZEF2dThKbmE1bHg4UTBmVjAwU1NIZUJOVU9N?=
 =?utf-8?B?aWV6cXVLRlhxQUhYMW1VdUd3aFVDcGJBNXVOb1ZJVXhBNkRXc3Yzd24zRVht?=
 =?utf-8?B?MTV2RjhCeGMzQmhVNnljTkQwOVNhUmI3NSt0OUJFSW40YVJ2NlZGYndGZHdW?=
 =?utf-8?B?UVNhZi84ZDdXSGdxVCt6RE90VzZYMzU4R3NYSHcyNS9nM1IzNXRyTVAzU2VH?=
 =?utf-8?Q?T9OovlTo4rg3M/Xx2Ron3cazs61MJgNs?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;6:wkphnF82NlwdwCDbpCONnX3Eywyf/ZSIHPU4mYH87MPbKRE127AE+/fvsVt8IoB5W+bJjuW9xYHFR2wP+tMjwiAsPZWoUkN/PntjOn8xrd+y1uouOToV9gQ19qRLsKvxjKAmmVX8J9eeAjZ0mvxpPOpCSKwiyQzrZjlsmwf82JlUk3Auk6D68UmSG7d2a1MQehK0z7OHYdU/0/BMPvunKryg2xifPBd4uJ5DQ03OS9qNZrf0QwCVtGCrtegyCOlqNGRwh4+QE0+NUgggH8RnwbprWNQ1io2z2C6wxqIOZfpToBWw1U23MTgTzdRMaJRVeNEh7DElXNTDsxyFZmKytuc8ykYxLIn8TQFNXOvmOSQ=;5:su//mAlgaegYu0p9IK4L0Dft4qKv+0KDTfx1XhHuGw1xJKeI0JjyYWaPYVLclAi8RaWM+HES2XxUaB3X/Z9AeIkF8z/OAQPsu73H8+GfQ+xI9/pbTREdaqwTgKXGuKguZDkTy8I3gsM2TVR5NhqQteJNHz8ypyKzVrxWQpW5Xv8=;24:gL9lMp/X+SHS23qH6DnFtAreAsQeuE5Gi/Z92xIWYbPI+9Ng7xKBi1CfwmrhLlM6DBLkaYVGB6576Xpoa2XtjQgdCHjOQXP+kuNNS3DJQ/c=;7:kVW4OoNYhfKa3iX4XHlx+o0hynLVxNDr1I4PKb/NH1WMf+FK7XhyGE4oNwi6QSRf1nk/0nKCX4DABTUrmWCmDnpllMznEJIqtNW9jD68qTVxcSIOAynBC36UVwvMWvlr4yWbPlqBcco5J8F+ORXBXO0HWrU77gZbS4KCjdF/Nf0aobcylkbCCgv6cIBvz2FEMDYi1i6g+BCzp7idmGDEdVmzsQ3eVLkKQhIi8oBeMzf5Dnx3anEoXmJfRPpOrdvq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;20:rsUhtT+rkVmRZgbs/LrYc21Noe+rffH3+HORzblCawxd/gew2jhHmbaYRjZQfiNdKFpK9UOSHTg5D+3DQngNeQSTWtI+wvsuYzqps8VQDKR4pAXYib8fnF7dG79lZ/+8vqSSr/+7/LGeS0lfH2faovQ3djCFvnO/hilhd43wUIbkoS4Oa8BEgxmtx2/GI750JgoV+VtPbVwUl03E50FY+HEhJh4rlMxMXfIQ35Sd+LOOgaKfJkXGOnQ1uTOshPwt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 10:33:00.8564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df650bde-ba9a-424c-8732-08d567ccd707
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1310
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.01.2018 um 11:18 schrieb Michal Hocko:
> On Tue 30-01-18 10:00:07, Christian König wrote:
>> Am 30.01.2018 um 08:55 schrieb Michal Hocko:
>>> On Tue 30-01-18 02:56:51, He, Roger wrote:
>>>> Hi Michal:
>>>>
>>>> We need a API to tell TTM module the system totally has how many swap
>>>> cache.  Then TTM module can use it to restrict how many the swap cache
>>>> it can use to prevent triggering OOM.  For Now we set the threshold of
>>>> swap size TTM used as 1/2 * total size and leave the rest for others
>>>> use.
>>> Why do you so much memory? Are you going to use TB of memory on large
>>> systems? What about memory hotplug when the memory is added/released?
>> For graphics and compute applications on GPUs it isn't unusual to use large
>> amounts of system memory.
>>
>> Our standard policy in TTM is to allow 50% of system memory to be pinned for
>> use with GPUs (the hardware can't do page faults).
>>
>> When that limit is exceeded (or the shrinker callbacks tell us to make room)
>> we wait for any GPU work to finish and copy buffer content into a shmem
>> file.
>>
>> This copy into a shmem file can easily trigger the OOM killer if there isn't
>> any swap space left and that is something we want to avoid.
>>
>> So what we want to do is to apply this 50% rule to swap space as well and
>> deny allocation of buffer objects when it is exceeded.
> How does that help when the rest of the system might eat swap?

Well it doesn't, but that is not the problem here.

When an application keeps calling malloc() it sooner or later is 
confronted with an OOM killer.

But when it keeps for example allocating OpenGL textures the expectation 
is that this sooner or later starts to fail because we run out of memory 
and not trigger the OOM killer.

So what we do is to allow the application to use all of video memory + a 
certain amount of system memory + swap space as last resort fallback 
(e.g. when you Alt+Tab from your full screen game back to your browser).

The problem we try to solve is that we haven't limited the use of swap 
space somehow.

>>>> But get_nr_swap_pages is the only API we can accessed from other
>>>> module now.  It can't cover the case of the dynamic swap size
>>>> increment.  I mean: user can use "swapon" to enable new swap file or
>>>> swap disk dynamically or "swapoff" to disable swap space.
>>> Exactly. Your scaling configuration based on get_nr_swap_pages or the
>>> available memory simply sounds wrong.
>> Why? That is pretty much exactly what we are doing with buffer objects and
>> system memory for years.
> Could you be more specific? What kind of buffer objects you have in
> mind?

Those are GEM buffer objects which user space uses for things like 
OpenGL textures, OpenCL matrix, Vulkan surfaces, video codec surfaces 
etc etc...

Regards,
Christian.
