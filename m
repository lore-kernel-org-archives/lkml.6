Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B08BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E293214C1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qi0rT+B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E293214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeK3IQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:16:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33978 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeK3IQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:16:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so1974673qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WuRRWBvN2Frb3JwoD3duCo0M+5ZFSe3S1T1c2uHxZFI=;
        b=qi0rT+B9eJMJgGwDNDstcCosDnrXTnNYrsytQiyspo4kDQ7hWwoF0gjsZ8+o8JguIu
         i7PTfG9V5XrOSmy8VRXWXaxvgTnqIjnYS4rPhQD3r9R5VzWWHFto4HHSzY8qm4FnUvkH
         3GZTFQZEmeYFuy9BsQbKzCOfuvr46MqJdn27lJYiAuivvDkmeuF1AzvyRXMwOmtk+yTN
         fkxstJvyFlCMrs+Ya1BHU2ZB5QRS4jE6l1GEKn+/jgGuVOW+uyQe9PIV5CFniLhUnw9a
         dy0lN+UU/Gyx5Uym5QBf8TNJXFlqWj3UvBRIO+cFn+2OV8MXZKhmx6+meNBtsqErgSmN
         BsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WuRRWBvN2Frb3JwoD3duCo0M+5ZFSe3S1T1c2uHxZFI=;
        b=GRrerHXwTfw1nA6fBZQYVUyj6psIOm0vpfzXMD1CkdAgnzfQf3Fgkax963J/z1ajBe
         4YxqvwKpD8+WZsBFTJ7RPsER4KVv/RPdR48GXTTsPzfVYN9dxyfWr8pk9S6cz8QH0l/G
         fx8PJXurs2xo+Rfy6Y0BBp1ccubZPskwNKqAumavbKNwCrX92i/655gF2+4Kggj/Momm
         SixzlZAj0wiIgPqlE+WLYM5CMMtoSkxYbsm5f+7YjcNnjMFYnoUORMp6rumt5bZnDau/
         HP2ndPKBvVGJNxC7OkooCPa5ST6fH8Lrtx7uGV01oTJqarR7dr2YpRaphCGN6JaHhO4q
         7B3w==
X-Gm-Message-State: AA+aEWaBhodGOB+JgeEYWK9TxXtQconrMwe3/9Ejb+BER8Z4Ai/Cas9Q
        KfvIqUZQIJ5sdQk8cEzrsg==
X-Google-Smtp-Source: AFSGD/VM5OOh2HUfFKJHS4AuuJYjAr0iIBshFWj45ws5B46gtBopOvsUppw2yS3nRxfZ6nMXfu1H5Q==
X-Received: by 2002:a37:3346:: with SMTP id z67mr2894075qkz.134.1543525806844;
        Thu, 29 Nov 2018 13:10:06 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b188sm1392991qkc.58.2018.11.29.13.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 13:10:06 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:10:03 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181129211003.saxfvyboxpsn5mdr@gabell>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:16:27PM +0800, Chao Fan wrote:
> To fix the conflict between KASLR and memory-hotremove, memory
> information in SRAT table is necessary.
> 
> ACPI SRAT (System/Static Resource Affinity Table) can show the details
> about memory ranges, including ranges of memory provided by hot-added
> memory devices. SRAT table must be introduced by RSDP pointer (Root
> System Description Pointer). So RSDP should be found firstly.
> 
> When booting form KEXEC/EFI/BIOS, the methods to find RSDP pointer
> are different. When booting from KEXEC, 'acpi_rsdp' may have been
> added to cmdline, so parse the cmdline and find the RSDP pointer.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpitb.c | 33 +++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.c   |  5 +++++
>  arch/x86/boot/compressed/misc.h   |  4 ++++
>  lib/kstrtox.c                     |  5 +++++
>  4 files changed, 47 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/acpitb.c
> 
> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
> new file mode 100644
> index 000000000000..614c45655cff
> --- /dev/null
> +++ b/arch/x86/boot/compressed/acpitb.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define BOOT_CTYPE_H
> +#include "misc.h"
> +#include "error.h"
> +
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +#include <linux/numa.h>
> +#include <linux/acpi.h>
> +
> +#define STATIC
> +#include <linux/decompress/mm.h>
> +
> +/* Store the immovable memory regions. */
> +struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +#endif
> +
> +static acpi_physical_address get_acpi_rsdp(void)
> +{
> +#ifdef CONFIG_KEXEC
> +	unsigned long long res;
> +	int len = 0;
> +	char *val;
> +
> +	val = malloc(19);
> +	len = cmdline_find_option("acpi_rsdp", val, 19);
> +	if (len > 0) {
> +		val[len] = 0;
> +		return (acpi_physical_address)kstrtoull(val, 16, &res);
> +	}
> +	return 0;
> +#endif
> +}
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 8dd1d5ccae58..e51713fe3add 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -12,6 +12,7 @@
>   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
>   */
>  
> +#define BOOT_CTYPE_H
>  #include "misc.h"
>  #include "error.h"
>  #include "pgtable.h"
> @@ -426,3 +427,7 @@ void fortify_panic(const char *name)
>  {
>  	error("detected buffer overflow");
>  }
> +
> +#ifdef BOOT_STRING
> +#include "../../../../lib/kstrtox.c"
> +#endif
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index a1d5918765f3..809c31effa4b 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -116,3 +116,7 @@ static inline void console_init(void)
>  void set_sev_encryption_mask(void);
>  
>  #endif
> +
> +/* acpitb.c */
> +#define BOOT_STRING
> +extern int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 1006bf70bf74..a0ac1b2257b8 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -126,6 +126,9 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  }
>  EXPORT_SYMBOL(kstrtoull);
>  
> +/* Make compressed period code be able to use kstrtoull(). */
> +#ifndef BOOT_STRING

I got the following build error.

]$ make arch/x86/boot/compressed/misc.o
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CC      arch/x86/boot/compressed/misc.o
ld: -r and -pie may not be used together
make[1]: *** [scripts/Makefile.build:294: arch/x86/boot/compressed/misc.o] Error 1
make: *** [Makefile:1715: arch/x86/boot/compressed/misc.o] Error 2
]$

I think this error gets fixed by changing the BOOT_STRING ifndef
order before the EXPORT_SYMBOL, like this:

#ifndef BOOT_STRING
EXPORT_SYMBOL(kstrtoull);

I'm not sure this change is a good way...

Thanks,
Masa
