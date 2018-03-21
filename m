Return-Path: <kernel-hardening-return-12711-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv5BS4TqW2+sijk1o1nziX3hfEsrOEKsGf2slWYSAsox2uA0/BhMm8ZmDOaQF0+1RInSC59
ARC-Seal: i=1; a=rsa-sha256; t=1521590774; cv=none;
        d=google.com; s=arc-20160816;
        b=RRWBejjwrt1ojQg+W6LtWQOo6Xi4TdUl0optPuFCdSbfHxrpRy2XhhfrmQNUV3h0Vw
         sYJ+UeflbleOt1KwMu8EwCfYwUvDFuWDPP5OEtcgxZNcTgDHNXTK3JkhYf8aC2pEhBu+
         bJnZt4hBCwroLLBwiAJSKVg2CMYSe5LwESk9z0torOqLaZ6BLULimtQBUF+EREhgsj1+
         AGq4UKfKC28FVLjTlkDAiwbMPhzVYPJ2r6XUjTdNTl57N/XhwKNFV3fIKOg+uU47Gx+U
         MnWVDyDxmuC/SBYz/Y4vOnzxoqAqJHDSvflAer3uJOGK1BnyXgLEdzrKyn0J8TzJ2i7t
         K5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=8MjA7ARsmdvsfLsKYmuZ3Y6MsuucOKxT1VXIA3Rhdqk=;
        b=w8h7hAzo1Z5X1j/y5Rl/51FcSeKtbUj3rLkfPp9/qm0B7qEckAK/uE8waC58dg6Crx
         ly67vQMU9QqgWx3OLdnhtZKXCTejnOgApETr10Ik3bow1qOgCy5jAa+/LYPjydafT2YV
         ooXK/c4qufbcnnXdR+PuMaET8qSIqrJQ+39G5MHFPk0KN5w05ULMxWD+xvxxaO3+VIf+
         yKX+Os+1PUhNE5U6EUPhTfRbKEuZlJA56EL10aalt/iy7QbHjiaPGhBM5XCP1GSWriZm
         QPfJnnECBC4jt3THX6Zib/5BcOim6a1PM74neU2gMt9zFrPCNR767RN4Ry0x3MHOEwZy
         nO3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12711-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12711-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12711-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12711-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 21 Mar 2018 00:05:32 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Message-ID: <20180321000532.GC30522@ZenIV.linux.org.uk>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk>
 <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
 <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com>
 <CA+55aFwxk=tUECYQkd4cog08qW4ZT=r2K7FQXzGnc-zuMc7JQA@mail.gmail.com>
 <CA+55aFwO8KZD_tZwqwL05FbzpKW4Ucd88C0tcR7LJ1utuy3WGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwO8KZD_tZwqwL05FbzpKW4Ucd88C0tcR7LJ1utuy3WGg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595503568038121970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 04:26:52PM -0700, Linus Torvalds wrote:
> On Tue, Mar 20, 2018 at 4:23 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. So thanks to the diseased mind of Martin Uecker, there's a better
> > test for "__is_constant()":
> >
> >   /* Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de> */
> >   #define __is_constant(a) \
> >         (sizeof(int) == sizeof(*(1 ? ((void*)((a) * 0l)) : (int*)1)))
> >
> > that is actually *specified* by the C standard to work, and doesn't
> > even depend on any gcc extensions.
> 
> Well, it does depend on 'sizeof(*(void *)X)' being 1 and the compiler
> not complaining about it, and that sizeof(int) is not 1.
> 
> But since we depend on those things in the kernel anyway, that's fine.

It also depends upon "ICE for null pointer constant purposes" having the
same extensions as "ICE for enum purposes", etc., which is not obvious.

Back in 2007 or so we had a long thread regarding null pointer constants
in sparse; I probably still have notes from back then, but that'll take
some serious digging to find ;-/

What's more, gcc definitely has odd extensions.  Example I remember from
back then:
extern unsigned n;
struct {
	int x : 1 + n - n;
} y;

is accepted.  Used to be quietly accepted with -Wpedantic -std=c99, even,
but that got fixed - with -Wpedantic it does, at least, warn.  What is
and what is not recognized is fairly random - 1 + n - n + 1 + n - n
is recognized as "constant", 1 + n + n + 1 - n - n is not.  Of course,
neither is an ICE.
