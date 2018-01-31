Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753516AbeAaINS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:13:18 -0500
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:2809
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753502AbeAaINN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:13:13 -0500
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b7dca756-b703-ff51-196c-832e5a43c63a@amd.com>
Date: Wed, 31 Jan 2018 09:12:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <MWHPR1201MB0127760D359772D5565BA3EBFDFB0@MWHPR1201MB0127.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: HE1PR06CA0140.eurprd06.prod.outlook.com (10.170.251.27) To
 BN6PR12MB1300.namprd12.prod.outlook.com (10.168.227.150)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72f44168-79b9-46d6-e8c1-08d56882785a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1300;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1300;3:CXOnPEQGLrgC2Nb3XaGYHS4B0PLHYNcIf3i7UV5oDpE2gQNXpu7lTH9mgd4j1toNg4Szrx+1I1mgfhz+tFPSf6Qfx+L0+4L66JH2o83jFQRS3AQUnlEqunzZq6N1cyYGrM/NSzQcILMobHYRQfSL8IwvzFMTzLFPV9+avPxItKiEjU2PnINkzvm4+aSi0pa5jYfdJ+V8ZQE9aaXUftQOB8bgzCzgRRBNm5MIn9+17DOgbe0na9bsPayQuC9qUlQD;25:zK0E0Xz2r+61mxxRTVl3Q04D0UcDz1DGCwaYunM59YaqDa+2K4m+XFoyqOMzwmEMfwznhouvMDIPFIhkrUH0O/JfjCjMndSl6D/T3klvZuFl58XvEEsjEitMbXoHyY1l6/3ZyC+ggHSEKTVEkFYlHt9KktrGMQANmowe40BSeT1VAdujmzZ/BOsaw+IDx7bXFzRgu7hfJRTsAcb4ikTyV6UBkvIS92LOW1drIR8l35uJzkyMUN6wNvTDFjUwqTv9lFCf0KYTcWm62GP8ZXPXjCHWA46t6SVX4z3O9XJe5M4dNzipM64jk4Cm0vP6aV9K3WWzl9VYO1jUhQqkpMmBnA==;31:1EqRn8evMXsKpwMHR0YUukrc4k0nNtzB5Ixa9PcmONb6i8Gyq5ReErjfHA0N8PD/WeKzPx+2pT3J26kifmiRoLggh9KEZHJicqB0z+wfSB/JUZsOJxcXvrAi2FXrKgyeq0cDRy0Lxoekcf3MCQB7JTrTddsChbWv5XuJKp1QyJTFdtN6mZAyFfFGtG68HthU1W4nTso5lmsrBSA1ex4SQTL67CcLcqDaetGplI9Lbrg=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1300:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1300;20:UWyCJuaD6Mj8EqKhIFYOxSyVy5B6wDkPsNbn5MnGaAOdZc5ADJ7ssDQElDbLuEgkWDqsDsvBSjf0HBg3I5k2HGULSgx09sbkkKkAQqOi9BZUyFGeYX+i9003H10PMq+1fUFj+yj4MVqBDs3JexhfbcgLs1m7ikz33g7Lmf+EbPb5oIkOunT+CBlH8yzAqlxJGFiUI/D8CbXxQDbOaEiQlQqjUTAi8w8MAGoxGqGh9MH9jsaTNN4mqC8Qo/td9sKtISw3FAX5sL8E9SJsAcorvhHpIHPQUi+4tDzgVZSJQqCdOU/CF50NXnoamJ6jZTtat44t/8OFie5aDDkMF+Bzwozqx7W5jelb1kRffV+9FwH75tG4ayPVDzKaZylBqfCQ8ZGofxEEyjX5hGuoH18nYDUADrWi2aQXw3dsTT13NHXCdx96JDe54v8IdQLyEfU6hA9Xjy+Hf58bw8Aj6uL/oJj1AxqRJ4Ov6PNi42UbzBXK1iLFET4HxZ5npsBjoa6v;4:kJJD5CV96QenmMlBKr/j7bULjQkyBcTvWv7A0kEG05a6M6oSBcXl/RFcJLIKQHtcTubkXTzOae2QXtCflJgiHL/Oc238wRLSsCHzi0CX33Rbn9nuqQ6z8S5cvXOdxM+Kx7PRXRk6NkUxH/h45+8pnyCQIutx6W6MubZQpI9C1OQYv+w93tKzvBq7LJivyZIWWf1O5SFVtT1PsYTnTmthk6JiyYYb/e8g9Ge+9a5humjefo5aZL4FBF9Wgh6wEhisKtaGaAq5//Dg/LErEqWnBdoQkP8y6aMjONb6p6CMKTn+lyVpXRGSMu8gMWwBJjZDZjygKiyuRalISoGBGSfuqRg/V+B+IOMbVdX4pkslsQRqlZV5BRiAvh5dsrtn5Aj7
