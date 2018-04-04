Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522875529; cv=none;
        d=google.com; s=arc-20160816;
        b=PY2mxFJ4tUwJei3KiWvwngqdaNR520n7kzqD2cpEKmyc3x5TXsItTfoqoTPs+/BgkC
         gCQAosjYX5Ij5GUYwT9CR0KiIEfS6SV+suPykI5L5UI2M7P4OiEO5++IF5GnSmRXTF+Q
         8wG55uE9ElyIZb79oVDJR/AJ94VxFg8D0ucj42zs33QuZudGJ80dcSuEivoC86fjhPFn
         Qf9n+6oM7olVOHRE2bcX7KQI3z762IvzvYZzogY1DO4P7GEy4sOD9okhoaLMFcfBoKbs
         4IRMi6t5sWRya9/EpNNKInB9LFquXvt9s2/K2+YpSZO6Hw3KD1D/fSeHnSkF/BrOwLI0
         GcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=bqaqfZ9MJW/hawIwANrTTj52GCfKVJd8SzqCBjQZ98Q=;
        b=iKz0VAKxyaK1lto5rVBPx9bXov8E0XbzDK8Q0jesEUfTpqXnoYOQWTaj3xwEvWaGED
         uEhEf07PlDeP3PUt9n9T/x7eQnZ0mPA5sW/QGQzINUERGUV4kl3yGoQMfthEOLri0nLs
         OP1D0tpDQ5O5QAmXHpHnaWZ2fr6CmumQ2eZEyPsqQKRBvp3kUOZMR+vi6+3qTmk2YpIZ
         Si43ZCwGpVARJ+tQezKsCcaXUn7RwUdPpJB2iqbLS2YBCzBEG3h3TpFQT2XxEyuYbGmh
         Xbs4kLj1cR8iGtnKuNW2LArIyetJxzRa6OmcbXmh/0aZlwfaI6c5gyGN5ALORWVUV4Fw
         ko8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=nlO3PW4E;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=nlO3PW4E;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48lvbvOGA0VOA9252rSFemrSg65sU8CUCAao3JzbzT+ogBorTLL3WDViuJVRn0WvqjxxrzaCA==
Date: Wed, 4 Apr 2018 13:58:48 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20180404205848.GG87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com>
 <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596850731478687978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Wed, Apr 04, 2018 at 10:33:19PM +0200 Arnd Bergmann ha dit:

> On Wed, Apr 4, 2018 at 9:17 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > El Wed, Apr 04, 2018 at 11:30:07AM +0200 Peter Zijlstra ha dit:
> >
> >> On Tue, Apr 03, 2018 at 11:06:58AM -0700, Matthias Kaehlcke wrote:
> >>
> >> > Yes, Chrome OS R67 (currently dev, soon beta) will ship a kernel built
> >> > with Clang for multiple x86 Chromebooks.
> >>
> >> But there are still _known_ miscompilations....
> >
> > Our compiler team is looking into this (missing option
> > -fno-delete-null-pointer-checks)
> 
> Do you know if anyone is looking into __builtin_constant_p()
> optimization as well? We have a lot of uses of this gcc feature
> in the kernel, and if I remember correctly, clang implements
> this by basically always returning false for the cases we
> are interested in.
> 
> In most cases, this is used to implement a fast-path for a helper
> function, so not doing it the same way as gcc just results in
> slower execution, but I assume we also have code that behaves
> differently on clang compared to gcc because of this.

I think I didn't come (knowingly) across that one yet. Could you point
me to an instance that could be used as an example in a bug report?
