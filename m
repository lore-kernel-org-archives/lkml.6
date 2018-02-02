Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeBBHyi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:54:38 -0500
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:3584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750915AbeBBHyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:54:32 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Topic: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Index: AQHTmNtYoBUw/9kRPkGbswRNbnupYaONlMmAgAANf7CAAAKaAIABYvbAgAApVyCAAYFAEIAAD56AgAAAvMA=
Date: Fri, 2 Feb 2018 07:54:28 +0000
Message-ID: <MWHPR1201MB0127DC2146094EC5FA2138A5FDF90@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <9ecba5f4-3d4c-0179-bf03-f89c436cff6b@amd.com>
 <MWHPR1201MB0127760D359772D5565BA3EBFDFB0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <b7dca756-b703-ff51-196c-832e5a43c63a@amd.com>
 <MWHPR1201MB0127A0AE58A331BDBF9DD34BFDFA0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <MWHPR1201MB01273A4737F27450D7E1A4C3FDF90@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <540b5f5b-5670-5653-70de-4ff42e898550@amd.com>
In-Reply-To: <540b5f5b-5670-5653-70de-4ff42e898550@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB2541;7:o/IobO0ogxs4TUtrb77CbS6JDtBLA6SzdCRZ6UyNLmvyp3Bml5PTyXPAGpal3ACv7A88XqAjSTNcZEPkcrdGw+jikDCdl5z/N4Y+wBkKCnMpEWXCMlHntiIh6mjKKWjhu2NAmzw1xecI9aIcascAA904DezWLYzw5MQMeI2CtzMi+PlJFYDcTPUcJD7gUOH91rbblzcz/AGpJx0nhcBf4/MAKchH37Cf/9h4YjgiM9nzGRPMBbkyLum+C0hC22Sm;20:chCSbzrqFAiltCjEBDWwUm8UQI1KNW7pR4n0jqbzblj1Q3mTpZPk0Y+Kd0EY1OPNhwNakU70qCGDdInlMAAY1iQyHP1xAc1PPBKruobU5yT7/mfO9iHKqVhp0UdMz16ss20wnrsOpgKUOv6M3ZMTB5bW/umBSA/UcbR0FsF0hLtTY9Fe1sgbr0wfBvY2Qj5+KA2QOeNQ34J1P1o9ei2w+d+I92QYEBTDbeKJJSz0+vm7YguU2AQcX0QNyTR5CRKx
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(13464003)(2501003)(7696005)(76176011)(8936002)(14454004)(5660300001)(102836004)(3660700001)(97736004)(2950100002)(59450400001)(6506007)(4326008)(53546011)(86362001)(93886005)(110136005)(54906003)(6246003)(2900100001)(8676002)(81166006)(316002)(3280700002)(81156014)(53936002)(68736007)(6436002)(106356001)(105586002)(99286004)(77096007)(6306002)(9686003)(478600001)(26005)(966005)(33656002)(72206003)(55016002)(7736002)(66066001)(25786009)(229853002)(74316002)(3846002)(6116002)(2906002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2541;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 314f2828-e2fa-42b1-821c-08d56a122fa8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB2541;
x-ms-traffictypediagnostic: MWHPR1201MB2541:
x-microsoft-antispam-prvs: <MWHPR1201MB254123CB6E5746D05103FABEFDF90@MWHPR1201MB2541.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR1201MB2541;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2541;
x-forefront-prvs: 05715BE7FD
x-microsoft-antispam-message-info: fLDDTLm+KXJdh6l+mCs6V/4VXBQhpE4uPN4lKjmIsOAXvKNZTD/Rlpu7TCm+pmhpm+iSqoFabvi5ZJAolj4T+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314f2828-e2fa-42b1-821c-08d56a122fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2018 07:54:28.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2541
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w127shhI019626

	Can you try to use a fixed limit like I suggested once more?
	E.g. just stop swapping if get_nr_swap_pages() < 256MB.

Maybe you missed previous mail. I explain again here.
Set the value as 256MB not work on my platform.  My machine has 8GB system memory, and 8GB swap disk.
On my machine, set it as 4G can work.
But 4G also not work on test machine with 16GB system memory & 8GB swap disk.


Thanks
Roger(Hongbo.He)

-----Original Message-----
From: Koenig, Christian 
Sent: Friday, February 02, 2018 3:46 PM
To: He, Roger <Hongbo.He@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages

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
> To: Koenig, Christian <Christian.Koenig@amd.com>; Zhou, 
> David(ChunMing) <David1.Zhou@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; 'He, Roger' 
> <Hongbo.He@amd.com>
> Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to 
> expose total_swap_pages
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
> From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On 
> Behalf Of He, Roger
> Sent: Thursday, February 01, 2018 1:48 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Zhou, 
> David(ChunMing) <David1.Zhou@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to 
> expose total_swap_pages
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
> To: He, Roger <Hongbo.He@amd.com>; Zhou, David(ChunMing) 
> <David1.Zhou@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to 
> expose total_swap_pages
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
>>> + * expose this value for others use  */ long 
>>> +get_total_swap_pages(void) {
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
