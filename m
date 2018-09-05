Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F0DC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC0420869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si8045YZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC0420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeIEGWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:22:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43826 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEGWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:22:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so2484391plv.10;
        Tue, 04 Sep 2018 18:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jSu3Tnv4Suvym0TdNDWpnRmgc1IGVVG8+wYxPonTSSQ=;
        b=Si8045YZA4Grf/u/zYidVkDjBdwQ/miNmM9uMtEYWa/7oHZK5iS8Fr9yGWHLYayjv1
         uIeyZP3I/clTqJ2CN+NiiIwVrWzW5BmAKQzBPIhzWVRUUtMC5+QLdvkvcZoAiopj8HDa
         GiLW2zBoh4KL95de0Ssx6oeKDP1UdROwryN5yX+NcQEYHaXE3Kd8x3DRLeqB9Vv4uHX2
         Gd423rOf6hIDkEzTVjE3vL8uNh3MeLI/skzcYByLCztb+6VCOnTajY172qZekLFacXBC
         fYL56crTsF91yC05xLeb+ZB6C/gWc7EsB45M4n01xF6UTxfxhhCdiecYmPg3cIG2E7g1
         WhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jSu3Tnv4Suvym0TdNDWpnRmgc1IGVVG8+wYxPonTSSQ=;
        b=AeKZNkn+dkQFZxezz4CSH7sT1HHR7gvwyVf7rslrC9mm4whurEW+o+kXxpoHKhcjB6
         baUJsDODk96pTrhxSCYx/O3Q0n9NH4Gcw+U7NYgac/fedFBBTbDAJiZ4XYG41SDJKu3C
         rZttL05QCKyqOYncEKoNyA2aM6/HJ7+g7GSYJ6YdkUaHujQHk5Q9I24I8kM/WAgBdR3m
         YsBjOAG8qYRT6gD+IGIc6tU4SAKTM/fVNQiFbwbcWRMxUE9x6hq/sH0nCtsGyiMV7tTN
         nL6Wp0fVvXcrN36BMbL7cIHvTBKwseFvWUbGP3+z0HwR8U0s5zWCxWQqzzY6rSADPS5G
         +9sw==
X-Gm-Message-State: APzg51CUyuY1+KIrmYKPU318aO1HRRY0DOVfsafZP0I5KOtepU+LWBia
        NluTgMCxZS7y4GPuCoRkDeNJTdFD
X-Google-Smtp-Source: ANB0VdZ3vvgovuPVv5nEU0DCgvC8yBrL3vOzJeUsIe6Qh0cNDAzQP3oRdAteJ++Ow2kDyHGx2Aarxg==
X-Received: by 2002:a17:902:b218:: with SMTP id t24-v6mr5036648plr.235.1536112463633;
        Tue, 04 Sep 2018 18:54:23 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 6-v6sm328367pgf.38.2018.09.04.18.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 18:54:23 -0700 (PDT)
Subject: Re: [PATCH 2/3] of/fdt: avoid re-parsing '#{address,size}-cells' in
 of_fdt_limit_memory
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180830190523.31474-1-robh@kernel.org>
 <20180830190523.31474-3-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <8b866d4d-1362-311d-5a6e-3e414d8f90ab@gmail.com>
Date:   Tue, 4 Sep 2018 18:54:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830190523.31474-3-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 12:05, Rob Herring wrote:
> Now that we initialize dt_root_addr_cells and dt_root_size_cells earlier,
> use them and simplify of_fdt_limit_memory.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/fdt.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 49abe18f1bde..fef4b2c8a171 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c

As kbuild test robot noted, of_fdt_limit_memory() will access
__initdata dt_root_addr_cells and __initdata dt_root_size_cells.
A possible (untested) fix would be:

- void of_fdt_limit_memory(int limit)
- {

+ void __init of_fdt_limit_memory(int limit)
+ {


> @@ -44,28 +44,7 @@ void of_fdt_limit_memory(int limit)
>  	int memory;
>  	int len;
>  	const void *val;
> -	int nr_address_cells = OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
> -	int nr_size_cells = OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
> -	const __be32 *addr_prop;
> -	const __be32 *size_prop;
> -	int root_offset;
> -	int cell_size;
> -
> -	root_offset = fdt_path_offset(initial_boot_params, "/");
> -	if (root_offset < 0)
> -		return;
> -
> -	addr_prop = fdt_getprop(initial_boot_params, root_offset,
> -				"#address-cells", NULL);
> -	if (addr_prop)
> -		nr_address_cells = fdt32_to_cpu(*addr_prop);
> -
> -	size_prop = fdt_getprop(initial_boot_params, root_offset,
> -				"#size-cells", NULL);
> -	if (size_prop)
> -		nr_size_cells = fdt32_to_cpu(*size_prop);
> -
> -	cell_size = sizeof(uint32_t)*(nr_address_cells + nr_size_cells);
> +	int cell_size = sizeof(uint32_t)*(dt_root_addr_cells + dt_root_size_cells);
>  
>  	memory = fdt_path_offset(initial_boot_params, "/memory");
>  	if (memory > 0) {
> 

