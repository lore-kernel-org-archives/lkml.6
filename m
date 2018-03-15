Return-Path: <kernel-hardening-return-12644-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs34JVe/vjAp64AoOcR9o9K++wO6SStRGXzbLIRtQvG2zKq695mqcIOfPUeJVHUVU1/C6/R
ARC-Seal: i=1; a=rsa-sha256; t=1521152231; cv=none;
        d=google.com; s=arc-20160816;
        b=k+rR5aqvzszXpUgUWw5yaOmunAu3o8StK/wXGHznq7bDRm2qi/87u8P4TO6aogbsSC
         N5IgKvtw67bBmkpE8HdOpGeb66kZi8pKHQp/kcpY3ddgOWI2jml3hT026OlQpjCDfQsl
         ENcC6nKopDRHvDQTiq4UI73YLHiTjLJcSRj/EZKC0OtZ4hvQ6/Gag/8DJjV3YZ7WUT1N
         FD+bAOF3TJ1WBDL9Op5vfotinvoDxCJkgb89l9ZdD0LU0Vp8fhVWUOdJIWsjWWUOuWf3
         xBxW3bgTJm6ULkkuGazHSisRO6RiThTRG8tkKCv95LIwqXjd6SEkiSqu49FS5QGduVSE
         3gPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=QvYfgLBBHdlApZO/geOC9SAHbFXHn9iSu+5gB1EQqQY=;
        b=yJkBY3PAZi0sHwwEUS5+49aKptPY4fcthbGBzywueO6yyesrcNtkK+m5fi/llvQvr1
         09SjY6tWMfnUqvnMdNY2K+OF/Qxvv4sdAamY3Agsux3RS/3WoRe8fozYlGtPZ+urnv4B
         wvI2+xmz8wKaaMi41C54e4YP3YeoYq58X+xN87Hg0TEi3cuOW405/5m1KOJB6m7oe+qw
         9w8i5nLMzOyCl0a34ZE62/IhCdROUTC/nsb74plFpeFO7raaCzmEnTHPa6+FZ3GwjB/X
         KbYMDEHj0kYd9Q6/rxQ/+t5j++7+TKiYM/xRrh6pDGmQ6qKWiMKTSi1YHk0ehFt7iwJT
         P86A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Y1Nlbjeu;
       dkim=pass header.i=@chromium.org header.s=google header.b=jWSZVfGS;
       spf=pass (google.com: domain of kernel-hardening-return-12644-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12644-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Y1Nlbjeu;
       dkim=pass header.i=@chromium.org header.s=google header.b=jWSZVfGS;
       spf=pass (google.com: domain of kernel-hardening-return-12644-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12644-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Mar 2018 15:16:51 -0700
X-Google-Sender-Auth: 0_rSiiLmhJ-uR9I6XACJqAY1ZtU
Message-ID: <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034361293703830?=
X-GMAIL-MSGID: =?utf-8?q?1595043722195799550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 2:42 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Mar 15, 2018 at 12:47 PM, Kees Cook <keescook@chromium.org> wrote=
:
>>
>> To gain the ability to compare differing types, the arguments are
>> explicitly cast to size_t.
>
> Ugh, I really hate this.
>
> It silently does insane things if you do
>
>    const_max(-1,6)
>
> and there is nothing in the name that implies that you can't use
> negative constants.

Yeah, I didn't like that effect either. I was seeing this:

./include/linux/kernel.h:836:14: warning: comparison between =E2=80=98enum
<anonymous>=E2=80=99 and =E2=80=98enum <anonymous>=E2=80=99 [-Wenum-compare=
]
          (x) > (y) ? \
              ^
./include/linux/kernel.h:838:7: note: in definition of macro =E2=80=98const=
_max=E2=80=99
      (y),  \
       ^
net/ipv6/proc.c:34:11: note: in expansion of macro =E2=80=98const_max=E2=80=
=99
           const_max(IPSTATS_MIB_MAX, ICMP_MIB_MAX))
           ^~~~~~~~~

But it turns out that just doing a typeof() fixes this, and there's no
need for the hard cast to size_t:

size_t __error_not_const_arg(void) \
__compiletime_error("const_max() used with non-compile-time constant arg");
#define const_max(x, y)                                         \
        __builtin_choose_expr(__builtin_constant_p(x) &&        \
                              __builtin_constant_p(y),          \
                              (typeof(x))(x) > (typeof(y))(y) ? \
                                        (x) : (y),              \
                              __error_not_const_arg())

Is typeof() forcing enums to int? Regardless, I'll put this through
larger testing. How does that look?

-Kees

--=20
Kees Cook
Pixel Security
