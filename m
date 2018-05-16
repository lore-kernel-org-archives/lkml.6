Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZps3hwyqSwa/uUKwhgFpi8HRtRdWRh1LzUKFcMg2OUHEizmPhAdENQi+RrqOJZIfOahtd0J
ARC-Seal: i=1; a=rsa-sha256; t=1526454021; cv=none;
        d=google.com; s=arc-20160816;
        b=EGqDOrQZNTedEllg7i9b58VXfRi3PgnXHkwGt8k7Lu7YQ8TE1dvQJ9MNCWO/0M+K4o
         M4ZIUZrkVRwsJknenim6kl3+wUQq/4SEOIZ1IbgZDKRY7TSIZVtIYshGCoYKufLZUjyA
         CLpMiG4KXV9mEA2vVANB3SkGG9utStYwMBjl5zbdYjy7fl87YbuKVHD9rs2/yVtRa9W/
         4BW7YY1mhGcIKqDMcS7Cof/LDew96TSDCnlUftTceTOnrXTQ+jhVbv7a2km1HDXNXOrF
         pJO1Aceybj4hUqC2AGzh30XjqwCIB1lDktmDYK1Bv3l6VOFnEmAfzMHMTC90KVgVdp6S
         WaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=uIJgLcA4hTkegfj/pOxHSm7q0Z4NURbPnXVOFr6PTq0=;
        b=cAcwrI0Rfr/ri/RZw0Gk/C97e1ow9Uz04msbXuXhWnm7EcIh7Cd3dp8S1ilMS5OHHy
         uiNU5HG+DNjEj9RWxSgokzrnlOk/k+SSwpxDbVXJ/R0WhnEWeU/RC0SAl7+tNRMzL+TP
         ykdOPhFfJjXW18LNavPii1zvSGJxlhsd1zxBHD2piVdQjncRCa5k/SXwjTT4FAcYhn6B
         J0d59Vviw7RWggtfqvPJ7vTl4NHq4qXiiFFYfrZ6fLcXfSKvkATmlKFHFVYB3/z0cHGG
         QKHlpay8ntmJaJ1YnPDQ+sfkCn/cMl0n39TjPTD4xiAR8XK+4FXcz3p5JL+9vfW1STR5
         2BxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=M7/8F/Ys;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=M7/8F/Ys;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4G6xgI0018877
X-Nifty-SrcIP: [209.85.217.181]
MIME-Version: 1.0
In-Reply-To: <20180516062623.GA32694@kroah.com>
References: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
 <1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com>
 <20180515155925.9c16962e2b416e5f507c07b1@linux-foundation.org>
 <CAK7LNAQJA2WJ6QO8H7dGi3D3=pHFfXLU=o8eBPcC+wxq-v7TqQ@mail.gmail.com> <20180516062623.GA32694@kroah.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 16 May 2018 15:59:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHZpTW5VWOPdEqwuACN_K7HNKjar51iTbb-Y6+cJwCyw@mail.gmail.com>
Message-ID: <CAK7LNASHZpTW5VWOPdEqwuACN_K7HNKjar51iTbb-Y6+cJwCyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] types: use fixed width types without
 double-underscore prefix
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lihao Liang <lianglihao@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600495013490118173?=
X-GMAIL-MSGID: =?utf-8?q?1600603052012654375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-16 15:26 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Wed, May 16, 2018 at 10:07:50AM +0900, Masahiro Yamada wrote:
>> Hi Andrew,
>>
>> 2018-05-16 7:59 GMT+09:00 Andrew Morton <akpm@linux-foundation.org>:
>> > On Tue, 15 May 2018 11:22:05 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> >
>> >> This header file is not exported.  It is safe to reference types
>> >> without double-underscore prefix.
>> >>
>> >
>> > It may be safe to do this, but why is it desirable?
>>
>>
>> It is shorter. That's all.
>> If it is a noise commit, please feel free to drop it.
>>
>>
>> BTW, a large amount of kernel-space code
>> uses underscore-prefixed types.
>
> Sometimes it can/should do that.

I agree that UAPI headers must do that.

If you mean "it should even for non-exported code",
I have no idea why.



>> I wonder if we could check it by checkpatch.pl or something...
>
> You do understand the difference between the two types and why/when they
> are needed, right?  I don't think checkpatch.pl can determine if data is
> coming from userspace or not very easily to make this a simple perl
> script check :(


I am getting puzzled...

It sounds like you are talking about __user or __kernel.
If so, it is a matter of sparse tool
but I believe it is a different topic.


If I understand correctly,
using 'u32' is safe outside of 'include/uapi/' and
arch/$(SRCARCH)/include/uapi/

Why can't a simple script do that?

Am I missing something?



> thanks,
>
> greg k-h



-- 
Best Regards
Masahiro Yamada
