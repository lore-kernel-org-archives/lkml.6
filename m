Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528E2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67C120838
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spHR4cs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67C120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeIEGRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:17:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36222 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:17:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so2575177pgo.3;
        Tue, 04 Sep 2018 18:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MUqfIhgvbv/pmYClS49jq5IiiHFV+VYPr5DzS7QTlEQ=;
        b=spHR4cs4WzvnP7BPfVhaJlnY+LiSwXQZDRZP3D4qoYtdVzOfo6pd+4ZpqugB8n1QO7
         cNvxfaV7V2ahiLHeAouYr1LU7pzzRPJ5ktgzADYgpA6kONwoETXglCmBTg6maX1/5rhK
         ul8GsTF9XK7+JoQExwmGY8wWeTB3hPYZyP6bjoEKSJ0O02TeDAsqtzVMDFF6UVqSxiyw
         bQuXHoLZPnzVEr5NXXhYjCWUE8s+QTZUfWUar3XzqaykGa9eIFMauwh3KtPeu7A2QsMD
         hDtMXS7scgHVlS0Hs+r18tON2TWxBfwyB9KZSov1qi9BbzpxSh7oOd7kEzA+o5uGQZ9v
         9FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MUqfIhgvbv/pmYClS49jq5IiiHFV+VYPr5DzS7QTlEQ=;
        b=jdTx3xbmPa2uXelAf3BEC9oVoORnNhn3Fwjtk7NX742acXsH6mUd8GCxMyB3dqZE0d
         jNIASUW4hG22nqjVov2Een3TRTEZSsfsjwpMDWYKXV5DFy94g//9SFe21dkwuJgCC2rl
         oJxhXiNXfNeQZ+3O8EJwDJd8zFF/MeC0wjRczmKe1aOr+RlzUq8HRfRao7ejhSHUXg0c
         RNhVjtAIV34Vp6n4oA/TRzN8btHuDhLD+UiKcHQvOAnlD4eWrS6I3MgEIWAc9ICmfwmw
         HX/JZcGx949p4mP51p/pMt7X9oPowmAvuwl0VERifb0orerxT7DLjrBtVG+MJTioJ/xx
         P5qw==
X-Gm-Message-State: APzg51DZfURcYwPKBeZBUJO/ylWycYY1YlZZRSXxexlrfvpM/RXXyeTX
        Gnr1j6Y9bQfNJPJKe7RHaBkhaIWZ
X-Google-Smtp-Source: ANB0VdZQltDDS/mu577VO7GFc8mSn7NukomV9hHY/Vsg+fJzQQE9/ViCYy/2E9N8jDQU/xOLXAjOWw==
X-Received: by 2002:a63:a54f:: with SMTP id r15-v6mr33834237pgu.336.1536112189075;
        Tue, 04 Sep 2018 18:49:49 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id x2-v6sm376407pfi.166.2018.09.04.18.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 18:49:48 -0700 (PDT)
Subject: Re: [PATCH 1/3] of/fdt: Scan the root node properties earlier
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180830190523.31474-1-robh@kernel.org>
 <20180830190523.31474-2-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b86ed9cf-d5fd-09fb-eb82-0143c759f5cf@gmail.com>
Date:   Tue, 4 Sep 2018 18:49:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830190523.31474-2-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 12:05, Rob Herring wrote:
> Scan the root node properties (#{size,address}-cells) earlier, 

                                                        ^^^^^^^
                             before mdesc->dt_fixup() is called

> so that
> the dt_root_addr_cells and dt_root_size_cells variables are initialized
> and can be used.
                 by mdesc->dt_fixup()
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/fdt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
Moving early_init_dt_scan_root() to inside early_init_dt_verify()
puts something that has nothing to do with verifying the fdt
into a function whose purpose is the verify.  It hides the side
effect of initializing the dt_root_addr_cells and dt_root_size_cells
variables.

I suggest creating a new function early_init_dt_scan_init_pre_dt_fixup(),
move the chunk of code there instead of to early_init_dt_scan_nodes(),
and call the new function from setup_machine_fdt(), just before
calling  mdesc->dt_fixup().  This would be a little bit more code,
but more clearly showing the intent.

-Frank

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 800ad252cf9c..49abe18f1bde 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1215,6 +1215,10 @@ bool __init early_init_dt_verify(void *params)
>  	initial_boot_params = params;
>  	of_fdt_crc32 = crc32_be(~0, initial_boot_params,
>  				fdt_totalsize(initial_boot_params));
> +
> +	/* Initialize {size,address}-cells info */
> +	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> +
>  	return true;
>  }
>  
> @@ -1224,9 +1228,6 @@ void __init early_init_dt_scan_nodes(void)
>  	/* Retrieve various information from the /chosen node */
>  	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
>  
> -	/* Initialize {size,address}-cells info */
> -	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> -
>  	/* Setup memory, calling early_init_dt_add_memory_arch */
>  	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>  }
> 

