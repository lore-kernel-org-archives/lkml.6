Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755262075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhaF7Wj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755262075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeIHAg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:36:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36602 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHAg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:36:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id e11-v6so7042209plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fZlxA3XxwyWrVnQu5BuPgAUBtCuHGr1nqgpvY3ihLeY=;
        b=bhaF7Wj05Sdr1d7Ii79koEQEpO3BTE70kcnwnnY3R83jOps/f7IXDzwJL2iPHREB2s
         iN3fbU4dgysMmsZcnfn9JtYQts3GrB0bsb0/1OSS5H6gBJxjtkXxho1iKN+Y5DDWO9nX
         MJRvLmLKV8ywrPnHi1x5/dr3vvCTpV24xsX8Eptely1IEDsmG695PlShTG6BNNq2lS5R
         uQPkL3S5ynJ19m8zvv7SEsWsyLb0ndPiMcNZw2uHwFRW70j6na41hciV801RdzCOqLdL
         YrSalDRaQTfVbD6iWXVUcQ1/hD5x5T1tsMw46Rejk8SBGQ1wr4wlSrXCLqA+n6psbrYK
         ywjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZlxA3XxwyWrVnQu5BuPgAUBtCuHGr1nqgpvY3ihLeY=;
        b=DNQxkqN1bIVLhoktJOIPlDyRoBqNnGnQZO51hzgYx7aogyknnPS73ThPzIHi5yqkk2
         jOUYSNZTcAUnCyTuV3hYslRIxK7Hy8qew40eaeIufD0+7PTKHA+AySpNezxDDBow8eNF
         ++WNeqZgvZGxkvI9AhbgDCgCjRCl+cfhtFqawgiPqFLcmwR1Fh2HycBSsdmMX0i+K5IW
         o3Ozucel3b1Ypt+ZjRqIYb5xRgG26kdG02/aCcPqu9fKK8iaAN3Fk9OrNyFaQEU4U3sS
         f29OwfKFUEdK1TcMGlaZF1c+G8+jDvv8rW0ZpibzEektTafGcFHkEHEbjbJsPVrvaCfp
         FdOw==
X-Gm-Message-State: APzg51An/gPZ06l2rnBf9PZawvxZqXyh810U8eeXfpKemtrsIbkYGrAa
        LPptFHjJnhcH2/Ey+1KIDLMm+BR8
X-Google-Smtp-Source: ANB0VdZRck5sUC0qF0NsKcSO5/mmS0Uqo5WizY0NPD4Lnz+SIn8Y4HSjMpCQoqJZcqOVWVvilvO/lw==
X-Received: by 2002:a17:902:25ab:: with SMTP id y40-v6mr9520363pla.120.1536350041245;
        Fri, 07 Sep 2018 12:54:01 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id y69-v6sm18670724pfd.36.2018.09.07.12.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:54:00 -0700 (PDT)
Subject: Re: [PATCH v14 06/16] of/fdt: add helper functions for handling
 properties
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a535515a-92f1-fc33-bdb9-6f5e0392cb11@gmail.com>
Date:   Fri, 7 Sep 2018 12:53:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 01:00, AKASHI Takahiro wrote:
> These functions will be used later to handle kexec-specific properties
> in arm64's kexec_file implementation.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> ---
>  drivers/of/fdt.c       | 62 ++++++++++++++++++++++++++++++++++++++++--
>  include/linux/of_fdt.h | 10 +++++--
>  2 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 800ad252cf9c..dc960cea1355 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -25,6 +25,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/serial_core.h>
>  #include <linux/sysfs.h>
> +#include <linux/types.h>
>  
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
> @@ -537,8 +538,8 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>  
>  /* Everything below here references initial_boot_params directly. */
> -int __initdata dt_root_addr_cells;
> -int __initdata dt_root_size_cells;
> +int dt_root_addr_cells;
> +int dt_root_size_cells;
>  
>  void *initial_boot_params;
>  
> @@ -1323,3 +1324,60 @@ late_initcall(of_fdt_raw_init);
>  #endif
>  
>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> +

Please add comment:

/* helper functions for arm64 kexec */


> +bool of_fdt_cells_size_fitted(u64 base, u64 size)

Please rename as of_fdt_range_valid()


> +{
> +	/* if *_cells >= 2, cells can hold 64-bit values anyway */
> +	if ((dt_root_addr_cells == 1) && (base > U32_MAX))
> +		return false;
> +
> +	if ((dt_root_size_cells == 1) && (size > U32_MAX))
> +		return false;

Should also check that base + size does not wrap around.


> +
> +	return true;
> +}
> +
> +size_t of_fdt_reg_cells_size(void)

Please rename as of_fdt_root_range_size()


> +{
> +	return (dt_root_addr_cells + dt_root_size_cells) * sizeof(u32);
> +}
> +
> +#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> +#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
> +
> +int fdt_prop_len(const char *prop_name, int len)

Please rename as fdt_len_added_prop()


> +{
> +	return (strlen(prop_name) + 1) +
> +		sizeof(struct fdt_property) +
> +		FDT_TAGALIGN(len);
> +}
> +

Please add comment, something like:

/* cells must be 1 or 2 */


> +static void fill_property(void *buf, u64 val64, int cells)

Please rename as cpu64_to_fdt_cells()

Thanks,

Frank

> +{
> +	__be32 val32;
> +
> +	while (cells) {
> +		val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> +		memcpy(buf, &val32, sizeof(val32));
> +		buf += sizeof(val32);
> +	}
> +}
> +
> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> +						u64 addr, u64 size)
> +{
> +	char buf[sizeof(__be32) * 2 * 2];
> +		/* assume dt_root_[addr|size]_cells <= 2 */
> +	void *prop;
> +	size_t buf_size;
> +
> +	buf_size = of_fdt_reg_cells_size();
> +	prop = buf;
> +
> +	fill_property(prop, addr, dt_root_addr_cells);
> +	prop += dt_root_addr_cells * sizeof(u32);
> +
> +	fill_property(prop, size, dt_root_size_cells);
> +
> +	return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> +}
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index b9cd9ebdf9b9..9615d6142578 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -37,8 +37,8 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
>  				   struct device_node **mynodes);
>  
>  /* TBD: Temporary export of fdt globals - remove when code fully merged */
> -extern int __initdata dt_root_addr_cells;
> -extern int __initdata dt_root_size_cells;
> +extern int dt_root_addr_cells;
> +extern int dt_root_size_cells;
>  extern void *initial_boot_params;
>  
>  extern char __dtb_start[];
> @@ -108,5 +108,11 @@ static inline void unflatten_device_tree(void) {}
>  static inline void unflatten_and_copy_device_tree(void) {}
>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>  
> +bool of_fdt_cells_size_fitted(u64 base, u64 size);
> +size_t of_fdt_reg_cells_size(void);
> +int fdt_prop_len(const char *prop_name, int len);
> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> +						u64 addr, u64 size);
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* _LINUX_OF_FDT_H */
> 

