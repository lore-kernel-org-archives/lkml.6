Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5CCC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4163208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4163208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933122AbeFUNQk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:16:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63236 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932956AbeFUNQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:16:38 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 5f18c0b8d406711d; Thu, 21 Jun 2018 15:16:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] ACPI / processor: Finish making acpi_processor_ppc_has_changed() void
Date:   Thu, 21 Jun 2018 15:15:24 +0200
Message-ID: <2790550.zlpsS0gzWJ@aspire.rjw.lan>
In-Reply-To: <20180619170201.36531-1-briannorris@chromium.org>
References: <20180619170201.36531-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 19, 2018 7:02:01 PM CEST Brian Norris wrote:
> Commit bca5f557dcea ("ACPI / processor: Make
> acpi_processor_ppc_has_changed() void") changed one of the declarations
> of acpi_processor_ppc_has_changed() to return void, but the !CPU_FREQ
> version still return int. Let's return void to be consistent.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  include/acpi/processor.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 40a916efd7c0..1194a4c78d55 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -309,7 +309,7 @@ static inline void acpi_processor_ppc_exit(void)
>  {
>  	return;
>  }
> -static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
> +static inline void acpi_processor_ppc_has_changed(struct acpi_processor *pr,
>  								int event_flag)
>  {
>  	static unsigned int printout = 1;
> @@ -320,7 +320,6 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
>  		       "Consider compiling CPUfreq support into your kernel.\n");
>  		printout = 0;
>  	}
> -	return 0;
>  }
>  static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
>  {
> 

Applied, thanks!


