Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522879150; cv=none;
        d=google.com; s=arc-20160816;
        b=x5NXQdCp2g1rLO3ZizyFVG9WfXqtVN4IINLC6KeATZvitsZaTWZi67mqochu8Cfp1o
         F6y58Ek8FUyP+inePSy6XdLU3eYfyfrlG813eOyxrgf5nKyTwUuf4DRQY7f5XTtqx0+M
         oiC6MpTIiIvBrfz+oWZbRT7vbADVdMFUv7bC/ETGC0fzKQI3HI6c9uBouPPjJzRbNkXj
         QkXhECNsix6V4nAkt02dR+HAe4hwcr/ajAAvJ9V1WWv9BXb4cTKtRAX/EFyu99VcETjQ
         jiLLu2XKUmk69gvDrhGKYlpV8IrK3dCWxEfnrZCGKtFvTTDQF/QR2iCRCdkR6UjsBO9w
         0tEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=IUALUZU5/E38f+Fq7zGWAJJyA22LD1D3pLLj6WafFI4=;
        b=YP5a09WkRdQ4toirG+oUlUALIpgMD/gCAXIdvKF8nkELNIH22c8p7hUcnH6R4ZlZtR
         bjU0cDRMMtzR+LuUONV40OkaRjNqfjsAR5Hbtc12rXqAhaINM7Q8mF5WDvZWXNUxtgdJ
         iw0xvLxdapX7GoG1hNwLaTUQOV5vrdV6Q/OTkbWKZBnMQdJEo/5xUJyn/qYDLerP4erL
         wo/MApwwG6a2B+YydcW8LovzwKd7sgyHo9OkEewweNcF133o5mflIi9f4H40eVBOoYkZ
         3C/UCHZoIqx4hFxr1fTS+/1TlOjseW0ux66ZwM9335SHMrwkhG2n163Hs6bh4KcnQUVQ
         UTkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CTppJcdA;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=aogCVgeN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CTppJcdA;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=aogCVgeN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx49hU0ym006xUMAQYCjKdHkyxfSaU8HCXivP21BTtHhy5vZ5VNuay/6BOJHmHCPlt+Ehdj/NpGxaTnPo7uUEmL8=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180404214639.GH87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 14:59:09 -0700
X-Google-Sender-Auth: vXSixFOnOEAC_dwm7_twIYRUWmw
Message-ID: <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1596854528420308223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 2:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> I understand this is annoying, but it seems I'm missing something:

I think you're looking at !AEABI case.

The AEABI case is worse. It ends up getting the code from
include/asm-generic/div64.h after defining a few helper inline asm
functions.

It's probably best if you start taking some recreational drugs
_before_ looking at that code.  It might make you go "Ooh, kewl!"
instead of trying to dig out your eyeballs with a rusty spoon.

               Linus
