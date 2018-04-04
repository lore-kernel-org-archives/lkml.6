Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522876297; cv=none;
        d=google.com; s=arc-20160816;
        b=L06QD31SNxZXip3ONT1d6kPb8EPypVauXJjzw7kfvygLiPNufXhnTBChcaZ18X8Ftl
         jXAlFXH3vvneCCocvJD64yhCfkqa/Q+QUp36agXiyvWAHLxZYf3UfoSD7D2F1j/ROJgU
         oWO68GS4APYpJ12MhE8dvCrIkDY/LsghBZY1vPGvBk6oDx6r1QQ08SCJKBbGY+Hc9n8P
         O6+7bL20DUrLgHTLcNvLLv2nc1dpnOg7P05CK4kuA5ijOMmtqjYUnr4OaAaRGPirLpT3
         kpvPsdmN+222mMYccL50tYQ27x7ynlxrVwDclVwZqF7q8u23mIdCJoBjMkX8MSkcrH1D
         x0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5j2kNrEML1S0cPZZKz2V3FNVYkg2liznwcv6NX71yDA=;
        b=fUIMg4KugXxn9yeKZdg7JzMuUgoBhvYR97ezuZBabn4twEuW/mfBULHxfnW+N+Nynx
         +Fev+EJWTgkg/GGydAnyHN1l0cDn2YStP0hDPoE4IjK+NICFfqSvs2TP9JEr26eIrf7N
         XKXC+GVpY4+5CbiisVh16pMusrw7JfD+9kHZFe8OtCg/i+k2ni60FcBPcgavlSy8OVDb
         jyBQtGAN7peyWu1Xj5toAwNB46g3VS3KMtMpBrKg5qdJJlzZMfZQltZ1H76rXApf+HPz
         awpuIgtsx5PZOZWV1Dv3UZXe1idGpD3dVbO7RyJsCHLcmL4czkuvIvp6OoUwkFw2knC2
         IMbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=F31HatcQ;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=F31HatcQ;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx4/PYOCRJmv1ePNG38lw1GXAOedgGupWanVJDP2hQq23w2zepnVaQVWJg9/pHmRXylTFyFo3dhY5X1JHM1aTV2g=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180404205848.GG87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 23:11:36 +0200
X-Google-Sender-Auth: bGWSqgYn9-Na13GdjIeMIeZCLko
Message-ID: <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>, Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596851537287190931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 10:58 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> El Wed, Apr 04, 2018 at 10:33:19PM +0200 Arnd Bergmann ha dit:
>>
>> In most cases, this is used to implement a fast-path for a helper
>> function, so not doing it the same way as gcc just results in
>> slower execution, but I assume we also have code that behaves
>> differently on clang compared to gcc because of this.
>
> I think I didn't come (knowingly) across that one yet. Could you point
> me to an instance that could be used as an example in a bug report?

This code

#include <linux/math64.h>
int f(u64 u)
{
        return div_u64(u, 100000);
}

results in a call to __do_div64() on 32-bit arm using clang, but
gets optimized into a set of multiply+shift on gcc.

The same thing should happen on x86, but haven't tried it
because of the 'asm goto' build failure in linux-next with clang.

      Arnd
