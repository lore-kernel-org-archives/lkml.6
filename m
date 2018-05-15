Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZqZyg7Ffy0uSom90//CpYj/ivZQKylQfOM6aLHWxWY5QRaJZUN3AUtwgAUie8VxCSfP5aG1
ARC-Seal: i=1; a=rsa-sha256; t=1526398192; cv=none;
        d=google.com; s=arc-20160816;
        b=XOsddM1Sz+AswmAjeQLjOMZ6CazA8qvH0UHhQrhTKGOwfb5QsftcVDwjW22lgmNaed
         wkHcG/2M2sedRdJ174BCTTgy8byXk2ybsd+uqeayLOW6N+vF7VqefBzmYtMUXNDru9i9
         BPnBjs3EEB5ynkyn0NMXuZ0kxbSU1b45Auw773hf2xpiat128uH1kRvX1g3G3Ymw+hKq
         e9a4I//IyDXlpVmmEe81O0nlL/kCt2K2UONayab0pyrkUkf7xgvyzp0nERmP9uSZDRWg
         JixZ1NAU2kY9a1mVXRe0aH2pyDqhtVFdy6Y39FFXf9msbXS/02HV9v7H2PXQ2YPwi5dE
         d1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=UI4G9BrRXUBY2D9NjoeqbkpElVzcCtTs0BeSsscv2e0=;
        b=t8bfwCv6IJsqJIC8N1GkN5laGxpYHimswaR59KuA7fNrX2J31eJeGEybQvV0rn47MO
         QocaMCJd6C+I9isX+yeg3tO0XRQP0/7xAQENK9TBcsm81uOM91pJyf3LDcIxXkSlEra9
         aBOnVKL6GEVkeJDbzDBGEhAx2fz9rUwUYMNpjKFtWjhUKe/n78WCZ3qNmFx4hAYc70rG
         FQ51csKGLZzPf79JvyQ4aZcn19xmLoAGt59sOrW8Ejr/gNqZz4AJkRxh2pOAO0MABHY6
         BMv+vBe8FyXZZGcHK/bNC7NLELHyy6FmOSYWX7iG2aejbsECT294IuGwbv0MESzDRBDO
         M1Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=h0jD9yRz;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=h0jD9yRz;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] vsprintf: Add command line option debug_boot_weak_hash
To: "Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>, Theodore Ts'o
 <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <1526359115-5489-1-git-send-email-me@tobin.cc>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f9bacaa1-7741-d28e-29d1-4b42ae0c986f@infradead.org>
Date: Tue, 15 May 2018 08:29:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526359115-5489-1-git-send-email-me@tobin.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600503563774077130?=
X-GMAIL-MSGID: =?utf-8?q?1600544511142614617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 09:38 PM, Tobin C. Harding wrote:

>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  lib/vsprintf.c                                  | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3b8032431585..c95dd6704592 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -748,6 +748,14 @@
>  
>  	debug		[KNL] Enable kernel debugging (events log level).
>  
> +	debug_boot_weak_hash
> +			[KNL] Enable debugging early in the boot sequence.  If

That makes it sound like "debug_boot_weak_hash" turns on early debugging.

> +			enabled, we use a weak hash instead of siphash to hash
> +			pointers.  Use this option if you need to see pointer
> +			values during early boot (i.e you are seeing instances

			                          i.e.

> +			of '(___ptrval___)') - cryptographically insecure,
> +			please do not use on production kernels.
> +
>  	debug_locks_verbose=
>  			[KNL] verbose self-tests
>  			Format=<0|1>


-- 
~Randy
