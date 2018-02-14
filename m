Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518629975; cv=none;
        d=google.com; s=arc-20160816;
        b=l2hJqyNE5Ur2ipVWT9YY5EE3ppWDvO/yDWLWAj/jyKo41IhUVu9j7D1WGkCumEDuNX
         lAr2/JFBEneXtDZQ4e/zAVZ2CK8GG7iTJJoqBPMqBicJT85CI0SrpqALvFJpX6blyfAG
         2kEcOrGDbldLWVMJ3z5eqBcmC/Q+suefba1Kd5zOQMMjvrtA/MbrjSCvw5KY6iCkaSU5
         rj8zi+uBL/yOmF+SKY/dNLuzKXlgyosYJijujiGNiTJkzXU0vTDOpVg5cMCV/d2Io8wJ
         AnRpWBnq+KUU9vVlrb/5hJ1MIqrUCFEDoT/XL763q3ntGu2CU+c5GxcUAqWY4w8iPXBY
         cXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=CfGdu8zw1fpY7H601LGMGfIxaar//qQ5FAj2G2BtMbk=;
        b=R4VBFbyVCRmB82DQkBXMco0OIIgJDjHCOnasbrp56LP3+fDPkB1RxWQKcxTuAJfVUu
         xMp783bR4NeomFNmJnITBRiJNeI/2SyVYWKKqWPMH6hpMelfZc72YF6p4Aj4VFxWY3AX
         ymgzig0V40PtoeHdZ3WH4N4lcSPN98xkQaX+UJLt41UcxVLLiPC4e14/62PWNFRbYRIt
         AqdIrnvo17tmIRC//PZCsqQvqL4sSygaQnlncFOb2qGmmeetZxE0slysfP0Pyqy+Ub7z
         57nOg/nAzdPJ4wN0Gz1F5e1Fza3LlK2HF4i90hBmVuWR7LOsyai7f61TzIExMYqBTImy
         SImw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qg1BjGkm;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qg1BjGkm;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225rnEt7QS+rAzOxfsYvbfk3KEoTs0/FZML209qefrorO+ajaFo9/0FWAevDBwRz0yMztQAYKcWhA+bnKv5iv5U=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180214103434.GY25181@hirez.programming.kicks-ass.net>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <20180214090851.GU25181@hirez.programming.kicks-ass.net> <A3D6595E4CE1DA4A80538CC077C51A2B84771900@hasmsx107.ger.corp.intel.com>
 <20180214103434.GY25181@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2018 09:39:33 -0800
X-Google-Sender-Auth: 23Rf1XZMTWNmc7zia2mfZEVFC2Q
Message-ID: <CA+55aFyCp-9Qqjcn9wp=VDp2KO7tfYuUMJxVKC75Xxu0wEB5Cw@mail.gmail.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Yatsina, Marina" <marina.yatsina@intel.com>, Kees Cook <keescook@google.com>,
	David Woodhouse <dwmw2@infradead.org>, Chandler Carruth <chandlerc@google.com>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>, "ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>, Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>, James Y Knight <jyknight@google.com>,
	Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>, "Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592398945661548693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 2:34 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> So it's far more than just tracepoints. We use it all over the kernel to
> do runtime branch patching.

Side note: I have a patch to the user access code to do "asm goto" for
the exception handling too.

In fact, the infrastructure is there already, but because we supported
older gcc versions that didn't have asm goto, I never applied the
final patch to actually make use of it.

See "unsafe_put_user()", which currently does

        if (unlikely(__pu_err)) goto err_label;

rather than just have the exception table itself directly reference
"err_label", and not needing any code at all in the regular path.

I suspect there are other things like that, where the lack of "asm
goto" means that it's not worth the pain of having two code paths.
Once we update to a newer gcc requirement, those suddenly will also
very naturally use asm goto.

The other asm use that the clang people might want to look at is the
"condition codes as return value" one. That one we currently handle
with CC_SET/CC_OUT, and it's somewhat more amenable to those kinds of
games, so missing it isn't as nasty. But it *is* a useful "modern"
extension of gcc asms.

Maybe clang already supports cflags output, I haven't checked.

              Linus
