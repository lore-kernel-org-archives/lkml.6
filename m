Return-Path: <kernel-hardening-return-12361-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtzIlhnCXX3rdGUVkR5miV6YFTprMcpKp2bcofeFGn1scmuHmk0gSC9YFL+YnDuJVj0q51v
ARC-Seal: i=1; a=rsa-sha256; t=1520651557; cv=none;
        d=google.com; s=arc-20160816;
        b=ptOleHsjwlNI9TIy3h/NFdKXRQgudWfdx0fyzAHd4IsN2w2W6ue0F4OOvyPhCogQV0
         C5m1g0K7Tn4OZQpdJSozpKWoCmdn5f1IhoNFsEhWujMMhINJ6vbOdsK3E6h5/Y7sMzRf
         KGTrwHciwfbIwGfqyy7V2/mQIjtphkj9yLbe3rmm33fNV+oM7aMLZ6gs1pKP3QhFHxx2
         GbkBbhmENTjlUGY9dnd7SMrPqjGGlfWFbVyyLz4yKoo4ckmoJfskOVlYCZT9ddVtRu/Q
         Rj4xwEGlW2EEreFG/fmoAmMh+XumlCt5pnKsSfe7jObSP//n3z46m1hsnfv3Bizxwq80
         Vu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=lMVbaL0cJS7WOhbrqp21sc8aRXBBYd1pulwWcnSnLgg=;
        b=FXojCi5f+NNkxaRtd76qK9bUil3i/yzFhWGDTdC+jUWMDWVBHJfclhodQWR0dnOsbQ
         KDLu6ck7bRcOrN3RiMNLIbMluV4J0EfQk0cYNwmLLB7sHdkwCy91gtvLEBOfBU+Wor0s
         tFj72zISsARVGRVpIt2nsVrmCshP7KYoDupM/OqzdWVJN/wT2eHCPEGDTl1BfpFT8zed
         8ZH5+NqVM/DmE5NHKV9OreuZQ4m+4iIIuhnwexj1efcfj8v7EjrvjhCNWUORsNZT2eph
         L08veeC157pwJJrYIL67bOEMgRmfZN/FKTQR+CwAngGsSRPTQrWKY0b2xzqSgOfHiJZ/
         0aqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=merlin.20170209 header.b=2npUthO6;
       spf=pass (google.com: domain of kernel-hardening-return-12361-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12361-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=merlin.20170209 header.b=2npUthO6;
       spf=pass (google.com: domain of kernel-hardening-return-12361-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12361-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
To: Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>,
 Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
 Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov
 <bp@suse.de>, Ian Abbott <abbotti@mev.co.uk>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Petr Mladek <pmladek@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Linux Btrfs <linux-btrfs@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20180309200536.GA5670@beast>
 <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org>
Date: Fri, 9 Mar 2018 19:11:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594518726992330023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 04:07 PM, Andrew Morton wrote:
> On Fri, 9 Mar 2018 12:05:36 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
>> When max() is used in stack array size calculations from literal values
>> (e.g. "char foo[max(sizeof(struct1), sizeof(struct2))]", the compiler
>> thinks this is a dynamic calculation due to the single-eval logic, which
>> is not needed in the literal case. This change removes several accidental
>> stack VLAs from an x86 allmodconfig build:
>>
>> $ diff -u before.txt after.txt | grep ^-
>> -drivers/input/touchscreen/cyttsp4_core.c:871:2: warning: ISO C90 forbids variable length array ‘ids’ [-Wvla]
>> -fs/btrfs/tree-checker.c:344:4: warning: ISO C90 forbids variable length array ‘namebuf’ [-Wvla]
>> -lib/vsprintf.c:747:2: warning: ISO C90 forbids variable length array ‘sym’ [-Wvla]
>> -net/ipv4/proc.c:403:2: warning: ISO C90 forbids variable length array ‘buff’ [-Wvla]
>> -net/ipv6/proc.c:198:2: warning: ISO C90 forbids variable length array ‘buff’ [-Wvla]
>> -net/ipv6/proc.c:218:2: warning: ISO C90 forbids variable length array ‘buff64’ [-Wvla]
>>
>> Based on an earlier patch from Josh Poimboeuf.
> 
> v1, v2 and v3 of this patch all fail with gcc-4.4.4:
> 
> ./include/linux/jiffies.h: In function 'jiffies_delta_to_clock_t':
> ./include/linux/jiffies.h:444: error: first argument to '__builtin_choose_expr' not a constant


I'm seeing that problem with
> gcc --version
gcc (SUSE Linux) 4.8.5

in mmotm.

> That's with
> 
> #define __max(t1, t2, x, y)						\
> 	__builtin_choose_expr(__builtin_constant_p(x) &&		\
> 			      __builtin_constant_p(y) &&		\
> 			      __builtin_types_compatible_p(t1, t2),	\
> 			      (t1)(x) > (t2)(y) ? (t1)(x) : (t2)(y),	\
> 			      __single_eval_max(t1, t2,			\
> 						__UNIQUE_ID(max1_),	\
> 						__UNIQUE_ID(max2_),	\
> 						x, y))
> /**
>  * max - return maximum of two values of the same or compatible types
>  * @x: first value
>  * @y: second value
>  */
> #define max(x, y)	__max(typeof(x), typeof(y), x, y)
> 
> 
> A brief poke failed to reveal a workaround - gcc-4.4.4 doesn't appear
> to know that __builtin_constant_p(x) is a constant.  Or something.
> 
> Sigh.  Wasn't there some talk about modernizing our toolchain
> requirements?


-- 
~Randy
