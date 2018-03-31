Return-Path: <kernel-hardening-return-12840-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx480tzWxdWyzJPVnJWhSJABwkVPsJVxO9nYw6h+kFuZ+J03hAOzN/I1zg/xCJLcydzOBMUpM
ARC-Seal: i=1; a=rsa-sha256; t=1522503479; cv=none;
        d=google.com; s=arc-20160816;
        b=PiwLlYfvuSS2gdGoHz8HkDQ2Gr4VgUI9gjTxRAKQtig/uR+/0vRb/4XlSV6DcvcUjj
         QiONJ4VrZjgqwpfzRoMvtl9UqFq5SLutabT4oUYHFsCexlibsZgpH9MMUAoWCdFvILnZ
         1LKL7fYTa8m+KTE2/5yWgEORmt8CkVCXXWecEVptmWzHIF7YXn+dUHBEc9fcPbMZHZJM
         I/yDyaC6SeN43HtMW9GCxYrcgXzW0ET3RDQWoDvuHL3KPFUb7Po7lbJVW4Qhshvm2H9N
         8b35WWxd7LL9redIkZ6FqiTJ81fhdEhop0jbjqMvzx6IH1Vv+aXgC8UzH9f4xtjZ+0jz
         Lkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=9p8t4SfxFJe+y02WW+YO5IVXQEpGZxj5AXxeT3QrK6U=;
        b=K3kOAzDhU0LgMZndv83fC9dHFLAvHECzYaaiiGAHgCl70yx9uxmfs5kFL4u3l2XKc1
         malQ3APZvIAtxmraqrfd/iYOBkiKEs+WW9wHbXZEPHUEoKEf/PLx2iXgRr2MybWeiezt
         lJOeWYS9SPpL3hyj9gRuinPbU1Byl1NBzCAlCa8rjuf8ZrF4KKucQfMML4CKpZq8g0PK
         PgHzxX2Ni/5SJlp2huZEC/ufRB03MiLQY49x8s4kjp7bWEey//XMWg+IE+G9doDYV6BA
         7m77NufYiynly9RgajsttmhnLkoI2T8EdDLCksfutnUR+bnLUSTgkXsyxIFlsUGfvLMt
         q6Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Zs7lnmar;
       dkim=pass header.i=@chromium.org header.s=google header.b=XcjjB0k0;
       spf=pass (google.com: domain of kernel-hardening-return-12840-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12840-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Zs7lnmar;
       dkim=pass header.i=@chromium.org header.s=google header.b=XcjjB0k0;
       spf=pass (google.com: domain of kernel-hardening-return-12840-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12840-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180331053434.akno723avvcri654@gmail.com>
References: <20180326221554.GA45166@beast> <20180327054748.jx6mzywguuqfkqpv@gmail.com>
 <CAGXu5jK74cVQPigf2Q23E2pjonfzq+MMxhbqTNvzbWFxP4aGig@mail.gmail.com> <20180331053434.akno723avvcri654@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 31 Mar 2018 06:37:37 -0700
X-Google-Sender-Auth: JCLb-vN2vXh7tWh0mpFd7yG-heU
Message-ID: <CAGXu5jKrE+oejudtV1SKFgTMd0cEaPv_y=iw16LnGUUX0R8M8Q@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1596460608086893367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 10:34 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> On Mon, Mar 26, 2018 at 10:47 PM, Ingo Molnar <mingo@kernel.org> wrote:
>> >
>> > * Kees Cook <keescook@chromium.org> wrote:
>> >
>> >> In the effort to remove all VLAs from the kernel[1], it is desirable to
>> >> build with -Wvla. However, this warning is overly pessimistic, in that
>> >> it is only happy with stack array sizes that are declared as constant
>> >> expressions, and not constant values. One case of this is the evaluation
>> >> of the max() macro which, due to its construction, ends up converting
>> >> constant expression arguments into a constant value result.
>> >>
>> >> All attempts to rewrite this macro with __builtin_constant_p() failed with
>> >> older compilers (e.g. gcc 4.4)[2]. However, Martin Uecker constructed[3] a
>> >> mind-shattering solution that works everywhere. Cthulhu fhtagn!
>> >>
>> >> This patch updates the min()/max() macros to evaluate to a constant
>> >> expression when called on constant expression arguments. This removes
>> >> several false-positive stack VLA warnings from an x86 allmodconfig
>> >> build when -Wvla is added:
>> >
>> > Cool!
>> >
>> > Acked-by: Ingo Molnar <mingo@kernel.org>
>> >
>> > How many warnings are left in an allmodconfig build?
>>
>> For -Wvla? Out of the original 112 files with VLAs, 42 haven't had a
>> patch applied yet. Doing a linux-next allmodconfig build with the
>> max() patch and my latest ecc patch, we've gone from 316 warning
>> instances to 205. More than half of those are in
>> include/crypto/skcipher.h and include/crypto/hash.h.
>
> Great - once the number of warnings is zero, is the plan to enable the warning
> unconditionally?

That's the plan, yes. Like inbox-zero but for VLAs. ;)

-Kees

-- 
Kees Cook
Pixel Security
