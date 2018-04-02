Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522708703; cv=none;
        d=google.com; s=arc-20160816;
        b=dWIuNIL6JjfFwGDEuKVDFFQ10qHXWNLvKB927bJmxgWsLyb/k5x65jUJ1/fj0Knexi
         hIFMBHSfXDLQWI/HQ2VVuRb8AIB3O6ra2xoXr/orI2Nv/+WawejmUXGsENu9DtHbAeG1
         TMuupt9C1Q6qwOOSIwdbgePuJmUJYr0SOjgoOV924eGwPIBpitWwQXm9D+bA4A5qUoZu
         7Hx80AuETDkaV9vrN6YXX6r7NAkdrqi7k1Vg15w+UL5ibSEONecpjZRmK/RD6G8VuDZL
         yDDyzYTKR9yPbIGRQ4tjbYBy/sDQc5OohwRTVr23ZXtcSO5fvSbNZL8SCqO66EahA09X
         Qj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mWoDxO0pJPUTS3KMXzUh/m4XDiztfwTqv6AFAlLZHf8=;
        b=s7hgxQmZ9qxiMfDehYK19dAIke48inWNMwxHG1oPI5ocPkX9Zs8ffgWfcs2+VPLI57
         UsHxdYJZpLU+GBBNZHvCNYDaxOhVHLsoVGsHypu9yDvltEXwaWyhINr0fkUWEI1cQcHG
         7/OfOoK/jwBDhHW6IV1+3kC3LXstF8f05hQxE1BRZAv/XmnL66vfI94dsdYlPW+wU3z8
         +bl885PivfpycX9TCJsuYX/hFHBi8GT1LaNwsoo+R8jvcr0MUgIu/vkwDUx8E2x5LhlL
         R+07L+9dxHVJnA9yUXIZ26BSWJbHwQi/2YW76rNCbjb0INzUMvu2LhUQ0m460ICAmwxV
         CqLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ab1B2PAC;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ab1B2PAC;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/aLnd/PXPJ9RSOUI3bKogt5jyL2raMWjZi0GsuhYJhV9pZDHQg6tTGhRYp1CvFxsVHsYOHSw==
Date: Mon, 2 Apr 2018 15:38:21 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180402223821.GC87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596675801568391777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Mon, Apr 02, 2018 at 02:44:48PM -0700 Linus Torvalds ha dit:

> On Mon, Apr 2, 2018 at 2:50 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > The biggest change is the forcing of asm-goto support on x86, which effectively
> > increases the GCC minimum supported version to gcc-4.5 (on x86).
> 
> So my biggest worry isn't gcc-4.5 (anybody who hasn't updated deserves
> to be forced, or can stay with old kernels).
> 
> No, my biggest worry is clang. What's the status there?

I know there is work in progress for asm-goto in clang, but I don't
know the details or an ETA. Some folks in cc might have more
information.

> I've pulled this, and honestly, the disaster with
> -fmerge-all-constants makes me think that clang isn't that good a
> compiler choice anyway, but it's sad if this undoes a lot of clang
> work just because of the worries about Spectre and mis-speculated
> branches.

It would indeed be very unfortunate to loose clang support again, now
that it just got added after years of joint efforts from different
people. And this wasn't exclusively kernel work, in my experience over
the past year the LLVM community was very open to adopt/implement
changes needed to build the kernel without ugly hacks. It's still not
a perfect world, but I think LLVM folks deserve some credit.

Couldn't we just raise the minimum gcc version without enforcing
asm-goto for clang (yet)? This would give almost everybody the desired
extra protection, and give clang some slack to implement asm goto.
