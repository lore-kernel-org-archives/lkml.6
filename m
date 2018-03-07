Return-Path: <kernel-hardening-return-12208-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuq7Wb5Yww8S6ofHc3u/mC2+L9U1/y6aSKaPLyzrUSayBouG+yp87HLZagN0Ffqikpj9Wy5
ARC-Seal: i=1; a=rsa-sha256; t=1520451174; cv=none;
        d=google.com; s=arc-20160816;
        b=yVB0YivGNXlYDU/FibMDyQM58LDQRurgAPgMi7BhcWCSP2WAikwdgBqNEg1RRX+/Ku
         wtO+Q2m95mYnXEZXJAZwYBxrRPO8ORJEfpqGHWfxA9iP/2bfX48YVsSg7EIWoaHK/WnP
         4WSx3atz3eSvgNV0lluOpamnKTthde5CPZBTBxFZbMoE6F7IScbd5bRygqeeBedXB/nn
         VwYtu2gqN5JPLhTexGpuTWiYEflEnHT2OKCu3Z7wivEef/ATBlSJM7aWDP/NjGWEBLMI
         mpTu7zhF4rbPV6cm0UJgTtDAV/9QEclJSjTwxrh6syNrCl+NGTJCpOZazEdHIIAL+R+l
         w9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Dn9WPQKJMo1su9kjOV9SzMaADvfsLpBw2zLT+pJslCk=;
        b=qnoFcIQL8ss1B5uWRG+4gJcoZMIf7FIQtawriZYYR5UDbJPbU5xNBYtePKiGAjYDJl
         gysDJZYvuYhnwYcmk9KZd5zmwPXsihopqN/JSEc/N/VUUPdBIjkCRqzsQ8lYR9ExBlO6
         Es4qUVbw+UJc0+2PEnUBCgEowQw0p6NpXHmKwefamCZ5DXCzicnQIiRdx2z0kXUM+oN7
         8U10FlhBXqjKmViRvGXSgT44yCBytU2mnfizkwnhu20crsSEVzBdIIVFWezPj/QtM+yx
         ncihdu2Ep4AVI2EC6m2kteF886X+RZrB+xr9XctSTGookerLmt2XWftWpFG9XSjWsrN6
         vskQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12208-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12208-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12208-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12208-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE23B2178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180307193110.GA3307@isilmar-4.linta.de>
References: <519fee5268faea09ae550776ce969fa6e88668b0.1520449896.git.luto@kernel.org>
 <CAGXu5jKOQPNuXR5At7984FSMHHrT7G6z7Tx5SdfP+62WON7JNA@mail.gmail.com> <20180307193110.GA3307@isilmar-4.linta.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 7 Mar 2018 19:32:12 +0000
X-Gmail-Original-Message-ID: <CALCETrXWyGxN-UC78jB6reo_OWghRBGt-uU1Jjf1EYznxkZAYQ@mail.gmail.com>
Message-ID: <CALCETrXWyGxN-UC78jB6reo_OWghRBGt-uU1Jjf1EYznxkZAYQ@mail.gmail.com>
Subject: Re: [PATCH] x86/vsyscall/64: Drop "native" vsyscalls
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594307354733708248?=
X-GMAIL-MSGID: =?utf-8?q?1594308611042532145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 7:31 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Wed, Mar 07, 2018 at 11:21:46AM -0800, Kees Cook wrote:
>> On Wed, Mar 7, 2018 at 11:12 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> > Since Linux 3.2, vsyscalls have been deprecated and slow.  From 3.2
>> > on, Linux had three vsyscall modes: "native", "emulate", and "none".
>> >
>> > "emulate" is the default.  All known user programs work correctly in
>> > emulate mode, but vsyscalls turn into page faults and are emulated.
>> > This is very slow.  In "native" mode, the vsyscall page is easily
>> > usable as an exploit gadget, but vsyscalls are a bit faster -- they
>> > turn into normal syscalls.  (This is in contrast to vDSO functions,
>> > which can be much faster than syscalls.)  In "none" mode, there are
>> > no vsyscalls.
>> >
>> > For all practical purposes, "native" was really just a chicken bit
>> > in case something went wrong with the emulation.  It's been over six
>> > years, and nothing has gone wrong.  Delete it.
>> >
>> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> I related news, I wonder how long before we can switch from EMULATE to
>> NONE as the default? glibc 2.15 (which stopped using vsyscall) is (not
>> coincidentally) 6 years old too...
>
> Or, in the meantime, add a warning
>
>         if (vsyscall_mode == EMULATE) {
>                 warn_bad_vsyscall(KERN_INFO, regs,
>                                   "vsyscalls are deprecated -- use vDSO instead");
>         }
>
> Otherwise, the patch looks good.
>

I'm not sure the warning buys us anything.  AFAICT there are no modern
toolchains in any language that will use vsyscalls.  The problem is
old binaries.
