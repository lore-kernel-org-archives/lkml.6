Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB5C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D97220811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D97220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeLLTCk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:02:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:51538 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbeLLTCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:02:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 11:02:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="283075187"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2018 11:02:39 -0800
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Dec 2018 11:02:39 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.103]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.100]) with mapi id 14.03.0415.000;
 Wed, 12 Dec 2018 11:02:38 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Sinan Kaya <okaya@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Thread-Topic: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Thread-Index: AQHUkj7xabqLvJKsV0WIbkZeNQOeIqV7dNjw
Date:   Wed, 12 Dec 2018 19:02:38 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
References: <20181212171941.7437-1-okaya@kernel.org>
 <20181212171941.7437-6-okaya@kernel.org>
In-Reply-To: <20181212171941.7437-6-okaya@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODY5OTZlOGUtNGNlMS00M2JmLTgwOTUtZmFjY2EzMGEwNzFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicUlSTEVQNTV5cXphYjRBM1FpXC94WEJcL2hPNE92NVFjVmVzTnFiOG5XMHViUkFuOHd1MkQ3QXhNQ3JXQk94WmRhIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sinan Kaya [mailto:okaya@kernel.org]
> Sent: Wednesday, December 12, 2018 9:20 AM
> To: linux-acpi@vger.kernel.org
> Cc: Sinan Kaya <okaya@kernel.org>; Moore, Robert
> <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>;
> Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
> <lenb@kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPICA)
> <devel@acpica.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
> CONFIG_PCI is unset
> 
> Now that we allow CONFIG_PCI to be unset, remove useless code from
> ACPICA too.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/acpica/Makefile  | 2 +-
>  drivers/acpi/acpica/achware.h | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile index
> b14621da5413..59700433a96e 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -77,13 +77,13 @@ acpi-y +=		\
>  	hwacpi.o	\
>  	hwesleep.o	\
>  	hwgpe.o		\
> -	hwpci.o		\
>  	hwregs.o	\
>  	hwsleep.o	\
>  	hwvalid.o	\
>  	hwxface.o	\
>  	hwxfsleep.o
> 
> +acpi-$(CONFIG_PCI) += hwpci.o
>  acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
> 
>  acpi-y +=		\
> diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
> index 43ce67a9da1f..1c827184fe64 100644
> --- a/drivers/acpi/acpica/achware.h
> +++ b/drivers/acpi/acpica/achware.h
> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
> acpi_gpe_xrupt_info *gpe_xrupt_info,

CONFIG_PCI is a Linux-ism. We should stay with the OS-independent nature of
ACPICA. Please use ACPI_PCI_CONFIGURED and put it above the comment like so:

#ifdef ACPI_PCI_CONFIGURED
>  /*
>   * hwpci - PCI configuration support
>   */
> +#ifdef CONFIG_PCI
>  acpi_status
>  acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
>  		      acpi_handle root_pci_device, acpi_handle pci_region);
> +#else
> +static inline acpi_status
> +acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id, acpi_handle
> root_pci_device,
> +		      acpi_handle pci_region)
> +{
> +	return AE_SUPPORT;
> +}
> +#endif
> 
>  #endif				/* __ACHWARE_H__ */
> --
> 2.19.0

