Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510DCECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158A820825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158A820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeKHXLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:11:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:3211 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKHXLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:11:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 05:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="98643530"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2018 05:35:43 -0800
Received: from [10.251.4.32] (kliang2-mobl1.ccr.corp.intel.com [10.251.4.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A0323580444;
        Thu,  8 Nov 2018 05:35:42 -0800 (PST)
Subject: Re: [PATCH 1/2] perf/x86/intel/uncore: Add more IMC PCI IDs for
 KabyLake and CoffeeLake
To:     tglx@linutronix.de, peterz@infradead.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Cc:     ak@linux.intel.com
References: <20181019170419.378-1-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5f37bea5-51ce-5216-31f0-ee67773f2c12@linux.intel.com>
Date:   Thu, 8 Nov 2018 08:35:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019170419.378-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Ping.
Any comments for the series.

Thanks,
Kan

On 10/19/2018 1:04 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> KabyLake and CoffeeLake has the same client uncore events as SkyLake.
> 
> Add the PCI IDs for KabyLake Y, U, S processor line and CoffeeLake U,
> H, S processor line.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   arch/x86/events/intel/uncore_snb.c | 115 ++++++++++++++++++++++++++++-
>   1 file changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index 8527c3e1038b..bfa25814fe5f 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -15,6 +15,25 @@
>   #define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC	0x1910
>   #define PCI_DEVICE_ID_INTEL_SKL_SD_IMC	0x190f
>   #define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC	0x191f
> +#define PCI_DEVICE_ID_INTEL_KBL_Y_IMC	0x590c
> +#define PCI_DEVICE_ID_INTEL_KBL_U_IMC	0x5904
> +#define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC	0x5914
> +#define PCI_DEVICE_ID_INTEL_KBL_SD_IMC	0x590f
> +#define PCI_DEVICE_ID_INTEL_KBL_SQ_IMC	0x591f
> +#define PCI_DEVICE_ID_INTEL_CFL_2U_IMC	0x3ecc
> +#define PCI_DEVICE_ID_INTEL_CFL_4U_IMC	0x3ed0
> +#define PCI_DEVICE_ID_INTEL_CFL_4H_IMC	0x3e10
> +#define PCI_DEVICE_ID_INTEL_CFL_6H_IMC	0x3ec4
> +#define PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC	0x3e0f
> +#define PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC	0x3e1f
> +#define PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC	0x3ec2
> +#define PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC	0x3e30
> +#define PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC	0x3e18
> +#define PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC	0x3ec6
> +#define PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC	0x3e31
> +#define PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC	0x3e33
> +#define PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC	0x3eca
> +#define PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC	0x3e32
>   
>   /* SNB event control */
>   #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
> @@ -569,7 +588,82 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
>   		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_SQ_IMC),
>   		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
>   	},
> -
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_U_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_UQ_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SD_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SQ_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2U_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4U_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4H_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6H_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
>   	{ /* end: all zeroes */ },
>   };
>   
> @@ -618,6 +712,25 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
>   	IMC_DEV(SKL_HQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core H Quad Core */
>   	IMC_DEV(SKL_SD_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Dual Core */
>   	IMC_DEV(SKL_SQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Quad Core */
> +	IMC_DEV(KBL_Y_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core Y */
> +	IMC_DEV(KBL_U_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U */
> +	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
> +	IMC_DEV(KBL_SD_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Dual Core */
> +	IMC_DEV(KBL_SQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Quad Core */
> +	IMC_DEV(CFL_2U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 2 Cores */
> +	IMC_DEV(CFL_4U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 4 Cores */
> +	IMC_DEV(CFL_4H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 4 Cores */
> +	IMC_DEV(CFL_6H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 6 Cores */
> +	IMC_DEV(CFL_2S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 2 Cores Desktop */
> +	IMC_DEV(CFL_4S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Desktop */
> +	IMC_DEV(CFL_6S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Desktop */
> +	IMC_DEV(CFL_8S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Desktop */
> +	IMC_DEV(CFL_4S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Work Station */
> +	IMC_DEV(CFL_6S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Work Station */
> +	IMC_DEV(CFL_8S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Work Station */
> +	IMC_DEV(CFL_4S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Server */
> +	IMC_DEV(CFL_6S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Server */
> +	IMC_DEV(CFL_8S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Server */
>   	{  /* end marker */ }
>   };
>   
> 
