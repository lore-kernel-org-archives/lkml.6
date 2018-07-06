Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACDEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E8423E8C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soqwDxas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E8423E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeGFLmW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:42:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55904 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeGFLmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:42:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so14609622wmv.5;
        Fri, 06 Jul 2018 04:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BxTBb1dOk8aT5MZMFGJakb+Gi/SKyYeUKHIP0onHjU4=;
        b=soqwDxasWDVUlye/9XEu+t2+uGVsYvJeV96Q8LJwwwHknmhDxz03OoPKfH/czKfPZ/
         6zJpMn9+VQTpxnu3TMyhJ2kKSYx6d/Ym0onPZLD9YBYFYmUuT6mhPh8F3CF3/OMe0wLj
         sQGLCp8lA88m/eodDuVbRrgONAxvS6WCfVS89w7yNq8/eiJ8gAnGXnumwprR/lpVO8XS
         hBlCI3+44m4P/YGhR2FlKnu4qfRbRe1B5efQKMKwbU4xFrM+Sd2JwwMvISiP6pwiQnW6
         Vee3XF2TibK8sK5oM0lNbd0eP8SATGV4kXZ7Ov1oGwdH1y1iFMd340DxK6Gk3ByNHsTZ
         4GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxTBb1dOk8aT5MZMFGJakb+Gi/SKyYeUKHIP0onHjU4=;
        b=Zhvkr93lO2CIM5RV27F+ktRTjMR+xItmS4de8AxSWvNv+QU/EpccPbPoJuLn3Oz8Lx
         YgI5VUJxp+1QJTPe1T+Z63PGpm9FSc7KJUDNgJgs6W2EyRHi0jYJ13xACQ0ZmlofU2mA
         3+VjZvisV6fUz/rLWRoO3YQTJrFWFyxcQvNYV5937WaB9Dl8Ti9+MKv54hHs4ud30Q4q
         4FM898NcD+fq1pOJyGmc3PflypEnS/aSRzeO5tMwXgvgSODsrGyZnrYNSKB3Z+Qybzu1
         nk0q4lWmPshbd666GNn3RpmXIqJWvsABgyfsBMIfI/MShb1T+ayvvLHk3PI8cj5XDq98
         Rvpw==
X-Gm-Message-State: APt69E3F4qxErozTZ8A6ukoeK6wkM6vjuAk1XNnJwhQXC0zuL5GlwB5V
        /r5CeaAAvCakbREJiTUpyhQ+2k3l
X-Google-Smtp-Source: AAOMgpecniKQEr+sozAzw5Btqi8+a50R1PpaVq3ni/tLXRx3wqkbVOmsoQBTnoriZSraHQR5Ia89hg==
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr754999wmx.75.1530877338672;
        Fri, 06 Jul 2018 04:42:18 -0700 (PDT)
Received: from wintermute (HSI-KBW-078-043-112-026.hsi4.kabel-badenwuerttemberg.de. [78.43.112.26])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5913588wrn.34.2018.07.06.04.42.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 04:42:17 -0700 (PDT)
From:   Jan Glauber <jglauber@cavium.com>
X-Google-Original-From: Jan Glauber <jglauber@caviumnetworks.com>
Date:   Fri, 6 Jul 2018 13:42:16 +0200
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, thunderx: Remove VLA usage
Message-ID: <20180706114216.GA31180@wintermute>
References: <20180629184850.GA37464@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629184850.GA37464@beast>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:48:50AM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a kmalloc-allocated buffer instead of stack space.
> This should be fine since the existing routine is allocating memory
> too.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: David Daney <david.daney@cavium.com>
> Cc: Jan Glauber <jglauber@cavium.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-edac@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Jan Glauber <jglauber@cavium.com>

thanks,
Jan

> ---
>  drivers/edac/thunderx_edac.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index 4803c6468bab..c009d94f40c5 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -408,26 +408,29 @@ static ssize_t thunderx_lmc_inject_ecc_write(struct file *file,
>  					     size_t count, loff_t *ppos)
>  {
>  	struct thunderx_lmc *lmc = file->private_data;
> -
>  	unsigned int cline_size = cache_line_size();
> -
> -	u8 tmp[cline_size];
> +	u8 *tmp;
>  	void __iomem *addr;
>  	unsigned int offs, timeout = 100000;
>  
>  	atomic_set(&lmc->ecc_int, 0);
>  
>  	lmc->mem = alloc_pages_node(lmc->node, GFP_KERNEL, 0);
> -
>  	if (!lmc->mem)
>  		return -ENOMEM;
>  
> +	tmp = kmalloc(cline_size, GFP_KERNEL);
> +	if (!tmp) {
> +		__free_pages(lmc->mem, 0);
> +		return -ENOMEM;
> +	}
> +
>  	addr = page_address(lmc->mem);
>  
>  	while (!atomic_read(&lmc->ecc_int) && timeout--) {
>  		stop_machine(inject_ecc_fn, lmc, NULL);
>  
> -		for (offs = 0; offs < PAGE_SIZE; offs += sizeof(tmp)) {
> +		for (offs = 0; offs < PAGE_SIZE; offs += cline_size) {
>  			/*
>  			 * Do a load from the previously rigged location
>  			 * This should generate an error interrupt.
> @@ -437,6 +440,7 @@ static ssize_t thunderx_lmc_inject_ecc_write(struct file *file,
>  		}
>  	}
>  
> +	kfree(tmp);
>  	__free_pages(lmc->mem, 0);
>  
>  	return count;
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security
