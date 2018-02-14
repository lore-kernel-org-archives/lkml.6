Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x227GsCe1sa4ohWbZGcn1BtzEtlUA8HLr/fBq+FjpG+PDkoLFELaPMzPRLMeA2Hc2GIt/kbht
ARC-Seal: i=1; a=rsa-sha256; t=1518605130; cv=none;
        d=google.com; s=arc-20160816;
        b=E0xPCYvpnL1eiaw7rRerEEoyLsRZm/N6MkSiISpj9qAH6VkroZbw2+spWoscDPPabA
         s5Tr0FOJduxDYwd/9mfSCYX/m1YQy44s41hEuWOkMsyuImwGhFQ/ke+R53FVkN23E2Pu
         5FQDve2H69omCzWxrw+HbxWbUWGbHFE7rdw35/zYO5cuJrZtqvATH1lP503kAbsvawQA
         BAtaEFb9MKZC/z03+tf1/n+UwlmYgl0Ssh9ZPvgZDSas6hHm13SiuajL1crBDvhpb8EZ
         r1uaQwFhKT/YSJc77qhD7gwSs5vFMZMyfWYZ9uqDdwYKjkb7aejECK2rOE7Onz/VEUXG
         gUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=B6mW+FQ4oi2NLpfSzLQod90r4xbil1ZLonvZWUwTsIQ=;
        b=mx0m/0ylh3bLjIMZYw67m5yVPKBLLQwXOswMqCqf19MB3IKdJxzL6XSJz0b+AAfeVb
         HgkUxJgYGnmsuu9prXSYABh67bLAb7vsfcHmBZmeHLeBeGav9ZJHej9bVch4Oeb35dYk
         Rsi5vOC0Km90Uhb5oOaqNeWSArqtHfOmHEXFjJL7eH97bjctYNwWNlL5r4TBpnaW+gO6
         7dDDWKw6HAQ6XBVODPPN9QlSQLqy3d7itec44Hzq4ujot0El549UvDKkOC9l41q8rAuG
         PlbSb/jUu4cuTx+vFkH/6QA/f/MxCsLjNqie1KErjjite+mMwIJqIfL52M0tC8SMFbca
         d8FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Wed, 14 Feb 2018 11:44:08 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: Chandler Carruth <chandlerc@google.com>,
    "Yatsina, Marina" <marina.yatsina@intel.com>,
    Kees Cook <keescook@google.com>, David Woodhouse <dwmw2@infradead.org>,
    "Kreitzer, David L" <david.l.kreitzer@intel.com>,
    "Grischenko, Andrei L" <andrei.l.grischenko@intel.com>,
    "rnk@google.com" <rnk@google.com>,
    LLVM Developers <llvm-dev@lists.llvm.org>,
    "ehsan@mozilla.com" <ehsan@mozilla.com>,
    "Tayree, Coby" <coby.tayree@intel.com>, Matthias Braun <matze@braunis.de>,
    Dean Michael Berris <dean.berris@gmail.com>,
    James Y Knight <jyknight@google.com>, Guenter Roeck <linux@roeck-us.net>,
    X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
    Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
    Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
    Tom Lendacky <thomas.lendacky@amd.com>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
    "Hansen, Dave" <dave.hansen@intel.com>,
    Tim Chen <tim.c.chen@linux.intel.com>,
    Greg Kroah-Hartman <gregkh@linux-foundation.org>,
    Paul Turner <pjt@google.com>, Stephen Hines <srhines@google.com>,
    Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
In-Reply-To: <20180214091042.GV25181@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1802141030300.1292@nanos.tec.linutronix.de>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com> <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com> <CAGCO0Kj01tAXdzRrL_p+LrTLK6-k-1-BFPm97jQMuJSPH7PTJQ@mail.gmail.com>
 <20180214091042.GV25181@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592372893389871317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Feb 2018, Peter Zijlstra wrote:
> On Wed, Feb 14, 2018 at 08:41:43AM +0000, Chandler Carruth wrote:
> > Marina, Kees:
> > 
> > I think the combination of LKML and the LLVM developer's list is probably
> > too large a set of folks to have a (somewhat) lengthy exploration of
> > options and how to go about this and find a good path forward.
> 
> As one of the original authors of the jump-label implementation I'm
> saying there are no options. We're not going to do a second parallel
> implementation. If you want to build the kernel, you get to implement
> asm-goto, teh end.

Amen to that.

As x86 maintainer I'm really interested and willing to support llvm/clang
for x86 and the kernel in general, but asm-goto is not longer negotiable.

asm-goto is in the kernel since Oct 2010 and the relevant llvm/clang bug
#9295 is open since Feb 2011. All clang/llvm folks came up with in those 7
years is occasional handwaving about better solutions.

We really try to support old tools and tools which lack features for quite
a long time, but that's not a free pass for eternity.

That said, I'm not willing to wait another 7 years and I'm going to pull
the plug on compilers w/o asm-goto support soon whether llvm/clang gets
their act together or not.

Hint: GCC is not the only major compiler which supports asm-goto.

Thanks,

	tglx
