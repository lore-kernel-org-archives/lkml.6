Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeAaIw2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:52:28 -0500
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:16805
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753616AbeAaIwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:52:21 -0500
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "He, Roger" <Hongbo.He@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <9ecba5f4-3d4c-0179-bf03-f89c436cff6b@amd.com>
 <MWHPR1201MB0127760D359772D5565BA3EBFDFB0@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <b7dca756-b703-ff51-196c-832e5a43c63a@amd.com>
From: Chunming Zhou <zhoucm1@amd.com>
Message-ID: <72eb44ec-fb94-6b41-b660-f6e6f8f589fa@amd.com>
Date: Wed, 31 Jan 2018 16:52:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <b7dca756-b703-ff51-196c-832e5a43c63a@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(39380400002)(376002)(2980300002)(428003)(199004)(189003)(13464003)(6246003)(2906002)(65826007)(58126008)(53936002)(105586002)(97736004)(16576012)(2950100002)(2870700001)(110136005)(54906003)(106466001)(83506002)(65956001)(229853002)(36756003)(77096007)(26005)(6666003)(6306002)(16526019)(4326008)(47776003)(5660300001)(316002)(336011)(50466002)(64126003)(104016004)(356003)(67846002)(72206003)(8676002)(186003)(59450400001)(31686004)(76176011)(81156014)(8936002)(68736007)(23676004)(2486003)(6116002)(3846002)(65806001)(7736002)(53546011)(478600001)(81166006)(93886005)(966005)(2501003)(31696002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1445;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT028;1:6VfmqTwDGzu4sAYA+3gSU+cBlr0MUHFJC6oXfrJfkmsRhjG7KyUt8rN45mnCNrGsCAo7EpsUsj+gDS8fVKLUAA3LHlWtVj2qIxPuMjaFm4VMel8C6AqiUeZeNQ1aKT0P
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8955ea2a-af83-4bce-b55f-08d56887ef36
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1445;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;3:vgdoHbMSp7kCT7QLy/kFrLG9uJCqfl7FseeWKh1EIwGoL8aqqACI9oPGbcKBUA351a+b8AMjaDq4nmoG1EfcauQPpmpePU9uSWZbxl91ofUkeZhsg5kIyh0Q+QjYgRjqawsEu9O+/bTi9SBn+AxI9xeV9GpXk7VzwNDEsxtkCPVXHnBfukq5+XBmcqxQmieyjPUPfHA4Ec6dDeVD1Iis4R/CS8+Xt/PoFgb77vQyH+VZmgm+oL7DT6/06Lh/7wjYzrUoQfjuX4XYHLLStjlsE78ZzsSFbiIj3ODsfKa81kqRYpcYvYfsTZxqEWYcRVTly3VIX28Zn2J6lbpJyLTxuLEBnFifKB+ljIYeVPM1PVk=;25:dO2gBYWvcyRsoPxiWXmhzvd3rdDsfXqYN4Dpkxmy/Z0tii9qqNgDi2krIDUvI0tWn76Zzj0yRbUKsObBns3JoyokjfMU6uTczpRNnIYj+BFdCFkzlUZgpskAxU/EKOobeNA2fOj8X5F3QrqxT/PJbQBisxmtMGCWkkRpNwJbk9eYv7wvfwA3oIQyq7iTA+jpw8v8HelVxrCPIRR6BdDJVx2YmBK4y4Qaz1HGOYFOMksz9QH+psVe8F4eyN9GxyolV1dmrnz+nBY3Yr4LnB+WuY/Hew7o8medHrwYll3EQ7XbMuNQt+TFW16l8dsIUrx1Sfi0cdYLM0xsp68NcN5JnQ==
X-MS-TrafficTypeDiagnostic: CY4PR12MB1445:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;31:7VOq/SOZZEdANCCNn/0XViOXBf372ZZ/CI5N075mU43VBE3FaiTmfRkPvt69tTu/McFgERUr3JbDqY3SmqIlw5/7sNpA2GQzBEfFflFcha6W8hx+CeauGNXmQc5Y693M8jqzAwicaJ3d8ifQgYX3XdxxOxCQogg9poL3K4y6aNFtiXnbGT8/iH4q5s8P3BDoitfIsMJJo0MNzbyjuhqTCBwxbwZQe2Un+slNzSUHOAI=;20:HQFGgztXXrULIitP1I7zFjOJpSZGUtMuvi/mC+o0CvVIVh6zqggRUtoUyIzn3IV+39mVdjiKAa0O0IzJPqm1mSDZ+sOYofvNl3ij+0aNcCjm0aj1+DwWdn2tzRdQ/v1kBEP2RMTAXJhhx25HGy24hT42qWcldpdkOzjsChfwPMDeHt/HN2tqxzgyYceZV85PDf+wa7IFXY2UVQVYag0zpHPP8rwMtXq0WRYc/17v6DrPShjUuHP7V00t30lNPGkKpEhLpbYsiFpEYSgiOv1ADoNiYeKrfXJ3kHuv5scWc9ni4mUszyWGBZ07J8MIldB8mDs2Vb8bzlDnCbYkY33oOjPDXwb92h54e+fGoF5x/BFeZ0NeFJ4TaXXzD2Qcx4ZGl6I14cczWPO3LU/EqVZUj7Ra0A6RoE6GUW+hkMb/JwlANKFNMjOO24UCNqD3nVreOQVl5KCGQVBl5h/orflJC5FaUYoN7ZHKFU6NoorCKGTgEyvJB52ZVZ+SWQh8XGOs
X-Microsoft-Antispam-PRVS: <CY4PR12MB1445C74C142C4129C0EBA2FBB4FB0@CY4PR12MB1445.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93003095)(6055026)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1445;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1445;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;4:DNzpKRsjJqzNsChrU0dncF55bsBdWrezBJMafTfKfw5qveJW32tg2Ewx+RRpdqKGoqOblzZQqdmXdWmkzGMxxggOaRmEerT+hXaqlQdT3nYXRd+yOaf/dx9QHmvafrE2B3hRC3stexSo2Dom6Af+zXVZCfvRafzCZ4H3WmJWCKvCleC3SGTmSWcnFD49WL2cblJC1ce3rMSmcnfNnxgIFQqC9qU8/+rue7gt8fFucW9O+lxqaDtBPt6dCNT/A+mpqPQU4c/FKegnZQm+TMTygnuc/bB8G/Dd60DVpQxfFU8jfnBZeKJUQpO//ZuSlsqDarZqI/4o+wSC/c4RFwTBTObMK59OISeUmK4J0HVIIpRrpX6NEJhgsBWYN1Gu8iQb
X-Forefront-PRVS: 056929CBB8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ1OzIzOmt5eWo2K1pTZU40WUVoeVNtRG1tTnZTRUJy?=
 =?utf-8?B?NFZUbjdZNmNyTTdWWDIzZnJRNDNNN0tJQm1GVWVRbGwxYk9OMXhpYlk2Y29t?=
 =?utf-8?B?cjZjRjQwaWJVM3BtTzl5Z05LN00yTEV2d0dSb0xUMVVRRWVBR1dNbGg3amNF?=
 =?utf-8?B?RE0vNDN1SnBlV1I3aWJDb1kyZmVqektPdU5BaDlpY25mL0VBbnFoOVhjQ0hX?=
 =?utf-8?B?bXIxQ2p1UVBjeXVVUmllNE4wakpqRkhJbzRpU1Q1cE9BUnBidEpFWFFnZ09w?=
 =?utf-8?B?ZksxOW14NlNOMjFCNkFpM2puc3E2cmVTNjd3ZFpnbDE0NnA1SlI5Q1FnVmZZ?=
 =?utf-8?B?TDNDMHpnNzhmQUd0a0pkNWwxRHZudzVrU244MDZxSnkxRzhwMGV4TU54YStI?=
 =?utf-8?B?bm1HYnNRK1d0NTErQlo4Um1UOGpYOUFPWDBiZ3dmMzcwTWtRSFNWNmNrUGJ4?=
 =?utf-8?B?VEVEbFJKSjFYbUVWWkxWeU9uZXpzaTFWVHhtRk8xc3NuMUlPMG4yN25ma3BZ?=
 =?utf-8?B?ZDk5MXNvQ3lUZ3NTeHdmS0lYY1JJdExsNFltbVF6QUloajByY1cwNU1qRUs5?=
 =?utf-8?B?YTN0M1ZEdE43c1FkRVVnMVV2MjMrYTFtaWZKQmdlNTcrS2U1SDNHbDRMM3FJ?=
 =?utf-8?B?cW1Yc2l2MHoxU3N4K0NRTWJFY09Kc2tWb2dBWCtDL0trcmVJWHdhS0wyS3da?=
 =?utf-8?B?Y1dIRGFjTDd6TDNFY0FRUlJVQTVRZ1FlWm5kODBYS092Qk4vckhicDk3MkVz?=
 =?utf-8?B?NkltbEc1Nmt3QjUxOHI1QkpyQ2hyYnM0WnJWYUswWUxUYW9xZTEyYkJvWnN4?=
 =?utf-8?B?SWpOVGwvZ0ZmNkFrd3krTHcyK2dpZ2Frc0lkK1FNQ3djWWpndThJZmxBWnRU?=
 =?utf-8?B?T3dzVnBPbXlmNVZ3MXRVckFaWnpHT3ZYOE01SmxudmJ3clMrOXJOdEtCeWhH?=
 =?utf-8?B?VDZqMTdVN0dqa0ZsMEduVmVPR2wwVVl1ZUgrclk0a0M0ZUtla2dMUTdXUEkw?=
 =?utf-8?B?V1FjbmxjK08rSzFxblpTWVhYMkE1VXdCTkZyRW1ERVJxNGdnNGduYjd4N1Fy?=
 =?utf-8?B?RmlZbTFaSXU1TTFWWFFqMTlyZ2wrOHNEZUZUeTRuZld3UWR4ZmFJNzB0TWh5?=
 =?utf-8?B?dmN2Sis5WmVmSFprYWhpN2E2NG5kaGZIV3k2aGRQK3JUS1YvcW1GWWxBQU1O?=
 =?utf-8?B?WWtPUEExbm5zbitVS1R0U3J5TWJCQWpwdWFXZEZXbnZFOUlIeWJNdFVhRy9t?=
 =?utf-8?B?YmhHSmg5ckhSSm85MWFIcGdJTE5NUTdjODkwYlZnQzRLdVZrWU1xTEVTM3BK?=
 =?utf-8?B?bW5JOTRzT3VlUVAvVmV1d3I4VFh4MFRDQTJySzFucTA0bStnSURBQUo3c29l?=
 =?utf-8?B?dk15N3FxUStVakQxeERnTXo2eVZRVXViTWFweGJ2azJJOE55c2ZQYWd2cCsw?=
 =?utf-8?B?TTVraDRwQ1BrR0ZCS0krNk5VV2NDditscDlZUmVXZS85dGFwNndiclNQYzM1?=
 =?utf-8?B?bTBIQzI3ZlZpa0xZS0Iyb0dHcFdBZkk4L3pmWDdPL0FEdlRPM3lvanJHeEU3?=
 =?utf-8?B?SDd0U3FxZjFlandpVFJVYXdIbXNYQVNlQjZOcGdvMGd2WncyRlhINWtXdGZK?=
 =?utf-8?B?SzdnNVpRMjBXOVh4U1Q2NG40NW9NNDlUNVFFcVlXanlwdVRqZEovTDk2WWR5?=
 =?utf-8?B?b05LeHU2cHorZDZQVytUQXZ1d09BN2ZpUFVpRjc5c1lJMkdLaEtYZnJYa042?=
 =?utf-8?B?SXFjM1pZbklieWNFVE1QbElCaGtST09XR2VGMFFZUVZzMVlzVU52Z3hWdlFL?=
 =?utf-8?B?SmtWQ0lxWERqOWtUcUhva2lEbkl1SHFIdFdUclVqSDZjTmp1TGJIYlRpR2tJ?=
 =?utf-8?B?K202UEw0NTF5WmROZFIxaVRxUFFCZmthTjdDRkI4aHMzd1dCR3pRazdsWWdJ?=
 =?utf-8?B?c1NreWZBZmVLU3RRNWlBcXlnQXowVGZPQng3VVVRZ3loSXR3a1ZRMURuYkpj?=
 =?utf-8?Q?j91eGo?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;6:iIiiiR6WjKH5a5kOOilIek0vmCzeJ0wUprjHyvRp8rSdeEyI2mheFiT4zII34PpEE98XZ96siTdTSS2TUPixEmtaQh83/ab4Y+Fv9pcEsuuPDQOgtjHZ5Bj5H7/VzMJ+5EClJYbP13fT7MIoOv4jiJrYt8DR3nlFGjVNC6V6X0cHTYbhHmhCpiN2WxDBUIHe4lL5nfa7Dxlzi178GLFd20seDpVrhGUSTfNRs3cK8CNx7r25Lq7mTaCpdboI96c0r7dmmbw3eTHxod51RUANKPdEZwuurkywYS9y6gRhhVgjMZ6PKbK3ZYkU2kJEnLknL7ANk8rqS7I3/JluEhlZxCgndrOA8qf3sk5B1W5uEag=;5:W03vmnns6miipIciq0Y+rz+yyuxvg9XLDmO1oXpUMHQ4vgPtTuiqeNzLr9g15c6pKMDBaY3pPZrrsWGKV0OS9v1yrgeAYZGF1oJYknDXTeMntIEB0bPG2Yd1mEsvW62I019/r4A44rzOOYnh5Q4VhMAou8xzQrBFNNwwO68i+3E=;24:3z+qSD+nohZD6kgVKqVkPgXKzJ7f52bDlgiz/0VGThna+HeKYZbXOr2YESDDenZZBK7coVtKru6Rbe+mJ8cO3xjLUqE3jDG7dNxHOlmw/jE=;7:mKB6Kbr4DMbaZ85TnYkctPosVVn0oM6hlM53PiUKVzZgnIlTPFgxG+g4tE8bz48rfiOvf63ac8KotH+xlUmUmFOzuJqM9j1EWAz6rsEKW4cMjbkBEgc3XgJhuMxRwAYS/9Z7bgBWSTwd8Wr2c5UZwwLQ2BJUU/cg2u7P+Rm0UvTM85Db256hmQ/WOlwR11MmmkfRauO2Vi1eKZCEMPpzZ1G7J9UrY7OZRI3ny152DFXoZ1zVzPI3AArIE+vra6hK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;20:74b/HOhQmxuOBz7vStpzpfIIz6VHACmFeXk8WsiYmHkNFS4YC7t00oMeFzLVKb05bO2vSu/lweaz3hm27Yelu+jC2BNq2O6hpvOYxc+8RNymN96/xaoCMgkXyS6tO1UwqucM/PJFJfku0eWwx5xourga5optSDj3nEi1IiGVOqaZPQ+bMGhYwkq2i3bGDL7hIEL+H5zGK/dpzbM0uU1zoefzfK4LPIojTYWg+OQKuQsy/2v12vKYHF42QDGUW6Z0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 08:52:18.4444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8955ea2a-af83-4bce-b55f-08d56887ef36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discussed with Roger just now, we can try "void si_swapinfo(struct 
