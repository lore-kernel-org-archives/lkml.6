Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103ABC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA5A21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfBKS1E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:27:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:62521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfBKS1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:27:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 10:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="125619107"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2019 10:27:03 -0800
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 10:27:03 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.48]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.80]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 10:27:02 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: RE: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Thread-Topic: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Thread-Index: AQHUwBELRUotvo/++EOsz9jPMtTFnaXa7fTQ
Date:   Mon, 11 Feb 2019 18:27:02 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C57BD14@ORSMSX122.amr.corp.intel.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
 <20190209004718.3292087-2-jeremy.linton@arm.com>
In-Reply-To: <20190209004718.3292087-2-jeremy.linton@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jeremy Linton [mailto:jeremy.linton@arm.com]
> Sent: Friday, February 8, 2019 4:47 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> devel@acpica.org; catalin.marinas@arm.com; will.deacon@arm.com;
> mark.rutland@arm.com; Moore, Robert <robert.moore@intel.com>;
> Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; lenb@kernel.org; Jeremy Linton
> <jeremy.linton@arm.com>
> Subject: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
> 
Hi Jeremy,

> [Placeholder patch for upstream ACPICA commit]

FYI: we are planning on releasing ACPICA patches by the end of this week at the latest.

Erik
> 
> Add just ACPI 6.3 changes associated with the arm64 SPE.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  include/acpi/actbl2.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> c50ef7e6b942..4b58eb6cf64e 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -623,7 +623,7 @@ struct acpi_madt_local_x2apic_nmi {
>  	u8 reserved[3];		/* reserved - must be zero */
>  };
> 
> -/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
> +/* 11: Generic Interrupt (ACPI 5.0 + 6.0 + 6.3 changes) */
> 
>  struct acpi_madt_generic_interrupt {
>  	struct acpi_subtable_header header;
> @@ -641,7 +641,8 @@ struct acpi_madt_generic_interrupt {
>  	u64 gicr_base_address;
>  	u64 arm_mpidr;
>  	u8 efficiency_class;
> -	u8 reserved2[3];
> +	u8 reserved2;
> +	u16 spe_overflow_interrupt;
>  };
> 
>  /* Masks for Flags field above */
> --
> 2.17.2

