Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C47C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE02C2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjW4GbeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfBFUZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:25:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39304 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBFUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:25:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so3407787pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 12:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mEPQMob7Y7bIR6a6hOz1uK6fQC1lut6GuEl9je0HyRU=;
        b=PjW4GbeIUem/DTDy+VOwWgI/6WtjuRmmlioLRrbiQPgPReGqDpZSCIkf6umLMTKnfu
         0/50DwjaMm6Z55EG9ylGyks6Ws92Yw4qTV6fW/YIisfqin+FBaLLikurbCJpKUgorPY6
         Hzcfl2XuZjY6oCw9O0IfUQAxC8G+X5LEDMjazhmrMvxcPGkCYTHz2SRlipTVyg9QL9Zr
         tlPyZBKZ+YDUKJzCvcXmssyq/umq2YgyHdfYd/kDAsJMuaAGBMHoePYW3yUGg2L74fiJ
         xDjqWfWLvCi48d2hAAhPWd2ZgqOkyZ7nE76asd/EgechBBNZETIWClGocY1E1Sl8wOLh
         baCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mEPQMob7Y7bIR6a6hOz1uK6fQC1lut6GuEl9je0HyRU=;
        b=NNdDZ671rYx0jd+KRkQl17tkUaiGXDcXjdJ+GKXGjUnGxe1+haAihlLrM7QeqcXfKW
         6lGR9RW19v356YkASfgcK2Qj9U0WqGEYZBqcmhgHvm15o1SYykcox5zv2+oHkiYzesCq
         jImt0oFeO2zeFQAdC3NBgbo1bn7DBRfj7JDsLlHk8bwLNsJ9ZppTm+1bjSa2gWoD+cgc
         A4MbDqixC7dytG02OuQEDQ3Ztpk8ofziLZMaWpFVYWQpmZaDzcX4vjj2d4gKASmbm3iW
         DGby+alM9ZiueNlWh6XK5NJosa3AAeJYHIY3ZrfZdD48yjaa6GzVY8j9vvV4fjyyuHcs
         3NHQ==
X-Gm-Message-State: AHQUAuYCeaSrKPd+hd23qKZA/w1/ms6ZcmFLDjPJg0Y5Z6bljYBB8YCa
        05VJTNhGXTIVX2TYNY984xU=
X-Google-Smtp-Source: AHgI3IZnVFG+Z/D7Pbb7Ys3z97ScsbCVRIcyIe7jsrBsm2KkrcEjjiYKHmNI06DKYN+62Q7XfObjsQ==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr11355655pgf.240.1549484703311;
        Wed, 06 Feb 2019 12:25:03 -0800 (PST)
Received: from ?IPv6:2601:641:c000:8c20:65b1:6954:4d02:2a9a? ([2601:641:c000:8c20:65b1:6954:4d02:2a9a])
        by smtp.gmail.com with ESMTPSA id b26sm15724384pfe.91.2019.02.06.12.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 12:25:02 -0800 (PST)
Subject: Re: [RFC 1/2] ARC: U-boot: check arguments paranoidly
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com
References: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
 <20190206172228.9261-2-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; prefer-encrypt=mutual; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <7f614e3f-9f93-67b1-5422-1795074f2642@gmail.com>
