Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDQRqW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:46:22 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:56800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751232AbeDQRqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:46:20 -0400
Subject: Re: [PATCH v3 1/2] iommu - Enable debugfs exposure of the IOMMU
To: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <9123cd44-e01f-bff6-8441-792acbde10bc@amd.com>
Date: Tue, 17 Apr 2018 13:46:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152302066417.47565.4017200105445420643.stgit@sosxen2.amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:404:8e::28) To SN1PR12MB0701.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0701;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;3:LX+1DBunpjyZdCBYQ6lWenTYyIJdB1s7UAN3iKOI1ZBlKKY03v9WIQ9ChuLFU4/pUTeD3/ty36i5Q7/92169BGDDAWf6rp1Ks5lFO6ScNvnQcFHGAehyaXrW++4Jvw2+EDb2EBQOg1iLnVn9Be874C2f8Q0YaTaiNZ/npkLkJRe2TGBGhqXHtT5nt9N6NZazZ2RZYu5c7k6WE95YPx6T79svEujykPJw5AekkERrVj4HPgq83F2pgaDrLwxG1dnl;25:AVbPzLeMCmntaw3AKuGPhXd9m1DEPgISMbeT2iol5q5ZusuN8FYlSCIVRm+7ovLSdbAY9VSuUoyA+Fa8Z3vfWf/ts+38XOlsTniaxXNDAaFE5PptdTtC1ItQyAmS+fErLfdvdX/xXui+wK4hEoMU2uNS2KoUtFtkwcPw6YSuYTxPoKC1J2UPHRrp6SZ2Jh2zfybpoZmusBTuIQqkhtFOBQ/xozG0YcL8zXCXxxPCj6qrpe6D/ubVgS47Dvg5BEqtdZYC1IdVojyTuGYkZlbw5Xbk4iEMcTTCSPjUznPnzkehfpSWWIxZ1vkhZB7jPKkKkiidQEjhGiN5hZt2cpEYBw==;31:3e2cAAtBLbAkxpjs3G7xtUv8pjuLvAjypLAK0Ucq78Xtjw9Ljz63ry7M+QILgcK2qwBv5CFQas6GzRBJgM3lDMA33lzalwtMK9jxkhlqrQb5ljKUIzPCV339kBOsuBPRwjDrI5wQMEtNoZDXvdEXJ3e54ux1KHE18B6ieKexXEb1ogtJfhVrhsf5khw+1XE5QEW0ds7nh5Wqhk0Qfim2/V+sAbCP2vt7+cH+48+e4Zk=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0701:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;20:Dvs+ZyWGKuWO9eTXFS1667SccJtWYhmdDBxxhR2dXeTqZ8QgpmivX0et/2xXVAVXjhs88zceruTn1TGHEpQIzgfAKiBBnyFiTnSD3NSO1wwDE58a+eismuUvyqt1E4Gkmsq8WomBDcMHiwcl+ysM6yWXnSd1J8LCHC7v7WPq7JvKsKNXMGHdSO5a12lvB+ceys+EHH9Go7avZnV54SlcirsXWdEfiMRWJ2oS0d+gWNB62yoIEoxwwilkWQdOZJh5/e20pAUWSFy4DMPF17yr75NgwEVmSwyldSBUxQBnTTJoQUdp0UNsgAlKhTrmlUWYpG4eXqUmaJwygrGmpGRHhEHE/Nj7iIs/i1GyYyuLBF/9fP+oYUz8nUwykijrgQSokpSy/G7vNv2k9lPlhvWA7zro1Ulmoh19n/l+Qt2CpppQxOrj8kXR/982K2x4BGmNPaTmULmqzoELkCknVGAl4ghsSEWYmjencAfi4NL5Z4rSaZCdk6njm5uU15d3cz00;4:yA3vh8LsOdmvY3fgmRxdvVcv/EhDgVNtSIFFlV14lc28yZKWpj/Nh7HyNC63U9sY9fGZkbWLPpEBCOGYr2VytmocSgWpb9ReBh7n88EzD4l8SEzdW1Bz12e+S33W2Z1dxqgOsTDPuzfmhxLd6citVutMGZqEC/k/3fFdIq9ytHB9YHYRFcnndidHsAXbnIFmNcCD7pwefSVJaIU20u9R/KefIR5e5r5QPr2GnZMQP41eeTKxyqIPjrL4haweyUEmEAOEeHyCCaI4J53ilIK4fNHIcTWH9+zbs5CPLOW2qbcpMRzhZ3D1tbRfWwwshf9T
X-Microsoft-Antispam-PRVS: <SN1PR12MB0701C2C6733F5C3EA6120AC6FDB70@SN1PR12MB0701.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501359)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0701;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0701;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(189003)(199004)(16526019)(2906002)(31696002)(106356001)(67846002)(97736004)(7736002)(4326008)(305945005)(64126003)(72206003)(6666003)(66066001)(478600001)(8676002)(47776003)(8936002)(65806001)(65956001)(6486002)(81156014)(186003)(77096007)(26005)(81166006)(53546011)(65826007)(229853002)(16576012)(11346002)(2616005)(36756003)(956004)(316002)(59450400001)(53936002)(446003)(486006)(5660300001)(3846002)(50466002)(6246003)(6116002)(386003)(58126008)(230700001)(52146003)(105586002)(52116002)(31686004)(2486003)(476003)(23676004)(76176011)(3260700006)(25786009)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0701;H:[10.224.10.182];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAxOzIzOnQ3R3ZlbmNVTzFSdWhFT1RwcERPTm0rNTJE?=
 =?utf-8?B?N2pFT3RhMGw0ci9qV0VTRCtEVm5GamFuOGxXcEJRYzB0RkREVHRvRVB3UWwy?=
 =?utf-8?B?ajl0ZW5BSVpSTENGaEFESUZZSWF4MmFOMGpaSzdRVnQ0QWhCNi9VY3BmN0xY?=
 =?utf-8?B?ai8zblBST0tCaFVHOU9vSjBPNlZ2eXplK3R2NStlQjhxbzdHdndlSVJjemY4?=
 =?utf-8?B?NmRjTmdQUG1XeEs0c002d0dOMFp2YitSd296M1FQQmhPNjgyNkpPT3A2ZDZK?=
 =?utf-8?B?Z3BZWm0vRm1oOUtBUmh0NVY0RDVCR21ySFptWHVqSTFBaEtyNjBvNVVxN0JL?=
 =?utf-8?B?QkVOMUJnU0NjcVlCUWFoNHdDYlFHUmlMcFZ5SVU5NXJCdVN0NHpEY1R1Undo?=
 =?utf-8?B?ZE13QUJkaFBNRHovc1FIemlRaHVqMlk1ck4xWk9RL3ROS1kxd0hhSGlsMzIy?=
 =?utf-8?B?Wm55QUxQU2sxNlBoVTZSUzRGRmNDQ0lFUXJHMDZORUJNZjVGN1NtRm5oV0Nn?=
 =?utf-8?B?M2tHWkNpUWlJa3B6NUx0UEVtaFZrS2N3aUNIZVMvYmZ1Vk0xaHZNRnJReDA3?=
 =?utf-8?B?WjVrZGVWWWdDdWI2Y3RaNzU2ZjBkam8rc2JlMjZ1bHo3bTJqV3lKQkdpZFFZ?=
 =?utf-8?B?VjkyUC9mSi81UFRBV2lQREg4VXBrQ3Q4MUFOWU0rTHk3Lzh1NDYwVDNKbGJn?=
 =?utf-8?B?ZE5CNjZRcjZkMTU3bmZQTmw4RHI0N21MMlh2U1ZTTENkTG1tYllwMEhpQ1E4?=
 =?utf-8?B?OVBoa1J1Sk1EUndORmJuNW9vaUdMMzdla1Bpek1BT3o5KzFPSEZOVkFwYXRH?=
 =?utf-8?B?VXZLMEY5cnc1Y05VMTdnZCtGZzNkUGFyUHg1QU82bXMyZmJyaXJEYkRMU3NH?=
 =?utf-8?B?aU02dWZMcm8zQ0xEcEhuZlFTbjJWcFRjWmpONUw2U2IrZGhnN1lMUzloMG56?=
 =?utf-8?B?cmRjb2pMa1lTMTZSUVduWWZjY0EwOXJUNmdkZXZFai9HY2h5YWsrbEpWYm9j?=
 =?utf-8?B?cVBLMGRaMzUrVTZmc21Qd2krQjhNMEY3SnZMYVpMTzF3NnBLZjdQNWFTL2pM?=
 =?utf-8?B?VE5YQi9VTWZ4Yk1lc3VVUGZwZ2lGWFNSUkxRamFNYi9HaXgwUFFiV2p0S2NS?=
 =?utf-8?B?MWRjY0lEN0lxZzRlZ0xYcUVmZlprOTQ3bEJzQVR4MEJ5bDFKQ1FPNXR3eVdQ?=
 =?utf-8?B?emc1SGQyd0dLcWpHZnJIWi9IUURFVWFHLzcwbTV6YTdaMVZ1dHZDN2V6QWRj?=
 =?utf-8?B?UGU5dERCU1RXMVJDdWkwMVpnMU5EKzNraUYvbE84UFFnY1lRaXNRSDRHQVh1?=
 =?utf-8?B?NnZTMHorWXhXb3VMRmFSUitHc3pMbWszQ1BYa1BxcVhXNmxNVzI5dzhVQ0NV?=
 =?utf-8?B?dzNJUHVGeWM1UTdtNWpncW9oanRLa3FWVWZXZWRtQnZKbFBwenNBUDhKV2E0?=
 =?utf-8?B?NTBWelVHSS85TGplTFZHak80Wjk0MlhReUYrS2lyVjdGZ05QUFhxOTE3R0xZ?=
 =?utf-8?B?eDFEVzM1QXZFTG8rNm5hRGNxRlNja052N0ErYUlvN3VnYzFzb2dFNEdmNnA1?=
 =?utf-8?B?V3p6ODJUM2tMSVJlbXpSbDJrakJpenJCd1QyVEViaEJJTURwZGRzSHFJVlFx?=
 =?utf-8?B?b1dPeUJyM2M1cGdyTFgveElIZUJjTXMxYjh4dCtyUTk2V2lsaXNPeTFYMjgv?=
 =?utf-8?B?RGI2c0lVbTNNelJUUlpBSTR6a0JOZUdPdlViTEVwbHZaREUyOWZrWGs2NTQr?=
 =?utf-8?B?aWFjemliRm5xRkp4TXhnYzdjNUNISjZGZ1VseTJ3Q040UnRTaVJDVGREZmUx?=
 =?utf-8?B?Wm5TTFJ5a0FMbC9nZWViOGRtWDNWSDN4TVRiQlVHKzdXOG05VUtybmU1SUpV?=
 =?utf-8?B?WERRSVU4WERHZ0JWSXZwQ3dLQmF5N3F0Y05udEdVcHZ4dmRjWjRZa0x6VHAw?=
 =?utf-8?B?R0VxbUdXNFB6amhPNml5WmRrZTEyY1V6eTZGWGRrTHA4Q1haVloxeXROeGxX?=
 =?utf-8?Q?L4hxQI?=
