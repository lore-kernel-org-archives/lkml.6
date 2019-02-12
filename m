Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BBAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C57206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TxZJdO9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfBLAeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:34:12 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:56152 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfBLAeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:34:11 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 71B9624E13F1;
        Mon, 11 Feb 2019 16:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549931651; bh=4u4qpnEOiBhDQgMgtxhglyRa/HVZ07/tYzHh0hNk9zs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=TxZJdO9wp1xqlbv+ce99cPtv5TuwcMxsfWmISGJA7oK0akvUNj1fXJZae1vwnnVKv
         KOhFwiY3eilfPk3fRK6HrM85NTk5K87C9nx+h78j+2BgB1HTpSdI6y4KX/uDlsP9S/
         Wby953VrbPlEi/gJ3i/ecc8UCt6xaDnH9WkIMb1yTtf/l4YK/r5bBFaeZUNC+GML53
         d8+cuVtj2u0GRD3bLsmHfE+6EK0sigM4qZ1tPELvvSQK9zt4VbzWrX+6l2FuikB516
         J3qn8B3jEzrHhxf0rdXWuxgSVXwi8VTAELTmSin/3wv1pBmQUIu8PV1/cjZeiWFsu/
         h0FD/v3XQvCUQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8F328A0070;
        Tue, 12 Feb 2019 00:34:09 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 16:31:55 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Feb 2019 06:01:54 +0530
Received: from [10.10.161.59] (10.10.161.59) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Feb 2019 06:01:54 +0530
Subject: Re: [RFC 1/2] ARC: U-boot: check arguments paranoidly
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
CC:     <linux-snps-arc@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, <khilman@baylibre.com>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
 <20190206172228.9261-2-Eugeniy.Paltsev@synopsys.com>
 <b3226062-e177-ef15-b683-71493e91d804@gmail.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <54a865e9-eb95-6dbc-3de0-4f9513095e37@synopsys.com>
Date:   Mon, 11 Feb 2019 16:31:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b3226062-e177-ef15-b683-71493e91d804@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.59]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping ! Are you happy with approach ?

-Vineet

