Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32730C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E149B2242B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E149B2242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeGELfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:35:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57661 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753726AbeGELfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:35:23 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id c6669edef0a83844; Thu, 5 Jul 2018 13:35:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tristian Celestin <tristiancelestin@fastmail.com>
Cc:     lenb@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi/x86: enable touchscreen on Dell Venue Pro 7139
Date:   Thu, 05 Jul 2018 13:33:56 +0200
Message-ID: <1929463.ctoOnHkgrM@aspire.rjw.lan>
In-Reply-To: <1528582686-18577-1-git-send-email-tristiancelestin@fastmail.com>
References: <1528582686-18577-1-git-send-email-tristiancelestin@fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, June 10, 2018 12:18:06 AM CEST Tristian Celestin wrote:
> Permanently enable the SYNA7500 touchscreen device on the Dell
> Venue Pro 7139. The DSDT hides the touchscreen ACPI device on
> the 7139 in the same fashion as the 7130, and needs to
> be enabled in the same way.
> 
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
> -	 * On the Dell Venue 11 Pro 7130 the DSDT hides the touchscreen ACPI
> -	 * device until a certain time after _SB.PCI0.GFX0.LCD.LCD1._ON gets
> -	 * called has passed *and* _STA has been called at least 3 times since.
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
>  	 * The GPD win BIOS dated 20170221 has disabled the accelerometer, the
>  	 * drivers sometimes cause crashes under Windows and this is how the
> 

Applied, thanks!


