Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522869446; cv=none;
        d=google.com; s=arc-20160816;
        b=HyL+rdsl8dB2MtpSanQ3KoUIYgoktvMnCjjz79YbzAhBsXQvwlpXPTfn6GCQpKVJO7
         qDzHRZb7u8faVuuWlozvrJxlck1it01AstCDh65MDRU0mlt20LepMV6hVYY/brddc0sE
         1OsFCDIoyoedIBy5OAYQtZtsg8VpakZH5C2eNL+HeZ3ZSLzsPB60CouElrRCGut8360y
         wPDGzxW7DOk8j+WclkkCjA1gqzX3QDReYEMQEByjj64W+gKdfTQhJanlUIU6irOVv+wP
         Zq565sdWNs4xHHiqe4+BrZjlDuJ3XBlcjdpbIli7MrX9eSX02bE+/pEEZDBlj5ceCuaz
         BWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=J1y6lQYMHFu9ziEYinqW4gzYnq1v4oqjCwjwJ+CceRE=;
        b=JmO+jg2UPAqHK6vskBdDalaxiBBH90t0JaMDnztRyBSr3JZjaSCeYw8oEircjdpow5
         3iU+YcuKViKctB93E+fqa+makItOl66chpE5iWkJ4hvu5xqyUYJh9l0Bz65qf+avjXbD
         d8fmDe55GimLbe8Le3YYeN4mizhyoeeeHWGdc1lFmBiElbIThUne6ToRVNkeH7LbQXWr
         JEax+QnUQY8+ltAJJyuY45nsmgxpA+ji1z97FFcQNtKYcXXZCg9MX56ovllRZLA0Tr5T
         O8pHlOlYW2D5oxfh/qxWRAHoOHsvRpR1nIA/8h9iJGM9iFPNIkqcDxCEqjAPGAE7Du5p
         3Qug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=VonY1TEE;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=VonY1TEE;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48xNm3Ku5Jrhp6hh8uEs7veCu/cliDy6Wk3MkN9RXDCeIFfCVT+XKHVjfVwd1soyCfW683u5w==
Date: Wed, 4 Apr 2018 12:17:24 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20180404191724.GF87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <20180404093007.GI4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596844352737543139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Wed, Apr 04, 2018 at 11:30:07AM +0200 Peter Zijlstra ha dit:

> On Tue, Apr 03, 2018 at 11:06:58AM -0700, Matthias Kaehlcke wrote:
> 
> > Yes, Chrome OS R67 (currently dev, soon beta) will ship a kernel built
> > with Clang for multiple x86 Chromebooks.
> 
> But there are still _known_ miscompilations....

Our compiler team is looking into this (missing option
-fno-delete-null-pointer-checks)

So far we didn't encounter any actual issues clearly linked to this,
neither during internal testing nor from devices in the field (some
arm64 devices use a kernel built with clang since R63, some x86
devices shipped with a clang built kernel with R63 and R64). Obviously
there might be latent issues and we are working on fixing the
underlying problem.

> > Given that it takes time for distributions to roll out new compiler
> > versions I would like to ask for a longer period of 'exemption' from
> > asm-goto for Clang, at least if it isn't an actual burden for the
> > kernel, like preventing important features from being added. An ideal
> > time would be after the next-next LTS version, if this is considered
> > too far out, after the next LTS version would be the second best time
> > IMO. Let me be clear, this is *not* to delay the implementation of
> > asm-goto, but to facilitate the use of Clang-built kernels by other
> > projects and distributions, as well as automated builds of upstream
> > kernels with Clang, without requiring necessarily the very latest
> > version of Clang or extra patches.
> 
> I don't think that's sane or realistic, given that the very latest clang
> is _known_ to miscompile the kernel. How can you want to support older
> compilers that are therefore also known to not work correctly.
> 
> Next LTS is still a fair way out, if we take LTS release to be
> every ~5 releases, the next one would be ~.19, that's still 3 releases
> hence. That's a _long_ time.
> 
> I don't see the point in waiting that long for a compiler that doesn't
> work even without asm-goto.

Even with clang having known issues it would be preferable not to
break kernel builds with clang, if this doesn't place a signifcant
burden on the kernel. I'm not sure it is strictly necessary to 'wait'
for clang to enforce asm-goto for gcc (and thus the vast majority of
builds), which is the primary goal of your patch. Couldn't we just
exclude clang for now from raising the error when lack of asm-goto
support is detected?
