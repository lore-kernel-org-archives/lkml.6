Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx49I8UnwTVr9ztxPtVky7nsYwerbmyx4+owJiE/uuI8cd3n08/n7PyBVv5qsg5lXBmxch1Wo
ARC-Seal: i=1; a=rsa-sha256; t=1522833554; cv=none;
        d=google.com; s=arc-20160816;
        b=g7ARXaOGX0lIIuR3i3jn6O2NlIoUln8HWQfm1Ef841mtBzOAr6Hn6iji+8u4g6UJSO
         ylzSYCJ8Faz7k+UWTcO2cJis/6AqJ7uZDAnLL33wv2kwIvgnPXMOa0H3W/p4KQ7FYew3
         JBorNZrVqHKE2n1U4CF9H8RHAA8KHlz4bV46wwQO+CC1GgaGB1LunCjJsUSP8uxLjeGQ
         PqwKHPXUZ0I/EVfPsY1LkviZxive3V0ujlruRJCUQL7oSkyrQZw1oMxoKLHyx1bk3g+b
         1VJwXxz6H8zF+HgmflAWG334J//ed5HGbKyxwhc1wnYXVzT/eDRkyo0FT4weWuNYCmQi
         WqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=6rrBUm09oTQalFRxSqKf6vxMKoxP128izyMvI8yvkl4=;
        b=AUBHqBWe878RsrV9ImgOCHR5wkkCPWkTzMnKe5o/I+NcAnyukFKttLap5POTMCAt+R
         ujBsc4RXal/6XTnuIm8BcGjbAEMrz0ooh5nFg1na6fGqwV6UpbCmSfJs5BBq/tpEtHRl
         rVNGZgS7n4dT75TpFkS0jde3RSjZU4vfOqpuDyGjZy0GvMBSjkMexUrR8lesDWTg5rcu
         vTU0O7Rru1kcPdoPwZ9W1tuGeWtTQLaDq8KXkOGwEje+R1GGihuthb/kF/q+eggXwbcr
         1fzhXtwk1EGSPBvC4yr7BKFrNNSLSXKoOap9n3goKDUiK/QpLCcU26ao3WSQWRZODFfi
         ShKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=kh3koJNt;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=kh3koJNt;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 4 Apr 2018 11:19:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>,
	groeck@chromium.org, Greg Hackmann <ghackmann@google.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180404091909.GH4082@hirez.programming.kicks-ass.net>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596806717508595645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 09:58:03PM +0000, Nick Desaulniers wrote:
> Speaking more with our internal LLVM teams, there ARE a few different
> approaches to implementing asm-goto in LLVM proposed, by external parties
> to Google.  These proposals haven't progressed to code review, so we've
> asked our LLVM teams to reignite these discussions with increased priority,
> if not implement the feature outright.  We (Google kernel AND llvm hackers)
> are committed to supporting the Linux kernel being built with Clang.
> 
> I can see both sides where eventually a long-requested feature-request
> should come to a head, especially with good evidence (
> https://lkml.org/lkml/2018/2/14/895), but just as you wouldn't accept a
> patch that doesn't compile with GCC, I'd like to request that we don't
> merge patches that fail to compile with Clang (or at least start to think
> what that might look like).

Again, I ask what the plans are for asm-cc-output, hard depending on
that is a few years out I imagine, but if you don't promise feature
parity for all the features we use, I can see this all happening again.

Also, it would be good to get input on the whole memory model situation;
esp. with people looking to do LTO builds, the C/C++ memory model can
cause us quite some grief, for specifics I feel we should start a new
thread. But this is another issue that's been raised several times
without feedback.
