Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E2AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C036206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbeLQLoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:44:46 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51291 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732052AbeLQLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:44:45 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 2ca4a2cd1487bb7d; Mon, 17 Dec 2018 12:44:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: ia64: Remove unused header files
Date:   Mon, 17 Dec 2018 12:44:20 +0100
Message-ID: <2029526.yj18hjzxFf@aspire.rjw.lan>
In-Reply-To: <20181205154449.15725-1-tiny.windzz@gmail.com>
References: <20181205154449.15725-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 5, 2018 4:44:49 PM CET Yangtao Li wrote:
> seq_file.h does not need to be included, so remove it. Moreover deleted
> a line of meaningless return and some useless blank lines. In a function
> whose return type is void, returning on the last line is not required.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> changes in v2:
> -revert modify of MODULE_
> -delete some blank lines
> ---
>  drivers/cpufreq/ia64-acpi-cpufreq.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
> index dd5440d3372d..80c5bf590acb 100644
> --- a/drivers/cpufreq/ia64-acpi-cpufreq.c
> +++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
> @@ -16,7 +16,6 @@
>  #include <linux/init.h>
>  #include <linux/cpufreq.h>
>  #include <linux/proc_fs.h>
> -#include <linux/seq_file.h>
>  #include <asm/io.h>
>  #include <linux/uaccess.h>
>  #include <asm/pal.h>
> @@ -28,7 +27,6 @@ MODULE_AUTHOR("Venkatesh Pallipadi");
>  MODULE_DESCRIPTION("ACPI Processor P-States Driver");
>  MODULE_LICENSE("GPL");
>  
> -
>  struct cpufreq_acpi_io {
>  	struct acpi_processor_performance	acpi_data;
>  	unsigned int				resume;
> @@ -348,10 +346,7 @@ acpi_cpufreq_exit (void)
>  	pr_debug("acpi_cpufreq_exit\n");
>  
>  	cpufreq_unregister_driver(&acpi_cpufreq_driver);
> -	return;
>  }
>  
> -
>  late_initcall(acpi_cpufreq_init);
>  module_exit(acpi_cpufreq_exit);
> -
> 

Applied, thanks!


