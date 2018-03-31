Return-Path: <kernel-hardening-return-12837-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48HHnJMF7kyT9lA6tyyYinFc9QUJwW4guEcgjB9UhkssPBqJzETAPr1ipUTE6SkSg3HXnOk
ARC-Seal: i=1; a=rsa-sha256; t=1522472243; cv=none;
        d=google.com; s=arc-20160816;
        b=QtmyOMHgMg1zxEw7cgGeEZ2QvhRjrOAzwg7R462Rcl9xezd0IoSYOwMVXW3E+Jegn8
         RgQyxtNhCF+Qy5xBRCYMNQFzX/OgmSo7s0gTO8S7I1qFRpePkBwlIdzr6hwGyRMRI788
         bMzzUvlmUqSbb3toSmnjtmK45weetJDg/Essj4IrPGmJj1nskUwErZhtnImPE4YhEbK9
         CabrfayYIoFGJsfRaQXpfJv77ibEW2oxG8vfDX8vfIwhdwdIV4bLrAtuDkrSYSqfCt01
         l/ossUdBfCH86wZawD4Fpi3vvG4CoblWC7Ooe0p0dAU7ElC4YecBujEOsSAPZH0Gefb2
         XlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=c9R529rVbkgpTPxXJ9TrBefXaSfRE3l6gVa7yLBJd/c=;
        b=FpdF1MmJhwbijI34WeB6XwhzSPSBT00KKfLA6o3L09F5i18FI0QnXgFZnbRKvbNeeW
         Mx4IhEANoVeXxxY5zw2t8wFh14IxDBI3YIahCb54m2zkT610ntr96sR9+Y6yu6r6vETh
         X5crZHEnILPjndOwaOXB+MS4ug/0yN4ImJ8vHVOchwLmA+4vp1Ffgn7PyAYqAv9SZGYs
         +54Wh0Bn5QLyObHUZR4InOz+TAMtGh5/azkTKbhx+Ns1DKC+7OtSRZ7mSUeYc0optVIX
         cX56ADqmU0sZLdNVmNjl4pQzouM/p6INu2dNyYsz4PWt4v7J31sC0klEPqhdrroI8d4Y
         UWRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=RuOUh1XY;
       dkim=pass header.i=@chromium.org header.s=google header.b=bj7KgsR4;
       spf=pass (google.com: domain of kernel-hardening-return-12837-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12837-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=RuOUh1XY;
       dkim=pass header.i=@chromium.org header.s=google header.b=bj7KgsR4;
       spf=pass (google.com: domain of kernel-hardening-return-12837-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12837-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180327054748.jx6mzywguuqfkqpv@gmail.com>
References: <20180326221554.GA45166@beast> <20180327054748.jx6mzywguuqfkqpv@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 30 Mar 2018 21:57:01 -0700
X-Google-Sender-Auth: dp46AQF17_KdvWwnaajxP-WTdvE
Message-ID: <CAGXu5jK74cVQPigf2Q23E2pjonfzq+MMxhbqTNvzbWFxP4aGig@mail.gmail.com>
Subject: Re: [PATCH v6] kernel.h: Retain constant expression output for max()/min()
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596040250176531135?=
X-GMAIL-MSGID: =?utf-8?q?1596427855264719395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:47 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> In the effort to remove all VLAs from the kernel[1], it is desirable to
>> build with -Wvla. However, this warning is overly pessimistic, in that
>> it is only happy with stack array sizes that are declared as constant
>> expressions, and not constant values. One case of this is the evaluation
>> of the max() macro which, due to its construction, ends up converting
>> constant expression arguments into a constant value result.
>>
>> All attempts to rewrite this macro with __builtin_constant_p() failed with
>> older compilers (e.g. gcc 4.4)[2]. However, Martin Uecker constructed[3] a
>> mind-shattering solution that works everywhere. Cthulhu fhtagn!
>>
>> This patch updates the min()/max() macros to evaluate to a constant
>> expression when called on constant expression arguments. This removes
>> several false-positive stack VLA warnings from an x86 allmodconfig
>> build when -Wvla is added:
>
> Cool!
>
> Acked-by: Ingo Molnar <mingo@kernel.org>
>
> How many warnings are left in an allmodconfig build?

For -Wvla? Out of the original 112 files with VLAs, 42 haven't had a
patch applied yet. Doing a linux-next allmodconfig build with the
max() patch and my latest ecc patch, we've gone from 316 warning
instances to 205. More than half of those are in
include/crypto/skcipher.h and include/crypto/hash.h.

-Kees

-- 
Kees Cook
Pixel Security
