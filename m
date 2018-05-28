Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeE1Rkx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:40:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52036 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeE1Rkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:40:52 -0400
Subject: Re: [PATCH v6 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
To: "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
 <1527472002-11571-5-git-send-email-me@tobin.cc>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fde2cc84-f1d8-b1ee-510b-b3659834874d@infradead.org>
Date: Mon, 28 May 2018 10:40:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527472002-11571-5-git-send-email-me@tobin.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/2018 06:46 PM, Tobin C. Harding wrote:
> Currently printing [hashed] pointers requires enough entropy to be
> available.  Early in the boot sequence this may not be the case
> resulting in a dummy string '(____ptrval____)' being printed.  This
> makes debugging the early boot sequence difficult.  We can relax the
> requirement to use cryptographically secure hashing during debugging.
> This enables debugging while keeping development/production kernel
> behaviour the same.
> 
> If new command line option debug_boot_weak_hash is enabled use
> cryptographically insecure hashing and hash pointer value immediately.
> 
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>  lib/vsprintf.c                                  | 20 ++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2040d46f095..8a86d895343e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -753,6 +753,15 @@
>  
>  	debug		[KNL] Enable kernel debugging (events log level).
>  

Hi,
This is much more readable than the previous version.  Thanks.

> +	debug_boot_weak_hash
> +			[KNL] Enable printing pointers early in the boot
> +			sequence.  If enabled, we use a weak hash instead of
> +			siphash to hash pointers.  Use this option if you need
> +			to see pointer values during early boot (i.e you are

			                                         i.e.

> +			seeing instances of '(___ptrval___)').
> +			Cryptographically insecure, please do not use on
> +			production kernels.
> +
>  	debug_locks_verbose=
>  			[KNL] verbose self-tests
>  			Format=<0|1>


-- 
~Randy
