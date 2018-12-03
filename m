Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9721C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78CC20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLw0qCrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78CC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbeLCEmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:42:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40587 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLCEmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:42:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so5791687plq.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 20:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PHkp+2PbJG2mAi0QHRiC0TyJcm+mY/1SMyho8DgD6KM=;
        b=NLw0qCrQ51lbkaEfab2bwbrz1E24Pwqa7aKySndLjDtvXUIESUltDthtmM0JpHy4GY
         LsSPuY727r/wpKgARtn0onKAcyKvi49hWjfs7cqeqos/ykhLyxR5nWGoGgAw/gLozAp0
         0gYcHndqwrIYrnJrtICAs2gt/j+9ZNCQ/2ZEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PHkp+2PbJG2mAi0QHRiC0TyJcm+mY/1SMyho8DgD6KM=;
        b=GsHq91RyYkFE6OdubXKmTCdBQXFwzax8kllwKg/Y3o+3Y6RFZeJilG1IpSdOUrZoub
         ByxtCSrTJau57xZcHVYeDOqls7Qd8UlxGLzMyY+ZRUo74kxDpJ244QMRlyoruyWBRDSL
         gyuWJrQdI2kYk1ZsLEnGSkXvEabBBu/9/C8kq4lppTxymLfBHT4Of9n8NCKS1F1cCivB
         5/yhLP5+MX2fqFgrTBlMNVeEwJl2PnXGzgCX7AteL3IXAWB76sbNLoUaeWbVcLd4PJYJ
         fOEtlG8vhda46+oYWE+w9pYh9LgxITjw9FIyfnVtweSRUshaGqlDuzqUU7HteIjuX7bK
         mpCw==
X-Gm-Message-State: AA+aEWaA6GyNhkQpLQBGNO9Nd63a5UVQRet4Nisi1K++tX4B5W0QRSr5
        VsOkiUNYaERs7ghnGLgZtBY9ZA==
X-Google-Smtp-Source: AFSGD/VbzlJBirQktxXkuyxTwmNGozi5P3W5tvVMYcQydrR6MRyL1xfTitkjPGm/itdIiTECoznnMA==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr14098761pls.322.1543812147281;
        Sun, 02 Dec 2018 20:42:27 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id w3sm14998084pge.8.2018.12.02.20.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 20:42:25 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:12:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: ia64: Remove unused header files
Message-ID: <20181203044222.rt3v3fnrc5fpjlji@vireshk-i7>
References: <20181130141620.2488-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130141620.2488-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-18, 09:16, Yangtao Li wrote:
> seq_file.h does not need to be included,so remove it.Moreover deleted a
> line of meaningless return and move the module declaration to the end.
> In a function whose return type is void, returning on the last line is
> not required.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/ia64-acpi-cpufreq.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
> index dd5440d3372d..43ac191fb46a 100644
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
> @@ -24,11 +23,6 @@
>  #include <linux/acpi.h>
>  #include <acpi/processor.h>
>  
> -MODULE_AUTHOR("Venkatesh Pallipadi");
> -MODULE_DESCRIPTION("ACPI Processor P-States Driver");
> -MODULE_LICENSE("GPL");
> -
> -
>  struct cpufreq_acpi_io {
>  	struct acpi_processor_performance	acpi_data;
>  	unsigned int				resume;
> @@ -348,9 +342,11 @@ acpi_cpufreq_exit (void)
>  	pr_debug("acpi_cpufreq_exit\n");
>  
>  	cpufreq_unregister_driver(&acpi_cpufreq_driver);
> -	return;
>  }
>  
> +MODULE_AUTHOR("Venkatesh Pallipadi");
> +MODULE_DESCRIPTION("ACPI Processor P-States Driver");
> +MODULE_LICENSE("GPL");
>  
>  late_initcall(acpi_cpufreq_init);
>  module_exit(acpi_cpufreq_exit);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
