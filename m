Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeA3Wk1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:40:27 -0500
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com ([104.47.41.54]:38112
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751927AbeA3WkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:40:24 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCHv3 1/3] x86/mm/encrypt: Move page table helpers into
 separate translation unit
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180124163623.61765-1-kirill.shutemov@linux.intel.com>
 <20180124163623.61765-2-kirill.shutemov@linux.intel.com>
 <f1005ed5-c245-b64f-fe4b-64fff5790172@amd.com>
 <20180130222800.7hrnzpy56fb6jwnn@node.shutemov.name>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e35bd204-a8d5-f88b-c042-c9eca792493a@amd.com>
Date: Tue, 30 Jan 2018 16:40:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180130222800.7hrnzpy56fb6jwnn@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR1601CA0017.namprd16.prod.outlook.com
 (2603:10b6:300:da::27) To CY4PR12MB1143.namprd12.prod.outlook.com
 (2603:10b6:903:38::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8faab49-f626-4c89-95ac-08d5683272a0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1143;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;3:5kklL0wL7u3T1fkq9xuQnOQjOKm8tkFYcBZ9YUA0QUnzu7IvKQU7r0fFfEad+9eNtj38LZoKxna/FN1KfZQaJEWyOQ5urum/lQGPDVJk2j6DP1/5GFhxeZuW0CBlI0ZfayOaZ0LS0YkSaVH7HtHDZhMRbMjXFkjVI7nBLQw0o+7ML+vuc1ryGmHpeZ/s5bVLMtRFsFhMejqSMr9bD0l93dasQRTjOPtuvtRMzZQcVXfQgJ4E332lBBAOy1OU9XzE;25:GHFKu4cwnV45cGCiCvPy2UxNSR64pohxGdW5adHNQ6/8uPrHbWvGTxo5jAV7uRy6b8gCEt6nTRfSRvuKmHGuG3XDEPQ5GtGDwsi/ide77LQAYmobTe0d5HAQ5eF8lKfLP4BdrTJ/IlXhG4obbZLlrHvEg4NZkoljX5MoRAmkcwcy75f8yzH6qCzoCn1XUCAs7ZNPdhkA2xws8xduOqqofXSANWx3FJz/1GMA0KFND9wdzoSjS5U8WCl7nER/pbMpBLv1817zHEXSDXxlkNwZnowhL5r+SPDOXl1AbhADIWUfJUQJpsjcOFuYICIbCAdvvjAAoINlyh3bHLQUO4KGjQ==;31:/LeKFsPJKmT2PvlUxa5t7WogDVvLjpZBrq/n9b0UObXwu/Lk4UJx4mvWnz4W+xI0oJG71gge5MOCPMCK+YkxKlMgYROM9+V6Igu4ne56sJs95clF1RkoqGQ0HoPijsMicK1Q1wqFCgjkH0XyfZRP2bnC30+586FY68LlGVNioB+FiT8q4n7J5JIRmDvTuP4oqLEEUmisD66F0ndx8QYmHIy8OF/Bd6/2Ed7CKe0rqv0=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:fpU+vq9gK8swl0l9r9vqyltaSYrHOmfk0SxsgfgKlaSF2ASdkHp+B+S4LVTI7A+dJYrRCyfoUQBYrZuBLXAV1bRCqdkwuvubiXMKcDF/n52O2oWJvfj1JEhr/txFoDQtbqkzLzJ4UABsdjzOu/rctcD47AtD1/r9vTriJIeutJEvXhPoJOH37YFYxPUgngkuktjUN2JqDW2E+A3q7Uxn1FKtmfGVTfHdOa8OJS61GPNzX4auNAn8pUT8zPkbaktL8dCRzLMsWN9lu63UDEnLEwrPZHZ0cAHBJQlKe5EXlx7rNyXFNzIxOJJVErwY3WYJwamIxYmfKxREWRaKH7J+idR42PVMN8sMIYPqOrq1y2UMK4FxbPpXjuoDEdzfDmFcmHcvIZVMc5LkHa1RGQbPJox2KIC6r7CF9SOfpuF+DiD1MELNITf9DR012c/NRwUFa9u3vW0tKNQ+6BXpP970S3H6KOUtRoEH3X8Jz2eFCCSBFxSvrdXQiNC584unrU2q;4:FwmL/NvQsJyrLhOt9nGtWb59hbjmo5Ga6TbAzGnZcnd1RTSbyP6YWMPHpylVIc4ouZil5q3Xy5q1HQyZQ9kYPT5hnpg7JJzhlRV0uuUPjRfG1Uw3T+M6pMxjfJzwIWhoaJHHt6w5blTEtONXuL1UpaC03dGJmKVd5By3ub84OFXUAGZ8vKUMNZVxe9Cxs9MXY3yAEuHe8ck1ZyOdk7SdCwyl6fqEPLMWRV+hZ8zTM5PbZBWIqXUJTH56Uc1nkP8pvYTsYd/HcOAc6YH9nMwA/m0vcmTXB37WLCzOMhWdxN58PoRxNm/9CSt2OKLRfOHKKx8okAGeccd9VDbSgl+Z9w==
X-Microsoft-Antispam-PRVS: <CY4PR12MB11432925C263D8146A433BEEECE40@CY4PR12MB1143.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1143;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(7736002)(81166006)(8936002)(2906002)(86362001)(65826007)(186003)(5660300001)(81156014)(83506002)(26005)(8676002)(305945005)(7416002)(386003)(16526019)(6246003)(6916009)(3846002)(53936002)(6666003)(6116002)(50466002)(66066001)(93886005)(65956001)(31696002)(31686004)(105586002)(97736004)(47776003)(52116002)(6486002)(64126003)(229853002)(106356001)(2950100002)(478600001)(77096007)(25786009)(68736007)(4326008)(52146003)(316002)(23676004)(72206003)(53546011)(65806001)(230700001)(58126008)(54906003)(3260700006)(76176011)(59450400001)(2486003)(36756003)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQzOzIzOlBqcHd5dzU1UFBXcmJtNjFrZ21WU3U5ZE9C?=
 =?utf-8?B?Q2R2eDB3NDEreVBla2plTjFScDZxaVV5VnVhSTV6M1JOVHR1eldKUFF3MGRD?=
 =?utf-8?B?QXJqWnBUdDZId3g5VVh1RmRFMkdjZldhVzZXQVN3UmhLdlVnRVczbWhzdk00?=
 =?utf-8?B?blNqNUNQa3VWeGM1cXFCQ1o1R0FyMWY0L1Vkd0hmMy9GR3p4cm56Z0lKY215?=
 =?utf-8?B?U1pKcG9ocmFZSHpsL3F6SlpKUmhkaHJtUlh3RGR0OFg5Qit4NDFESitKTGl2?=
 =?utf-8?B?b2hvRlNOWGtyd3lZZldYSE9ka1Brb3I3OTlnNkpmbHVlNk9wL2JMckwrdEtC?=
 =?utf-8?B?Mm9Pc2IzMC85T1JabHl1eEZ6UldEOXFJeFlxZWl0YXdZNklHTGlmL0o2NjF1?=
 =?utf-8?B?Qmg5aS9rVnJxdjRIQW4yUlZVcGpCZFR3SnArR3dDL1JNbG9aUVlGMGZJY2gx?=
 =?utf-8?B?b0U4bVJ4U1RSMlk5WkxMWWpqUU1zczhON0FFRVNzaXlpWmF6cUd6bHI5eGFs?=
 =?utf-8?B?TFFUQ3FDdWhxbVpBaGJqckpuTmI5VWptclNqY2d3dUQva0ovMVNXQ0loSFZP?=
 =?utf-8?B?aU1TZEgzdDRmYlVEcGFwbjErZ1ZZa3BFSjdvZm1YNnc4azFDTnFHK3N6QzVz?=
 =?utf-8?B?cUlVRjJySDdGYW5lM2ZsNllKMEdMV2psQ0wxdGxjOTNPR3JxMURjaXdiN3FD?=
 =?utf-8?B?Z1dRYlRlY0c1MWtvUFBadFRIMzFuVE5vOGhCS1lKV3hLU29EZ0QweGVnSC94?=
 =?utf-8?B?dUkvZzhhQmsrbGxhR3R5ek5aNzFPZThST0sraS9ySE1KRDJPbnlyWXFtTGpU?=
 =?utf-8?B?Ny9sYVlkK1puNDY3eEw4L1d2MEQvMVZ5T3F0Uk1yTE80Q3BEeDdhOEtyRnFF?=
 =?utf-8?B?c0RZSGVDcTVkaW9HaTNYMTFTdERjajdxMG9aN01tR25zZHJMdWRYVGU5MHNP?=
 =?utf-8?B?clc0dTh4bWFZdVRaV3QzcGFyQmc5NXBOK09pa3QzR3pVZ3g2c0xORmd6dU5W?=
 =?utf-8?B?RDBWeU50MTN0OUsvaExQRVFLTmZiRDlWa2ExUjZOczFjVUVuRXlmcXJMRDVj?=
 =?utf-8?B?THVMVUl0U0xmekxYZUM3ejV4YzFJRTAxaXJlOHZBMEFxRzBEa2Y5VytBY3ly?=
 =?utf-8?B?aGNrODVSc2xKWE94RkduRTFMR2ZRSlN3SW80WElLZXhVc1RreG9lK1BBTmpY?=
 =?utf-8?B?aU10N1c4R0VkQVk5UmM3U3gxbzJ5OHQ4TTQwcHpRMm5JTXJwMWl2M2EwWFdl?=
 =?utf-8?B?NFMrbExNc2NiNDJzVCs3dEpldXdtV202NUU4VGMxUnJsa3B1dER0dGFzTllL?=
 =?utf-8?B?c1FBT1RGbE45enRGQWdqb09qYUkreEgrRml3YlUxUHdKUEF1YUpsRDhtUXN1?=
 =?utf-8?B?ZDk0L29OM2ZZSXpIQUQzYlNORThLRnIyMVBObzNLZmRHZUVNQVBHclZJUlF4?=
 =?utf-8?B?aEtMbVlNcW5uTmlnS1RrQ2xmWDFQcXZSMkNkRjBEOHpVSnFXZWxnRlEvNE1Z?=
 =?utf-8?B?NnR2dWdaVFE1Q01LNWJGakRiSXlOdHZ5aFZYcWRzbUwzaEJkc0p5NXRPSC8w?=
 =?utf-8?B?VEU0TjNGL0djOUI5dW1qdWN6cGNyN015ZWdSSG1IaW9sVW9JVTF0VHlnblBS?=
 =?utf-8?B?QVJpK1EvaVJwZ0pSWTR5VzA3RDRZTXNHVGdXQUs4SjB5eDBOUDloTnUySzM1?=
 =?utf-8?B?NFVaRHRMb2lTRDVIMnlBMG9MZEZ1U1VqWkh6bWE2ZGVoUDFKZkw3aWQ3NVB2?=
 =?utf-8?B?QitWVVpsd3VVTjI2dytBZjhGd3AzTFVIZ2JrUVFqb2huVWpoZzdjd1d3M1l1?=
 =?utf-8?B?MmVCM1RsV2lhZjBhYTRxRThwcWUyUHFQNXdYUVhWclIrcGdSZENGczIrUGxz?=
 =?utf-8?B?bW9vNEs5Rkw4RmNWMFhPMjlBWEZWVWxpUXNhSTR1djMrd2ovM1Y2dTZqdlZQ?=
 =?utf-8?B?SGdWdVhZNDBsN3NNdm0rRWRubjl4ZWczZ1BNbTFLbndTOTZSaUhHcE90Tktp?=
 =?utf-8?B?dGcwZHpOam9naHBRVUNzbFcyRUY0N3JYRFpOUT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;6:28+npLuusQwv1lW9HgVyLAwIETt8tOHZ7LvzAW7Lkdf1NOLn2b41CWhNkt5pqLU3UJ/nrweaUHiYAbrxWPaxEj4XyXsThrbrlAoYYJhb1qfzP1KAZBa+JTP8RBR4E/X7iWjhO2moYvHXeYKz/3/VvhEcn5ABZcvD+3v1SMbXNDpKCE7Leif5bAkwKQ8eEnQbk2DgQcb8mJRAQpXae9wJ54lpQBDG8eLcJWLL1E4AkcfqJLLSKUcLZVe60rhSaNTI+klniepGAuVpcyL0Umq9hFP8G+nE2I90+cBvnRRoxE/Ybfq4CMeIDuax2Xnb7pLBEEcHPFmZUZP7+ifKLdSvJv5omuNh8THnvh5zNZLxabg=;5:nSTEnN8J+GZNtfLjTR6V9TUh0GIfsnEzfGFcrGwoHyUkt3/4C+21lNwNtq/jQ8+vTDt1ZP3sZiyZlb5rLSEb2Xn5uSjo0+uYPg7wDYfzlFMVxn3koiN70oCk7vn30FpQlbUIdb9t/oTidHdVRlKrUeZjPz5GKsSY5lp15OtCuhM=;24:qyzC5VQ8C5yDrU8pHm/DM4k8dXskMe1cIs5zhjG2Uu26wbl+6eWlcivTKuHWbBFNN0x5a6W3ZPnyLCZQvJ+r44ss11sQgD0p5jaGmepG2QA=;7:O7GZG3ql9OGuf2qj+uuz4QnfINCAPmZQXNBPIbZxc/Izgx6ufAv70IGyZZRgCRISfxO4UrQJpj81DUoATyH1b0cbBMXGTxhtUr61V1Vtif5/OB6Ls/m1QZHNDZkI1EIhdBpckJOxCQ41h2aEmO9Thn4z1rhBEtii8FicFKW6xl7bTn6Ybwlu9dANEyXkCdmpIaDEjy9UO/7ludRf87b7ytMQuz07oEoTm0yoVRcd1tzeG2lYB4BQPi/zzwVC7MBx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:axD5qDPUw3OKKlWhWRHVIOvVgabKiS0Z+mxbt/A1YnDXd53J5LcdXGTbF/0vKqniHf53Pc0UvNLQuCF44CI/UmadEAHxutvRmrQSWX1AYHLM9HnKlPs4ek2LuXItgpPpsB8WTyWxnHOGS6bF/rq+TV0g3umVZj23HR3W2R4dqSp8YGG2jP5UT01LT1GFKdUy9IqqF5T0qMRHOK7MMDzlCgIly/3ioN8HkGpfi/W80qH9w3v6QjPRQJY1b5/bcm9L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 22:40:21.1073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8faab49-f626-4c89-95ac-08d5683272a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2018 4:28 PM, Kirill A. Shutemov wrote:
> On Tue, Jan 30, 2018 at 04:26:03PM -0600, Tom Lendacky wrote:
>> On 1/24/2018 10:36 AM, Kirill A. Shutemov wrote:
>>> There are bunch of functions in mem_encrypt.c that operate on the
>>> identity mapping, which means they want virtual addresses to be equal to
>>> physical one, without PAGE_OFFSET shift.
>>>
>>> We also need to avoid paravirtualizaion call there.
>>>
>>> Getting this done is tricky. We cannot use usual page table helpers.
>>> It forces us to open-code a lot of things. It makes code ugly and hard
>>> to modify.
>>>
>>> We can get it work with the page table helpers, but it requires few
>>> preprocessor tricks. These tricks may have side effects for the rest of
>>> the file.
>>>
>>> Let's isolate such functions into own translation unit.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>
>> Just one minor comment at the end.  With that change:
>>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>>
>>> ---
>>>  arch/x86/mm/Makefile               |  14 +-
>>>  arch/x86/mm/mem_encrypt.c          | 578 +----------------------------------
>>>  arch/x86/mm/mem_encrypt_identity.c | 596 +++++++++++++++++++++++++++++++++++++
>>>  arch/x86/mm/mm_internal.h          |   1 +
>>>  4 files changed, 607 insertions(+), 582 deletions(-)
>>>  create mode 100644 arch/x86/mm/mem_encrypt_identity.c
>>>
>>
>> ...
>>
>>> diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
>>> index 4e1f6e1b8159..7b4fc4386d90 100644
>>> --- a/arch/x86/mm/mm_internal.h
>>> +++ b/arch/x86/mm/mm_internal.h
>>> @@ -19,4 +19,5 @@ extern int after_bootmem;
>>>  
>>>  void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
>>>  
>>> +extern bool sev_enabled __section(.data);
>>
>> Lets move this into arch/x86/include/asm/mem_encrypt.h and then add
>> #include <linux/mem_encrypt.h> to mem_encrypt_identity.c.
> 
> Why? Will we need it beyond arch/x86/mm/ in the future?

I just think it would be best to keep all the memory encryption stuff
together.

Thanks,
Tom

> 
