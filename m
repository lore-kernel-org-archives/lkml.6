Return-Path: <luto@amacapital.net>
ARC-Seal: i=1; a=rsa-sha256; t=1518628936; cv=none;
        d=google.com; s=arc-20160816;
        b=MrJoDG7IMpcgfcU46xT9UAFaxn81HgpogdM+v1Lvd5RghbrlbjXqN/euE3hFdDn2l7
         nOIaM27OnoeAFFW2VmMlatrB2J2YYtazc9/2m/vgZbyA8ZTSh7pY6ssnoE249JOOECMG
         IObljZ9klH+cA/SybC87Yv8LBOWMMrgkc1zIsntYxYPeOeV7CyU1tQm13TvJrdLcfrzn
         JQA+AQyuV98kybqVJM3pUbsmsWI3M3MqwAVKSsQcgh5XEDxhXosVyCJ/ucjfXLixldpT
         ttEbjaWoU4yRhvIEwhJfBz6TSbkR2iEN7ZD14bCsWxhzesEoE3Xb2c/mC00th5IqCWCz
         dkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=nL/hbHNHxg6K/dhTeG/lbryJ6P8W34ECieOPjUkkDdA=;
        b=WYanwCEkOsu/dF2/afWT4qL2wPEw5DsfjH+8iB8iAw0ZriZQCmLV713M+k9RfH9hdU
         TqzIfSd6Qgt0x1oSdE8MCu5uX1sAag3pi950o5fBdPl6GemS4faK6ckru0nqq8L9otWB
         sTE2H+2LFLantuNNTZXhazSXUEvFfuenqrtkG267dKUhVgYs0lq6hNY9RefUtd5W1AOp
         OmSnm15IhyLffayvw20QWcQS1JYy9UuEr7JO8oaKDTA7t6PSB2usm6jO1Qjqzw19xEYF
         Gaep/SoXn8SRUR2BGgcn2Vj+OnOJqNc6MmNaCD8Dl5OIu86yjki0t6NA8RcpYn84lw3Z
         y9xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=XQHWw5T8;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=XQHWw5T8;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
X-Google-Smtp-Source: AH8x226S/eJXkh3ytbbgmCoLT6bfRuAI1r4ZJQcf8/ndsNW+kt0FS7j3xlbnXgTAshzB09YEpM2UBaofVpa1IIP7FRY=
MIME-Version: 1.0
In-Reply-To: <CAA2zVHqxQeZRdQtfhL-QRjqE5W94g+NU9E9Lx8RwwjDof36M_Q@mail.gmail.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com> <CAA2zVHqxQeZRdQtfhL-QRjqE5W94g+NU9E9Lx8RwwjDof36M_Q@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 14 Feb 2018 17:21:55 +0000
Message-ID: <CALCETrVeOKXa_xiggzqjcx34TtTs_rMyq56u-EXCFYgQtcei5g@mail.gmail.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
To: James Y Knight <jyknight@google.com>
Cc: "Yatsina, Marina" <marina.yatsina@intel.com>, Kees Cook <keescook@google.com>,
	David Woodhouse <dwmw2@infradead.org>, Chandler Carruth <chandlerc@google.com>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>, "ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>, Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>, Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592397855663470455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 3:31 PM, James Y Knight <jyknight@google.com> wrote:
> I'd be definitely in favor having clang support asm goto. I wouldn't
> want to exclude having other conversations about how to more directly
> provide compiler features that the linux kernel could use, ALSO, but I
> do not think that conversation should block implementing asm-goto.
>
> IMO, inline asm is, generally, a valuable feature to provide in the
> compiler as an escape hatch, and asm goto is a relatively sane
> extension of it. Supporting outgoing edges from an inline asm block is
> a reasonable thing for users to desire, and as far as anyone's said so
> far, seems like it ought to be fairly easily implementable, without
> causing bad side-effects in the compiler.
>
> Of course, we generally do want to minimize the need for users to use
> inline asm, by providing appropriate compiler support for the features
> people would otherwise be forced to implement using asm. But I don't
> see that as really any more important for asm-goto than any other
> inline asm. There will always be a desire for escape hatches, to do
> weird and unique things which aren't supported directly in the
> compiler. (Also, the kernel is a pretty special case in terms of its
> requirements, it seems exceedingly unlikely that we could ever provide
> enough compiler support to let it eliminate inline asm.).
>

If clang implements asm goto, could you also pretty please make it
better than GCC and support output constraints in the same asm
statements?  This would give us a very clean, short, and fast
implementation for __get_user() and __put_user(), and it would also
help put pressure on GCC to implement the same feature.
