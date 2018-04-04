Return-Path: <ndesaulniers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522883098; cv=none;
        d=google.com; s=arc-20160816;
        b=W5nPBTw4ct4TijtRiXznYAe9gyfQ/iXxSMaE+3HmSAzUWskcI5sKdSlyrSjwPnHQ5K
         X5AtINll3O0DBsZ74HOpe4NnI7Q5LbHKIbm1mvcWRr7IuZPDCmXEgu4lmW/DTRirhGOW
         ESsmPRX8MEJ7elLKyOfYlelpkw86imY3Xn12PObFBHmuwSzxiLgstlkTCOwzhXZACU5j
         DLnV7UkK7relJOuuTxjP1qtvM01ZCvliyvtsuh+ehqP7uD5lYoc+hUF0nOZDVKvufcJf
         dJPCDkzxWhzDsYugzMuk5jrcSW0jOUbjVLQM0bipmPP16I/ghdIhvdVzauBKB9moWCP4
         g1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2bzEG7p/WIgFhhXabvaLfSDdZfN7u8EEgloJDsEL/qg=;
        b=vM0JXckaRGTBPw1y1YNxIanUB/wO3+LLqubFj1R2v53a8oSoHAVih3XYKwC4OJq75N
         prlhDU+pkarvQzxhDqCuetERfEE5MEocHTgQxeilV2f/ZTonQUuJlUP3bnlV17WkjvET
         o/x7wcZTDfkiUjTxkW+MZvl7MTgBBKg87hgOd6iGH+3dBOdltTSsK3KEhwWpfFLWHRBy
         obFaKEdBRnsx25Gpqc8FVYiah1viSBuMSYLnDA/xt5zMeB7RPHHd75e6oFKHjrRJYQSr
         annDnSJyJh+AQzeh0K2Y1TBPTRVohvX/G3+07mlGC3PcrSffA7zXg0ExK/HxHaTfU0mp
         0Erg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OHLopmuO;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OHLopmuO;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx482LiVJ2k8mbP1s+N/8KHqmma++NXbC82m2gK+4tosiDpbD5DKg34aXYSdMPzlKjcld5Vd0HCtL/6f/pd0f6vA=
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com>
In-Reply-To: <20180404191724.GF87376@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 04 Apr 2018 23:04:46 +0000
Message-ID: <CAKwvOdmq0iXCze0YWcNHAf+vVzj4F2bTDc=gy+t6BgH4qa8mSQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596858668258651609?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 12:17 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> Even with clang having known issues it would be preferable not to
> break kernel builds with clang, if this doesn't place a signifcant
> burden on the kernel. I'm not sure it is strictly necessary to 'wait'
> for clang to enforce asm-goto for gcc (and thus the vast majority of
> builds), which is the primary goal of your patch. Couldn't we just
> exclude clang for now from raising the error when lack of asm-goto
> support is detected?

In particular, I worry that this now stalls adding clang support to 0-day,
since now this will fail outright to compile.
--
Thanks,
~Nick Desaulniers
