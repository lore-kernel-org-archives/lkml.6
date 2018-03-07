Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520457864; cv=none;
        d=google.com; s=arc-20160816;
        b=SBNLTamRSQ6JRe0TH7fFr66gf2yPD1kYB5z2AY9GEQJMDP1NfboNwzwJltPTECdMof
         QA6FegQtHManlWeXIpMsCYIWrMkuAh1oDy7Jk3Dfc5Y1OmHBX9XTGFLbY6PAGICO1q3u
         eGVzMdehLjLWSObWQdI13E0NTdEsi2i73QInaanZ8URQJLiciY6t6bIVeh7ZRG4fP+E+
         MV50TWQ2GNuDODoziC9ShGa2jJdYeotNjf6fo2uoAxrfAG9zAKpF40xdZjAPRjVA5XOL
         tqOT6f+E7dr+dZIp5LRVkqp5wL9OBx3pR/KWruD0Dybpr5yCQ77ksqqRjxXiAwHT5qpJ
         ZW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=18Fkw59ceXzKTxluf0ZdW+yT8LW3uL6DTXlXPys/7W4=;
        b=HZG+Om5VH7HSWMi4nrp2WAZRSivA0r5beIT43jsPnWFFP1dV6acCmI/GHiUs5SvHHY
         oVqdyCXbkE7HWu8aZ271uob3DcFkK21S2zZUpAwuwmoEsgUJpESxYF2C79/hURNQXn5j
         /uYS90690xaiayao8OJBraTwNnY6U5DDkGisYoQHmcg0Tawj+ZgyXTZXZp2Nj/uW1hDq
         gicnHXnQu4XrhnUlpqa5PiHS+kNITEriuW9+NOmaJ2OixmX2inV5YQMwZFZfwxeXFE3g
         JJIlbVwAfL+6yxttyOoD1oyCioC9eyxvR1zjW9coYj/N0FwxbFkZfeAYigPyX1Sfz33W
         3yyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U+kE/w/O;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U+kE/w/O;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELvm/Bvaz4B/3NRO5Hca+KBLuoVG7/o91XwX7OBhi0RPHamEQ222wpiKYuGEB/zMnLHxhw8mgAT1RcWSjsCNSKw=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 22:24:23 +0100
X-Google-Sender-Auth: DDyO_JiM0Rwoz7PUh-PnsDrAyl4
Message-ID: <CAK8P3a2qV5n57f7=FC0nYZWfeXCVaOaK4R_7Wr74p3ZMyuwJNQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Remove metag architecture
To: James Hogan <jhogan@kernel.org>
Cc: "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1594315624987980143?=
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

I've pulled it into my asm-generic tree now, which is also part of linux-next,
and followed up with patches removing frv, m32r, score, unicore32
and blackfin. I have not removed the device drivers yet, but I'm working
on that.

       Arnd
