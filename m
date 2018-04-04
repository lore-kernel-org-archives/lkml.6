Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522880266; cv=none;
        d=google.com; s=arc-20160816;
        b=E6GbX5czWo+9Ez2V+fsWafkDBT7rH0VieGWHpkSznJ4izBkXWlzeFtExwh+SK40uC3
         B9j2ZgqFNEjgr9Dx40iUn+oRwi/kUSzM6o5vjfIB/hvxWechiTUEIODISCN4AsiRAH8q
         6ul+75E3VBOKT1wb88X2GlGrh3qOotqJUVIRtgKCIH6jlxkdUt0CTRWDIYU4xMNYLWyH
         KWPD4/sEWFCVrLyQFbtPyRr7b7ZFUcntifVIHOBSXb9UJd8vNvp/Zdqgez3FDO+NDKNC
         FdFcLzuJt2gqVNpSvHRjoUeFrgrg7gkplFxJBli30KXZdRY9QMpAreJ5fduDzPzqBQKt
         HTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=cPOHnX4rYQZeLfVfM+gq7+pJ5LCRbKYTw5taFgvafgg=;
        b=0fvsJ0HYR4ndllG63wZfOQL991nnN786XG5z8GoEE+gLM1q/q3DgYmoXZMkaRDHYN9
         /7nM6GZ6fGchtpKCGeqimjZBGEy498qh0HgqQdcAGoPaiv/OnXGPiXP0qfdHEK7BJsjj
         gN/nlXvSaa8LCxe0BUCp2tdoRmuaaGwCbPfIytSR3+1BJh5XA7fS6NPgPnjFd1869TpO
         NuJmJmaYz5HixaPfwGr8kgiYz4zPHC2rgyJAXxBdAXMPX2v9eBJaomMsuPXQWOwh+YhM
         B1iUPCRpJLLSMEB/DrGkvxdpqE6wfSSOv81iqrW5fMA5GfBivNqaN/QzQT9isajPoUcw
         rWuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=LDJJciNf;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=LDJJciNf;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49VuZl1/GlqVuDhsY1/5pqDYC6V+runhbaDdxC1/+fGF1GrdrThoOgULr8fJhUivurKXyB+Dw==
Date: Wed, 4 Apr 2018 15:17:44 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180404221744.GI87376@google.com>
References: <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com>
 <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com>
 <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com>
 <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596855697904559647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Wed, Apr 04, 2018 at 02:59:09PM -0700 Linus Torvalds ha dit:

> On Wed, Apr 4, 2018 at 2:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > I understand this is annoying, but it seems I'm missing something:
> 
> I think you're looking at !AEABI case.
> 
> The AEABI case is worse. It ends up getting the code from
> include/asm-generic/div64.h after defining a few helper inline asm
> functions.
> 
> It's probably best if you start taking some recreational drugs
> _before_ looking at that code.  It might make you go "Ooh, kewl!"
> instead of trying to dig out your eyeballs with a rusty spoon.

Thanks, though I really should have followed your advice ...

Getting our compiler team high to look into this might affect a timely
(and correct ...) implementation of asm-goto and others important
features. Arnd, do you have another, preferably simple instance to
keep our compiler folks (halfway) sane?
