Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeBXSbE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 13:31:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:40165 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbeBXSbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 13:31:03 -0500
Date: Sat, 24 Feb 2018 19:30:44 +0100
From: Borislav Petkov <bp@suse.de>
To: Gustavo Leite <gustavoleite.ti@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Ian Abbott <abbotti@mev.co.uk>, Randy Dunlap <rdunlap@infradead.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH] linux/kernel.h: break long lines
Message-ID: <20180224183044.GB29374@pd.tnic>
References: <20180224181003.29604-1-gustavoleite.ti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180224181003.29604-1-gustavoleite.ti@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 03:10:02PM -0300, Gustavo Leite wrote:
> Break lines that are longer than 80 characters do match the linux coding
> style.
> 
> Signed-off-by: Gustavo Leite <gustavoleite.ti@gmail.com>
> ---
>  include/linux/kernel.h | 74 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index ce51455e2adf..13b84cfd09a9 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -307,10 +307,12 @@ static inline void refcount_error_report(struct pt_regs *regs, const char *err)
>  #endif
>  
>  /* Internal, do not use. */
> -int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
> +int __must_check _kstrtoul(const char *s, unsigned int base,
> +		unsigned long *res);
>  int __must_check _kstrtol(const char *s, unsigned int base, long *res);
>  

But this:

> -int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);

is more readable than this:

> +int __must_check kstrtoull(const char *s, unsigned int base,
> +		unsigned long long *res);

> -int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
> -int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
> -int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
> -int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
> -int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
> -int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
> -int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
> -int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
> -int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
> -int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
> -int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
> -
> -static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
>
> +int __must_check kstrtoull_from_user(const char __user *s, size_t count,
> +		unsigned int base, unsigned long long *res);
> +int __must_check kstrtoll_from_user(const char __user *s, size_t count,
> +		unsigned int base, long long *res);
> +int __must_check kstrtoul_from_user(const char __user *s, size_t count,
> +		unsigned int base, unsigned long *res);
> +int __must_check kstrtol_from_user(const char __user *s, size_t count,
> +		unsigned int base, long *res);
> +int __must_check kstrtouint_from_user(const char __user *s, size_t count,
> +		unsigned int base, unsigned int *res);
> +int __must_check kstrtoint_from_user(const char __user *s, size_t count,
> +		unsigned int base, int *res);
> +int __must_check kstrtou16_from_user(const char __user *s, size_t count,
> +		unsigned int base, u16 *res);
> +int __must_check kstrtos16_from_user(const char __user *s, size_t count,
> +		unsigned int base, s16 *res);
> +int __must_check kstrtou8_from_user(const char __user *s, size_t count,
> +		unsigned int base, u8 *res);
> +int __must_check kstrtos8_from_user(const char __user *s, size_t count,
> +		unsigned int base, s8 *res);
> +int __must_check kstrtobool_from_user(const char __user *s, size_t count,
> +		bool *res);
> +

And this is the perfect example that breaking those lines is a very bad idea.
What you have now is an unreadable mess vs before where you could actually keep
apart function names from arguments.

And, for the record, if we have to break a function signature, we align the
arguments at the opening brace like this:

static inline int __must_check kstrtou64_from_user(const char __user *s,
						   size_t count, unsigned int base, u64 *res)


But if you really want to get your hands dirty with the kernel, I'd
advise to start here: https://kernelnewbies.org/

HTH.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
