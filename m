Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933664AbeCSOui (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:50:38 -0400
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:32640
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933002AbeCSOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:50:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 12/14] dma-direct: handle the memory encryption bit in
 common code
To: Christoph Hellwig <hch@lst.de>, x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180319103826.12853-1-hch@lst.de>
 <20180319103826.12853-13-hch@lst.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <6d05efef-3e2a-5875-aed6-0680d5b5e5be@amd.com>
Date: Mon, 19 Mar 2018 09:50:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319103826.12853-13-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:3:37::17) To CY4PR12MB1143.namprd12.prod.outlook.com
 (2603:10b6:903:38::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fa25ed9-d291-4638-268f-08d58da8c3e7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1143;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;3:l5tSLyo+dbS5f85ELXTt/a2hkq2swL6HOWDs07Tb3hKvhqLFhwIwq1d+EBbH/D3v/677y4CX9HiLuVE560VFPq4QbgqD8m8SHsH9mWvKXme/DoSrJjcQvoOgnGdBvsfvwz1XNWWtNsyhzzIMTgOxd8mEcFA+1LzQ6zIlRDCu/qOkbEAoqi9ogHYU0MVFAZ71j8sHtoCgwFFPW+6B0I/cmubbVU/BAhE/jXPomTDdXI7g4fFe3bLGgWLl06kipHbw;25:U/kDcPa01mIRwzevqpOV0+ZkeATCoFHS6ouX5oVDdmvRFv4eTnU90snxQ8QkEjwookSyCLJwqBSrKRrWz2mYrzDBs026Crd056j8PURi4zHiH+ZgR/UWGBoytGNUBoUC2OZJTh+2woKuJV8INaV2qi+ffCPW4XSImhKEoWPvXn3UIQHySKjSM0jolAh4v8e+Dcsz3aTKrG17CuWAxyUhCCSbzEad1GaiU3oe9IQdJtn2Inh3BjtfOKhyi9GijkBaWbdB13dy2VhpNossIGwT+wORp7C2DRLY2+2vHBdqyAk7NncWotlKYTMYWGwB3OgKxf7udswKOTjHwDBVFaukTA==;31:2FijxGbxVQiAqXZzeY9PaiJ8VfYfqhGO9dVgkaYoYp896UZi8oPhGEMscuo0EQvXGQ90RSB4EQarydwDqzh8JlqB6yuI77XkHX62ybE/UOyfcN5fJCmyABtahYI8kAcl5VKOetHWaMyGsz2oJZClirWa243xvrr36Yxk0IlARccfeCq0PkWUvBZ/MD0Swof/rx1FX+NRAjrkXQ6TwcZle9k0H/WonIvM8KrBlCSJot4=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:ST3BOeBeDfM186p3bY9xegzaftjGB1nFgkz0naBdqtp96c+jG3TPvKs8iqBokyvQb6qeZz5IQrTz+OLk9PmplL0V6DKABYDe+XolJdapc553fydoMNBx9T4LOzCq6tdgjCKSkNbmOh1+lMeypoJjO7IKh31RY+4lmlh2T06bmkfYPDzmnc3xdcVdZXhag79bSi5TzkXUlDphNvsYCeivHiff5s5RCwhgKXnk+6BqO0WbqH6udbsfYFgPZVF1JFTicQtczc4DsJiJDAgjBu20mAQMb5+TgDDAXIc0Vrve1C1KY4WBzgaq9vTZWuV50weT5DLGvm2IRQ0jwGu4qu2su+bpXOmbefggufPZpEXP62V8tac5Ptk6eQI+OOEwlMzRpwMa2UcrHa+tkOhuaNiT+kPlevlpUabC+DWLPxExPBtn2h4/HkSOH7xYpSt/xvjQo8sDRm7fpvHKIDSWLogPe5Ff/B9h9VoHeHcLYhBmXhBK58QWm2BVQXSjyaxeJOPM;4:AigzLSEQn68utEAKcaU+eLhtdScHP3U6LgQwOeSzg/wK8MTBl7u0bMGqqQm4cdDRH5ytPyAu7x9TbpbyjBlLirxjnIe5rF0tna3XanwBlQQiPSGYv5LLvksSfcoJMkDzWPh3HtY9Gslw7k+YSDbqHDJcqV1j9WSWgP7W5gnrVLaN6E8D5GxYCntT534PZcAHdaDhNiAj6EAx6PXwLYbmnoh3gDlnemhR6id1vDjRmbdmlvVBdOHngUPyEAmDam9i1Cy2751C1SGaf2B8V7wRKEVlN23x9W5QLNezuWfExT9C6W24felk7XbjRW67TWNU
X-Microsoft-Antispam-PRVS: <CY4PR12MB1143A474120BC17E7BB23B68ECD40@CY4PR12MB1143.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1143;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(189003)(199004)(186003)(6246003)(105586002)(478600001)(52116002)(4326008)(7736002)(65806001)(114624004)(47776003)(64126003)(36756003)(50466002)(305945005)(66066001)(2950100002)(65956001)(52146003)(58126008)(77096007)(68736007)(6116002)(54906003)(3846002)(53936002)(106356001)(76176011)(23676004)(5660300001)(2486003)(16526019)(575784001)(81166006)(8936002)(230700001)(6486002)(26005)(31696002)(386003)(316002)(53546011)(97736004)(25786009)(3260700006)(59450400001)(6666003)(8676002)(72206003)(229853002)(81156014)(16576012)(86362001)(31686004)(2906002)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQzOzIzOjdjckptVDJtYVNqOGxPY210ZjhJcWRsY2pn?=
 =?utf-8?B?K3dhSmhOcFpya2ZOdUo1S2hCYW9MalRMMkJIemJxSWdrM085QkpvZmhIUE9k?=
 =?utf-8?B?Y3JscGRVNFJnWmtWZFdJTmNyVXFoYmlMd3poSjZCT2JaZGhQT2o2WWJ5VzZp?=
 =?utf-8?B?RGpoZ0xoeDlrVWhWb0lzSzYrOStkWmdUTTVCZlNRNHFjU2tlWTBBalo1UFRk?=
 =?utf-8?B?SjhVUlE0Ykl5b1ZHUEcva0hiaHo4VGNPeEVRK2tabVpoRk53ZC8xb1BkSFp3?=
 =?utf-8?B?UUtOMzFPTWQ1NS9kcnhtVUtsalhIU0hUSFdJdVhEUzZJYlpnVHJOWGdOUXlS?=
 =?utf-8?B?aUxVbW41SGZTaUVvWDhGUFd5d2hEQ3dLVFlmZFNiaGpsQ0o2d3ljOE1iTXpH?=
 =?utf-8?B?QklENENiQ3RwMlVwYXVTTlBhaHZGbVp5R01mRFAzL2YrTGdtQjZlcFdvQUQy?=
 =?utf-8?B?cjZVTDVwNkJTdDlOY2YvU0o4Y1BML1pLSithQWp1RzlTL29WRGJNaVZ4U2R1?=
 =?utf-8?B?akdnUGdybEd3QUJsemRSUWZ5YUtVMk9LREhvaFJkTFRpVjFLbGlxSmZGQ2xZ?=
 =?utf-8?B?Vzl1SDRsMnJUdWpEWFg0ZmFvVTVVTnZlaWphZi9WYW96NzBORjc5d3dzcHly?=
 =?utf-8?B?a25HMldrOHgwSnJoT1p6NGo4WlExSDBnTURZWGNPaFM3ZnAyRUFHWmVpZ0JW?=
 =?utf-8?B?MG52dWhsbTNjUUJMeDVCZE5EaUNyeGd1NjM3OVhjTWVtMVVRcm5WQldpajhp?=
 =?utf-8?B?YWd6bUlQTi9rV0t2SC9DZlRMMGR2OTVDbFpDcTVuRjFJVkFlL1lxamcwTlUr?=
 =?utf-8?B?d21vcWkzOVRoYUxPYUtMcmZVSUk3c3VjczdFZURjMjl1UlZ2SG5kU0c1NUp1?=
 =?utf-8?B?aGh6SzBaeEo0cFhjNkFKanBkSHJLYnBjWStNUEVDRVRnalpOYTJBbGZwaFRr?=
 =?utf-8?B?NDIrdHBKdUxWZzNJM2FZQU1keEJMdkw5aUJNbFZERm55bzRUZFJWN2hGQlBK?=
 =?utf-8?B?S1Q5c0hLWGUvQkFGUXZNZkh4blNzclRBei94RW82VVI5RkJoSzJvQmZUNDhB?=
 =?utf-8?B?MU9CU0drc2RIL0NNSTRkNlBCQ0VvY0piOUROeW5yWkN4RHRZNkdNVkY2L0ZQ?=
 =?utf-8?B?Q0xBTWRvaW04UEVjeHNwVlRRTGNJc1hLRDBKa2VESHN1NWt1OU5jOVd2bFNK?=
 =?utf-8?B?eldaLzhPcVA3OFhzaDdEbjdZc2hYNEMvMFhUQmpicHI1MzYyUDZTRHhoZlh5?=
 =?utf-8?B?T2pFMkZFcUtMOTd0UDhJTDFUZTlZMmg4UFlsZlk3Y2x5MU1jbXd3SEhJSVBC?=
 =?utf-8?B?VVowS3A5dENQTWx3U1d1b2dsYjdBUElCNG15YWlxVHFSbVQyYThWaDhpZnhn?=
 =?utf-8?B?WU1EakpiUkgzMGNWem85aUduMTRxcEQ1bzlOUkVUbkpnejY2MFJmeVhBOUtZ?=
 =?utf-8?B?Q1Q4Q3JHODVVNkdRVmZMQWpBaHZxcmlaVTA2UnNOSXJQQllpeHo4c0JmV3Ji?=
 =?utf-8?B?V2o1UWQxaEN3VnN2c3FQcmJqdm55MTB2bFk3cXZoMEZqN3N6K2Y0VWtMWDZh?=
 =?utf-8?B?Y0NOYnBXR2FRMEZKV21rRVFhZC9wSDVQRER5NTZqd2lna2Z3ZW4rdXZoRHdm?=
 =?utf-8?B?VGo0WVBzdE1IWE9IT3NZeUFxQ08raWZCbUpwVktYS1B2OXdqMk9MSFBGNGJI?=
 =?utf-8?B?WHgvQ0xRZmllSEpVSDlQblJ1c3JYZTArMWtQc21DMWoxbHlMMyt1U1p6K1pm?=
 =?utf-8?B?dWd3VFUwWlBpbTNHc1MzLzZJZ0l0VFpuZzB2eUlIWTlYZkRPeGdqaVIxMHYr?=
 =?utf-8?B?dWJUVXFVNk9YYUh4VThyRmZoZW9lRXRjZ1hjYTBRQ1VlVjdTdmVJanVzZks1?=
 =?utf-8?B?dFJoNDZrd1Rmd0ZXRmRydjArWXZlTkYyYlJTMmlQOFdzUUdPbnZGV1VWTDFC?=
 =?utf-8?B?OWxuYnhSK2dJbXhkSThYWTFxTzJJZktEeWNGNnlVOUoyQ2F6Tk4zR0FuQ2xN?=
 =?utf-8?Q?A/t3y6?=
X-Microsoft-Antispam-Message-Info: qrNBFi0oOh8pZ9YICAr2gD+VzNyZzJ9zedXqTed8n6b51u99+aPl1kJMBC++G3ZXBHnrnrsRI/BLIUtqZiupKtXrjkdI6jjvWRFLnyJ79QLGhWaoT9L40cpLmeSkC5t/s9YJREcGK+G66mejR3a+ZVFED7WvF/+SHPmorxJSXVF7wtwwV3NljZkSb+X0oWIh
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;6:BA/i/JoC1apIxwHdOT630iMfJzZIr75N1o9pXwshmSHYNEa1l6HtLBBPndyHoG2fUPzvKVhBKCQ+An9AVIi1CltWXutUI6YCYa0hT0Jyo9eVMry4HvQhyPY+OIIfqs6I9Iu9SjMT1aonVcyU3fqhpQC5QITb6zTEewZHRagM5pDxFjARiMHUgmVsX+4o2+g8IH+I3TKCwfnpjrLfaqi07zve3dsiOe+lVwuJcTbDd9Gqx6r81hHXDolw7qPCy7tSU1Mhivwk3EH2KgHtOdjtAqQ/uAlhW6hSlOPuc0hY4SX4lzfxiFs/vUqOdqEtCi6m6maTg0cHIyfwQDfmxwJ2hzKlYNd124nGBgKwo/7a2aE=;5:QTj/bVRXw2WI13yFLapbIhIeggHAcm0Jxlu5i3kWVBLvCu8gNjQU1XsP6mCR+54d0QqNh6fpFM1ZJvGCdTbKAVVRlsLfGxuQAzNZ2inKKsIm8Re7MSPC9lFvJTlidLCD6JqV9KAVE8gNjTcxL1uHAYRWD2U5PlScgs3ZgfRnWx0=;24:P4eXQWUoxbhYjv/Q1JajUEZhtOia6xiblCUV3/3MBpyjv5FrNy89Iuwpc4IQHGErMkoPIU6Fg7PhnMzaIK0Sw1yIRXKX31VsoywSuDcrBvI=;7:LSmfeVgMcwFKsHv83bgDmAToZFMryu1Tl961WGFVdnvMW3AJ26H4xTyLQfsPNnb/3hnogF1A8FvCWjvyVsORdciLMALcvxM7ntX56xtZg1e1RWul2gpt+66nVKa2tN9JGGYvvNuTb9vVmgr4piq+7pTJrmYi+FMX80eplWfP1rGvrduhzWVTqPmp7xiqljfVIuKysMuaXhf4hVZJdMzvVUcchTjWf8EO/V0bZobN2ELY9hZYZk6427kF+wTHb2p7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:djSHbnsUrf6JTfuiUCB75Ruk8lNjZAbQuts9Hcq8fqR5PD69t1FbgdDe8PEAgV0wb/pZ6NW/NNCNo1N1WV3mvvD9Y+IsIliNm3xLGMG7AUHIjv+UEa939I2HCou5yp17peqqYjVFdSb9zqm58G0C3Q02d9RfTt1bY3R0TPy1QkBdl27h2reOkDk2tqZEFWkkIv0emqHdpQHMC3Q6mJW4OW8qxCVOlu7jVw8SyClC2Bcuaf8qVkAvk8lhT5Vk7hc5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 14:50:31.8364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa25ed9-d291-4638-268f-08d58da8c3e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2018 5:38 AM, Christoph Hellwig wrote:
> Give the basic phys_to_dma and dma_to_phys helpers a __-prefix and add
> the memory encryption mask to the non-prefixed versions.  Use the
> __-prefixed versions directly instead of clearing the mask again in
> various places.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/arm/include/asm/dma-direct.h                  |  4 ++--
>  arch/mips/cavium-octeon/dma-octeon.c               | 10 ++++-----
>  .../include/asm/mach-cavium-octeon/dma-coherence.h |  4 ++--
>  .../include/asm/mach-loongson64/dma-coherence.h    | 10 ++++-----
>  arch/mips/loongson64/common/dma-swiotlb.c          |  4 ++--
>  arch/powerpc/include/asm/dma-direct.h              |  4 ++--
>  arch/x86/Kconfig                                   |  2 +-
>  arch/x86/include/asm/dma-direct.h                  | 25 ++--------------------
>  arch/x86/mm/mem_encrypt.c                          |  2 +-
>  arch/x86/pci/sta2x11-fixup.c                       |  6 +++---
>  include/linux/dma-direct.h                         | 21 ++++++++++++++++--
>  lib/swiotlb.c                                      | 25 ++++++++--------------
>  12 files changed, 53 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
> index 5b0a8a421894..b67e5fc1fe43 100644
> --- a/arch/arm/include/asm/dma-direct.h
> +++ b/arch/arm/include/asm/dma-direct.h
> @@ -2,13 +2,13 @@
>  #ifndef ASM_ARM_DMA_DIRECT_H
>  #define ASM_ARM_DMA_DIRECT_H 1
>  
> -static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	unsigned int offset = paddr & ~PAGE_MASK;
>  	return pfn_to_dma(dev, __phys_to_pfn(paddr)) + offset;
>  }
>  
> -static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> +static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>  {
>  	unsigned int offset = dev_addr & ~PAGE_MASK;
>  	return __pfn_to_phys(dma_to_pfn(dev, dev_addr)) + offset;
> diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
> index c7bb8a407041..7b335ab21697 100644
> --- a/arch/mips/cavium-octeon/dma-octeon.c
> +++ b/arch/mips/cavium-octeon/dma-octeon.c
> @@ -10,7 +10,7 @@
>   * IP32 changes by Ilya.
>   * Copyright (C) 2010 Cavium Networks, Inc.
>   */
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>  #include <linux/scatterlist.h>
>  #include <linux/bootmem.h>
>  #include <linux/export.h>
> @@ -182,7 +182,7 @@ struct octeon_dma_map_ops {
>  	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
>  };
>  
> -dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	struct octeon_dma_map_ops *ops = container_of(get_dma_ops(dev),
>  						      struct octeon_dma_map_ops,
> @@ -190,9 +190,9 @@ dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  
>  	return ops->phys_to_dma(dev, paddr);
>  }
> -EXPORT_SYMBOL(phys_to_dma);
> +EXPORT_SYMBOL(__phys_to_dma);
>  
> -phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
>  {
>  	struct octeon_dma_map_ops *ops = container_of(get_dma_ops(dev),
>  						      struct octeon_dma_map_ops,
> @@ -200,7 +200,7 @@ phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>  
>  	return ops->dma_to_phys(dev, daddr);
>  }
> -EXPORT_SYMBOL(dma_to_phys);
> +EXPORT_SYMBOL(__dma_to_phys);
>  
>  static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
>  	.dma_map_ops = {
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> index 138edf6b5b48..6eb1ee548b11 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> @@ -69,8 +69,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  	return addr + size - 1 <= *dev->dma_mask;
>  }
>  
> -dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
> -phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
>  
>  struct dma_map_ops;
>  extern const struct dma_map_ops *octeon_pci_dma_map_ops;
> diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> index b1b575f5c6c1..64fc44dec0a8 100644
> --- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
> @@ -25,13 +25,13 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  	return addr + size - 1 <= *dev->dma_mask;
>  }
>  
> -extern dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
> -extern phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
> +extern dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
> +extern phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
>  static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
>  					  size_t size)
>  {
>  #ifdef CONFIG_CPU_LOONGSON3
> -	return phys_to_dma(dev, virt_to_phys(addr));
> +	return __phys_to_dma(dev, virt_to_phys(addr));
>  #else
>  	return virt_to_phys(addr) | 0x80000000;
>  #endif
> @@ -41,7 +41,7 @@ static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
>  					       struct page *page)
>  {
>  #ifdef CONFIG_CPU_LOONGSON3
> -	return phys_to_dma(dev, page_to_phys(page));
> +	return __phys_to_dma(dev, page_to_phys(page));
>  #else
>  	return page_to_phys(page) | 0x80000000;
>  #endif
> @@ -51,7 +51,7 @@ static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
>  	dma_addr_t dma_addr)
>  {
>  #if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
> -	return dma_to_phys(dev, dma_addr);
> +	return __dma_to_phys(dev, dma_addr);
>  #elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
>  	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
>  #else
> diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
> index 7bbcf89475f3..6a739f8ae110 100644
> --- a/arch/mips/loongson64/common/dma-swiotlb.c
> +++ b/arch/mips/loongson64/common/dma-swiotlb.c
> @@ -63,7 +63,7 @@ static int loongson_dma_supported(struct device *dev, u64 mask)
>  	return swiotlb_dma_supported(dev, mask);
>  }
>  
> -dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	long nid;
>  #ifdef CONFIG_PHYS48_TO_HT40
> @@ -75,7 +75,7 @@ dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  	return paddr;
>  }
>  
> -phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
>  {
>  	long nid;
>  #ifdef CONFIG_PHYS48_TO_HT40
> diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
> index a5b59c765426..7702875aabb7 100644
> --- a/arch/powerpc/include/asm/dma-direct.h
> +++ b/arch/powerpc/include/asm/dma-direct.h
> @@ -17,12 +17,12 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  	return addr + size - 1 <= *dev->dma_mask;
>  }
>  
> -static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	return paddr + get_dma_offset(dev);
>  }
>  
> -static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> +static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
>  {
>  	return daddr - get_dma_offset(dev);
>  }
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 10f482beda1b..1ca4f0874517 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -54,7 +54,6 @@ config X86
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_KCOV			if X86_64
> -	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_PMEM_API		if X86_64
>  	select ARCH_HAS_REFCOUNT
> @@ -692,6 +691,7 @@ config X86_SUPPORTS_MEMORY_FAILURE
>  config STA2X11
>  	bool "STA2X11 Companion Chip Support"
>  	depends on X86_32_NON_STANDARD && PCI
> +	select ARCH_HAS_PHYS_TO_DMA
>  	select X86_DEV_DMA_OPS
>  	select X86_DMA_REMAP
>  	select SWIOTLB
> diff --git a/arch/x86/include/asm/dma-direct.h b/arch/x86/include/asm/dma-direct.h
> index 1295bc622ebe..1a19251eaac9 100644
> --- a/arch/x86/include/asm/dma-direct.h
> +++ b/arch/x86/include/asm/dma-direct.h
> @@ -2,29 +2,8 @@
>  #ifndef ASM_X86_DMA_DIRECT_H
>  #define ASM_X86_DMA_DIRECT_H 1
>  
> -#include <linux/mem_encrypt.h>
> -
> -#ifdef CONFIG_X86_DMA_REMAP /* Platform code defines bridge-specific code */
>  bool dma_capable(struct device *dev, dma_addr_t addr, size_t size);
> -dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
> -phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
> -#else
> -static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> -{
> -	if (!dev->dma_mask)
> -		return 0;
> -
> -	return addr + size - 1 <= *dev->dma_mask;
> -}
> -
> -static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> -{
> -	return __sme_set(paddr);
> -}
> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
>  
> -static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> -{
> -	return __sme_clr(daddr);
> -}
> -#endif /* CONFIG_X86_DMA_REMAP */
>  #endif /* ASM_X86_DMA_DIRECT_H */
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index d3b80d5f9828..1a05bea831a8 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -216,7 +216,7 @@ static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		 * Since we will be clearing the encryption bit, check the
>  		 * mask with it already cleared.
>  		 */
> -		addr = __sme_clr(phys_to_dma(dev, page_to_phys(page)));
> +		addr = __phys_to_dma(dev, page_to_phys(page));
>  		if ((addr + size) > dev->coherent_dma_mask) {
>  			__free_pages(page, get_order(size));
>  		} else {
> diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
> index eac58e03f43c..7a5bafb76d77 100644
> --- a/arch/x86/pci/sta2x11-fixup.c
> +++ b/arch/x86/pci/sta2x11-fixup.c
> @@ -207,11 +207,11 @@ bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  }
>  
>  /**
> - * phys_to_dma - Return the DMA AMBA address used for this STA2x11 device
> + * __phys_to_dma - Return the DMA AMBA address used for this STA2x11 device
>   * @dev: device for a PCI device
>   * @paddr: Physical address
>   */
> -dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	if (!dev->archdata.is_sta2x11)
>  		return paddr;
> @@ -223,7 +223,7 @@ dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>   * @dev: device for a PCI device
>   * @daddr: STA2x11 AMBA DMA address
>   */
> -phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
>  {
>  	if (!dev->archdata.is_sta2x11)
>  		return daddr;
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index bcdb1a3e4b1f..53ad6a47f513 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -3,18 +3,19 @@
>  #define _LINUX_DMA_DIRECT_H 1
>  
>  #include <linux/dma-mapping.h>
> +#include <linux/mem_encrypt.h>
>  
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>  #include <asm/dma-direct.h>
>  #else
> -static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	dma_addr_t dev_addr = (dma_addr_t)paddr;
>  
>  	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
>  }
>  
> -static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> +static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>  {
>  	phys_addr_t paddr = (phys_addr_t)dev_addr;
>  
> @@ -30,6 +31,22 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  }
>  #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>  
> +/*
> + * If memory encryption is supported, phys_to_dma will set the memory encryption
> + * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
> + * and __dma_to_phys versions should only be used on non-encrypted memory for
> + * special occasions like DMA coherent buffers.
> + */
> +static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	return __sme_set(__phys_to_dma(dev, paddr));
> +}
> +
> +static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> +{
> +	return __sme_clr(__dma_to_phys(dev, daddr));
> +}
> +
>  #ifdef CONFIG_ARCH_HAS_DMA_MARK_CLEAN
>  void dma_mark_clean(void *addr, size_t size);
>  #else
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 005d1d87bb2e..8b06b4485e65 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -157,13 +157,6 @@ unsigned long swiotlb_size_or_default(void)
>  	return size ? size : (IO_TLB_DEFAULT_SIZE);
>  }
>  
> -/* For swiotlb, clear memory encryption mask from dma addresses */
> -static dma_addr_t swiotlb_phys_to_dma(struct device *hwdev,
> -				      phys_addr_t address)
> -{
> -	return __sme_clr(phys_to_dma(hwdev, address));
> -}
> -
>  /* Note that this doesn't work with highmem page */
>  static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
>  				      volatile void *address)
> @@ -622,7 +615,7 @@ map_single(struct device *hwdev, phys_addr_t phys, size_t size,
>  		return SWIOTLB_MAP_ERROR;
>  	}
>  
> -	start_dma_addr = swiotlb_phys_to_dma(hwdev, io_tlb_start);
> +	start_dma_addr = __phys_to_dma(hwdev, io_tlb_start);
>  	return swiotlb_tbl_map_single(hwdev, start_dma_addr, phys, size,
>  				      dir, attrs);
>  }
> @@ -726,12 +719,12 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		goto out_warn;
>  
>  	phys_addr = swiotlb_tbl_map_single(dev,
> -			swiotlb_phys_to_dma(dev, io_tlb_start),
> +			__phys_to_dma(dev, io_tlb_start),
>  			0, size, DMA_FROM_DEVICE, 0);
>  	if (phys_addr == SWIOTLB_MAP_ERROR)
>  		goto out_warn;
>  
> -	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
> +	*dma_handle = __phys_to_dma(dev, phys_addr);
>  	if (dma_coherent_ok(dev, *dma_handle, size))
>  		goto out_unmap;
>  
> @@ -867,10 +860,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  	map = map_single(dev, phys, size, dir, attrs);
>  	if (map == SWIOTLB_MAP_ERROR) {
>  		swiotlb_full(dev, size, dir, 1);
> -		return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
> +		return __phys_to_dma(dev, io_tlb_overflow_buffer);
>  	}
>  
> -	dev_addr = swiotlb_phys_to_dma(dev, map);
> +	dev_addr = __phys_to_dma(dev, map);
>  
>  	/* Ensure that the address returned is DMA'ble */
>  	if (dma_capable(dev, dev_addr, size))
> @@ -879,7 +872,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>  	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
>  
> -	return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
> +	return __phys_to_dma(dev, io_tlb_overflow_buffer);
>  }
>  
>  /*
> @@ -1009,7 +1002,7 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
>  				sg_dma_len(sgl) = 0;
>  				return 0;
>  			}
> -			sg->dma_address = swiotlb_phys_to_dma(hwdev, map);
> +			sg->dma_address = __phys_to_dma(hwdev, map);
>  		} else
>  			sg->dma_address = dev_addr;
>  		sg_dma_len(sg) = sg->length;
> @@ -1073,7 +1066,7 @@ swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
>  int
>  swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>  {
> -	return (dma_addr == swiotlb_phys_to_dma(hwdev, io_tlb_overflow_buffer));
> +	return (dma_addr == __phys_to_dma(hwdev, io_tlb_overflow_buffer));
>  }
>  
>  /*
> @@ -1085,7 +1078,7 @@ swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>  int
>  swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  {
> -	return swiotlb_phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
> +	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
>  }
>  
>  #ifdef CONFIG_DMA_DIRECT_OPS
> 
