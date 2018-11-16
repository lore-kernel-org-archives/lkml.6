Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8E4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E3C2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hjuzqfwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E3C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbeKQADW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:03:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38770 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeKQADW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:03:22 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542376251; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3X8CklvEmkvgWLWLHZ5kTxsga9PUjD9YHyfB6EUQ9U4=;
        b=hjuzqfwLA9nRca/H63hRAjbsgvfstQJXwyF1MMEXSpUd0r2Ke2ORZT80auEjZzYpAkyeyK
        pdYMZ1McXStqTQZKMhn62CooCb771LAixj0mzbbiFXpLzFsiWyc6/xi7uGtwmyCbZZX1CC
        e2dV6HCo9USuMgVTm2/E0klUQOtFyJg=
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nOm4npYJLoTa; Fri, 16 Nov 2018 14:50:45 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0FE004D130AD2F34E6DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:fe00:4d13:ad2:f34e:6de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 243A81EC03C8;
        Fri, 16 Nov 2018 14:50:45 +0100 (CET)
Date:   Fri, 16 Nov 2018 14:50:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 5/5] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20181116135039.GE20313@zn.tnic>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-6-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112094645.4879-6-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Subject: Re: [PATCH v11 5/5] x86/boot/KASLR: Walk srat tables to filter immovable memory

s/srat/SRAT/g

On Mon, Nov 12, 2018 at 05:46:45PM +0800, Chao Fan wrote:
> KASLR may randomly chooses some positions which are located in movable

		    choose

> memory regions. This will break memory hotplug feature and make the
> movable memory chosen by KASLR can't be removed.

			by KASLR practically immovable.

:)

> The solution is limite KASLR to choose memory regions in immovable

limite?

"to limit"

> node according to SRAT tables.
> 
> If CONFIG_MEMORY_HOTREMOVE enabled, walk through the SRAT memory

			   *is* enabled,

> tables and store those immovable memory regions so that KASLR can get
> where to choose for randomization.
> 
> If the amount of immovable memory regions is not zero, which
> means the immovable memory regions existing. Calculate the intersection
> between memory regions from e820/efi memory table and immovable memory
> regions.

This is explaining *what* the patch does and generally doesn't need to
be in the commit messge as people can read it in the patch itself.

> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 77 +++++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index b251572e77af..174d2114045e 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -97,6 +97,11 @@ static bool memmap_too_large;
>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>  static unsigned long long mem_limit = ULLONG_MAX;
>  
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/* Store the immovable memory regions */
> +extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +#endif

For this and the other occurrences of ifdef CONFIG_MEMORY_HOTREMOVE,
define empty stubs for those functions in a header and remove the
ifdeffery at the call sites.

> +
>  
>  enum mem_avoid_index {
>  	MEM_AVOID_ZO_RANGE = 0,
> @@ -413,6 +418,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>  	/* Mark the memmap regions we need to avoid */
>  	handle_mem_options();
>  
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +	/* Mark the immovable regions we need to choose */
> +	get_immovable_mem();
> +#endif
> +
>  #ifdef CONFIG_X86_VERBOSE_BOOTUP
>  	/* Make sure video RAM can be used. */
>  	add_identity_map(0, PMD_SIZE);
> @@ -568,9 +578,9 @@ static unsigned long slots_fetch_random(void)
>  	return 0;
>  }
>  
> -static void process_mem_region(struct mem_vector *entry,
> -			       unsigned long minimum,
> -			       unsigned long image_size)
> +static void slots_count(struct mem_vector *entry,

That's a strange rename.

__process_mem_region() makes more sense to me.

> +			unsigned long minimum,
> +			unsigned long image_size)
>  {
>  	struct mem_vector region, overlap;
>  	unsigned long start_orig, end;
> @@ -646,6 +656,57 @@ static void process_mem_region(struct mem_vector *entry,
>  	}
>  }
>  
> +static bool process_mem_region(struct mem_vector *region,
> +			       unsigned long long minimum,
> +			       unsigned long long image_size)
> +{
> +	int i;
> +	/*
> +	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> +	 * walk all the regions, so use region directely.

"directly"

> +	 */
> +	if (num_immovable_mem == 0) {

	if (!...

> +		slots_count(region, minimum, image_size);
> +
> +		if (slot_area_index == MAX_SLOT_AREA) {
> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> +			return 1;
> +		}
> +		return 0;
> +	}
> +

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
