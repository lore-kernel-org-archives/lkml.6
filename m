Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227JcqsOwyzGuAcPefFj6HR+e5aoJ/BH5o0CwsHkrl1l+bGGe1iRsvtnsOixQ6dMxyHZxFff
ARC-Seal: i=1; a=rsa-sha256; t=1518633621; cv=none;
        d=google.com; s=arc-20160816;
        b=ROZrqc9Rde3Bwf1q/J2R1mVu13LhzyfyZHU+WQ/fBbFUHuBdn+63g2CKjkWyvFmNu2
         FRIVOJY//7xsQZeSYavLuAcCxw/5OhaCvjF9mcipwJiksx0rwUU/wJVTinsGeAV9FZAR
         xPEKHRtDuyr3g4IGDnpt3xGWD2DuYRwEYQSmnjvtPGLLv8LHIvhMRwbasyBe7lf2B0Cv
         qhIoaUxWWl1ZZA0rceZerL/JF4qxZVgG1UNpGd5/OsjS8B4kW3ZpstTtoYhjIb9ba9vX
         t6KHh8Vs6QhkH+TLuRUXm1q7WThXDCIGFCojonmWYgscSRh3muHLhTd2Ul16BjimJMU3
         eoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+7HuhZrSKo8lULjNQcD5n2OeyCAAKC0Vxcgyz7auagE=;
        b=Ah39RmUffaWRjK8+9umDV9iYDOb1isgzkbKafDtGfIgqdZyt4rDoBeXX66OX5lrpad
         mP8HUAxOyuG2eYf4LEVDI9mu3VeL4jnic7Nicjrg/Hz97Uvr+cNKAsheiAFX+y6mTuaL
         hsK5YSqnNMFGdYHDAMxrFnU1NHf9GSUuDMi4RNDiAkH+v/Hfxf7kM5KhFpjzN56YbTsZ
         JcSA/tciH88IGuC1aGckIcTimfwKe7BQ8Z4YySrHkRg1sprhHQI6ORMKHyDGif5d37a6
         NYklIDXbrMcyPaJsp2jDj7/e5DCNE3AgK7sYGE885y4I5DPst4/rl6H3HWzxkdGmV26+
         mk4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=P4V6am3d;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=P4V6am3d;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 14 Feb 2018 19:39:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@google.com>
Cc: "Yatsina, Marina" <marina.yatsina@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Chandler Carruth <chandlerc@google.com>,
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
Message-ID: <20180214183955.GS25201@hirez.programming.kicks-ass.net>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <20180214090851.GU25181@hirez.programming.kicks-ass.net>
 <CAGXu5jKDAKZYwvi2FAvTOsuPdu1wrqH8bckutbO1BGDyGx+U4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKDAKZYwvi2FAvTOsuPdu1wrqH8bckutbO1BGDyGx+U4A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592402768820950459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 09:31:22AM -0800, Kees Cook wrote:
> On Wed, Feb 14, 2018 at 1:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > If you ever get to the point where it makes sense to build a kernel with
> > LLVM [...]
> 
> Just to speak to this point in particular: it makes sense to build
> kernels with LLVM right now. It's already happened; millions of Pixel
> 2 phones are already running with Clang-built kernels. And even if
> you're only interested in x86, that works too.

Only if you really don't care about performance. And as should be
evident from the rest of this thread, you soon won't be able to build
it anymore.
