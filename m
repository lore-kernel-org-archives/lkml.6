Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518568139; cv=none;
        d=google.com; s=arc-20160816;
        b=VhMAQq467jtLwHs8pUjC6NeL/22MWnKpSlvfCJ9T/sOXswtXAcRyjCixHSvFIrkeMd
         XwV11l2TQXXLhhqDEiAXu+B8j0t0VNHJXj8OYqfm9CJW4r1JcSfHqyInM56OSb4PI/Gf
         P56QoqovZdljelnaKzwocFNrudcw8fLdlw9AYMIr5zLzPfo81cwZCv6VSUGOLN7qwHA5
         mRQubsAvUNswYdnKc92vUk/yFymrmqxLs69Bc5ktAgkHtmwTmIXZLJNyYqcMk+0s8wMs
         4ncaVfGmmRnDhASXTn06Z5ojV1VzZJAkMuLY4Wgb1/LZxWiCtk9Ps/IgIfc2ZWNVEspM
         EPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=MmXhaBXwwzlgTK6cD13lAdgS0oXG3C836YJdL5719JE=;
        b=umstDMz9Yw0SKsB2qwsMEwIoIBS34T53aTPfeVPFpQf/czV/8685rXCNuqV3XD5LYg
         enATLyMgugXQV4aVcbm8wZdoGX1mKoKjEoWOZFv8FX1t4uOqJgKzRgGpXPdm8+wcDcoE
         ckP8LmnewDw8PH/uGk2STQPt35mdk3oQM4d5LYWKkUykEqAo3r6SkebB2jv0rS8dwKCv
         8q2LTew6qPDeDoDuELgBoI924BuVmOMwyrK6Ruac3fJuNf9Y1fADuvzJkqlKy62jS67O
         vaFCb4mFdP00zPRU+WDRXN3bfUnVSdyF3S/uC5SxBfO3I+oFqFEyC2cdy++8dXArOpad
         PptA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dnI7vHLH;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dnI7vHLH;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x224+0RCGgaWI6kSKKAskTMQ5hw466pVbUVIa7sJx0KqCAQDYWLarKTho3g7eRp8GPrbjgx1d/KS+Ea0akxFEPtI=
MIME-Version: 1.0
From: Kees Cook <keescook@google.com>
Date: Tue, 13 Feb 2018 16:28:56 -0800
Message-ID: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
Subject: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add clang support)
To: David Woodhouse <dwmw2@infradead.org>, Chandler Carruth <chandlerc@google.com>,
	Marina Yatsina <marina.yatsina@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Dave Hansen <dave.hansen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592334105121442328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 4:10 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> We also need to resolve the asm-goto thing.

Yes, this is becoming much more urgent, assuming we'll be raising the
minimum GCC version soon and drop support for lacking asm-goto...

Do you happen to know who the right people are to include to move the
discussion forward? I know various kernel folks that are passionate
about it, but I'm still getting to know who to talk with from llvm.

I see an earlier thread here:
http://lists.llvm.org/pipermail/llvm-dev/2017-April/111748.html

It seems to end there? I'm still coming up to speed on it, so I'm
likely missing other context.

-Kees

-- 
Kees Cook
Pixel Security