On 2/6/19 2:13 PM, Vineet Gupta wrote:
> On 2/6/19 9:22 AM, Eugeniy Paltsev wrote:
>> Handle U-boot arguments paranoidly:
>>  * don't allow to pass unknown tag.
>>  * try to use external device tree blob only if corresponding tag
>>    (TAG_DTB) is set.
>>  * don't check: uboot_tag if kernel build with no ARC_UBOOT_SUPPORT.
>>
>> While I'm at it refactor U-boot arguments handling code.
>>
>> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>> ---
>>  arch/arc/kernel/head.S  |  2 +-
>>  arch/arc/kernel/setup.c | 65 ++++++++++++++++++++++++++++++++-----------------
>>  2 files changed, 44 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
>> index 8b90d25a15cc..7095055bb874 100644
>> --- a/arch/arc/kernel/head.S
>> +++ b/arch/arc/kernel/head.S
>> @@ -95,7 +95,7 @@ ENTRY(stext)
>>  	;    r0 = [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2
>>  	;    r1 = magic number (board identity, unused as of now
>>  	;    r2 = pointer to uboot provided cmdline or external DTB in mem
>> -	; These are handled later in setup_arch()
>> +	; These are handled later in handle_uboot_args()
>>  	st	r0, [@uboot_tag]
>>  	st	r2, [@uboot_arg]
>>  #endif
>> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
>> index feb90093e6b1..7edb35c26322 100644
>> --- a/arch/arc/kernel/setup.c
>> +++ b/arch/arc/kernel/setup.c
>> @@ -462,43 +462,64 @@ void setup_processor(void)
>>  	arc_chk_core_config();
>>  }
>>  
>> -static inline int is_kernel(unsigned long addr)
>> +static inline bool is_kernel(unsigned long addr)
>>  {
>> -	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
>> -		return 1;
>> -	return 0;
>> +	return addr >= (unsigned long)_stext && addr <= (unsigned long)_end;
>>  }
>>  
>> -void __init setup_arch(char **cmdline_p)
>> +/* uboot_tag values for U-boot - kernel ABI revisions 0+; see head.S */
>> +#define UBOOT_REV0P_TAG_NONE		0
>> +#define UBOOT_REV0P_TAG_CMDLINE		1
>> +#define UBOOT_REV0P_TAG_DTB		2
>> +
>> +void __init handle_uboot_args(void)
>>  {
>> +	bool append_boot_cmdline = false;
>> +	bool use_embedded_dtb = true;
>> +
>>  #ifdef CONFIG_ARC_UBOOT_SUPPORT
>> +	/* check that we know this tag */
>> +	if (uboot_tag != UBOOT_REV0P_TAG_NONE &&
>> +	    uboot_tag != UBOOT_REV0P_TAG_CMDLINE &&
>> +	    uboot_tag != UBOOT_REV0P_TAG_DTB)
>> +		panic("Invalid uboot tag: '%08x'\n", uboot_tag);
>> +
>>  	/* make sure that uboot passed pointer to cmdline/dtb is valid */
>> -	if (uboot_tag && is_kernel((unsigned long)uboot_arg))
>> +	if (uboot_tag != UBOOT_REV0P_TAG_NONE && is_kernel((unsigned long)uboot_arg))
>>  		panic("Invalid uboot arg\n");
>>  
>>  	/* See if u-boot passed an external Device Tree blob */
>> -	machine_desc = setup_machine_fdt(uboot_arg);	/* uboot_tag == 2 */
>> -	if (!machine_desc)
>> +	if (uboot_tag == UBOOT_REV0P_TAG_DTB) {
>> +		machine_desc = setup_machine_fdt(uboot_arg);
>> +
>> +		/* external Device Tree blob is invalid - use embedded one */
>> +		use_embedded_dtb = !machine_desc;
>> +	}
>> +
>> +	if (uboot_tag == UBOOT_REV0P_TAG_CMDLINE)
>> +		append_boot_cmdline = true;
>>  #endif
>> -	{
>> -		/* No, so try the embedded one */
>> +
>> +	if (use_embedded_dtb) {
>>  		machine_desc = setup_machine_fdt(__dtb_start);
>>  		if (!machine_desc)
>>  			panic("Embedded DT invalid\n");
>> +	}
>>  
>> -		/*
>> -		 * If we are here, it is established that @uboot_arg didn't
>> -		 * point to DT blob. Instead if u-boot says it is cmdline,
>> -		 * append to embedded DT cmdline.
>> -		 * setup_machine_fdt() would have populated @boot_command_line
>> -		 */
>> -		if (uboot_tag == 1) {
>> -			/* Ensure a whitespace between the 2 cmdlines */
>> -			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>> -			strlcat(boot_command_line, uboot_arg,
>> -				COMMAND_LINE_SIZE);
>> -		}
>> +	/*
>> +	 * If we are here, U-boot says that @uboot_arg is cmdline, so append it
>> +	 * to embedded DT cmdline.
>> +	 */
>> +	if (append_boot_cmdline) {
>> +		/* Ensure a whitespace between the 2 cmdlines */
>> +		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>> +		strlcat(boot_command_line, uboot_arg, COMMAND_LINE_SIZE);
>>  	}
>> +}
>> +
>> +void __init setup_arch(char **cmdline_p)
>> +{
>> +	handle_uboot_args();
>>  
>>  	/* Save unparsed command line copy for /proc/cmdline */
>>  	*cmdline_p = boot_command_line;
> 
> I think we can grossly simplify all of this w/o adding any new ABI contract
> between kernel and uboot and eliminate CONFIG_ARC_UBOOT_SUPPORT as well (make
> uboot support always enabled)
> 
> So when bootloader runs it passes {0,1,2} in r0 and corresponding arg in r2.
> For jtag case we can assume that core registers will come up reset value of 0 or
> in worst case we rely on user passing -on=clear_regs to Metaware debugger.
> 
> Now as you already figured out, we just need to make sure kernel doesn't try to
> dereference the pointers for bogus values. How does the hunk below look like (and
> in a subsequent patch remove the Kconfig)
> 
> -------------->
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index def19b0ef8c6..cdd8e9a1768a 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c
> @@ -462,44 +462,46 @@ void setup_processor(void)
>  	arc_chk_core_config();
>  }
> 
> -static inline int is_kernel(unsigned long addr)
> -{
> -	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
> -		return 1;
> -	return 0;
> -}
> -
>  void __init setup_arch(char **cmdline_p)
>  {
> -#ifdef CONFIG_ARC_UBOOT_SUPPORT
> -	/* make sure that uboot passed pointer to cmdline/dtb is valid */
> -	if (uboot_tag && is_kernel((unsigned long)uboot_arg))
> -		panic("Invalid uboot arg\n");
> -
> -	/* See if u-boot passed an external Device Tree blob */
> -	machine_desc = setup_machine_fdt(uboot_arg);	/* uboot_tag == 2 */
> -	if (!machine_desc)
> -#endif
> -	{
> -		/* No, so try the embedded one */
> -		machine_desc = setup_machine_fdt(__dtb_start);
> -		if (!machine_desc)
> -			panic("Embedded DT invalid\n");
> +	bool use_embedded_dtb = true;
> +
> +	if (IS_ENABLED(CONFIG_ARC_UBOOT_SUPPORT) && uboot_tag) {
> 
>  		/*
> -		 * If we are here, it is established that @uboot_arg didn't
> -		 * point to DT blob. Instead if u-boot says it is cmdline,
> -		 * append to embedded DT cmdline.
> -		 * setup_machine_fdt() would have populated @boot_command_line
> +		 * ensure u-boot passed pointer is valid
> +		 *   - is a valid untranslated address (although MMU is not
> +		 *     enabled yet, it being a high address ensures this is
> +		 *     not by fluke)
> +		 *   - doesn't clobber resident kernel image
>  		 */
> -		if (uboot_tag == 1) {
> -			/* Ensure a whitespace between the 2 cmdlines */
> -			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> -			strlcat(boot_command_line, uboot_arg,
> -				COMMAND_LINE_SIZE);
> +		if ((unsigned long)uboot_arg < (unsigned long)_end)
> +			panic("Invalid uboot arg\n");
> +
> +		/* validate u-boot passed external Device Tree blob */
> +		if (uboot_tag == 2) {
> +			machine_desc = setup_machine_fdt(uboot_arg);
> +			if (machine_desc)
> +				use_embedded_dtb = false;
>  		}
>  	}
> 
> +	if (use_embedded_dtb) 	{
> +		machine_desc = setup_machine_fdt(__dtb_start);
> +		if (!machine_desc)
> +			panic("Embedded DT invalid\n");
> +	}
> +
> +	/*
> +	 * append u-boot cmdline to embedded DT cmdline.
> +	 * setup_machine_fdt() would have populated @boot_command_line
> +	 */
> +	if (IS_ENABLED(CONFIG_ARC_UBOOT_SUPPORT) && uboot_tag == 1) {
> +		/* Ensure a whitespace between the 2 cmdlines */
> +		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +		strlcat(boot_command_line, uboot_arg, COMMAND_LINE_SIZE);
> +	}
> +
>  	/* Save unparsed command line copy for /proc/cmdline */
>  	*cmdline_p = boot_command_line;
> 