X-Microsoft-Antispam-PRVS: <BN6PR12MB13001616484C264FEA49C24283FB0@BN6PR12MB1300.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1300;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1300;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(39380400002)(376002)(366004)(199004)(189003)(13464003)(8936002)(64126003)(478600001)(8676002)(1706002)(6666003)(68736007)(36756003)(81156014)(83506002)(86362001)(105586002)(966005)(25786009)(97736004)(7736002)(2906002)(31696002)(106356001)(5660300001)(65826007)(2870700001)(2950100002)(81166006)(59450400001)(386003)(305945005)(53546011)(6116002)(6486002)(6246003)(76176011)(2501003)(31686004)(47776003)(316002)(23676004)(52116002)(52146003)(186003)(2486003)(52396003)(67846002)(50466002)(4326008)(53936002)(54906003)(58126008)(16526019)(229853002)(6306002)(65806001)(65956001)(110136005)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1300;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMzAwOzIzOkUxa0J3Vk9BWjFtWUkzWWJIRHhaU2FRdmVG?=
 =?utf-8?B?THl0cW1Tc1V6WVNqNUVyY2FEN2lQOVFqeWRDdStUTWwwSG40UUJYK0ZkcFEw?=
 =?utf-8?B?bHBWMVVLZzArelNaZ1h1Uk96VCtHMDlBbjlwVFFaUEZRY2ZMNnV4RGtoNnhW?=
 =?utf-8?B?OVZWeDR2Qk80di9PMExlSXVkL0xUd1YrZjMycmptNkYwbW4yS0lWZ1VyNUZn?=
 =?utf-8?B?QmIzZU1hNkpyeHluaDBObk9SNDQvK0pKakVKeFJRZ2YrZVhSekpSWHhPb0pJ?=
 =?utf-8?B?UDEveDAzOGtMOGJEd2NUQmVXK2hhV3JEcDMzWjhmc3hBNlYyNGd5UVE2Vkhz?=
 =?utf-8?B?QjNBU1oxU2dLbHJ1VkROb0JucmZCOTVORHJ4WURwWVl1YTRpempHVWxkd0ln?=
 =?utf-8?B?T3ZKbHZtbzZGQzJVTTMwL0VieDdiMUN4SStrZWUvYXpZNm9teHJxY2FwME1x?=
 =?utf-8?B?YzVNdGZhVlFCb1VERGVIUko1WVBKMVltemdlSFpMcExiYk1nSDB6blpiL0RQ?=
 =?utf-8?B?MWQ3YWlzaTZkOEhSOTd4WlMxL1JSZVNwS1RFT3FMbDAvVHFFZEhFL3VHSWlt?=
 =?utf-8?B?a3B4YWlJQXc3a0thM0t1cEtZVWRhOXNBZnNCSXVHUlBmeloxczU0Vk9rWXp6?=
 =?utf-8?B?a05kejNQV3lXZkxiZ05XM2NoMWNjTC92RUp0VitocHBTWW8wczN1Y0pjWG5l?=
 =?utf-8?B?QkV3UFNmaGlmVzd6SGhnYnp0bE9tdmVuS2NNSzFPU1FPaEdzMDRxcmUzWDFu?=
 =?utf-8?B?Q0hwdWR2T0FMTXhFZ2FwTWVDT2haQnN3MXI5NnUvdmtlUU5zcXpEalFQMGky?=
 =?utf-8?B?eVZadUxPQytoamg3OWs0QnZ5aldKaWd0ek1jSEprbUlESWRFWExzODV5TTBU?=
 =?utf-8?B?ckVEWGZIOWlRVHdObVFVa3AzNlRmYStPRktmYmhDMGU1N0x5Ti9sRktiMlZ3?=
 =?utf-8?B?Y0k0R1U1UEc0MUNpNEhTc1hnelAxamsrdDR1V0RGOXpGcEZ5L3RsQ09xbTVa?=
 =?utf-8?B?T3ZPT2RlWVlPc0lKOHRjV3RDWkV3Tk4yWmRUelp1eS9xV084OUtmN2tJM0Rp?=
 =?utf-8?B?L29wcXVKZWFpbXBsREZ3TzZBeGlMcnFLRmVVV0xNZmNZcEJFKzZYaFFBRVla?=
 =?utf-8?B?a3d4cXk5czhEYy8vaDFVdHRFeisvU3BrY3ZWZEV0WFpqZXhGak1Ja0RIaVdD?=
 =?utf-8?B?RUxGWmpDTzBMMU80T0hDais3N3liblpqZmFmaUZUeU1ncUxiNmhHZFJjMkJ1?=
 =?utf-8?B?N3dPRFRuRVVINnZ2MmI4eGZPS2wwL2FISnBVUElKSXNmWkFSVTVoSjFleUVR?=
 =?utf-8?B?S1ZYOFVnSTZWYVMrajJpbkhlYTR1UXdrWSswZlQwVGhxeG5wWlg0Njc0SFBQ?=
 =?utf-8?B?UC8xWlFmSFJYejJ1K04vQ1d0U2FEdkJxNXpMeE5tM0tHejRsQWt3Z2hUMXFE?=
 =?utf-8?B?VjBIZzAzZHZLdDErclB2Z1l4aUl2NXNSNWZJaTh5YWExRXdhNkdYRE1RcnEw?=
 =?utf-8?B?RHgrNWhERWdwQlJMUFY2N29XOEJBTS9KYzUxc1NVak9CTjc2K0I4T3pxSFNB?=
 =?utf-8?B?TkZHdHJUb2cxSDZGbmljdFFRdVo4QUZpaFRGYzdELzZYR3NiZWh3cXZXcllt?=
 =?utf-8?B?dmF5ZXNBTCtxNWZyZkQ5UGphTXJaeldRS0tWMklnRVI3bkFyWVp2S1lwV3ZV?=
 =?utf-8?B?OWxPN1cwSGpUUmpSQll3QXpMdG5jZVNTcUJIWVg1bFBkV29ZNGpLaDN4VnRl?=
 =?utf-8?B?aXlWVGZPMk9GOFRRcWZPbGFVWXJ4L25uUGJXMnJMeW5TaFc0RzN6dWlYMmZ6?=
 =?utf-8?B?SzhTVER2N1U0ZnVvU3Q5aER5UUVSdW5XTjRveDdPWVNsODloenY2YW5kM1hZ?=
 =?utf-8?B?T2ZrVkVING5ZdkFSZDU0aW5YQkZBN0V1RE8wamt0WFQ5a1RxZGNMbVVic2hV?=
 =?utf-8?B?cVFQK0xrSEl6VlpDdFIyT1B5di9ZRStKT04xYmh3Y09zbUZJMnRkSnlTZitZ?=
 =?utf-8?Q?WQ/JK4?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1300;6:D5y4jJtTlP/sWjsOiQznp1dtZSm39ll9+leSvzquUI3rgaLiXS9mV9CGE6/iKPgiHIFaHP40JU7935kCtGwmC8TXM9JwJmsiibZUqlI7x/CO94dHjQZlss2X+TouG2P0Y7+hdZL6q7+EyH0dWF7Q/YUUz74Iwb/2Y/wjfjI5m/WePQrSvKVd4pq9+08ktGWpIllnyWRqPrwug+TDdSe0HLR+op8wTlxLpEos5tJyl38cPw7jl7cXW+5WFxQsAu1fxvki51AcDyHh2odokHOTFbM4GdLsCm5QTBYpc1M3IgQSL8CazTqb307FHbmF3PTLpu/WdOjwjeE2vjvp0ihCRSfEnVNno4L3M15pIMqNeoM=;5:iSHMOa7MNZf/nBY0ZxdmA/MC6hV3WXh3iAsV84apabF1QHixO1uEgS3IF4D7QmUtoCqNL5inHSlDJRybBnmHu+KvPX3aCv3TJ5vfbINzW7ocsuo/OXbrH/03QXUzuBP4HGK46hzJxpyf6AQBdHUvM/pEdv2XLpAuS4g52f60e+o=;24:Qy0EzJUZoqh6t4t6FDGcJEMfZ3UdJvBhNGtdoQaGL+NKbxfoXff4R/i5vutQz82jxRSh+upo2pjZkmV97nGbU5gTDmxZ3rsoKDyUfGbkajo=;7:gOq+Xdt/FoX+X//gfB5NU1QnDL3FnBzRZvmi/o1K+cU3lAcrxaN99PlzDYQFVwrWQ3dZ70VIudcupOcZzKQqHSJDuzJtgiA25fuIsrCoQuRLRYSAwzlhJpZmtXP5sCostqIxVIW+keUJmDgJJTeCP/CB9Pjr+h+hQ6Ga3f7axbFB0a3bH+wcmWQqsPnXIKWtiWO6xFi70dSpV6+yDAXq3wRPl9a2OLXK7B3mDOrUpA1A3cmmgiZ1NukiygKrZWqU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1300;20:uDJHRbh/79AbmiqrmeM4touGvvimEisU1+ARbfDhXmQVmTCLuF4x8Vm0Oj/Ch50PRMDDCZcs7gE2qnoNIRmksSF//Xp99T5Ce5AAQp3t7zkSs51do+TjuDhaa5766/JGQBqoIxTpR53F6wfQSjbi7WxGO2bxyy3OKKzYFVGeQKx9aeqM+BcKTpCPvgcTqCC27yGV8S4KfKIvfFvwyhlRiuAkphdUZRzbCV8ATbRd4ubK3Ss1g+vtMsVkHkOdl/A8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 08:13:10.3929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f44168-79b9-46d6-e8c1-08d56882785a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1300
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, indeed. But what we could do is to rely on a fixed limit like the 
Intel driver does and I suggested before.

E.g. don't copy anything into a shmemfile when there is only x MB of 
swap space left.

Roger can you test that approach once more with your fix for the OOM 
issues in the page fault handler?

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
> From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On Behalf Of Chunming Zhou
> Sent: Wednesday, January 31, 2018 3:15 PM
> To: He, Roger <Hongbo.He@amd.com>; dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages
>
> Hi Roger,
>
> I think this patch isn't need at all. You can directly read total_swap_pages variable in TTM. See the comment:
>
> /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */ long total_swap_pages;
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
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index c2b8128..708d66f 100644
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
>>    #define swapcache_prepare(e) ({(is_migration_entry(e) || is_device_private_entry(e));})
>>    
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 3074b02..a0062eb 100644
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
