Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477CBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056AE23C13
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8WZlsJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056AE23C13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeGFQvP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:51:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53860 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeGFQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:51:13 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so17338160itd.3;
        Fri, 06 Jul 2018 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VHh1/4zIjvV7f1rIyksq4Q2AyqHDaR5fqzSl2aO1WEE=;
        b=s8WZlsJNmUyfHD4YM3b5fVzxntx57SEjTyGbfvm8mJWwYCkoI+/MyzRiV5JGk+N1Op
         rS90dcB4gS8yzWhNnw7qvzLuSKrvy2HqwZpeC0Jfi7HlukupYwW8V6etDxPgdskifre4
         W/LaPJuzgzLGj5Ta6fR6kocCoC1P75zvYHrYxOH45tDrQ2Q8tfoJeywjQSpeBsSn/s9/
         IROotq66v2zITei/rFkuZEt00X1G0cwT9uAuGFHHnF5rWglrZ410iHXHQBcoE7c5S9Ui
         2chZuyCeHncpo9K5nEPgQPEEa+FE+Ok0abKlNrRBuuOxiK9q7GQGmqS/eQcJhYq/mhmt
         78DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VHh1/4zIjvV7f1rIyksq4Q2AyqHDaR5fqzSl2aO1WEE=;
        b=ReGyiZ5FA/eA6YJVPyrq0+xucdDU+pKbVf8YwbyK4oOAOsnmh+OVm+/90T7OZYkfx6
         nEpqZX7/zBIN6Q+eHUUoXG1gOBrX7dJ34Cz2nBeYreKGv+NU6CN0QCt1gSKPOxAwPi3m
         2TGIEa+e00cw5h2SVnW+ASP43wVRcMBI5gOZioTMCnXy6wXqlSzVwvD7qXxxysg2z790
         capM0DSfXtPbTM3uNGnySy1Gu8drcQvO69LfpruPIrXZ3SYoKr0UuW5gNhd7YCLycbth
         WXG8cArpMCG9I6ELzr8nWsZq5AYNrFomwXEPOlOMwNtBHpZcF16oOqCaFv5fJftSE2UC
         0hBA==
X-Gm-Message-State: APt69E3xROFXGNIUrsHb1O5V/L+hbWMwT7goUO4Az5j9ToIJzZPCtoMd
        p36hDjGPVV8GyqPcSXBZILQ=
X-Google-Smtp-Source: AAOMgpfe6HIoKfLyBgp6Lp9e6j0aFwHc5vIERs+huBarXPFcuOtRPLwllFHskayPrkNUi/y2x5taoQ==
X-Received: by 2002:a02:954d:: with SMTP id y71-v6mr9359460jah.19.1530895873154;
        Fri, 06 Jul 2018 09:51:13 -0700 (PDT)
Received: from [192.168.50.98] ([69.47.233.55])
        by smtp.gmail.com with ESMTPSA id 136-v6sm5196681itm.23.2018.07.06.09.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:51:12 -0700 (PDT)
Subject: Re: [PATCH] of/fdt: avoid undefined behaviour in
 populate_properties()
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20180706113715.30053-1-mark.rutland@arm.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <c1f615b6-6e56-414c-b4f8-e75ad4c114e7@gmail.com>
Date:   Fri, 6 Jul 2018 09:51:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706113715.30053-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/18 04:37, Mark Rutland wrote:
> We unflatten a device tree in two passes: the first calculating the size
> of the unflattened tree, and the second performing the actual
> unflattening into a suitably-sized buffer.
> 
> During the first (dryrun) pass, the memory pool is NULL, and we derive
> other pointers from this. Mostly these are done though intermediate
> casts to unsigned long, which prevents the compiler from being able to
> observe this as undefined behaviour. However, in populate_properties()
> we derive the pprev pointer from the np pointer, which is NULL if it is
> the first element allocated from the memory pool.
> 
> This is detected by UBSAN:
> 
> ================================================================================
> UBSAN: Undefined behaviour in drivers/of/fdt.c:190:8
> member access within null pointer of type 'struct device_node'
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc3+ #13
> Hardware name: ARM Juno development board (r1) (DT)
> Call trace:
>  dump_backtrace+0x0/0x458
>  show_stack+0x20/0x30
>  dump_stack+0x18c/0x248
>  ubsan_epilogue+0x18/0x94
>  handle_null_ptr_deref+0x1d4/0x228
>  __ubsan_handle_type_mismatch_v1+0x188/0x1e0
>  unflatten_dt_nodes+0xd40/0x1000
>  __unflatten_device_tree+0x58/0x248
>  unflatten_device_tree+0x38/0x4c
>  setup_arch+0x3b0/0xcc4
>  start_kernel+0xd8/0xb9c
> ================================================================================
> 
> In the dryrun pass we don't actually use the pprev value, so let's only
> set it when !dryrun, and avoid the undefined behaviour.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/of/fdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 6da20b9688f7..c1d0c348f2b3 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -187,7 +187,9 @@ static void populate_properties(const void *blob,
>  	int cur;
>  	bool has_name = false;
>  
> -	pprev = &np->properties;
> +	if (!dryrun)
> +		pprev = &np->properties;
> +
>  	for (cur = fdt_first_property_offset(blob, offset);
>  	     cur >= 0;
>  	     cur = fdt_next_property_offset(blob, cur)) {
> 

Please add a one line comment explaining why "if (!dryrun)" so that no one
decides to remove the test in the future as not needed.  Otherwise,

Reviewed-by: Frank Rowand <frank.rowand@sony.com>

-Frank
