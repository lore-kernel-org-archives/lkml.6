Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA8FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0002420660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfAJODc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:03:32 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:46558 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727916AbfAJODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:03:31 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id E249AB400EA;
        Thu, 10 Jan 2019 14:03:28 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 06:03:22 -0800
Subject: Re: [PATCH v3 2/6] static_call: Add basic static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <a01f733889ebf4bc447507ab8041a60378eaa89f.1547073843.git.jpoimboe@redhat.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <ab520f62-aacf-5229-7a55-f85b05798f77@solarflare.com>
Date:   Thu, 10 Jan 2019 14:03:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <a01f733889ebf4bc447507ab8041a60378eaa89f.1547073843.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24348.003
X-TM-AS-Result: No-12.038400-4.000000-10
X-TMASE-MatchedRID: 0dFPYP4mu5RfsB4HYR80Zia1MaKuob8PC/ExpXrHizwKogmGusPLb9aR
        zKCsaTounu68rwOw9rBQYI/UmFsW8P+j7mX1lKC+joyKzEmtrEcHgh3sKJBzPxI+jlzyGLPnaF2
        9jZP2X5dmPXOp+UJ5Utt9i45mMISqyUEGXxYlhT+L9v4vFTanjs7cqyVuQGhmcEX9nXlI6AvJP1
        gpPa+crmnvug6OzPjXybzcIsvft0OqO+wHLkIcOwPZZctd3P4BQfvCwHnjjjANmPMcsvd5FgaTa
        lM8C773wvUxdKBGcQxATzeCdAKeQI9Tk4aumaeg4vPWjjRvIipl0qH7/7HRjvHFoBcOsKezbwIu
        AyuB59zi/7qcdcQMFcY54tT3ZJ0V/zHzlVrCtbHBVprK8rvWX/i4nVERfgwdRQ0dAChl/lz9FIg
        peJ17D5U636acpR6Q70Qm3YXk6SxNfs8n85Te8oMbH85DUZXyseWplitmp0j6C0ePs7A07YFInL
        yeDAoZyhTaFVclfUCSknPTRqbbm/foUGBc9JB0N6198Qzys+Qpjj+miPpdkQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.038400-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24348.003
