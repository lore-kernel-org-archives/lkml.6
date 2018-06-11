Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JyYKIfs4HlucOAAAmS7hNA
	; Mon, 11 Jun 2018 08:55:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C93046074D; Mon, 11 Jun 2018 08:55:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4C7AA60385;
	Mon, 11 Jun 2018 08:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C7AA60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeFKIzX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:55:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:19393 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932272AbeFKIzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:55:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 01:55:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,501,1520924400";
   d="scan'208";a="58214524"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2018 01:55:18 -0700
Message-ID: <f05a1aa6e525ba26883d33fd40b85633442a83e1.camel@linux.intel.com>
Subject: Re: [PATCH] acpi/x86: enable touchscreen on Dell Venue Pro 7139
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tristian Celestin <tristiancelestin@fastmail.com>,
        rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario_limonciello@dell.com>
Date: Mon, 11 Jun 2018 11:55:18 +0300
In-Reply-To: <1528582686-18577-1-git-send-email-tristiancelestin@fastmail.com>
References: <1528582686-18577-1-git-send-email-tristiancelestin@fastmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-09 at 18:18 -0400, Tristian Celestin wrote:
> Permanently enable the SYNA7500 touchscreen device on the Dell
> Venue Pro 7139. The DSDT hides the touchscreen ACPI device on
> the 7139 in the same fashion as the 7130, and needs to
> be enabled in the same way.
> 

Cc: Mario.

> Signed-off-by: Tristian Celestin <tristiancelestin@fastmail.com>
> ---
>  drivers/acpi/x86/utils.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index ec5b0f1..3a13b2a 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -62,14 +62,20 @@ struct always_present_id {
>  	 */
>  	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
>  	/*
> -	 * On the Dell Venue 11 Pro 7130 the DSDT hides the
> touchscreen ACPI
> -	 * device until a certain time after
> _SB.PCI0.GFX0.LCD.LCD1._ON gets
> -	 * called has passed *and* _STA has been called at least 3
> times since.
> +	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
> +	 * the touchscreen ACPI device until a certain time
> +	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
> +	 * *and* _STA has been called at least 3 times since.
>  	 */
>  	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
>  	      }),
> +	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_ULT), {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
> +	      }),
> +
>  	/*
>  	 * The GPD win BIOS dated 20170221 has disabled the
> accelerometer, the
>  	 * drivers sometimes cause crashes under Windows and this is
> how the

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
