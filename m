Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519388770; cv=none;
        d=google.com; s=arc-20160816;
        b=puMckjjefIxObZoxZfP+EsDwz54wb+p7XTALAnFJV6nHg29Xg+5MrJJ2Dy10j6Kqve
         shskTuU13cSg/BZqiZiha4kvPJoX06LTn02lyWqje5mmqNKBNbR4LD9wKAkDsrF7uvbp
         BY+8Wg/eJJfiFnW3Nbs8stZy57B2hbQVAar15/mqDWLx9FOftRjFgtoTuC7xxeWEvXgK
         C89Rr5ZG29+rE7zoJK+fPyXHHgLDycBda/Cu348mkyVVLvI1V37Ri8yUo+2447NNgf/0
         ssd3uc2t0wFTd4S9QZxLfaI8jW/Dk/7r/AOWJMXNqYJXIaSmqB35NVQLfE47N8c4Azrn
         Zg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9nTFccAxCdG4Y2yHfF7/Anel16iE/JrnQvBkn3XTETk=;
        b=EvH2XznRAiQDkXxpCg8iuXOgqy03YtO1zanNMv0fDZWlfAHAnMVLMrI9FRPU7wH+N5
         MHNI0ItQEsPhNRUPpTdq1gGlEh7NXQlr3Oe799bifQIDH3tcaKH05UvAOxgwLeO50emw
         sSSTtwig+iE4xHvJYgb3Yz6bx9W4gJ2ZaENdnjQs9RLdqc1Ok7Acqc8iLvprd578H6PW
         Y+B8rPEkkEBEyeG0ZCteuSLehJWksctquC/URQoxWRaDklRvjaJscuJ6e03C5c1fgpdl
         F0B6Krj5oiqCeg3NuMEELKv9Hln9UaIJqiiCmswvsN1Asiprm4qornyXAtP9ffRmeaSK
         J76Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IvWoRGQp;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IvWoRGQp;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELt02OXYgg7m9bB/2LM7C2mJxjNPRH7DA677lWFKn4f2UtBm5lgNu4lolFp58300tx40UyEHDv/eJU9FkEFTnWo=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180223110207.GA14446@saruman>
References: <20180221233825.10024-1-jhogan@kernel.org> <CAK8P3a3CuNn-dSE33mhEZ9-iM7NOE3Y4AiJzpmF6ob5wrMuZpg@mail.gmail.com>
 <20180223110207.GA14446@saruman>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 13:26:09 +0100
X-Google-Sender-Auth: Y4sbkwqSAMcYXmuvw5DNGjtu_vY
Message-ID: <CAK8P3a12RKQvcmnPRHcDkDKq+uMWP79SuRdDz3_vi9YRM==GVw@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1593194598925535092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 12:02 PM, James Hogan <jhogan@kernel.org> wrote:
> On Fri, Feb 23, 2018 at 11:26:58AM +0100, Arnd Bergmann wrote:
>> On Thu, Feb 22, 2018 at 12:38 AM, James Hogan <jhogan@kernel.org> wrote:
>> > So lets call it a day and drop the Meta architecture port from the
>> > kernel. RIP Meta.
>>
>> Since I brought up the architecture removal independently, I could
>> pick this up into a git tree that also has the removal of some of the
>> other architectures.
>>
>> I see your tree is part of linux-next, so you could also just put it
>> in there and send a pull request at the merge window if you prefer.
>>
>> The only real reason I see for a shared git tree would be to avoid
>> conflicts when we touch the same Kconfig files or #ifdefs in driver,
>> but Meta only appears in
>>
>> config FRAME_POINTER
>>         bool "Compile the kernel with frame pointers"
>>         depends on DEBUG_KERNEL && \
>>                 (CRIS || M68K || FRV || UML || \
>>                  SUPERH || BLACKFIN || MN10300 || METAG) || \
>>                 ARCH_WANT_FRAME_POINTERS
>>
>> and
>>
>> include/trace/events/mmflags.h:#elif defined(CONFIG_PARISC) ||
>> defined(CONFIG_METAG) || defined(CONFIG_IA64)
>>
>> so there is little risk.
>
> I'm happy to put v2 in linux-next now (only patch 4 has changed, I just
> sent an updated version), and send you a pull request early next week so
> you can take it from there. The patches can't be directly applied with
> git-am anyway thanks to the -D option to make them more concise.
>
> Sound okay?

Yes, sounds good, thanks!

       Arnd
