Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x22666QMKQxnkYXLi4Rbd64oZ9RPx2oKmCA8SBRaTACAw/V/+DJKDdp4UpfumZmvDEjedv+12
ARC-Seal: i=1; a=rsa-sha256; t=1518599452; cv=none;
        d=google.com; s=arc-20160816;
        b=KiE/wCFsyCxK+aJtPLU+HtqWdYsBLLGQ2yYvwOS4/6K1KFy4LkHIHj2WSXxUpG5+9x
         +QRbHCe5PR8DIhyisv4IOZTxfToUMzvdZG39GyRrOS2zjQp/sDd19ocwekHrxED2YB4n
         G8J98XP2mHqU5Y5kMvqSXSXQl4JK7DAsrqqZe5EgRBuYxutonJlf8cJ2RyooUcd9BXd7
         qzbToEhs78AeHiiSQUWZKkxAUNrdwvCnrzf/UZiJkGm1bmF7FYAhcHxPiSOHHS8bK80W
         hUV3o413SgeeStUx9i8W6P05XLoF4WHoTAtRpdVSp5URnTJANUBYORECtmdGdNGKhl6l
         xdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=pQd5fLpnXw9wOWfJkrjRs7nSuSOzxLP92K7zZnlqRRA=;
        b=L6jrSm2d8GblgWsmY09TPlxnSVaBMZZFqhLgeHmOL9S7+OOMgSZr6GgYvZG1x05jZq
         LwptDXx6dY0rXp7Es2ksdRypHafheaghqAGPJH3eZoLiPWDzs+SymvSlzpvXWmgWxLaV
         gNxV0GMMIO+vM3qQHs7qALI4pT4V/4SiIegA+IQsdZmVaesB9nE0wkpjs0wj2VXORuDf
         Nll+k1kdTzhYOzPA/FA/hj7l00ZwFVlIktS/Q81133mxw3150dSOqcmJPg+TGep1lx7z
         mdTjVtFV/InRLVasnR+hH5fqvu8+2Umo0GgZzahHCkw8YFnB13Ev5oIoDq8/5kYv1Oa0
         VfPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=d6pfiXFR;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=d6pfiXFR;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 14 Feb 2018 10:10:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chandler Carruth <chandlerc@google.com>
Cc: "Yatsina, Marina" <marina.yatsina@intel.com>,
	Kees Cook <keescook@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>,
	"rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>,
	"ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>,
	Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>,
	James Y Knight <jyknight@google.com>,
	Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Message-ID: <20180214091042.GV25181@hirez.programming.kicks-ass.net>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <CAGCO0Kj01tAXdzRrL_p+LrTLK6-k-1-BFPm97jQMuJSPH7PTJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGCO0Kj01tAXdzRrL_p+LrTLK6-k-1-BFPm97jQMuJSPH7PTJQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592366939020628622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 08:41:43AM +0000, Chandler Carruth wrote:
> Marina, Kees:
> 
> I think the combination of LKML and the LLVM developer's list is probably
> too large a set of folks to have a (somewhat) lengthy exploration of
> options and how to go about this and find a good path forward.

As one of the original authors of the jump-label implementation I'm
saying there are no options. We're not going to do a second parallel
implementation. If you want to build the kernel, you get to implement
asm-goto, teh end.
