Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2541BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1DD2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1DD2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeKGVZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:25:46 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:2406 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKGVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:25:46 -0500
X-IronPort-AV: E=Sophos;i="5.54,475,1534809600"; 
   d="scan'208";a="81521354"
Subject: Re: [Xen-devel] [PATCH] x86/xen: fix pv boot
To:     Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <x86@kernel.org>
CC:     <sstabellini@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <boris.ostrovsky@oracle.com>, <tglx@linutronix.de>
References: <20181107113017.30090-1-jgross@suse.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.cooper3@citrix.com; prefer-encrypt=mutual; keydata=
 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
 6+ahAA==
Message-ID: <f95cf3fb-fb49-8211-0c54-f6c7382ac455@citrix.com>
Date:   Wed, 7 Nov 2018 11:55:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107113017.30090-1-jgross@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/18 11:30, Juergen Gross wrote:
> Commit 9da3f2b7405440 ("x86/fault: BUG() when uaccess helpers fault on
> kernel addresses") introduced a regression for booting Xen PV guests.
>
> Xen PV guests are using __put_user() and __get_user() for accessing the
> p2m map (physical to machine frame number map) as accesses might fail
> in case of not populated areas of the map.
>
> With above commit using __put_user() and __get_user() for accessing
> kernel pages is no longer valid. So replace the Xen hack by adding
> appropriate p2m access functions using the default fixup handler.
>
> Fixes: 9da3f2b7405440 ("x86/fault: BUG() when uaccess helpers fault on kernel addresses")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/xen/page.h | 39 ++++++++++++++++++++++++++++++++++++---
>  arch/x86/xen/p2m.c              |  3 +--
>  2 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
> index 123e669bf363..a39015cb2f3f 100644
> --- a/arch/x86/include/asm/xen/page.h
> +++ b/arch/x86/include/asm/xen/page.h
> @@ -9,7 +9,7 @@
>  #include <linux/mm.h>
>  #include <linux/device.h>
>  
> -#include <linux/uaccess.h>
> +#include <asm/extable.h>
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
>  
> @@ -91,15 +91,48 @@ clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
>   * Helper functions to write or read unsigned long values to/from
>   * memory, when the access may fault.
>   */
> +#ifdef CONFIG_X86_32
> +#define __i "l"
> +#define __r "k"
> +#else
> +#define __i "q"
> +#define __r ""
> +#endif

You don't need any of these.  GCC and Clang can derive the correct
encoding from the type passed in, and will DTRT given unsigned long's.

Furthermore, it makes the asm easier to read.

>  static inline int xen_safe_write_ulong(unsigned long *addr, unsigned long val)
>  {
> -	return __put_user(val, (unsigned long __user *)addr);
> +	int ret = 0;
> +
> +	asm volatile("1: mov"__i" %"__r"1,%2\n"
> +		     "2:\n"
> +		     ".section .fixup,\"ax\"\n"
> +		     "3: mov %3,%0\n"
> +		     "   jmp 2b\n"
> +		     ".previous\n"
> +		     _ASM_EXTABLE(1b, 3b)
> +		     : "=r"(ret)
> +		     : "r" (val), "m" (*addr), "i" (-1), "0" (ret));

This constraint hides the write to addr.

> +	return ret;
>  }
>  
>  static inline int xen_safe_read_ulong(unsigned long *addr, unsigned long *val)
>  {
> -	return __get_user(*val, (unsigned long __user *)addr);
> +	int ret = 0;
> +	unsigned long rval;
> +
> +	asm volatile("1: mov"__i" %2,%"__r"1\n"
> +		     "2:\n"
> +		     ".section .fixup,\"ax\"\n"
> +		     "3: mov %3,%0\n"
> +		     "   jmp 2b\n"
> +		     ".previous\n"
> +		     _ASM_EXTABLE(1b, 3b)
> +		     : "=r" (ret), "=r" (rval)
> +		     : "m" (*addr), "i" (-1), "0" (ret));
> +	*val = rval;
> +	return ret;

This also uses rval uninitialised if a fault occurs.

Overall, how about:

static inline int xen_safe_write_ulong(unsigned long *addr, unsigned
long val)
{
    int ret = 0;

    asm volatile("1: mov %[val], %[ptr]\n"
                 "2:\n"
                 ".section .fixup, \"ax\"\n"
                 "3: mov %[err], %[ret]\n"
                 "   jmp 2b\n"
                 ".previous\n"
                 _ASM_EXTABLE(1b, 3b)
                 : [ret] "+r" (ret), [ptr] "=m" (*addr),
                 : [val] "r" (val), [err] "i" (-1));

    return ret;
}

static inline int xen_safe_read_ulong(const unsigned long *addr,
                                      unsigned long *val)
{
    int ret = 0;
    unsigned long rval = ~0ul;

    asm volatile("1: mov %[ptr], %[rval]\n"
                 "2:\n"
                 ".section .fixup, \"ax\"\n"
                 "3: mov %[err], %[ret]\n"
                 "   jmp 2b\n"
                 ".previous\n"
                 _ASM_EXTABLE(1b, 3b)
                 : [ret] "+r" (ret), [rval] "+r" (rval)
                 : [ptr] "=m" (*addr), [err] "i" (-1));
    *val = rval;

    return ret;
}

?

~Andrew