sysinfo *val)" function to get the total swap space.

Regards,

David Zhou


On 2018年01月31日 16:12, Christian König wrote:
> Yeah, indeed. But what we could do is to rely on a fixed limit like 
> the Intel driver does and I suggested before.
>
> E.g. don't copy anything into a shmemfile when there is only x MB of 
> swap space left.
>
> Roger can you test that approach once more with your fix for the OOM 
> issues in the page fault handler?
>
> Thanks,
> Christian.
>
> Am 31.01.2018 um 09:08 schrieb He, Roger:
>>     I think this patch isn't need at all. You can directly read 
>> total_swap_pages variable in TTM.
>>
>> Because the variable is not exported by EXPORT_SYMBOL_GPL. So direct 
>> using will result in:
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
>> I think this patch isn't need at all. You can directly read 
>> total_swap_pages variable in TTM. See the comment:
>>
>> /* protected with swap_lock. reading in vm_swap_full() doesn't need 
>> lock */ long total_swap_pages;
>>
>> there are many places using it directly, you just couldn't change its 
>> value. Reading it doesn't need lock.
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
>>>    include/linux/swap.h |  6 ++++++
>>>    mm/swapfile.c        | 15 +++++++++++++++
>>>    2 files changed, 21 insertions(+)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index c2b8128..708d66f 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -484,6 +484,7 @@ extern int try_to_free_swap(struct page *);
>>>    struct backing_dev_info;
>>>    extern int init_swap_address_space(unsigned int type, unsigned 
>>> long nr_pages);
>>>    extern void exit_swap_address_space(unsigned int type);
>>> +extern long get_total_swap_pages(void);
>>>       #else /* CONFIG_SWAP */
>>>    @@ -516,6 +517,11 @@ static inline void show_swap_cache_info(void)
>>>    {
>>>    }
>>>    +long get_total_swap_pages(void)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>>    #define free_swap_and_cache(e) ({(is_migration_entry(e) || 
>>> is_device_private_entry(e));})
>>>    #define swapcache_prepare(e) ({(is_migration_entry(e) || 
>>> is_device_private_entry(e));})
>>>    diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 3074b02..a0062eb 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -98,6 +98,21 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
>>>       atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>>>    +/*
>>> + * expose this value for others use
>>> + */
>>> +long get_total_swap_pages(void)
>>> +{
>>> +    long ret;
>>> +
>>> +    spin_lock(&swap_lock);
>>> +    ret = total_swap_pages;
>>> +    spin_unlock(&swap_lock);
>>> +
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(get_total_swap_pages);
>>> +
>>>    static inline unsigned char swap_count(unsigned char ent)
>>>    {
>>>        return ent & ~SWAP_HAS_CACHE;    /* may include SWAP_HAS_CONT 
>>> flag */
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
