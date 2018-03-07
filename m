Return-Path: <kernel-hardening-return-12221-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt3gOZWWuLJ/3oEdrjj7GA7o7COCXW65KMOvkUs7c4BxRR1Oa7fidZwjW0sjkMYGVqMQbvJ
ARC-Seal: i=1; a=rsa-sha256; t=1520467187; cv=none;
        d=google.com; s=arc-20160816;
        b=mnmdOEO3awjXS4KRUC+xtQX5pJ7HGWT2I359Ec2zxdZb3WrePtHB3klirAMdMr6vta
         SuJxfWWQfUVIVJ7PLSzJmQljHxhMJBVzfFl4IuNpBpw8yx4t0DKnjdK4FXrJZ4WGqwLu
         8P9LxOtgpIj1NMKKpHfAdc9EO9cMvJ2mjzWO4mAPm0EH9FbRsT6hWw18BkvyNmUCgECS
         bTvZPSvnyWyJISWf/KEL8dvtq9NSbZIkoTJkjZvwMrHrPONlgUb49b8Y26qOtrxw0guh
         A6flJHNMt8HGKnUrqnawsTktJDJ6Hbs2MzCvvkLE0Irv3qz1PEU2oUXH+n3cpIAodSQX
         /s1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=N8XpGf0AbmGXwckgGj6FHPs5NC1iMrAylLjM+GfxY/Y=;
        b=a5ESW71sKcdp2eSDy0KnqRI+6JupgNc1aevJzpSATXLy+9QG3F9Bv/XU5/ynTHV7/r
         oqe/FCXLiopVoqGXXDb7ldsnr+jsNEQrz94O8yGf3lw6/eBQ5frtwOoJ4RvT6QsqIKhL
         GkNBaA8tNldzh1LaYMi7BpOEEbqXbtrbwrrp2qDYOp0MNY+zMKwmow/44HcLrjVvg/aO
         21qlQyHdppjHpWI5QdxUO5C9a+6el//GAkRkTPd30fjrFXndyc4gMh/07YWCxjryz2dY
         GiAK/i41GCAbWVWwmJJGycm2XeHomzlUr3QJhDPVIHoniEqBEkBsWOppPm2IT+N7GIX1
         SRyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ZgS5SUk7;
       dkim=pass header.i=@chromium.org header.s=google header.b=TtxDaT1I;
       spf=pass (google.com: domain of kernel-hardening-return-12221-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12221-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ZgS5SUk7;
       dkim=pass header.i=@chromium.org header.s=google header.b=TtxDaT1I;
       spf=pass (google.com: domain of kernel-hardening-return-12221-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12221-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180307234238.yxbbaka35ck2xymw@smitten>
References: <20180307230714.GA20797@beast> <20180307234238.yxbbaka35ck2xymw@smitten>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Mar 2018 15:59:27 -0800
X-Google-Sender-Auth: y29XRhRMMh-tCWRbgeeqShUwq5k
Message-ID: <CAGXu5j+d91dqTEPm13CXDvNzzaj01M-CYLYCqyMN5VjrD5Q4ww@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Remove accidental VLA usage
To: Tycho Andersen <tycho@tycho.ws>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Tobin C. Harding" <me@tobin.cc>,
	Jonathan Corbet <corbet@lwn.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594325401661962189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 3:42 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> Hi Kees,
>
> On Wed, Mar 07, 2018 at 03:07:14PM -0800, Kees Cook wrote:
>> The "sym" calculation is actually a fixed size, but since the max()
>> macro uses some extensive tricks for safety, it ends up looking like a
>> variable size. This replaces max() with a simple max macro which is
>> sufficient for the calculation of the array size.
>>
>> Seen with -Wvla. Fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  lib/vsprintf.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> index d7a708f82559..f420ab1477cb 100644
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -744,8 +744,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
>>  #define FLAG_BUF_SIZE                (2 * sizeof(res->flags))
>>  #define DECODED_BUF_SIZE     sizeof("[mem - 64bit pref window disabled]")
>>  #define RAW_BUF_SIZE         sizeof("[mem - flags 0x]")
>> -     char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
>> -                  2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
>> +#define SIMPLE_MAX(x, y)     ((x) > (y) ? (x) : (y))
>
> It's probably worth hoisting this out into some other header. When I
> was looking at this a while ago, this problem happens in a few places,
> see e.g. net/ipv4/proc.c:TCPUDP_MIB_MAX.

Hmm, good point. All of those suffer from the same "max*() is too fancy".

I didn't want to encourage a global macro that _lacked_ the safety
built into the max*() family, though... thoughts for a reasonable
approach?

-Kees

-- 
Kees Cook
Pixel Security
