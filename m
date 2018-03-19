Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933673AbeCSOlQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:41:16 -0400
Received: from mail-by2nam03on0072.outbound.protection.outlook.com ([104.47.42.72]:58656
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933327AbeCSOlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:41:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 11/14] swiotlb: remove swiotlb_set_mem_attributes
To: Christoph Hellwig <hch@lst.de>, x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180319103826.12853-1-hch@lst.de>
 <20180319103826.12853-12-hch@lst.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <7fe2c163-c659-c27f-b54b-23b38e4b0149@amd.com>
Date: Mon, 19 Mar 2018 09:41:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319103826.12853-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:3:37::33) To MWHPR12MB1149.namprd12.prod.outlook.com
 (2603:10b6:300:e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ea070d1-f4d2-42c3-3240-08d58da774cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1149;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;3:R/JWRccjCeQ/oCGNmI/mCTVyKmSSUDbBsduqFLnMPixvvM3590rXdr56R7iz+E0EEMxy/e3hL2pWB4oBI8T9TW6HZMLU2gIrZLdUPzrYdWwD0sevyRjUX6avCqRDA7OxaPtERfT68DCdDBseEvMlxHgdiLW2p3e3BLdf1YwTOFauLVaVAkvC8LeKXbUYKkC/yYGFjRaWqdXDhJdBbpL/LVRRC+qlyrYFHHMX+mEIUYjUTe/KYtjUlM+OsKinoDeo;25:Q6rW9E8/HZaCapI4DwwhdrvaUfdmBGwvvh3SnrPTaa3th/Pb1kWcETkMBV7GJK0bgiu2szDCL9D8rUiD9W6M7HtYs//7NVeBwnj/GHsLXlcAq379kSZonAlZZge7766tjFwpB4Z2QWQccfun5Xc6rWvKxoF4UMnMldXK8er2XSXzwxvW+hu78S2tnqYYbzE6vL94NM7yeOefnauXeV2TF3E/C0pS/ay5dexdQbWrpzeOzupXd2GTrJ1sCeTnAYEdnF168/0JaAsYZGNjRcvi4AXylSuMVmtfZx0Lg7Se/+4Z937hdQPfDf/JTwU3TZ7tU0M60OyJ4Tza6uOsRokikA==;31:p1mlDpaj5hJB01xz1ybF/jn0/6uWnHXHY6yVGm6LKCMWXc4oC/WhmFT88jrCsFueW8TS+9SCZ+NepcprYSaMv2Qdax5AWCSgRwoWjx/A1GW+VObOhCDRz2LRSCxJs/LKKFvcxjKBYpeH2YaScBOLYkEl9zrFr8oAAXtR57XNenXmEFNjJEjx1ipc3kpNP+DbKSEgnhod1CK1rEHfdR5iPsu1+hrh/bY9HSJlrFjVm6I=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1149:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:MwGBg9ZYYiYdPopEE35GgO2xMHwLQqTrxbMwbJBDhpBrRslGei2ZULiAy9XebLEE8xKKT8zzk7NtZMweZDGfCba7j1joGNBxvxBbkuFoJhyReayC//+7ngHW8j9OzQnqnO+F8Z1ibiRCsiLUkjMfMEnrLU/gfOP+6D0zrwReLL1qidsiz72RiDMR4MGmObFCm9Ol5gOyurs5ikMub/rhrssnqaHscxpUl7Iqq+Z9zRIeM7WMSZAqm97KF59lS2kIBNRSWfMZKacqeAiVJT3d1h4wrIvk4aBIzJtARCj0qaxGFU9AtHTSADK8TS+H6mALuaNrGDOrABJepK0T/Hd/NkBKnqAymwUAn9Wz+LRRdWU92h4zSuKU3aKG5gWoPIOJ9bBYzD5vfXVgs9BmjzyILfVPGc3RkeQ7Ncc3bB4/gXPQ68VtZoj4rnZeMnGDH4li2mJ7hso7tXauzoh3Slp0i4gyhPdRhtMJ68H3gCZRTE7cINc6BEXYsrUdK9IGTpS2;4:CcKhGIxjoh3oeodWdKedgLaFwtNcg482SWqt12TXrYkj/vegSVKrEd3KmiY/TuNyr1E42pf8dlk0TTgESJsxmbn2HPl6bnh4YKNPASxV8cfojTuJtoVh6GYTEvhuYeXvwtNKhJJStuC0G8109Phhz0k3ISewDUMlMyIYz+1rvMEHI11pVmi+F3oWHZrbQsc2OZuTOdW9/BZcfepRptnWcZ3sfv04QmNhFLF5enzbo5nR/NFtrGB4Zx4rMNvBPQAgDkyoHVi8KiQXBRH4cfBeaw8+j1PXnGYyjAjI7wMFvTYH393YCCTQb+9k45odzlOgjWNDTa1TCE2B+ifGVYSCdr35Zd/2mGFT0jE2NcBENEk=
X-Microsoft-Antispam-PRVS: <MWHPR12MB1149E6837080FC4B2900573FECD40@MWHPR12MB1149.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1149;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1149;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(77096007)(2906002)(31696002)(3846002)(6116002)(23676004)(52146003)(2486003)(76176011)(68736007)(50466002)(65806001)(53546011)(64126003)(65956001)(106356001)(66066001)(47776003)(386003)(16526019)(54906003)(52116002)(26005)(186003)(31686004)(105586002)(59450400001)(16576012)(2950100002)(58126008)(316002)(36756003)(6246003)(81166006)(81156014)(5660300001)(25786009)(8936002)(65826007)(230700001)(4326008)(8676002)(3260700006)(86362001)(575784001)(229853002)(7736002)(53936002)(478600001)(305945005)(6666003)(6486002)(72206003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1149;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTQ5OzIzOlRES0RGaG02SU9CV0RWY1NndDljbXVaWW53?=
 =?utf-8?B?TTNadnlYMm1ZM1lDMGxTcm8rWTI4WU13UnpGbUR5YnJ0akNRYUtGMDdMOE9z?=
 =?utf-8?B?UUUxTzBuZzVObHBKRjFGVUNDckppcXpEYkk0SzdTdjRTY0w3Ty8weVBZM1pT?=
 =?utf-8?B?dWIyaXRLcTMydFRubUpTbExHQUVRU2VMRzFaMGI5SVIybWNsaVB3dXRDOVl0?=
 =?utf-8?B?VVlNZlAwNXVTbk9RY2dZNEJoV043WFdmNXJERVQ4ZjZDTmNLMlU4YmliR21x?=
 =?utf-8?B?cVNTNGp0cEFoZU5nSjdYUFVwNnZWSXpWcFpuQ3JlM2NIVnVoWVJPb1dORTJh?=
 =?utf-8?B?Wm9BcVBLb3JLajVEdXM3MWxKTWh1ZkdQMW9UQ21vMGlqRkxqZkt3ay81UHRz?=
 =?utf-8?B?cndvbXZHS2RMajJLWnNaWGoxemhJUndBeTZvWUpWcG1ueTI0V0YzeVhjR2tL?=
 =?utf-8?B?VlRhbGZsY1lVNG9ySUU3aXNIQWFndnIzcGRzVms4VFR4YkJ0SW91V3ZRdmF1?=
 =?utf-8?B?czVTVWdjYUE5eXVoek56VVZhOFN5SGR3YjJyZTY5R3RxY05HYTVQN1NrWlhl?=
 =?utf-8?B?RHRCbk8zUXU3L0MxYnhFMCtpTFF4eEtzbEFIZmJPZUJPT0thak9EWmcrcWRm?=
 =?utf-8?B?UGdQZ2Rkclc3Y0svYUpFeW0zQkd0d2VSZjVrSkN3VDl1aTlOemI3TzREV1dp?=
 =?utf-8?B?OFgybjdkZGJzS1V1ZW56Z0pycnloQysyREFwcExjQzJIam56cnRRQWFZZDdt?=
 =?utf-8?B?dW1NU3UzVjIwOXRNTVV6QVczSDdNNGJEL3o2WUlIa21XaHVZVnoreGRtVGdO?=
 =?utf-8?B?TUJvWXFUaTkzU1RHd2FNQll1WUVSMVQxYTNPZlpRVEV0Wnl2RDJBNHJYajBT?=
 =?utf-8?B?aktHZXZuSTJiUHJEcFJCZUFBeElGOU9qNi8zSzErbUtNWHUvSWxmTFo3NHpt?=
 =?utf-8?B?cUN5dVNhT0JML1laQWZlVzFSMEtzUkFrU0xEUklWZUd4Ty9hQnJxM3lNb1dF?=
 =?utf-8?B?UjdSVzJXcGVmVmsxOVBIL3hIQ1lGRUNybHErMVBjNWdSeGVXUDB3U0FRTnRv?=
 =?utf-8?B?OWh2K3Uxemd6MXNMbEN6TlFGMStZTDc2RFBUZnNZcVlzVDJrUHVyOTErYmkz?=
 =?utf-8?B?VWd2VXFNV0E1ZGQ0Um1sL0ZaZDMwZDkxYUdLNHJmRm92cW5TRGJUaWsvRUZn?=
 =?utf-8?B?RVhyc3hRVnJ5N3lUY2dQdFliTWFTZjlQRkFOaHQ1ZVloR2w4WGFOWWpoUERN?=
 =?utf-8?B?MS9jL2M5NmVmTXNBcVBBMjMwNjl5bkN6YlRxb3NsU1psRUU0OERyVmkrSTQ2?=
 =?utf-8?B?SjJRYmZwOWw2U1dzMTJ2TmtlSW5EakwxdWFBWFB5Q0hJQm1PVGN3MEJJT1Ni?=
 =?utf-8?B?MlNXWWs5dW8zc0VTZWE3TEtwVlVWbXRGNTdTMHU1WVlzeHJYVnZRbDIwZTA4?=
 =?utf-8?B?OXJLb1pxdjdFTllkSjRzM2pxcEJEelhwQ0JxNmRkeFlNZHRYQjJQbGt4eTVm?=
 =?utf-8?B?dTZ6R0VnWm96NXE3amcwVG4zWVc1RGlDUlZCb2c5SklrUW5QNUI3UHQ2U0Qr?=
 =?utf-8?B?Z1dZT3crek5IZzJwOU5ackJCNkJ5ZFp3YjdtZTlYS1RVTWV0MGtQOVBiVDNG?=
 =?utf-8?B?SjFWaEl2azdqUTJCWEgxcno3YkltKzVBdmhLQzdTNGtuaCtWQ3hKRi9OR0ND?=
 =?utf-8?B?MHNtUHJvM1ByMVo1MTBZWHIxZ2JuUzFOUHhFQk9lUU1lUWdzNGQwNWg5OFZF?=
 =?utf-8?B?R3F3OTczV2ZTRW5ZNXJudUR1MlQrL0lDM3VqUEQvbGNxU0lib2dFeFgxQjhP?=
 =?utf-8?B?RmEyak56VFZrZmU0MXJUZG1DQ2FvZ2hpeXR1WEwrd1cyYmlFR2FHZVI0aUk3?=
 =?utf-8?B?VjNFS0EveFdBNWd4ME04QlVOd1p1aVNYNGF2VEVBcERRZUdJb3c0eWt0NXdY?=
 =?utf-8?Q?MsyHfNg2Qtz3XvRBDlPscUJVblt7II=3D?=
X-Microsoft-Antispam-Message-Info: PzLv+WxbKVeJxSqZwevpLrRuPQl/Msxn9bGNZlvn8hn2A/0xuhY+6rjf9/c6JwODXrN2oWoKkP7FG3NuSC0HfMZPZe0SImUMwSK4NnU7nEIOPYYevpDCsvUbN9x55NXzWyviFIE726bCFRAhey7CFCIdvF8cic+I877IdWBVyJ10ot29AoiKNmRlmqs6IpoV
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;6:jJYqSQ88Y6ttkUVMSPTQHDI7GhNpqQWDxyKeAUdcxX0fYRQiqrslG9gfyGHcfmCI8QDYypPrN1pXa+tiXiQGpudWbVErzeNDvgN0+mNBH6/AVH6WhNar0Vl/7EJHjExLjxezDbxDKPD8uDf6MnkmsRm1o9bMKMoixcEz3r4pKWdJOYhmUAEhFH/qrk5PjU1sySaQ2c1dtPdg3QKqB5RVhdr3CXT7OsyZOQBBM0nDULdWsxT51fa9LPwMuT9Rj7n2PdrgwE3yraPHWHFyVG+OOak7EOGUcLXfwkG0+tCMMW6wBtCvJz32KhBm2/zaZ+GE/Fb0xau9b57Ecxr92MZEZ9xyeU0xoZa6QReoU/jdDus=;5:TING5jt7K8KbbiegBRUpU09KEUOHPdKTWRCbF4Kb/vrZ1eqjYDH/5sTqg+rBlo7VrbpHU6wUemvUiCuor0DUsK8HwjI5S3UmpxV2cJ76ZoYh1JmC4zuxSrAJ7ZXNVbrgdhfSs3mBq1LPXAMyEBi3Jw8yfWOWFkPnzNKZkeVY37o=;24:fZ4HsQf3xoOxeu53O4h5u5i2VEpIDxEJ5P0xAErccqC44BpzlXKvriDoQUgp3H6AU+lTB+2iIcqnR/ZRazEZw1vK/CHU3B0fhwT1HNh7muc=;7:WSefzOzk1gMN3KsQe6RlptxS3podGauWdZcedCq2x2EHYIqlZM0b8u2vsbvH4e4xDrxY82po7Us5rNRML3u7hTji0Q+oJF+DQREOcocQfQOVgVB0TcFSgzPOLULcn0KWxjLbC+YnzhVNnkyPAAWNjDKWQ5BQHhwFf6iFU1Fn21dTFBMXK7DC7mT4ElEO+4wnRu76emycHFpbmNzouxcbXzfsuMxOjY8zfXawBIWw8mIMupmVLATmLSGtqwsTMave
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:TikwFkUZLV7wAzFzszIpiZPXjOsbCflvcbmfjb7dCXux5GxQnN72sTgp75YHbQ885du1YIoq362TtBppVrIvLwfwRMb/UqeAC8bS4Qpkow4olwnE27plxXcKylcBPFcUPnDr1wpgJ63aekkJR0DKqYAkn+Tpmt8axFtRf9sSjBN/e4PeXmrTAEa7EvuxkGlCiOJPIr1Oh8z0fG5juYjM+05CdmAIvUMDMPSBu7gwZFP9teHeabhAvYAaGYZO4tpS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 14:41:08.0984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea070d1-f4d2-42c3-3240-08d58da774cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2018 5:38 AM, Christoph Hellwig wrote:
> Now that set_memory_decrypted is always available we can just call it
> directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/include/asm/mem_encrypt.h |  2 --
>  arch/x86/mm/mem_encrypt.c          |  9 ---------
>  lib/swiotlb.c                      | 12 ++++++------
>  3 files changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 22c5f3e6f820..9da0b63c8fc7 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -48,8 +48,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_init(void);
>  
> -void swiotlb_set_mem_attributes(void *vaddr, unsigned long size);
> -
>  bool sme_active(void);
>  bool sev_active(void);
>  
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 66beedc8fe3d..d3b80d5f9828 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -446,15 +446,6 @@ void __init mem_encrypt_init(void)
>  			     : "Secure Memory Encryption (SME)");
>  }
>  
> -void swiotlb_set_mem_attributes(void *vaddr, unsigned long size)
> -{
> -	WARN(PAGE_ALIGN(size) != size,
> -	     "size is not page-aligned (%#lx)\n", size);
> -
> -	/* Make the SWIOTLB buffer area decrypted */
> -	set_memory_decrypted((unsigned long)vaddr, size >> PAGE_SHIFT);
> -}
> -
>  struct sme_populate_pgd_data {
>  	void	*pgtable_area;
>  	pgd_t	*pgd;
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index c43ec2271469..005d1d87bb2e 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -31,6 +31,7 @@
>  #include <linux/gfp.h>
>  #include <linux/scatterlist.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/set_memory.h>
>  
>  #include <asm/io.h>
>  #include <asm/dma.h>
> @@ -156,8 +157,6 @@ unsigned long swiotlb_size_or_default(void)
>  	return size ? size : (IO_TLB_DEFAULT_SIZE);
>  }
>  
> -void __weak swiotlb_set_mem_attributes(void *vaddr, unsigned long size) { }
> -
>  /* For swiotlb, clear memory encryption mask from dma addresses */
>  static dma_addr_t swiotlb_phys_to_dma(struct device *hwdev,
>  				      phys_addr_t address)
> @@ -209,12 +208,12 @@ void __init swiotlb_update_mem_attributes(void)
>  
>  	vaddr = phys_to_virt(io_tlb_start);
>  	bytes = PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT);
> -	swiotlb_set_mem_attributes(vaddr, bytes);
> +	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
>  	memset(vaddr, 0, bytes);
>  
>  	vaddr = phys_to_virt(io_tlb_overflow_buffer);
>  	bytes = PAGE_ALIGN(io_tlb_overflow);
> -	swiotlb_set_mem_attributes(vaddr, bytes);
> +	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
>  	memset(vaddr, 0, bytes);
>  }
>  
> @@ -355,7 +354,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  	io_tlb_start = virt_to_phys(tlb);
>  	io_tlb_end = io_tlb_start + bytes;
>  
> -	swiotlb_set_mem_attributes(tlb, bytes);
> +	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
>  	memset(tlb, 0, bytes);
>  
>  	/*
> @@ -366,7 +365,8 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  	if (!v_overflow_buffer)
>  		goto cleanup2;
>  
> -	swiotlb_set_mem_attributes(v_overflow_buffer, io_tlb_overflow);
> +	set_memory_decrypted((unsigned long)v_overflow_buffer,
> +			io_tlb_overflow >> PAGE_SHIFT);
>  	memset(v_overflow_buffer, 0, io_tlb_overflow);
>  	io_tlb_overflow_buffer = virt_to_phys(v_overflow_buffer);
>  
> 
