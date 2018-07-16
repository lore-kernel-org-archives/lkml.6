Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75552ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357032089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357032089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeGPS2A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:28:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:26212 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeGPS2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:28:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 10:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,362,1526367600"; 
   d="scan'208";a="57309450"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2018 10:59:28 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 16 Jul 2018 10:59:28 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.90]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.31]) with mapi id 14.03.0319.002;
 Mon, 16 Jul 2018 10:59:28 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     =?iso-8859-1?Q?Thomas_H=E4nig?= <haenig@cosifan.de>,
        Takashi Iwai <tiwai@suse.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: Clear status of all events when entering S5
Thread-Topic: [PATCH] ACPICA: Clear status of all events when entering S5
Thread-Index: AQHUFpu0XUtNzBv1akqdlUOPvTIt7aSSL9Hg
Date:   Mon, 16 Jul 2018 17:59:27 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB4D759@ORSMSX110.amr.corp.intel.com>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
 <1704080.gFTvVrrZA1@aspire.rjw.lan>
 <6f01a906-b27c-0e1a-e9f6-fa27c015faa3@cosifan.de>
 <2396867.eZQXUlvGZn@aspire.rjw.lan>
In-Reply-To: <2396867.eZQXUlvGZn@aspire.rjw.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjFmMTc1NDgtMWU4ZS00Mzc5LTgxNGUtZTRmNjdjMjA3YmZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVTlyMnArUG9lT0wwdWdoTGo2dDNtZWJycjJGem9LVEpScXJFb2pxQmFsZHY1R3ZSWnN3YWR5cmtYSmkwRWkzVSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Sunday, July 8, 2018 2:10 AM
> To: Linux ACPI <linux-acpi@vger.kernel.org>
> Cc: Thomas Hänig <haenig@cosifan.de>; Takashi Iwai <tiwai@suse.de>;
> Schmauss, Erik <erik.schmauss@intel.com>; Linux PM <linux-
> pm@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: [PATCH] ACPICA: Clear status of all events when entering S5
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI
> IRQs during suspend/resume) the status of ACPI events is not cleared any more
> when entering the ACPI S5 system state (power
> off) which causes some systems to power up immediately after turing off power
> in certain situations.
> 
> That is a functional regression, so address it by making the code clear the status
> of all ACPI events again when entering S5 (for system-wide suspend or
> hibernation the clearing of the status of all events is not desirable, as it might
> cause the kernel to miss wakeup events sometimes).
> 
> Fixes: 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs
> during suspend/resume)
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Thomas Hänig <haenig@cosifan.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Resend https://patchwork.kernel.org/patch/10511451/ with a changelig and
> tags.
> 
> ---
>  drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
> =================================================================
> ==
> --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
> +++ linux-pm/drivers/acpi/acpica/hwsleep.c
> @@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>  		return_ACPI_STATUS(status);
>  	}
> 
> -	/*
> -	 * 1) Disable all GPEs
> -	 * 2) Enable all wakeup GPEs
> -	 */
> +	/* Disable all GPEs */
>  	status = acpi_hw_disable_all_gpes();
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);
>  	}
> +	/*
> +	 * If the target sleep state is S5, clear all GPEs and fixed events too
> +	 */
> +	if (sleep_state == ACPI_STATE_S5) {
> +		status = acpi_hw_clear_acpi_status();
> +		if (ACPI_FAILURE(status)) {
> +			return_ACPI_STATUS(status);
> +		}
> +	}
>  	acpi_gbl_system_awake_and_running = FALSE;
> 
> +	 /* Enable all wakeup GPEs */
>  	status = acpi_hw_enable_all_wakeup_gpes();
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);

Rafael, I've created an ACPICA pull request containing this patch.

Thanks,
Erik
