Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46BA21534
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46BA21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbeHMT61 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:58:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:11236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbeHMT61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:58:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 10:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,234,1531810800"; 
   d="scan'208";a="83020668"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2018 10:15:20 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 13 Aug 2018 10:15:20 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.41]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.2]) with mapi id 14.03.0319.002;
 Mon, 13 Aug 2018 10:15:20 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: Clear status of all events when entering sleep
 states
Thread-Topic: [PATCH] ACPICA: Clear status of all events when entering sleep
 states
Thread-Index: AQHUMiqLwP6eT+bgikuipgTaRX9Zg6S97crg
Date:   Mon, 13 Aug 2018 17:15:19 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB67514@ORSMSX110.amr.corp.intel.com>
References: <1764673.ub23GCSM6t@aspire.rjw.lan>
In-Reply-To: <1764673.ub23GCSM6t@aspire.rjw.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTU0M2ZjNjEtZWZiNi00ZmY5LWIxMGItN2I0NjYzNmQ3NGYzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid280OURURHdUa0VzTmRkVmRuSEhGMkt6Y0RsWXNIdzRcL2dcL3kxdDRoVkpWOUczVlpjNjVtY1N0T25UUHVkeTJcLyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
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
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Sunday, August 12, 2018 3:50 AM
> To: Linux ACPI <linux-acpi@vger.kernel.org>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>; Linux PM <linux-
> pm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Schmauss, Erik
> <erik.schmauss@intel.com>
> Subject: [PATCH] ACPICA: Clear status of all events when entering sleep states
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit fa85015c0d95 (ACPICA: Clear status of all events when entering
> S5) made the sleep state entry code in ACPICA clear the status of all ACPI events
> when entering S5 to fix a functional regression reported against commit
> 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs during
> suspend/resume).  However, it is reported now that the regression also affects
> system states other than S5 on some systems and causes them to wake up from
> sleep prematurely.
> 
> For this reason, make the code in question clear the status of all ACPI events
> when entering all sleep states (in addition to S5) to avoid the premature
> wakeups (this may cause some wakeup events to be missed in theory, but the
> likelihood of that is small and the change here simply restores the previous
> behavior of the code).
> 
> Fixes: 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs
> during suspend/resume)
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: 4.17+ <stable@vger.kernel.org> # 4.17+: fa85015c0d95 ACPICA: Clear
> status ...
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/hwsleep.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
> =================================================================
> ==
> --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
> +++ linux-pm/drivers/acpi/acpica/hwsleep.c
> @@ -56,14 +56,9 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);
>  	}
> -	/*
> -	 * If the target sleep state is S5, clear all GPEs and fixed events too
> -	 */
> -	if (sleep_state == ACPI_STATE_S5) {
> -		status = acpi_hw_clear_acpi_status();
> -		if (ACPI_FAILURE(status)) {
> -			return_ACPI_STATUS(status);
> -		}
> +	status = acpi_hw_clear_acpi_status();
> +	if (ACPI_FAILURE(status)) {
> +		return_ACPI_STATUS(status);
>  	}
>  	acpi_gbl_system_awake_and_running = FALSE;
> 

I'll backport this for the next ACPICA release

Thanks,
Erik
