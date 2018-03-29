Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeC2PwZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 11:52:25 -0400
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:55072
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751642AbeC2PwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 11:52:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
To: Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
 <20180213140303.42mbzfxpypljy37l@8bytes.org>
 <20180213214002.GA27066@otc-nc-03> <20180213145332.35c73eda@jacob-builder>
 <20180215095337.fccoozdclfnbepi4@8bytes.org>
 <20180215083811.3ec86e49@jacob-builder>
 <20180315131854.s6xmltsvsysublcw@8bytes.org>
 <20180319093714.3afe698b@jacob-builder>
 <20180329084824.fvy7cg2wban4by4n@8bytes.org>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <d9657df2-3742-6949-52ca-23d4ca186a7e@amd.com>
Date: Thu, 29 Mar 2018 10:52:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329084824.fvy7cg2wban4by4n@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0801CA0006.namprd08.prod.outlook.com
 (2603:10b6:803:29::16) To CY1PR12MB0698.namprd12.prod.outlook.com
 (2a01:111:e400:c43b::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0f66d19-6c93-4a4b-3643-08d5958d0d76
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0698;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;3:ldZVq+8inptYHLrpqGnMLSqdsHN4nA/PmzusA2EjKFhbEBogxM/TXe7ol42t9eU8bxluuez56iKP+P+SyPxwsD3kVuSxAyex0rryww+W7Md2BLWHps6vdfge+GLZwsi8vawwhYjeFQOUn4dLLl47CJ2NPxreKNjii+bPd1UZ/Rhuzs0gg+/4tiXAgMYyzjuFj0wV3cedeBqO+0g3Vnxuj1MLvM1YWkxhu1P+4mhUxFjNsmvcvBSyFE2k5BkqpX8x;25:RkkGdFifoC2/JZIyZj0h2xoskNG32FJ953nYX6zE4ibGY0LJT8qsRszTy8HOVALvEhVXR92a82ms4HPbxU1K0tXHMUM8cMXQ4dGmmLDkPRyRi5vVhkESIa6/A8r33S3wp5Y8NzsPj/ISJxTm1arWp0Nas7cqHjpq4MpYc0Ag8Ssy3PljsW+fiZvKt+htJ78PD1NKkaMOaLUaE5JyuKi7XEGS3bUG9Fxb4ILCxRR1WrAWQp/1rQNHzC3231uZcob/R3MBohZxVj6akYp+51qpVpnv9Jz601FbnqzxKs4xoG2A8WxFNQyHj7tpVtpYoOSmQkvTyKSqo4kQyTDbe75yNQ==;31:lT02/vho2OcLKK9GUM1vdrtEw8u4Gn42gJ3RGEjqCQhh9cx8M+7ltC8RFbLpKjr5SwCXR9EqDT9wT/FnziifH7deUxuZQ+d/mO5j+uFlx2x7BzOzg2S0OiJJVV/cLYOnh8Kv9gjTndLXOC7QvoNDEgA84taB8KJSLMF/tiJPuUz8UOyq4otVf6gTLcQVFO3Eszjknl99eaPDlnuheRg/RkpOtrFHILzEUJwymEn7GQc=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0698:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;20:+5wOquym1IQyqJo6znxTXzD7FoxEYgiijF8EnVvzjuBkRGy+z+sl1Ums+plGL3+fF/VVV8jRFczW7Mt5I+ABd53f0N22b/SP/BbF/lEQJVDTSM8jdm8o3giMr9GZ2XbaAOq1SKPSSxmI9vLGbPbmcGPNMPp0IPSfJB3ii346qtaU6gas3JPLpm6dC5uLD5sDPYPKQ7I8Ue/9EFuaZdQFtv14xHvh1mYs+Y4pdtUrvDwmNEBaEV6m58WqQruJ19xRfTjPY1VxZa2YoHewBazPKthPnwsyy3ece/zfQQkPrhQodJ6IPU06ZtEGMvr91ZcAsymeR8SHBlKJpbRY384xw4jRgBPFik8qpbgnM7hVTGrqrCw1CH3nRTNbyoyCfd4ulqoF0MIb8hVZlOnfIQsR5zd8mn8gHQhpMbw8CXZ1qiHQxniTaqtnHiryHIRU6X/5NOAVIjqSkgxTVpxWF+fKPshv+zGIBsbYco9jDcv094NfXdd75nApGQrCTRrfddaf;4:xTNEV4YGAWGJB6+roHwoGY3ACFzVhU2XAPH9O1yeE6X2rpXlSmMDzbozu+nM0xmrMrNXXjo+X2zkVrzB8WgH5drPz6GEWRh/K+yLFuPknAnao0Fal6SGSRxOd7KTyFz+62r3dIt55bvbX0huZJnnRC+XivjGryoGLvMyIEdSI+1NjzgT3rSOSJVZbANl7C4z7NNmwO4/KXDb6YpTA+XlOHRvJDSb0o8Z4Iyo28HS7gTIlKE6268kx+eIkzGYR7NkypxyabRgXcmh1ZK52CXpj/ELs6Icc2xuOhkiX0E65/YAKi1R+SAuZ97P4vivb0d3
X-Microsoft-Antispam-PRVS: <CY1PR12MB0698BBA9024076A9E9873B1CFDA20@CY1PR12MB0698.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0698;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0698;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(39860400002)(366004)(396003)(376002)(199004)(189003)(26005)(97736004)(31686004)(64126003)(8936002)(81166006)(81156014)(16576012)(50466002)(316002)(86362001)(105586002)(68736007)(4326008)(386003)(59450400001)(25786009)(53546011)(93886005)(186003)(16526019)(66066001)(65806001)(65956001)(47776003)(36756003)(229853002)(6666003)(77096007)(8676002)(65826007)(6246003)(72206003)(54906003)(110136005)(52146003)(2486003)(23676004)(6116002)(76176011)(58126008)(230700001)(31696002)(5660300001)(53936002)(67846002)(3846002)(11346002)(2906002)(478600001)(6486002)(106356001)(486005)(956004)(7416002)(476003)(486005)(52116002)(2616005)(305945005)(446003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0698;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwNjk4OzIzOkh2d01jMnpBMUIzRWswNm1VYjZDNFZPYVNh?=
 =?utf-8?B?VzZVbVRHV2VmSU5pWGlZbHZMK3p2Z0hENFBDVEgzdU1pNDJBNW4zYlZGR1dj?=
 =?utf-8?B?ays3OG9YUkxDcEtoNEN0Y1hDaFdnYkRuMTVqRFFxelJ3RzVtMUlOamxzWGJj?=
 =?utf-8?B?SDVPVnRyTDRsazFOdXlHTUpEdm9DQzhQd1BpdXM1c2ZCUGxSTmYxby9VZUkv?=
 =?utf-8?B?cCtpWllWbjJBVHZCRVZtcDF1S3FHcmg4VkRaNjh6eVNOb1VxMXQ5Qmc3eG1l?=
 =?utf-8?B?WDRRcGMwNXhIVDFYMHNBNzN4WW56M1B6RlBKNXV0QWcyTytYYklONTErOVdG?=
 =?utf-8?B?d1c5M3k4Z2h4bkhyTFJYeWxvZFVXMXNJckhRNjd3Z2h6RW51RmEyb3JCSitH?=
 =?utf-8?B?QXV0dXpGelV6d3hQc09sc3hJK0xBdXNjUFk3MkRPTXZoTml6SVQ2L0FHaWU3?=
 =?utf-8?B?b1VoZVFXMENJWi9ydnk0VkhYeHExUCt2OW9UMkFlMmkrT0VmaFRtY1hzK0lD?=
 =?utf-8?B?bWFjZEtLZWZidVZqeFN1SkJLb1lsNEllQXZSRXZMSzhNQWlPVExNYU9RbXJ2?=
 =?utf-8?B?MTUrMXAvMmtIc0c2cUo3NG5zZGEvL0pnQTU0aWMyaXAveEJ3NFZlSXhhYjBm?=
 =?utf-8?B?VjczTmFybis3OGtFY0w5UkJ4d0VPME1uL1FmbGthcEROZ0ZHUmozb3YySDdm?=
 =?utf-8?B?dUY0WVBhUWgxeHhhWXBtT0xtMTY0Y0c4andCWExyd1hleDlJc2NUbzBGanA4?=
 =?utf-8?B?RktrY3lkZ2I1WXBuRWVEa3hpejZRa2Jqc2JLU0lleDJHS0gyb1A0dTIwclJK?=
 =?utf-8?B?WVo4WVFtZjgzRGhOSUFqanVPbmpranpmTzZvS3RBWXJ1YWRPZ0tVMG9lR2xS?=
 =?utf-8?B?VUlTL284cWNKSlYxWWJaSWFLUnV2YXY5UGpWMG9kVVdSSExJS1BYVkNLYWZO?=
 =?utf-8?B?QU9VTDNXeDkxUDVwWDRmY0laeThmU2hZZDhmWU9ncldKTzB0SmdlOG1JaWkr?=
 =?utf-8?B?eUJIS0xtWlc1WnNxTmtoT3AvOUFDSE9QMURKOC9PeW9obWRSOGJwZjNqdzlh?=
 =?utf-8?B?dkd2QWpZYkRaYk1ReHBuTHJoRGhPRFA0Zk1Ia084ZlQ0UVhsd3dDNlRUZURP?=
 =?utf-8?B?ajVvZTkvcThtZVc2cmliQ3lleTFSbDNJU3dUa0p4SkRKdjE5eEFLMndsMlhP?=
 =?utf-8?B?WjkwNmVBcW9zK29uaS82WGlIK1dhSlp6T0ZhVDJ0OXZVZDFzNm9zMUdkemF4?=
 =?utf-8?B?V0pWRXJ3cHhLdU9OSE01eUtjQmpFQW1pb0RVQ0x5VDVhR3p2NDltSTdBV3Nk?=
 =?utf-8?B?cXh5SnIwRUdHNG1PbkFubStXbW55NFlOdlVwYjBJTklCejExUW9RMUJRV3dy?=
 =?utf-8?B?MlhwWHUvM3QrTFJKb0I2eGh3L3RFMjMyOGYvUlNtemIyeW0wV3ZPVG91T2pi?=
 =?utf-8?B?TjBidGZ3dDVLYytobURncnd1c2xCcXUwTEk0d1Nzcm1DdVhkVjNNSTZNakNU?=
 =?utf-8?B?MThqRkQ1RDlyM25HTGxuVkZ0cFordGc2MDVOY0hzd1VjaFZsd2xvQmtRTzh4?=
 =?utf-8?B?dCtiRC80T0lqZWhodytwaVM1WXM2dW1Xam5VakduVnNZb0h0Q2Y0UXJYTUpx?=
 =?utf-8?B?Z3BDSUtsRlZPZWd4L1JSbzByODdsNTBCR2k1SDdueVZtb3dNcmM5QXBXaVBD?=
 =?utf-8?B?S2NUbmJ2dmdFMlJSeU16WU4zME5GU1ZSMTF0bVNqMkZ4RXh0RXVqZ1M0RVBm?=
 =?utf-8?B?SFNnRGpzOG10cW13bzR2MDFMRGk3cjJmME9jaTErQVJjaXY0cUNOTllJR29T?=
 =?utf-8?B?TzFPRjA4emVZa1lPQ0pWejZWT2hSQ28yMDdteFRVbHVQZjRWNGlLRFNaYS9h?=
 =?utf-8?B?MnlaemEwVFllbUExblhWT1YvODB3UzdraVFHZUxISFU0TzVzRzFOcW13OUVR?=
 =?utf-8?B?WHZXUDJMZU50SHZlMTVrUG43QXFhUEtUMHFSSmhuTEU1Y0doYlJMcDZ0Uisz?=
 =?utf-8?B?YUVWVGg2TTgxQUFnWGJxYUk0bC9VWHcxRkFHbWJjdFkyajBScjR0aVVmRFJS?=
 =?utf-8?B?SU9JTjIxdjFrZ2xJSXZaVSt6UjBNN0toa0RlLzc0ZXBZT2ZFYVRQZk53azc1?=
 =?utf-8?Q?ZSgu3uQQfO0EzILnJL53ZjA=3D?=
X-Microsoft-Antispam-Message-Info: d4QoYSIT/yAmI7or8gEFe7WULLsuWUg4umU5rvyQZubRM8bAlVb7ZuRqh7kbcWiMN2NrqWY4psA/Gj6plnLheq9oCrTbwxrfb/5is7v5EJlijMLrTr0wZt6/SQ7iNG/V21pGLD2HFjdq1K9q3wmSo9NjlQ0U+pzkGwOvR6x0RQtGSTge+xZ+6OWK4zgW0iMW
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;6:TghOQtg6JWWd/82F43bfpEELjhQWSSq97fmqoJRQjBNW/KAvZTtuRSNexhQG7DP0v6e0fNmoJrMhD8EQEv7BxWnKJqjWaViJjYf7lsdeptUyFXmRRrR/NkM4W1XL8WGM6h/DgV5tnqRbnp0wrwKen1+TtwmpYkgRBFAibChW92gOalG1qF0TIPPyJtOA3BvDouLUKwh12nNjOaGGfrHW7qbVojoptCUZ7JUJVrAzAFsyjYh+DNwbtfM3G6BhWi4swhQuvzE+PAauzBNxY5693fLFlmmHuMzyg4MpcF6VsI+rtX0UK69Q2f0cGWccyUvjWV+TRUtQ1XCyuhwo47In+WGfzlAJ2Yb7oElhvVThpHNWHFg80+sHnRkbcJOZ3T4maK1EubJozoS7OyP7IXof5g39EvV+fLYSPjoUl36Xb4y3jS7TwelvpkQHwF+PmNh3WSwfcPjP0iiSwCafxNBU1A==;5:7p/KtRhzAdOQHU8K7NnDNfXWT6iI1zD5gQurKChrKWuGVsbRn/hj/9hbj/VFTlyzc92r48717NIB97+knF759SPjncdpZdx0GljovtmqhCXo1AO+mOesGcdxYCo2EL3JhdxSpfBhR8GhoPVkKpWSbDhu6/cvZI4O6rsIk4wu+3g=;24:tVSQnbHSbs4Wh8m5aBmrsOBZiWYWE+EiyEMp3UoRT0nL4MyloNZWc+3yuDrfaa752h84KnpYBYruZi8WbBoUBrLtZG71CG+9xdNiBAkOE6g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0698;7:6E7Fqu7MZoRVaCDFM0FBxUtt6HlKTtNSUcsLCvrk1HE1S84PBvmi+ud8dBlc+SbTshhy/qu2P9ZuPOg+om/WRPesPUB4xZm1ANsGkPdJyXPVWHaqTNOKxVY1bQGkxcdBNw6mbGqJ5cpBCpyM/FkkjN+di/5ngknKJJlaqj7hyHPd//0Rw5uJx0VwqwZHFeoy0jWAH5JG5cSH/THLsvR0CXGMm8KjVAyPU8PwJ2hvMxkDyzaAvAOerPzb9dRerFau;20:AsK58li/hi1opN4UQH3fO70iAB/w8UNqQmHE6OEUcSt+bmJspAppbgHD+pWNar8m0a1lgGad6vtSianr0Nu5aH9bGAC6nEa3uFK0AxkmWYJCFieAISAqr52x5GxVc5TRi0dE7uvAHRaLC2aRKFILOo19zKRrzqXNKssn2EePSXfyYGfYOL4cFeQeAv8radIUPf6lPlSevukB1HoZwikB3g1vHt2KOksNjLmkiM3sFbUtuBvOwmxoBdfHp7Y+eylJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 15:52:18.5008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f66d19-6c93-4a4b-3643-08d5958d0d76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0698
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2018 03:48 AM, Joerg Roedel wrote:
> [ Adding Gary from AMD to Cc ]
> 
> On Mon, Mar 19, 2018 at 09:37:14AM -0700, Jacob Pan wrote:
>> On Thu, 15 Mar 2018 14:18:54 +0100
>> Joerg Roedel <joro@8bytes.org> wrote:
>>
>>> On Thu, Feb 15, 2018 at 08:38:11AM -0800, Jacob Pan wrote:
>>>> Just wondering if your concern is on the implementation or the
>>>> debugfs idea in general. Perhaps have some common IOMMU debugfs?
>>>
>>> My concern mainly is that we add interfaces which reveal
>>> potentially security relevant information
>> I don;t think security is any worse than existing kernel page table in
>> debugfs. i.e. /sys/kernel/debug/page_tables
>> This is a debug feature.
> 
> Okay, so here is the way to go: Please introduce a basic debugfs
> facility to the core iommu code. It should basically only create a
> 'iommu/' directory in debugfs where drivers can create their own
> sub-directories. This must be enabled by a new kconfig option
> (CONFIG_IOMMU_DEBUGFS) and the kernel should print a big fat warning at
> boot when it is enabled. This hopefully prevents anyone from enabling it
> for production kernels.

I'm halfway through this. Where would you like to place the invocation 
of the initialization function?

There's an iommu_init() in iommu.c, But it's a core_initcall, which 
doesn't seem like a good spot. Not knowing enough about bring-up here, 
Would adding another __init function be suitable?

Gary
