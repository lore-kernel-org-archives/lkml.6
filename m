Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519381619; cv=none;
        d=google.com; s=arc-20160816;
        b=pqOITt1CAx9PjjrHWwRp8Kj+/+zXw9NOUOELHTf5+JFoVWpMYlEp1UY7dUTgs8puX8
         2hkyHD4s5ipA3ppDuC4N7Z6xLFZvCjS82WRLAOdJmYkP/tQ4OgeRq+6u2bBbncslZEqi
         r2DzZ+H6/TjR81WFCgn6jdj65fobciHazETReqvblce8+rE8wRjmf0xLUvB6ZOwZWJhr
         ZD0LgoqD4X8Aaj4o4XGw6uEQlPHLK/hQr9INh4DR5yKbDIVR8BCTbZdyI54f0c8i636W
         W37omIuGbr1CP0XY4ksnspoW1ZFR4U/L3YO4Zy7wuA6TsjT06G6s2x6C6qn9SSxENsLC
         1nPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9g2lB0LRIxF0U+Ea7B4xB/nac3481dq8kP5qh4/qnLc=;
        b=JGucMzpUQJ4rgVcBG8gkSReDGV3m1e61hUiM4opR+Cjic/8ZgYRkTMZlHWd7YhMcU4
         PO10f/6ssD77V2aD5h80fNMouRpiAI5h5VJQPjZ6Rr8gm7XbZlWw5x/mUgD8MnJS4W/8
         a3GJ2/1P9MY0SHewNMsM+UNHm9hxkuObUoiIVO4T/TSbMJ5ALRx/hzwAM9eaTnJDDfRA
         5+P38j/GohVUDzNKYzPmEInsVfW/hACA7BRf4oiAqXh/+LgI74uRD6HjPS5DtaMAuYUR
         HzDrsl7yuMtZpVbi0wLRQY1sJQLAEkZ+uRKkW78rKZ8/RKAUMAXHDWr1ZHfrSvU6Efn1
         ixew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BC+IQxbo;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BC+IQxbo;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELs37wLS0XQv7hiTUh0l727P63vdSWkFJ7+Ml/avE8t46IFURz8jJaj5XjX9cqy+crDZCIewHMA8ssx0Q/2z0Cw=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 11:26:58 +0100
X-Google-Sender-Auth: dFZAMqEf8aqwgHIjx1IFXLsXNbU
Message-ID: <CAK8P3a3CuNn-dSE33mhEZ9-iM7NOE3Y4AiJzpmF6ob5wrMuZpg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Remove metag architecture
To: James Hogan <jhogan@kernel.org>
Cc: linux-metag@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593055859238851284?=
X-GMAIL-MSGID: =?utf-8?q?1593187101180225758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 12:38 AM, James Hogan <jhogan@kernel.org> wrote:
> These patches remove the metag architecture and tightly dependent
> drivers from the kernel. With the 4.16 kernel the ancient gcc 4.2.4
> based metag toolchain we have been using is hitting compiler bugs, so
> now seems a good time to drop it altogether.
>
> Quoting from patch 1:
>
> The earliest Meta architecture port of Linux I have a record of was an
> import of a Meta port of Linux v2.4.1 in February 2004, which was worked
> on significantly over the next few years by Graham Whaley, Will Newton,
> Matt Fleming, myself and others.
>
> Eventually the port was merged into mainline in v3.9 in March 2013, not
> long after Imagination Technologies bought MIPS Technologies and shifted
> its CPU focus over to the MIPS architecture.
>
> As a result, though the port was maintained for a while, kept on life
> support for a while longer, and useful for testing a few specific
> drivers for which I don't have ready access to the equivalent MIPS
> hardware, it is now essentially dead with no users.
>
> It is also stuck using an out-of-tree toolchain based on GCC 4.2.4 which
> is no longer maintained, now struggles to build modern kernels due to
> toolchain bugs, and doesn't itself build with a modern GCC. The latest
> buildroot port is still using an old uClibc snapshot which is no longer
> served, and the latest uClibc doesn't build with GCC 4.2.4.
>
> So lets call it a day and drop the Meta architecture port from the
> kernel. RIP Meta.

Since I brought up the architecture removal independently, I could
pick this up into a git tree that also has the removal of some of the
other architectures.

I see your tree is part of linux-next, so you could also just put it
in there and send a pull request at the merge window if you prefer.

The only real reason I see for a shared git tree would be to avoid
conflicts when we touch the same Kconfig files or #ifdefs in driver,
but Meta only appears in

config FRAME_POINTER
        bool "Compile the kernel with frame pointers"
        depends on DEBUG_KERNEL && \
                (CRIS || M68K || FRV || UML || \
                 SUPERH || BLACKFIN || MN10300 || METAG) || \
                ARCH_WANT_FRAME_POINTERS

and

include/trace/events/mmflags.h:#elif defined(CONFIG_PARISC) ||
defined(CONFIG_METAG) || defined(CONFIG_IA64)

so there is little risk.

      Arnd