X-MDID: 1547129010-BXtBBWp409-J
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/19 22:59, Josh Poimboeuf wrote:
> Static calls are a replacement for global function pointers.  They use
> code patching to allow direct calls to be used instead of indirect
> calls.  They give the flexibility of function pointers, but with
> improved performance.  This is especially important for cases where
> retpolines would otherwise be used, as retpolines can significantly
> impact performance.
>
> The concept and code are an extension of previous work done by Ard
> Biesheuvel and Steven Rostedt:
>
>   https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
>   https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org
>
> There are two implementations, depending on arch support:
>
> 1) out-of-line: patched trampolines (CONFIG_HAVE_STATIC_CALL)
> 2) basic function pointers
>
> For more details, see the comments in include/linux/static_call.h.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/Kconfig                      |   3 +
>  include/linux/static_call.h       | 135 ++++++++++++++++++++++++++++++
>  include/linux/static_call_types.h |  13 +++
>  3 files changed, 151 insertions(+)
>  create mode 100644 include/linux/static_call.h
>  create mode 100644 include/linux/static_call_types.h
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 4cfb6de48f79..7e469a693da3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -885,6 +885,9 @@ config HAVE_ARCH_PREL32_RELOCATIONS
>  	  architectures, and don't require runtime relocation on relocatable
>  	  kernels.
>  
> +config HAVE_STATIC_CALL
> +	bool
> +
>  source "kernel/gcov/Kconfig"
>  
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> new file mode 100644
> index 000000000000..9e85c479cd11
> --- /dev/null
> +++ b/include/linux/static_call.h
> @@ -0,0 +1,135 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_STATIC_CALL_H
> +#define _LINUX_STATIC_CALL_H
> +
> +/*
> + * Static call support
> + *
> + * Static calls use code patching to hard-code function pointers into direct
> + * branch instructions.  They give the flexibility of function pointers, but
> + * with improved performance.  This is especially important for cases where
> + * retpolines would otherwise be used, as retpolines can significantly impact
> + * performance.
> + *
> + *
> + * API overview:
> + *
> + *   DECLARE_STATIC_CALL(key, func);
> + *   DEFINE_STATIC_CALL(key, func);
> + *   static_call(key, args...);
> + *   static_call_update(key, func);
> + *
> + *
> + * Usage example:
> + *
> + *   # Start with the following functions (with identical prototypes):
> + *   int func_a(int arg1, int arg2);
> + *   int func_b(int arg1, int arg2);
> + *
> + *   # Define a 'my_key' reference, associated with func_a() by default
> + *   DEFINE_STATIC_CALL(my_key, func_a);
> + *
> + *   # Call func_a()
> + *   static_call(my_key, arg1, arg2);
> + *
> + *   # Update 'my_key' to point to func_b()
> + *   static_call_update(my_key, func_b);
> + *
> + *   # Call func_b()
> + *   static_call(my_key, arg1, arg2);
> + *
> + *
> + * Implementation details:
> + *
> + *    This requires some arch-specific code (CONFIG_HAVE_STATIC_CALL).
> + *    Otherwise basic indirect calls are used (with function pointers).
> + *
> + *    Each static_call() site calls into a trampoline associated with the key.
> + *    The trampoline has a direct branch to the default function.  Updates to a
> + *    key will modify the trampoline's branch destination.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/cpu.h>
> +#include <linux/static_call_types.h>
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL
> +#include <asm/static_call.h>
> +extern void arch_static_call_transform(void *site, void *tramp, void *func);
> +#endif
> +
> +
> +#define DECLARE_STATIC_CALL(key, func)					\
> +	extern struct static_call_key key;				\
> +	extern typeof(func) STATIC_CALL_TRAMP(key)
> +
> +
> +#if defined(CONFIG_HAVE_STATIC_CALL)
> +
> +struct static_call_key {
> +	void *func, *tramp;
> +};
> +
> +#define DEFINE_STATIC_CALL(key, _func)					\
> +	DECLARE_STATIC_CALL(key, _func);				\
> +	struct static_call_key key = {					\
> +		.func = _func,						\
> +		.tramp = STATIC_CALL_TRAMP(key),			\
> +	};								\
> +	ARCH_DEFINE_STATIC_CALL_TRAMP(key, _func)
> +
> +#define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)
> +
> +static inline void __static_call_update(struct static_call_key *key, void *func)
> +{
> +	cpus_read_lock();
> +	WRITE_ONCE(key->func, func);
> +	arch_static_call_transform(NULL, key->tramp, func);
> +	cpus_read_unlock();
> +}
> +
> +#define static_call_update(key, func)					\
> +({									\
> +	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
> +	__static_call_update(&key, func);				\
> +})
> +
> +#define EXPORT_STATIC_CALL(key)						\
> +	EXPORT_SYMBOL(STATIC_CALL_TRAMP(key))
> +
> +#define EXPORT_STATIC_CALL_GPL(key)					\
> +	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(key))
> +
> +
> +#else /* Generic implementation */
> +
> +struct static_call_key {
> +	void *func;
> +};
> +
> +#define DEFINE_STATIC_CALL(key, _func)					\
> +	DECLARE_STATIC_CALL(key, _func);				\
> +	struct static_call_key key = {					\
> +		.func = _func,						\
> +	}
> +
> +#define static_call(key, args...)					\
> +	((typeof(STATIC_CALL_TRAMP(key))*)(key.func))(args)
> +
> +static inline void __static_call_update(struct static_call_key *key, void *func)
> +{
> +	WRITE_ONCE(key->func, func);
> +}
> +
> +#define static_call_update(key, func)					\
> +({									\
> +	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
> +	__static_call_update(&key, func);				\
> +})
> +
> +#define EXPORT_STATIC_CALL(key) EXPORT_SYMBOL(key)
> +#define EXPORT_STATIC_CALL_GPL(key) EXPORT_SYMBOL_GPL(key)
> +
> +#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
CONFIG_HAVE_STATIC_CALL?

-Ed
> +
> +#endif /* _LINUX_STATIC_CALL_H */
> diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
> new file mode 100644
> index 000000000000..0baaf3f02476
> --- /dev/null
> +++ b/include/linux/static_call_types.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _STATIC_CALL_TYPES_H
> +#define _STATIC_CALL_TYPES_H
> +
> +#include <linux/stringify.h>
> +
> +#define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
> +#define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
> +
> +#define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
> +#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
> +
> +#endif /* _STATIC_CALL_TYPES_H */

