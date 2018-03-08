Return-Path: <kernel-hardening-return-12259-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsJJ3eSt0mEgNZoAcO4dgm6jw5VXWaHv/pOfYCCKOPqMYSXMZZOAN5jOkkWbchXpw11vtkE
ARC-Seal: i=1; a=rsa-sha256; t=1520541617; cv=none;
        d=google.com; s=arc-20160816;
        b=QPuTc+UT7iLagfrxIP7lFSK6ZOC9z4DPDiMDmzHcLwpbz/lS/Iglbfx/nwNSVFk2xZ
         LdAr75B1PQmzXZcl4MM5T6bRpgZqbO8TrZUZ5w4czaU8P21UCrbWDHyShieEJT20mKuH
         yqAlIWA9vvf1kUGB1qtejRQPa84VZ19ps4Oy9wxcLWYX9V/wgGW2YNSBTbfcFrRdAash
         l5tlP5hx5LQbp5V46uZ8K7fIRain3C+HlvbRd15plhqFAjL3nVqz3KIU/LGGTE4yadhL
         HRLJIFV5Klf2z5dbwwO4TaVKOmn1gUTmaQkTMcwtdsHVGZSJ/gxeHFZ8pdgPRVFB1qeZ
         scVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=j8dKEdnHa49f1OmG7y3a+TulPcp4ffnpjcmy7OCw0BM=;
        b=rfk681CbZYWkConVjcqZGZqzeISUbzQWyWPqlbswIs1hOVnl4nTYXGSD4kRQv6Fkt/
         +9IlbzVSftvvjf1LBQhmiOHUxIE2UDxhxGZS5C+p9TcvG500C4DkYU4bkPNo7He4t5PO
         FMJkUavlyOANgCZqoBf8+oFbS0aaJ3dlKe/oWpn5OkJV6qD48lR2ux/PyPd69yQQ5c+o
         jvXCJLqyF6QRdk3m8d4FuEXLoA17a8G2KUbJsElBHjNAlxBW/rkzORptRFuvWKk2G4Co
         B+SZZTpvSth80tLM8oaMtJLlFg/XiYFwtVvYuvFKfb3iSLyzCApyRYoE+haQzhE8ul4b
         zXpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=JgLKF0TL;
       dkim=pass header.i=@chromium.org header.s=google header.b=RxhVTzVe;
       spf=pass (google.com: domain of kernel-hardening-return-12259-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12259-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=JgLKF0TL;
       dkim=pass header.i=@chromium.org header.s=google header.b=RxhVTzVe;
       spf=pass (google.com: domain of kernel-hardening-return-12259-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12259-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <78428dec-270e-5d74-0160-83feb5c0ff02@rasmusvillemoes.dk>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
 <20180308150236.5tysfbm3xdouii5n@treble> <78428dec-270e-5d74-0160-83feb5c0ff02@rasmusvillemoes.dk>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 12:39:58 -0800
X-Google-Sender-Auth: b7_JEo-2tuPwxQG_mDZW65ry1xc
Message-ID: <CAGXu5jKgDOezBGrYXCcy_UwM88rnT6pEpt9F062Q2qjf63KXBA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Remove accidental VLA usage
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	"Tobin C. Harding" <me@tobin.cc>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338745857869070?=
X-GMAIL-MSGID: =?utf-8?q?1594403447190488301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 11:57 AM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 2018-03-08 16:02, Josh Poimboeuf wrote:
>> On Wed, Mar 07, 2018 at 07:30:44PM -0800, Kees Cook wrote:
>>> This series adds SIMPLE_MAX() to be used in places where a stack array
>>> is actually fixed, but the compiler still warns about VLA usage due to
>>> confusion caused by the safety checks in the max() macro.
>>>
>>> I'm sending these via -mm since that's where I've introduced SIMPLE_MAX(),
>>> and they should all have no operational differences.
>>
>> What if we instead simplify the max() macro's type checking so that GCC
>> can more easily fold the array size constants?  The below patch seems to
>> work:
>>
>
>> +extern long __error_incompatible_types_in_min_macro;
>> +extern long __error_incompatible_types_in_max_macro;
>> +
>> +#define __min(t1, t2, x, y)                                          \
>> +     __builtin_choose_expr(__builtin_types_compatible_p(t1, t2),     \
>> +                           (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),    \
>> +                           (t1)__error_incompatible_types_in_min_macro)
>>
>>  /**
>>   * min - return minimum of two values of the same or compatible types
>>   * @x: first value
>>   * @y: second value
>>   */
>> -#define min(x, y)                                    \
>> -     __min(typeof(x), typeof(y),                     \
>> -           __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),   \
>> -           x, y)
>> +#define min(x, y) __min(typeof(x), typeof(y), x, y)                  \
>>
>
> But this introduces the the-chosen-one-of-x-and-y-gets-evaluated-twice
> problem. Maybe we don't care? But until we get a
> __builtin_assert_this_has_no_side_effects() I think that's a little
> dangerous.

Eek, yes, we can't do the double-eval. The proposed change breaks
things badly. :)

a:   20
b:   40
max(a++, b++): 40
a:   21
b:   41

a:   20
b:   40
new_max(a++, b++): 41
a:   21
b:   42

However, this works for me:

#define __new_max(t1, t2, max1, max2, x, y)                    \
       __builtin_choose_expr(__builtin_constant_p(x) && \
                             __builtin_constant_p(y) && \
                             __builtin_types_compatible_p(t1, t2),     \
                             (t1)(x) > (t2)(y) ? (t1)(x) : (t2)(y),    \
                             __max(t1, t2, max1, max2, x, y))

#define new_max(x, y) \
        __new_max(typeof(x), typeof(y),                 \
              __UNIQUE_ID(max1_), __UNIQUE_ID(max2_),   \
              x, y)

(pardon the whitespace damage...)

Let me spin a sane patch and test it...

-Kees

-- 
Kees Cook
Pixel Security
