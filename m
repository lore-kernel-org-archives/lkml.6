Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CDC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D7620839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D7620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeIKQES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:04:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43586 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeIKQES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:04:18 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id 493bfd550be9d69e; Tue, 11 Sep 2018 13:05:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ACPI / LPSS: Get rid of custom ICPU() macro
Date:   Tue, 11 Sep 2018 13:02:50 +0200
Message-ID: <2988878.r6y5agHKkI@aspire.rjw.lan>
In-Reply-To: <20180831091018.17543-3-andriy.shevchenko@linux.intel.com>
References: <20180831091018.17543-1-andriy.shevchenko@linux.intel.com> <20180831091018.17543-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 31, 2018 11:10:17 AM CEST Andy Shevchenko wrote:
> Replace custom grown macro with generic INTEL_CPU_FAM6_NODATA() one.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 9706613eecf9..c363e2a40f13 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -289,11 +289,9 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
>  	.setup = lpss_deassert_reset,
>  };
>  
> -#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  static const struct x86_cpu_id lpss_cpu_ids[] = {
> -	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	/* Valleyview, Bay Trail */
> -	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
> +	INTEL_CPU_FAM6_NODATA(ATOM_SILVERMONT1),	/* Valleyview, Bay Trail */
> +	INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT),		/* Braswell, Cherry Trail */
>  	{}
>  };
>  
> 

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

