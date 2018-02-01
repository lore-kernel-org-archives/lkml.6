Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeBAFs2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 00:48:28 -0500
Received: from mail-by2nam03on0068.outbound.protection.outlook.com ([104.47.42.68]:10816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750936AbeBAFs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 00:48:26 -0500
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
Thread-Index: AQHTmNtYoBUw/9kRPkGbswRNbnupYaONlMmAgAANf7CAAAKaAIABYvbA
Date: Thu, 1 Feb 2018 05:48:23 +0000
Message-ID: <MWHPR1201MB0127A0AE58A331BDBF9DD34BFDFA0@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <9ecba5f4-3d4c-0179-bf03-f89c436cff6b@amd.com>
 <MWHPR1201MB0127760D359772D5565BA3EBFDFB0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <b7dca756-b703-ff51-196c-832e5a43c63a@amd.com>
In-Reply-To: <b7dca756-b703-ff51-196c-832e5a43c63a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB2542;7:f47fvKUaz0k4+bdQkWctCgx6HggtMJXmQbFZEgzV7z3LRXMnoeUgj29GteTl/m5k+nMAF+y+Y1TmB9uW/tzmqH31MpCc7s6xH1olt/+9g+ZEGIBuk/L/FPvnHI5GppiHUMRoJjBTH/kylRRJdXJEDY711lURsMoron3DUqFb9IRQ/ucmd2eiShVWmzDaqXVfl2KE2LBa+I377RQBDLruN+u0QimlXtBdXIVU7cNTTouvcv++B6wpr/JIPwzgq42i;20:BunPMzLDk6uSIIrEvNMQ0XZZBTHOw2fb8iBu4gwhEf3YI4QtHJKUPAHECmSangsUbrqeOqi2E98ijNjKLcek9QKUTiw9BTUUrHjVlGBVk3b5bkbuWeVnvJHXRWkIqOGoqERU4T1u6Z2QVQsf+gbGur9MDas2SEpJZY8bmeEvq+8Hwv93CZruK6x23FxG5s7jqS17BmHxGnVP+7zUILAdaRtUdWmuR5U4o7R77ln6cKBw4SPl91bZ7Ec0w40er2W0
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(13464003)(189003)(199004)(14454004)(6306002)(55016002)(76176011)(97736004)(478600001)(77096007)(8936002)(7736002)(2900100001)(305945005)(9686003)(2950100002)(68736007)(72206003)(6246003)(93886005)(99286004)(86362001)(26005)(5660300001)(6506007)(53546011)(7696005)(81156014)(2501003)(229853002)(33656002)(81166006)(102836004)(8676002)(110136005)(4326008)(25786009)(105586002)(53936002)(106356001)(59450400001)(2906002)(3660700001)(6436002)(966005)(6116002)(316002)(66066001)(74316002)(54906003)(3846002)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2542;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 308df612-0126-4208-c51a-08d569376828
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB2542;
x-ms-traffictypediagnostic: MWHPR1201MB2542:
x-microsoft-antispam-prvs: <MWHPR1201MB2542BFEEC26A7040F3C42324FDFA0@MWHPR1201MB2542.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR1201MB2542;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2542;
x-forefront-prvs: 0570F1F193
x-microsoft-antispam-message-info: 5XIVZLVfUIRkFkv3igprRIAyyiINUlqdfYv7/C6T6ttVK8UsfvbHTisveidwVbU5PEcAnt52Yfvdi1aEymcUKg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308df612-0126-4208-c51a-08d569376828
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 05:48:23.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w115mZo9024777

	But what we could do is to rely on a fixed limit like the Intel driver does and I suggested before.
	E.g. don't copy anything into a shmemfile when there is only x MB of swap space left.

Here I think we can do it further, let the limit value scaling with total system memory.
For example: total system memory * 1/2. 
If that it will match the platform configuration better. 

	Roger can you test that approach once more with your fix for the OOM issues in the page fault handler?

Sure. Use the limit as total ram*1/2 seems work very well. 
No OOM although swap disk reaches full at peak for piglit test.
I speculate this case happens but no OOM because:

a. run a while, swap disk be used close to 1/2* total size and but not over 1/2 * total.
b. all subsequent swapped pages stay in system memory until no space there.
     Then the swapped pages in shmem be flushed into swap disk. And probably OS also need some swap space.
     For this case, it is easy to get full for swap disk.
c. but because now free swap size < 1/2 * total, so no swap out happen  after that. 
    And at least 1/4* system memory will left because below check in ttm_mem_global_reserve will ensure that.
	if (zone->used_mem > limit)
			goto out_unlock;
    
Thanks
Roger(Hongbo.He)
-----Original Message-----
From: Koenig, Christian 
Sent: Wednesday, January 31, 2018 4:13 PM
To: He, Roger <Hongbo.He@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages

Yeah, indeed. But what we could do is to rely on a fixed limit like the Intel driver does and I suggested before.

E.g. don't copy anything into a shmemfile when there is only x MB of swap space left.

Roger can you test that approach once more with your fix for the OOM issues in the page fault handler?

Thanks,
Christian.

Am 31.01.2018 um 09:08 schrieb He, Roger:
> 	I think this patch isn't need at all. You can directly read total_swap_pages variable in TTM.
>
> Because the variable is not exported by EXPORT_SYMBOL_GPL. So direct using will result in:
> "WARNING: "total_swap_pages" [drivers/gpu/drm/ttm/ttm.ko] undefined!".
>
> Thanks
> Roger(Hongbo.He)
> -----Original Message-----
> From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On 
> Behalf Of Chunming Zhou
> Sent: Wednesday, January 31, 2018 3:15 PM
> To: He, Roger <Hongbo.He@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Koenig, 
> Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to 
> expose total_swap_pages
>
> Hi Roger,
>
> I think this patch isn't need at all. You can directly read total_swap_pages variable in TTM. See the comment:
>
> /* protected with swap_lock. reading in vm_swap_full() doesn't need 
> lock */ long total_swap_pages;
>
> there are many places using it directly, you just couldn't change its value. Reading it doesn't need lock.
>
>
> Regards,
>
> David Zhou
>
>
> On 2018年01月29日 16:29, Roger He wrote:
>> ttm module needs it to determine its internal parameter setting.
>>
>> Signed-off-by: Roger He <Hongbo.He@amd.com>
>> ---
>>    include/linux/swap.h |  6 ++++++
>>    mm/swapfile.c        | 15 +++++++++++++++
>>    2 files changed, 21 insertions(+)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h index 
>> c2b8128..708d66f 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -484,6 +484,7 @@ extern int try_to_free_swap(struct page *);
>>    struct backing_dev_info;
>>    extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
>>    extern void exit_swap_address_space(unsigned int type);
>> +extern long get_total_swap_pages(void);
>>    
>>    #else /* CONFIG_SWAP */
>>    
>> @@ -516,6 +517,11 @@ static inline void show_swap_cache_info(void)
>>    {
>>    }
>>    
>> +long get_total_swap_pages(void)
>> +{
>> +	return 0;
>> +}
>> +
>>    #define free_swap_and_cache(e) ({(is_migration_entry(e) || is_device_private_entry(e));})
>>    #define swapcache_prepare(e) ({(is_migration_entry(e) || 
>> is_device_private_entry(e));})
>>    
>> diff --git a/mm/swapfile.c b/mm/swapfile.c index 3074b02..a0062eb 
>> 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -98,6 +98,21 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
>>    
>>    atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>>    
>> +/*
>> + * expose this value for others use
>> + */
>> +long get_total_swap_pages(void)
>> +{
>> +	long ret;
>> +
>> +	spin_lock(&swap_lock);
>> +	ret = total_swap_pages;
>> +	spin_unlock(&swap_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(get_total_swap_pages);
>> +
>>    static inline unsigned char swap_count(unsigned char ent)
>>    {
>>    	return ent & ~SWAP_HAS_CACHE;	/* may include SWAP_HAS_CONT flag */
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
