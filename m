Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754442AbeDBVMx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:12:53 -0400
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:46637
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753218AbeDBVMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:12:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCHv2 01/14] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD
 SME
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-2-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <3513ea99-eb16-6538-ea3b-148fe5d85f21@amd.com>
Date: Mon, 2 Apr 2018 16:12:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328165540.648-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To BY2PR12MB0164.namprd12.prod.outlook.com
 (2a01:111:e400:585a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6854790-45d9-45ee-7f79-08d598de7b74
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0164;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0164;3:AFCXsyravSb8rR+1E9swEviSb77sBYA4vetIPWmLcQORjCnYnqJOpP2Q5WN+13z6vpjJ0HmUKCFoqUP6ior9B3B71ttljgFy5/Jdow3SfP/sQqObGdLpEyfu7T2a8GVdHpRrOZG96URzesRi4OBpCPVIcqpAZYMJslecgq4LMQaEGiPyEtj2CLD3J1Eq7+994Qzxhk5W1+PbmLnlWLPtGRkIjoXmB/U/eLpvfelcEFoo8OVEXUNCEq89vV6km2G0;25:mXY/nICjPcnPjbCYh1+AVIjvo/yxktqe/TY5dcyowke6+oPnNEwMP5g+mWtC7Z5va6ZpcXhOm50xLTkORZyVqWfZ0Xin+uH4kQB//4NldNRl8KS62ebDTM2+kHHlImLWe37mAo64enzgFVQ54oe40ZB602/c9+O6QaUVZlyM9WnbeJAUoqbJkYHFqDQoiSYIoPM1Ize+TUUp+HGCwZdXp6HthGOMQjJqD7FkJfT+yv/3utCxupx6vYZYYvntFtnHXspdNpUPie/vMe1qtOZzh+rcFi+memZXT4tI71tJs+WxLXCYLLtiwncek7dWLrtIdJmia9rpDrUkfD10R8CudA==;31:ty9bNlwJpHBK8qAG34DMfUO/ObNXmnWpyhMgm582nHPi5hjfzcDHGssshoxqFPcsO9sRiG7EE1OliQJ+D/+ZWCjw95vKLGeI3TlrRL3l2ZE4++lTcHOAODjTtgZh1stA8DSn5DfPzfuFXOmi/aZsVvdScsDkI5EO8SMh7dEJGANmFqKzFBUQ0POYr5t63wd/NXAOlzWtDfRfiQzyzvmbZazUOBuIm5gPETHtARem5Q0=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0164:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0164;20:9s23LPhwToMyo7axAj4olK8nwMZJbcZa09pyl4LYOQJWah3wxgfY/sU23BXQES8bHxwusfKUTvau7y1h3RnzHx8j9r86EfzTU+7pAvVw/vczgLC5klZzdu50NhtPxmmufwbiA5/cJoHq/QBmJM+sSu5aAJiohzJO8CJD4ODPXVPgj5ZJP31/ZBRRVh6oeeXoZcnFqTtIOUIVpYNrB5VEXboM0gzccgyEu45Ri+1/SWQr6yluS/Jc+FOwooGkGvoiTPAGhFHYakcQny9Q+cz7kCcdp4tJAoVUBOUgidx1n1C5Y0hmmcOV/3PfwY/LGhngbuid4ryTdwhzKKxa+lrodPnJdET6MI219qG6FHTOLo8DeSbLi+UopyF6svxop0WzGARJ7Ikm47l0a92+qsEWcm4prJQRLAj5k40qYVqrOrdx8XO6aiDbM+WOC/XWEGij5dFcOt16fTyyxC/44FCLzbIzB61362h/GiDhwyQlJyPzgoIgetbGOTEgCn+UYRBu;4:WBQSVdrVZI0yKN5u/FHmT9SMh41w4JYiSyH/otrfS0/GYUEgxKbb5JIhXfFKwZAV073MYU+UFaIhcyL/uO183GN0RS/BskgS5lC22OS74yGmrbkJmlodPOngOm/Tyim/l1u5zkLw0CIBZojRfrBUpQmCB8eyVq7yOJvJuM0kSb0EvvKvj70prl0K8eIiaQUSIPtddbCcCnUHQ7hg5d68g85vb78uSFCaSxzjiFZnfgPwNE30a65F9cw+8828siNqfVSNXl0nx0yoqfd4VfcdkAqyU1k2TIGvNjagykOyrxJT+OYURQbumBRjE/4n/oQugZzbpUU9tj7Q2fP+u9+sxw==
X-Microsoft-Antispam-PRVS: <BY2PR12MB0164BCF7155A5632C7B7378EECA60@BY2PR12MB0164.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR12MB0164;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0164;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(66066001)(31696002)(52146003)(52116002)(305945005)(23676004)(2486003)(53936002)(7736002)(86362001)(58126008)(316002)(110136005)(476003)(486005)(77096007)(11346002)(446003)(386003)(186003)(16526019)(76176011)(68736007)(6246003)(25786009)(59450400001)(6486002)(486005)(4326008)(16576012)(97736004)(65956001)(5660300001)(229853002)(3260700006)(26005)(53546011)(956004)(2616005)(65826007)(47776003)(65806001)(478600001)(31686004)(64126003)(105586002)(36756003)(54906003)(6666003)(6116002)(2906002)(3846002)(230700001)(8936002)(81156014)(72206003)(50466002)(106356001)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0164;H:[10.236.65.235];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMTY0OzIzOi9CM3ZuWGc0MzlUbmZjeGJGN0dnUi81UjFa?=
 =?utf-8?B?Z0t6cENxU2x3RU04L1htMGJhSW5WWktrcnU4bzZhM25FWlZSNTBYQVdrWUU5?=
 =?utf-8?B?UElTTzZMSTdGVVIwdEtRdGVsSWZ5VCthWmpDbGJJaFQrL2NyQjNoQzVJd3pZ?=
 =?utf-8?B?LzRQSkNXMzcrbUF4ekVXMGdDM0MwbngvT0VENituYVhlVy92L3JvUFdSME85?=
 =?utf-8?B?RjlrOHZHeWRGUGoxY3hrd2lpK3ZNWXNRb1hnSzM5bHBHQmhZTHd5aC9lRU8v?=
 =?utf-8?B?aUFGS1JqeTVuUUNRTHpKSlpnUFN3Q2x4ZE5HRzA1KzlEUFkza2IxUFNXb0Mw?=
 =?utf-8?B?bkNWNDUxcUJuS1Zzd2FvU1JSNXVmTHBZSWpXVW93WDc2blB2alA3NHZoM0J1?=
 =?utf-8?B?d3hrbmxWc0Z2MCtZaDZjQU5sWXFtbW9KZHhWRC9HNWJUVW5MS016VDErRXpy?=
 =?utf-8?B?dnQzZS9vWCsybXFTemJxSXowNElGRCtnRzlUV2NSa203ZHNHcVZyQ2RIVWVx?=
 =?utf-8?B?Wk80VlRBY0tBcWtQL095dDFsSHV5YUpPdVVaeVNrMXV2YXdnTkcvTnN4YUIz?=
 =?utf-8?B?bjdpdHl1dlI5MnJCb2IxY2gycDcxM2RTOWJPdWU4aG8vRE9QNitnS2tqQTBz?=
 =?utf-8?B?UFZrZlR1SlVJQlZKZGNHVXlsWDR2SWxRVUs4VU9QM24vR2JSYzNwc1N1NDRU?=
 =?utf-8?B?dWdFdXk3VFRENTVSc1pCU2FVR21ORFBCclRUaFVzb3ZNSVNMRXN6VlliZ1Ar?=
 =?utf-8?B?NVhmdTROK3E5NFRtUjZ3MjlSQndsTTR1Ky9SRXhjMVZEdUFpVXlsazArSE82?=
 =?utf-8?B?Z0NsNGtselBQRVUyWmFobmhIbzdNTkMyVEVxMzh2Z2toYnZpSFhiMXkxNjBJ?=
 =?utf-8?B?cEVzRXkxTGVPdDU5Mk5PK0lLb3lkRjkxOS9qbVdpRGtZZUdWUEdZVU54WGJr?=
 =?utf-8?B?YTZZbmZJWHBKMW16UWI2QzVZbG43SFJ4V0lpa3JMT3B4MUMzOUJWZU1lczJY?=
 =?utf-8?B?WnVUb2EzbWZoZTRtdUMwcmxXWFhvS01mOWdhcE5PTlE4QVhWSi9Kb3NKZmEy?=
 =?utf-8?B?Nm9XOUNxZmFlNE9WS2lRVDdMaysxYjhKYWoxTFF2QVhEd1NsbkZMRVMxLzdl?=
 =?utf-8?B?UVFCS3Z0WXN2Y0VjTDduT3VHcm9uZmJQQWVpMjFaZTRtTTNaUklUdklUR0Y5?=
 =?utf-8?B?L3dtUzJkYWFGbGVFdC9MR1ZleEMwMWpTMEZRKzJTWEpMOHFzbklzZmRJdDF3?=
 =?utf-8?B?a09Jem9hZk5XNlpZaVdiQVRRakdXeHRoZFBZQllmQlRwanlYOXVvdEhXRmYz?=
 =?utf-8?B?TTlkeE11WXBlakZRdGtpdDRvQ0V2ZXRKanQ3VzV5a1RhYnFhQnlTdWM4cG5x?=
 =?utf-8?B?SGdxKzdpZ3hFK1BhNk5wYTRaMm9mckl2VXk5SFExVU8rTVduWW5aclF6VFBD?=
 =?utf-8?B?UVoyQ2owYWZGOEhGMlJ3SCtjclYwNUVqakFmalNSb2dBZ2UrSDZWdFVMTysz?=
 =?utf-8?B?OEt6T2tXa0d2Q1hrQnBHSHRVd2FhWnhSYmVISEZOOEdTQnBoSldQM2RBNTJN?=
 =?utf-8?B?N3BXNWNueGU1a3RveXFJWndJZUFpMjhjVHB1UGxKK1l4TTBhd1EwdzRXcGR1?=
 =?utf-8?B?RUxZY0NFL3Q0c0ZvZVJoWmQ4YU1QNFRrS3MyNGQ0b2lScUg4U2JQL09sa0wr?=
 =?utf-8?B?TTdGak5CNURHd3dMdGpMOGpIQVVQdE9SdTZuQ20zb3lNSmRDcE5FME8wbGF5?=
 =?utf-8?B?aUFHOUhWbFpuaExOTG81NXhQeG0vVW4wSEFBTmNWelVjZUxOcG9JT3NIbEg4?=
 =?utf-8?B?dHVUVlFHT1JNL1ViMlp0VU4wVDUwd005YjU2d0ZTT2M3Y24xYUxzMzQxZTFa?=
 =?utf-8?B?bTVBekk3dEtpMmJ3dmNEak1VeUwrOE45d0k3RVpPNCsxVVc1R2ZsQmJ0Mnhx?=
 =?utf-8?B?Y1FyeUlPdDBrNXBPektNcWo1RlBGWmxUT2tucEcwdC9NTG1yYzlHTkRKeVpL?=
 =?utf-8?B?ODgrb2VEbTd1UGpiMk1hVDdncjB6dW5aR1RUWnNhcXplUE5rNExMQmUyNFcx?=
 =?utf-8?Q?Op3MVM3nJQr4i0fcZRSYyNGPZ?=
X-Microsoft-Antispam-Message-Info: /ZkBXaWb+i6uNKhR5fWxbyrDWxvI/M8UHOps5SI7EF/fdfHog1EC2EV9kgBo3HZgaLXq7t0AZ93Xkq5iQ1gUBtpva5JO7wvxGUGJKrNpF16k/gC0uQfi6XI5KM9uZtgQb8SzTlrKjAC/Uxn3R96X/24HHwWXOfPwnAcMxbZHl71/Lg912EBv6OKsE6hH1xHF
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0164;6:/rDDcvtfEUKxORSpw/cngoVl+FGT2VRQNjRxxwJT/VjJzvjOptF8R/ARw14Rol2SwBPfLwRf2uI93/Sd4yRSadrHZdkRx4HcB3FvpTRG5borGMqSmuUslxS2lV9fd3wZdchTFcQhuKxZKvRavJxUjrCuFcg3WedW9iXPKYMtCNTT0feqC1Eh2YYvXJ/HZ6tLMkIUOTF9TkhcgrawFbC3BebQwXlaMWMI8jkMK7eK1M6O6hxdUaoKfJjAjBki6LIQtkDlvBVR+dFQzg8HimeJ9Je8eV5Ut4pO6vSblWpC4yrOCkOrVpQKgYp2C4ZBIlHlfWEgMwmgUIR1coc+M8X6am69oQxqC8aGK8jTyz9l1sYZ1CJrktR0/Ih9xWsVCi1sx9xQEFZJcUHgwgNj6Xlz8wdtD24LCgHSiACLZQmaxHGXvY6lZU1iTr11cMwdHRioKb3kZVxWDZoY4NixwZnFTA==;5:Gy6lEJZiZhuQ19P5ApUZgdu45L57V/ezteZrz1coxxvxYphV2l9iJmT8/tzpk+szKxq9zCel84glpU/fsv/k20/PNjg/5CGhEBlH/p2cTYRVyrmRC8k1FNvNBdBpMUy5o6AHyexrOUawSKRfP1T+RxBvjy7l3wkNUEdqOnDhQo0=;24:YRNoJoMFZ7GIMq+Nk1dRgDjtVtnlZmeui+CEOpHGM4OBQoOLUb6rRne8PYfOHMZ/5gp+V1YATzBFGA7PjYt9CBvFZTsHMifCZo9/N8dMtjc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0164;7:610ajxAvelpjTGAfpEEfGtxp+mUklwVUtws7rw/ShFNtONXDyq/GuyyrK0O55KQCXz1QTeAaUzQjD8bPgqzYNlcIWz5YLAL3S3G0SNVxw2EhBy18Zp3nK9W5h8jpR9qfVijUBPf0D7Od64R/NUlVE9m2BK5XbazCsJ+i9KJkpJY5t3KWNdZyOXJ2fZwIDiQre+pscOoxuU2JN+9Qu5MFU7RgdJ4ZpzqaQvw4jRpR3iWXs4rxj9GKk9cxqEx33ufC;20:Ts7IiS30u6WN3VTx3fDSe40kGT+m5Mjtpyz+sEI40YxezQEqWm3IBf7DXY3GUBSzMW6TXcwMCQ5BFZuWTHl7bafiUms7KCVtJiOa+BMEgSBtU+e0Fb47TDSV8OvsbjNnZkdznm2bcouqewx/9hj8E10sqDS8ehg3OnYMf8y73pVpMm7NMlID3nkzIQR18xK5oBAuwPEGJEOAXsK6dNg/xfQqsfco3aNZbnVbP5dLGUCGZukqB9q2Cw18tJYlxLRW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 21:12:45.3739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6854790-45d9-45ee-7f79-08d598de7b74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2018 11:55 AM, Kirill A. Shutemov wrote:
> AMD SME claims one bit from physical address to indicate whether the
> page is encrypted or not. To achieve that we clear out the bit from
> __PHYSICAL_MASK.
> 
> The capability to adjust __PHYSICAL_MASK is required beyond AMD SME.
> For instance for upcoming Intel Multi-Key Total Memory Encryption.
> 
> Factor it out into a separate feature with own Kconfig handle.
> 
> It also helps with overhead of AMD SME. It saves more than 3k in .text
> on defconfig + AMD_MEM_ENCRYPT:
> 
> 	add/remove: 3/2 grow/shrink: 5/110 up/down: 189/-3753 (-3564)
> 
> We would need to return to this once we have infrastructure to patch
> constants in code. That's good candidate for it.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/Kconfig                    | 4 ++++
>  arch/x86/boot/compressed/kaslr_64.c | 5 +++++
>  arch/x86/include/asm/page_types.h   | 8 +++++++-
>  arch/x86/mm/mem_encrypt_identity.c  | 3 +++
>  arch/x86/mm/pgtable.c               | 5 +++++
>  5 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 27fede438959..bf68138662c8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -332,6 +332,9 @@ config ARCH_SUPPORTS_UPROBES
>  config FIX_EARLYCON_MEM
>  	def_bool y
>  
> +config DYNAMIC_PHYSICAL_MASK
> +	bool
> +
>  config PGTABLE_LEVELS
>  	int
>  	default 5 if X86_5LEVEL
> @@ -1503,6 +1506,7 @@ config ARCH_HAS_MEM_ENCRYPT
>  config AMD_MEM_ENCRYPT
>  	bool "AMD Secure Memory Encryption (SME) support"
>  	depends on X86_64 && CPU_SUP_AMD
> +	select DYNAMIC_PHYSICAL_MASK
>  	---help---
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
> index 522d11431433..748456c365f4 100644
> --- a/arch/x86/boot/compressed/kaslr_64.c
> +++ b/arch/x86/boot/compressed/kaslr_64.c
> @@ -69,6 +69,8 @@ static struct alloc_pgt_data pgt_data;
>  /* The top level page table entry pointer. */
>  static unsigned long top_level_pgt;
>  
> +phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> +
>  /*
>   * Mapping information structure passed to kernel_ident_mapping_init().
>   * Due to relocation, pointers must be assigned at run time not build time.
> @@ -81,6 +83,9 @@ void initialize_identity_maps(void)
>  	/* If running as an SEV guest, the encryption mask is required. */
>  	set_sev_encryption_mask();
>  
> +	/* Exclude the encryption mask from __PHYSICAL_MASK */
> +	physical_mask &= ~sme_me_mask;
> +
>  	/* Init mapping_info with run-time function/buffer pointers. */
>  	mapping_info.alloc_pgt_page = alloc_pgt_page;
>  	mapping_info.context = &pgt_data;
> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
> index 1e53560a84bb..c85e15010f48 100644
> --- a/arch/x86/include/asm/page_types.h
> +++ b/arch/x86/include/asm/page_types.h
> @@ -17,7 +17,6 @@
>  #define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
>  #define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
>  
> -#define __PHYSICAL_MASK		((phys_addr_t)(__sme_clr((1ULL << __PHYSICAL_MASK_SHIFT) - 1)))
>  #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
>  
>  /* Cast *PAGE_MASK to a signed type so that it is sign-extended if
> @@ -55,6 +54,13 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
> +extern phys_addr_t physical_mask;
> +#define __PHYSICAL_MASK		physical_mask
> +#else
> +#define __PHYSICAL_MASK		((phys_addr_t)((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
> +#endif
> +
>  extern int devmem_is_allowed(unsigned long pagenr);
>  
>  extern unsigned long max_low_pfn_mapped;
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 1b2197d13832..7ae36868aed2 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -527,6 +527,7 @@ void __init sme_enable(struct boot_params *bp)
>  		/* SEV state cannot be controlled by a command line option */
>  		sme_me_mask = me_mask;
>  		sev_enabled = true;
> +		physical_mask &= ~sme_me_mask;
>  		return;
>  	}
>  
> @@ -561,4 +562,6 @@ void __init sme_enable(struct boot_params *bp)
>  		sme_me_mask = 0;
>  	else
>  		sme_me_mask = active_by_default ? me_mask : 0;
> +
> +	physical_mask &= ~sme_me_mask;
>  }
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 34cda7e0551b..0199b94e6b40 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -7,6 +7,11 @@
>  #include <asm/fixmap.h>
>  #include <asm/mtrr.h>
>  
> +#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
> +phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> +EXPORT_SYMBOL(physical_mask);
> +#endif
> +
>  #define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
>  
>  #ifdef CONFIG_HIGHPTE
> 
