Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC22C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01113218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Idb+ldeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfBFWNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:13:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39223 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:13:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so3777479pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 14:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NVuH4SbEW4AObY4WDkB8pO1tE+iBq82Ll8X22QEyUsw=;
        b=Idb+ldeDJ3sZVfnW6i40ld16tfPoQNxuRY+D8qqgUSnBKWjqBPCEwS8tc7FuqzYPLo
         4Pcss/DvHwcx+BwRSPay6XF+AykZwPAdAykLWpk2BzqPclxFqkY+1dDIVPmHyFhV70JP
         NAhnwoojnFJynUjfwi7phD2dC1ZUn96lkQVHepE3NHSOPm7C4tuvkneY8aXAJENgrcoQ
         4W78LwMzIY9ucalQVkq2l2oEH9NywEFY/SS+9B7oP7hNOuihmxOKJKHxxKi9zx04hB/b
         +xy8N7XfgfQI52qUrwfhP3X8pR7ag5GbYrn3wbf6ZpjuLr8uU4RhDVoWIu6Uk1fQEnGP
         q0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NVuH4SbEW4AObY4WDkB8pO1tE+iBq82Ll8X22QEyUsw=;
        b=I0G194db22RiZlZ4LvltX3sjGOnRJQi04s9kvv3CbxhZ+gfYC9JphCrwlRBmCd4UDB
         vvWKLK60CRl40nLBZIVtJnW2f0MIbc5odCr0x3L8bYpjhFrj59wO9+a7ru1cRJpyv4uH
         jCF/KSxEDzaOWa33g3aBCzd/8s8kTha6Du3b66Z4xhfBWw0/fHRET0XlinKuPOesA63o
         Vttnpsqzb0YjHrf/frSHZ/YyijEiixeacHdC7rq/SetaPpmQYfFXFdkUQkmIvFyEOxAg
         oA0Z1KGoyoAtifu/HNmvm0oyf5T6VMm87eRs5Tk17W9h6y+eZT1BYP4yIJ5wYMl5uVnm
         w7Fg==
X-Gm-Message-State: AHQUAuY2ImE2oEf0eZJMGHJQupkSsyrGrxuWl5hc52sZOisGDJqz7134
        XHeEicUhL/9QfnCWWt8rlgo=
X-Google-Smtp-Source: AHgI3IapRWHi5tjsA2tK2XP05IaPeg2nbAEO4yzxXye8LAJW/oqqDU8NmpddhHwsw44ju1DYlw7dgw==
X-Received: by 2002:a17:902:8b81:: with SMTP id ay1mr6553415plb.320.1549491198165;
        Wed, 06 Feb 2019 14:13:18 -0800 (PST)
Received: from ?IPv6:2601:641:c000:8c20:65b1:6954:4d02:2a9a? ([2601:641:c000:8c20:65b1:6954:4d02:2a9a])
        by smtp.gmail.com with ESMTPSA id f8sm5469907pga.24.2019.02.06.14.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 14:13:17 -0800 (PST)
Subject: Re: [RFC 1/2] ARC: U-boot: check arguments paranoidly
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com
References: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
 <20190206172228.9261-2-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Message-ID: <b3226062-e177-ef15-b683-71493e91d804@gmail.com>
Date:   Wed, 6 Feb 2019 14:13:16 -0800
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
> +	return addr >= (unsigned long)_stext && addr <= (unsigned long)_end;
>  }
>  
> -void __init setup_arch(char **cmdline_p)
> +/* uboot_tag values for U-boot - kernel ABI revisions 0+; see head.S */
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

I think we can grossly simplify all of this w/o adding any new ABI contract
between kernel and uboot and eliminate CONFIG_ARC_UBOOT_SUPPORT as well (make
uboot support always enabled)

So when bootloader runs it passes {0,1,2} in r0 and corresponding arg in r2.
For jtag case we can assume that core registers will come up reset value of 0 or
in worst case we rely on user passing -on=clear_regs to Metaware debugger.

Now as you already figured out, we just need to make sure kernel doesn't try to
dereference the pointers for bogus values. How does the hunk below look like (and
in a subsequent patch remove the Kconfig)

-------------->
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index def19b0ef8c6..cdd8e9a1768a 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -462,44 +462,46 @@ void setup_processor(void)
 	arc_chk_core_config();
 }

-static inline int is_kernel(unsigned long addr)
-{
-	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
-		return 1;
-	return 0;
-}
-
 void __init setup_arch(char **cmdline_p)
 {
-#ifdef CONFIG_ARC_UBOOT_SUPPORT
-	/* make sure that uboot passed pointer to cmdline/dtb is valid */
-	if (uboot_tag && is_kernel((unsigned long)uboot_arg))
-		panic("Invalid uboot arg\n");
-
-	/* See if u-boot passed an external Device Tree blob */
-	machine_desc = setup_machine_fdt(uboot_arg);	/* uboot_tag == 2 */
-	if (!machine_desc)
-#endif
-	{
-		/* No, so try the embedded one */
-		machine_desc = setup_machine_fdt(__dtb_start);
-		if (!machine_desc)
-			panic("Embedded DT invalid\n");
+	bool use_embedded_dtb = true;
+
+	if (IS_ENABLED(CONFIG_ARC_UBOOT_SUPPORT) && uboot_tag) {

 		/*
-		 * If we are here, it is established that @uboot_arg didn't
-		 * point to DT blob. Instead if u-boot says it is cmdline,
-		 * append to embedded DT cmdline.
-		 * setup_machine_fdt() would have populated @boot_command_line
+		 * ensure u-boot passed pointer is valid
+		 *   - is a valid untranslated address (although MMU is not
+		 *     enabled yet, it being a high address ensures this is
+		 *     not by fluke)
+		 *   - doesn't clobber resident kernel image
 		 */
-		if (uboot_tag == 1) {
-			/* Ensure a whitespace between the 2 cmdlines */
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-			strlcat(boot_command_line, uboot_arg,
-				COMMAND_LINE_SIZE);
+		if ((unsigned long)uboot_arg < (unsigned long)_end)
+			panic("Invalid uboot arg\n");
+
+		/* validate u-boot passed external Device Tree blob */
+		if (uboot_tag == 2) {
+			machine_desc = setup_machine_fdt(uboot_arg);
+			if (machine_desc)
+				use_embedded_dtb = false;
 		}
 	}

+	if (use_embedded_dtb) 	{
+		machine_desc = setup_machine_fdt(__dtb_start);
+		if (!machine_desc)
+			panic("Embedded DT invalid\n");
+	}
+
+	/*
+	 * append u-boot cmdline to embedded DT cmdline.
+	 * setup_machine_fdt() would have populated @boot_command_line
+	 */
+	if (IS_ENABLED(CONFIG_ARC_UBOOT_SUPPORT) && uboot_tag == 1) {
+		/* Ensure a whitespace between the 2 cmdlines */
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, uboot_arg, COMMAND_LINE_SIZE);
+	}
+
 	/* Save unparsed command line copy for /proc/cmdline */
 	*cmdline_p = boot_command_line;

-- 
2.7.4

