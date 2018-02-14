Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518630206; cv=none;
        d=google.com; s=arc-20160816;
        b=qynS3B3vv+E6iW+sj/L2SnwP8ayt8rO4LA0s5QB/yv7ozaOAwnrmASd2rua2swvYrY
         v3ONMVUr0txzXb0qR0pHlulmu6mKsMAqcKdb3gG9E9WPNPkLiLohKkTKtFKFfQVfv8Gz
         EGcv9P3tt12uhzl++e9viMTaWBsgNIOrHZa3ejLQJ0s12ZRyPNd28kKbfeC4NElNeN+Q
         2LeyzeBrm94DiJAA7mdTual3b0lUB99JDJ2L2didvq0RYUKBB1jw84fjd7jJPHDtNKUr
         d483aB8vYAAX8p/pDSVCFuCOc8fKxNGmKhdY+eDWTUagbrpMKGfYHsTXlWPcJGAi0l5X
         AfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kvzReK7B7TcwTt5odqH4oSZq0OkUcX2y3L6ZFXYih5Q=;
        b=IEttEVZBvTlaY5xhUPHFLjrouesRmDcZz+/PmWHUYlKr60bFjNBACU/BEm5137iA4d
         yBATivimn9nfmRl/1N8ybXm9EBRzBSd+ME1hZl6Vlcw4N5mLywDY42OfRefjgUsnyOh3
         SL1bvVOrZDa4Pt+Kn6ejJOtz27c7ObS57dIpCiFd5xnQfiF0fByVfjh+bQi8Xg+qiyxY
         hfE94n8qDAL27GVlk8W5SUlG2kh5r12xT/JKychzC/CR0prx1f4klsKQ6CJxsHe6rfof
         36UPV8bsC5qQulYhpzugqPa/+0/KagmBFjdzNxXkBcP1OT0+xB9bR7AGoqDxnE+TYpLN
         vSxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UoIeB9/U;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UoIeB9/U;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x226fNtC7joxsr/F6iRCUDni+7Pz1/SX8nAQJIfQqDIQlkgv92RkkQefu8K7lvsbGFX3Q8NBJI4OZdCFy8Iwbtyc=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAA2zVHqxQeZRdQtfhL-QRjqE5W94g+NU9E9Lx8RwwjDof36M_Q@mail.gmail.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com> <CAA2zVHqxQeZRdQtfhL-QRjqE5W94g+NU9E9Lx8RwwjDof36M_Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2018 09:43:25 -0800
X-Google-Sender-Auth: aktuoriW_cajgq6oRfyS8PcOFuQ
Message-ID: <CA+55aFy+OxjvzxE3AXDwOwWJZLRAAR32OSsT9f5qy4r8qA+KCw@mail.gmail.com>
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
	Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>, "Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592399187829269256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 7:31 AM, James Y Knight <jyknight@google.com> wrote:
>
> IMO, inline asm is, generally, a valuable feature to provide in the
> compiler as an escape hatch, and asm goto is a relatively sane
> extension of it.

Side note: one thing that limits "asm goto" in gcc is the fact that
you can't have outputs.

If clang people are looking at "asm goto", the _syntax_ is actually
very straightforward, and there's really absolutely no point in trying
to make up some other interface.

But extending on what gcc does, and allowing outputs (possibly valid
in the fall-through case only, not in the cases where it jumps away to
a label) would be a big improvement on what gcc does.

At that point, we'd start to pester the gcc people to do the clang
thing, rather than the other way around. Because that's only fair ;)

                  Linus