Date:   Wed, 6 Feb 2019 12:25:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206172228.9261-2-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 9:22 AM, Eugeniy Paltsev wrote:
> Handle U-boot arguments paranoidly:
>  * don't allow to pass unknown tag.
>  * try to use external device tree blob only if corresponding tag
>    (TAG_DTB) is set.
>  * don't check: uboot_tag if kernel build with no ARC_UBOOT_SUPPORT.
> 
> While I'm at it refactor U-boot arguments handling code.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  arch/arc/kernel/head.S  |  2 +-
>  arch/arc/kernel/setup.c | 65 ++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
> index 8b90d25a15cc..7095055bb874 100644
> --- a/arch/arc/kernel/head.S
> +++ b/arch/arc/kernel/head.S
> @@ -95,7 +95,7 @@ ENTRY(stext)
>  	;    r0 = [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2
>  	;    r1 = magic number (board identity, unused as of now
>  	;    r2 = pointer to uboot provided cmdline or external DTB in mem
> -	; These are handled later in setup_arch()
> +	; These are handled later in handle_uboot_args()
>  	st	r0, [@uboot_tag]
>  	st	r2, [@uboot_arg]
>  #endif
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index feb90093e6b1..7edb35c26322 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c
> @@ -462,43 +462,64 @@ void setup_processor(void)
>  	arc_chk_core_config();
>  }
>  
> -static inline int is_kernel(unsigned long addr)
> +static inline bool is_kernel(unsigned long addr)
>  {
> -	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
> -		return 1;
> -	return 0;

So even though I wrote it eons ago I was confused myself. We panic if this is 1,
because this addr seems inside kernel's resident image (code/data). So add that
comment maybe.

> +	return addr >= (unsigned long)_stext && addr <= (unsigned long)_end;
>  }
>  
> -void __init setup_arch(char **cmdline_p)
> +/* uboot_tag values for U-boot - kernel ABI revisions 0+; see head.S */

Just call it ABI 0, and we call the new ABI 1.

> +#define UBOOT_REV0P_TAG_NONE		0
> +#define UBOOT_REV0P_TAG_CMDLINE		1
> +#define UBOOT_REV0P_TAG_DTB		2
> +
> +void __init handle_uboot_args(void)
>  {
> +	bool append_boot_cmdline = false;
> +	bool use_embedded_dtb = true;
> +
>  #ifdef CONFIG_ARC_UBOOT_SUPPORT
> +	/* check that we know this tag */
> +	if (uboot_tag != UBOOT_REV0P_TAG_NONE &&
> +	    uboot_tag != UBOOT_REV0P_TAG_CMDLINE &&
> +	    uboot_tag != UBOOT_REV0P_TAG_DTB)
> +		panic("Invalid uboot tag: '%08x'\n", uboot_tag);
> +
>  	/* make sure that uboot passed pointer to cmdline/dtb is valid */
> -	if (uboot_tag && is_kernel((unsigned long)uboot_arg))
> +	if (uboot_tag != UBOOT_REV0P_TAG_NONE && is_kernel((unsigned long)uboot_arg))
>  		panic("Invalid uboot arg\n");
>  
>  	/* See if u-boot passed an external Device Tree blob */
> -	machine_desc = setup_machine_fdt(uboot_arg);	/* uboot_tag == 2 */
> -	if (!machine_desc)
> +	if (uboot_tag == UBOOT_REV0P_TAG_DTB) {
> +		machine_desc = setup_machine_fdt(uboot_arg);
> +
> +		/* external Device Tree blob is invalid - use embedded one */
> +		use_embedded_dtb = !machine_desc;
> +	}
> +
> +	if (uboot_tag == UBOOT_REV0P_TAG_CMDLINE)
> +		append_boot_cmdline = true;
>  #endif
> -	{
> -		/* No, so try the embedded one */
> +
> +	if (use_embedded_dtb) {
>  		machine_desc = setup_machine_fdt(__dtb_start);
>  		if (!machine_desc)
>  			panic("Embedded DT invalid\n");
> +	}
>  
> -		/*
> -		 * If we are here, it is established that @uboot_arg didn't
> -		 * point to DT blob. Instead if u-boot says it is cmdline,
> -		 * append to embedded DT cmdline.
> -		 * setup_machine_fdt() would have populated @boot_command_line
> -		 */
> -		if (uboot_tag == 1) {
> -			/* Ensure a whitespace between the 2 cmdlines */
> -			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> -			strlcat(boot_command_line, uboot_arg,
> -				COMMAND_LINE_SIZE);
> -		}
> +	/*
> +	 * If we are here, U-boot says that @uboot_arg is cmdline, so append it
> +	 * to embedded DT cmdline.
> +	 */

This comment is useless after the more descriptive variable names.

> +	if (append_boot_cmdline) {
> +		/* Ensure a whitespace between the 2 cmdlines */
> +		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +		strlcat(boot_command_line, uboot_arg, COMMAND_LINE_SIZE);
>  	}
> +}
> +
> +void __init setup_arch(char **cmdline_p)
> +{
> +	handle_uboot_args();
>  
>  	/* Save unparsed command line copy for /proc/cmdline */
>  	*cmdline_p = boot_command_line;
> 

