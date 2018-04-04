Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522874001; cv=none;
        d=google.com; s=arc-20160816;
        b=g6mS6dUFqC0/lS3gXJJfVAVWQ5PyGsIA6WftFR3x9xyBKKriqVugmlDdGNX5GEJjzj
         PwX7HlSwcsTDdyCcNKWCWXRffX9DNa4zrm8zz171JQOPJ0+80fwjg9gqiiT4OFRIuU7a
         jOujpm7nkj8Bb5fDDkwe/w5g77u8kHO6jYb6xWmVLucaBY+Ijkt4tQs57YOeSED8AyBL
         9Lvn98rMd5YczR7nmiSmEp2ibkSZ4qkngATCQm/7aKuWokb3N1CgDW8Y2CVzJWYAKs3d
         J6Lrist8SVAHloFvmkWoZptYITGMNLmqTRzVTeV8Z9LAIY0Mg/eO18qbOlQJKGF714Y0
         b8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5nsXHd0TYy4jbclJA7jrKYVuCpBPEhMXL2KDqPd5sGg=;
        b=lTrxVnA30b6ScZMvyNcZMaWjOEDD3ZqNfhSmP+E6PzUXfrVRUlHIKXUqLgF2VrdAy6
         xYindfodz/seipWcY8QNkNx840pXnoQaIikv80wIa9l5EaxfeXI7EDZOZAwd4mzz8xoQ
         oumwTox+08FGrnC+29puJ9GGHliNozIUR3LUSOQzzP8VOz89wehIn7+7EFzQ39P9xojV
         1angW26h4ERFnkjOxX4y/1P1I2lKig6BpBxOidXUDt+Q2ULvCEVSQjnctXBnWQSV8rhZ
         o6WwBeXg7zzjonqXzWFzq4AJhutfDd/diBtsOn/J9jRPEGT06iwEbHm5zUBfhU1eYzTR
         QBTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qq5ODUJ/;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qq5ODUJ/;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx49s8ukDICfoBIEoNWGK8JkeR+u6ESgW47OwbGi0n9boYaky/YS2hpjffll9sjAdyngRpP9v3sauozJjE/KH2Jk=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180404191724.GF87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 22:33:19 +0200
X-Google-Sender-Auth: 1OAu9xtelrdlaVKXXiqNGkTGsM8
Message-ID: <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1596849128708141076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 9:17 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> El Wed, Apr 04, 2018 at 11:30:07AM +0200 Peter Zijlstra ha dit:
>
>> On Tue, Apr 03, 2018 at 11:06:58AM -0700, Matthias Kaehlcke wrote:
>>
>> > Yes, Chrome OS R67 (currently dev, soon beta) will ship a kernel built
>> > with Clang for multiple x86 Chromebooks.
>>
>> But there are still _known_ miscompilations....
>
> Our compiler team is looking into this (missing option
> -fno-delete-null-pointer-checks)

Do you know if anyone is looking into __builtin_constant_p()
optimization as well? We have a lot of uses of this gcc feature
in the kernel, and if I remember correctly, clang implements
this by basically always returning false for the cases we
are interested in.

In most cases, this is used to implement a fast-path for a helper
function, so not doing it the same way as gcc just results in
slower execution, but I assume we also have code that behaves
differently on clang compared to gcc because of this.

        Arnd
