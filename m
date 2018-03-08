Return-Path: <kernel-hardening-return-12256-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv2qVoKP9VtPyvSA7ZsDK7VMO6x9523rW7VFIqYnKcmv14JEVBh/cQOS5JPrYhfCCjxqVFj
ARC-Seal: i=1; a=rsa-sha256; t=1520539058; cv=none;
        d=google.com; s=arc-20160816;
        b=A9UmtZ0+t5wY/Ox62P2rX95K9gIerjdv7vZ0CGyIt9p0QRaC+dZU6o17YKjfHiCS6V
         dgjBIyVBYPe87CO3xUJsWYlHhVJzWUcj/9utHBUhHKDs3A3QBi+c8wOec4iN0KdyBQwC
         NIugdZzgl5wlzLCdB3z84ueFn6SUlpOlM9SX8JGJyGRU7ZqvMMdCpW0ISqyovPliH+6b
         PAgSPPOtd8+gfzYw2CJ+eRcL20ml0vAF6yxVNr3nzSJc0OG/WTV3HcCtb0hP9l6RXdvO
         60U2vg7z+zbeBC/Y0KUfD6t6NQ+BscAzgOodLDMFsKHUAratgumaUlekcRU48KRZ12Sv
         eZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Aq9t9zI20CilJvihstbjZJqL5B+zoLgcn0LOh0sPDck=;
        b=C+BeX1u+sJ5kqhLBJGP50zknddEsle3+lIKZYiAlTOVe0/1i2B3Bi+6vejqNWrgbiu
         bJWjZXBuuJ+l0e0IFAR/g0tHeie+CvLfDui1lwOZYvqqxvYT4Ep7pJQHqoMiHrmU57fq
         DQ1nl0TBPXH2pLJ8pcx1rUhRtEqo9oaEawj3I8rd6+R3CcbU32MYDpKv6U8YB/AhzT34
         O3Baxk96verCK6XW5ZKiIkEr7IUfMub90T0YF4+SxN4bYVHLXuVBo32wMmmm4x8AjCx0
         uBDXdJH3JpBT8HtUI+zFZovadFIYiUycDt8QBtavHAws/WuqInYPugo1/kBqic7nFH8X
         r+Lw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=ZQIA38Na;
       spf=pass (google.com: domain of kernel-hardening-return-12256-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12256-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=ZQIA38Na;
       spf=pass (google.com: domain of kernel-hardening-return-12256-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12256-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 0/3] Remove accidental VLA usage
To: Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 corbet@lwn.net, gustavo@embeddedor.com, rostedt@goodmis.org,
 Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
 David Sterba <dsterba@suse.com>, "David S. Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov
 <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
 Ian Abbott <abbotti@mev.co.uk>, "Tobin C. Harding" <me@tobin.cc>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Petr Mladek <pmladek@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-btrfs@vger.kernel.org, netdev@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
 <20180308150236.5tysfbm3xdouii5n@treble>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <78428dec-270e-5d74-0160-83feb5c0ff02@rasmusvillemoes.dk>
Date: Thu, 8 Mar 2018 20:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308150236.5tysfbm3xdouii5n@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338745857869070?=
X-GMAIL-MSGID: =?utf-8?q?1594400762937173248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-08 16:02, Josh Poimboeuf wrote:
> On Wed, Mar 07, 2018 at 07:30:44PM -0800, Kees Cook wrote:
>> This series adds SIMPLE_MAX() to be used in places where a stack array
>> is actually fixed, but the compiler still warns about VLA usage due to
>> confusion caused by the safety checks in the max() macro.
>>
>> I'm sending these via -mm since that's where I've introduced SIMPLE_MAX(),
>> and they should all have no operational differences.
> 
> What if we instead simplify the max() macro's type checking so that GCC
> can more easily fold the array size constants?  The below patch seems to
> work:
> 

> +extern long __error_incompatible_types_in_min_macro;
> +extern long __error_incompatible_types_in_max_macro;
> +
> +#define __min(t1, t2, x, y)						\
> +	__builtin_choose_expr(__builtin_types_compatible_p(t1, t2),	\
> +			      (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),	\
> +			      (t1)__error_incompatible_types_in_min_macro)
>  
>  /**
>   * min - return minimum of two values of the same or compatible types
>   * @x: first value
>   * @y: second value
>   */
> -#define min(x, y)					\
> -	__min(typeof(x), typeof(y),			\
> -	      __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),	\
> -	      x, y)
> +#define min(x, y) __min(typeof(x), typeof(y), x, y)			\
>  

But this introduces the the-chosen-one-of-x-and-y-gets-evaluated-twice
problem. Maybe we don't care? But until we get a
__builtin_assert_this_has_no_side_effects() I think that's a little
dangerous.

Rasmus