X-Microsoft-Antispam-Message-Info: /0ILIhR+vveOEhuLe18+U49xU6RJqbf1/pzAwLi53ov1SFXmTKBEgXxEXwdABq3hLcNEuci0qJXYOOOn3ctJwHs7liai3OyrCm1vz3ja3KNxe72SerY4UEe0d2pTA6DXrzqNO/WXTMX4Vdu5O0Aaew4WhLx6h2FuHxtGfbQBdDtFOtYcIafKYh0g7BUDspTE
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;6:j/g4Zwmas3V1yYMWq4RZqkTKFIKLxpQ++75cB6lf7Ei1L7RW57V3ihRecmIAPAko/GmrLKqy0O1S9sGWPgb10f1bitQyWuPmDOwVNzYPX7d8ywv9dQaipUJUAvJpHAboeVlwBGWLK37H4bXqDHYsvRd1JKb1YoW4bwv8pByx4s+j+ho+C4mz2zRdvB5OU/BYPmKV2ITjCZDa4IhICTqJJei2OQ5Qg+j0esTnoMPgxwx0rDvaUi2AUCRpztWjSS8NSZz1OdfM3VXNxVrOQZ5V7XO7WUSlyevgiU0yaNA1hi2BgSV6bjMloZOWdoiolj+y9B3jjwyoKHPmkpdqSDWgrjKvmddZgkl3+dFOqiey1lefdWIfm3zRJtJp/WF+a/G+XJo9ibLL1Ub1KgMsp/E2ZTOgDgDUDGvtZJEhKzVEoEDMvAd6EMv4dQOCGB7OnsLX2W280494dv0LolaQT6L1iA==;5:HDVfMuymSZUKYBVgB6vnJYTE7kgUo+cZqG0iJAIIASqHIqVPsTp8g84uI0wO/X6d7qMTXG1qpXljxbtIYcQYs9CX5rrKYl1/GHO/g4tM14/ZQa7GwX51PbgQFl+l9AA0ckVy/Xtx6P3r03nl62AukQtyzWShopivmVW+b36RVCc=;24:ODmHBP4s4nBp64tcOIAXwdkC6ci0ebGvtI6SVGFGdmhPKIIFmdnAhImVSACDpnP8TDpK0dg9E6Qi8D7T96N2lSKxMQ8/FuT7TYfC+WiGTmk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;7:2Ho0fEDNEPRi6bMz0WiyCeh6rfti3veYt8k/dRNB5l0ltBG7FUhR4BHWQJa61yLvbtcRVb6hv10gUULcKQrgMo5RY4V6KtzIB5SHOdAG5g8qIoj+/Bnnum8gAbfaoM77IYbMAdnBhtwkTmQ4G7P7fX8G5SNZ9n8djKVkZ/G56B8KS6868BhuXlTbFc5dPeHo1YNwqZXzT70QzuYFqifA4skwN5rteio/8puCwhwsPHJL25zELhekEG0gx3R+uJau;20:Yj/tUQqAtnRqs/+oB62PmVWinTDopj1HhwfoG+0uOB9YMmJNW8J3iMLI6PL09VYoQ9hhcx0DVTx3WYxY9ER5WZfBpFnuCeem2ReNEYJy+bwoALs/+jigxu5ic4tWpRp/HgbAbr9T5yJrkm5iHPn7SVORIXMPmPMfnJcaE5xKtfyKWK6hcTAZdFJkabFVM2iUTRb0PauYOyf/DBusqPkgPRkjm1HMM80vtUG6z27Nx6KmnhWIgVVGcGEfdb14fVES
X-MS-Office365-Filtering-Correlation-Id: d67317ec-caea-4ebe-187e-08d5a48b2049
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 17:46:18.4363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67317ec-caea-4ebe-187e-08d5a48b2049
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0701
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/2018 9:17 AM, Gary R Hook wrote:
> Provide base enablement for using debugfs to expose internal data of
> an IOMMU driver. When called, create the /sys/kernel/debug/iommu
> directory.  Emit a strong warning at boot time to indicate that this
> feature is enabled.
> 
> This patch adds a top-level function that will create the (above)
> directory, under which a driver may create a hw-specific directory for
> its use. The function
> 
> 	iommu_debugfs_setup()
> 
> returns a pointer to the new dentry structure created for
> /sys/kernel/debug/iommu, or NULL in the event of a failure. An IOMMU
> driver should call this function first, and then create a directory
> beneath it. A driver implementation might look something like:
> 
> static struct dentry *my_debugfs;
> 
> 	struct dentry *d_top;
> 	if (!my_debugfs) {
> 		d_top = iommu_debugfs_setup();
> 		if (d_top)
> 			my_debugfs = debugfs_create_dir("vendor", d_top);
> 	}
> 
> Since the IOMMU driver can not be removed from the running system, this
> patch only provides an "on" function.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>   drivers/iommu/Kconfig         |   11 ++++++++
>   drivers/iommu/Makefile        |    1 +
>   drivers/iommu/iommu-debugfs.c |   58 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/iommu.h         |    4 +++
>   4 files changed, 74 insertions(+)
>   create mode 100644 drivers/iommu/iommu-debugfs.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f3a21343e636..c1e39dabfec2 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>   
>   endmenu
>   
> +config IOMMU_DEBUG
> +	bool "Enable IOMMU internals in DebugFS"
> +	depends on DEBUG_FS
> +	default n
> +	help
> +	  Allows exposure of IOMMU device internals. This option enables
> +	  the use of debugfs by IOMMU drivers as required. Devices can,
> +	  at initialization time, cause the IOMMU code to create a top-level
> +	  debug/iommu directory, and then populate a subdirectory with
> +	  entries as required.

I should explicitly ask about this:

Joerg had suggested IOMMU_DEBUGFS, but here I've changed to IOMMU_DEBUG. 
I'm not seeing a lot of CONFIG options that use DEBUGFS for debugfs 
options, so I chose to follow an implied convention.

Question: should this indeed be IOMMU_DEBUGFS?
                                 ^^^^^^^^^^^^^
