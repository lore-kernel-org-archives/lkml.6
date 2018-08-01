Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCACC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B536420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B536420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbeHAVgp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:36:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:1236 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHAVgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:36:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 12:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,433,1526367600"; 
   d="scan'208";a="245214503"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga005.jf.intel.com with ESMTP; 01 Aug 2018 12:49:15 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 12:49:15 -0700
Received: from orsmsx108.amr.corp.intel.com ([169.254.2.3]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.46]) with mapi id 14.03.0319.002;
 Wed, 1 Aug 2018 12:49:14 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Mike Travis <mike.travis@hpe.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
CC:     Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
 Reference Count warnings
Thread-Topic: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
 Reference Count warnings
Thread-Index: AQHUKFhOdnOKO84lh0ePNJ9MGeCA/6SrUJBw
Date:   Wed, 1 Aug 2018 19:49:14 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B94DED8F@ORSMSX108.amr.corp.intel.com>
References: <20180730195545.795802877@stormcage.americas.sgi.com>
 <20180730195548.580717146@stormcage.americas.sgi.com>
In-Reply-To: <20180730195548.580717146@stormcage.americas.sgi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjYzNTFkYjctMTM1MC00NjE4LWIxZDYtOWJkYzdlZGQzZTE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRERCeDlkRUk4NGs1M04yeFJ3b3NDQVd3c1VFN3pFTWNIOFFDdDBtZE9XZW02bDR5dXpNU1Jmb2I2Z1hBMVBJVSJ9
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

Are there any actual memory leaks, or this a consequence of the number of sockets?


> -----Original Message-----
> From: Mike Travis [mailto:mike.travis@hpe.com]
> Sent: Monday, July 30, 2018 12:56 PM
> To: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> <erik.schmauss@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> Cc: Russ Anderson <russ.anderson@hpe.com>; Dimitri Sivanich
> <dimitri.sivanich@hpe.com>; Ross Zwisler <ross.zwisler@linux.intel.com>;
> Williams, Dan J <dan.j.williams@intel.com>; Verma, Vishal L
> <vishal.l.verma@intel.com>; Jiang, Dave <dave.jiang@intel.com>; linux-
> acpi@vger.kernel.org; devel@acpica.org; linux-nvdimm@lists.01.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
> Reference Count warnings
> 
> With the Intel BIOS support for 8 processor sockets with a full
> complement of NVDIMMS potentially installable, and there are empty
> sockets without NVDIMMS, there is an extremely large amount of the
> following warnings:
> 
> ACPI Warning: Large Reference Count (0x1001) in object ffff99453fc71750,
> 	Type=0x0A
> 
> On a 4 socket system with 4 NVDIMMs there were over 6000 of these
> warning messages and it has been seem on systems from 4 to 32 sockets.
> 
> Through some guidance from the BIOS developers and testing, it appears
> that simply bumping up the threshold for warnings from 0x1000 to 0x2000
> eliminates these messages.  Changing them to be ACPI DEBUG messages, or
> even removing them are other options, but it would then defeat the
> purpose of the warnings as the problem would effectively be hidden.
> 
> Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Tested-by: Russ Anderson <russ.anderson@hpe.com>
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> ---
>  include/acpi/acconfig.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-4.12.orig/include/acpi/acconfig.h
> +++ linux-4.12/include/acpi/acconfig.h
> @@ -123,7 +123,7 @@
> 
>  /* Maximum object reference count (detects object deletion issues) */
> 
> -#define ACPI_MAX_REFERENCE_COUNT        0x1000
> +#define ACPI_MAX_REFERENCE_COUNT        0x2000
> 
>  /* Default page size for use in mapping memory for operation regions */
> 
> 
> --

