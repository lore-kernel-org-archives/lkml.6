Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517999068; cv=none;
        d=google.com; s=arc-20160816;
        b=O6nnZow0uC2QAU2eh/3vfmV3nidRWl3J+M/bLny/rGuPqtUmVHOwlH7Rhg+g1EIafD
         MNm5M8TNZrY8iaewTeYU26kQD6R8yQ2vd7ePDwkE40f/I1Tc3qLABfXPQaYevZ1Om9Ls
         l5xRBg7Yakm4mbhkocfrp4BXdYLYVlr1lGQ5jT+QZEsfdwCraR0zQ/ohk3T445VkUEjH
         juVFAGeoIoC2kjgIlkSZD6dq8MOAis+Gxlj/G1BuMNJcE0hr/PfDUWFsaWKM3OvDnxd7
         BtvqmxO43lJWPfJfDtpE7yPz7B2fRAFzd1W7nlFyb6ARDwJHCME3kCtOTlqgrFMxPAEG
         /jIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=6KMG/YhDVJ3+BPD9QoNyTWW5jT6YDBCVQ076GBr2vAI=;
        b=e7sTIaawE738efimIAVWBIWq3FvmcWcSm0LU+7Di5GXDOtIHsPDKbgYBX9wFqrDXtR
         n51JoEs0UDfcGMDOYcajWrQM0W+GHGjZ5FiRzMasfCDPnMAay6TWMn3Ggu927OaaG6su
         e2wQcKsXZvjSvTnSpy95l17iUks/02wsW++OIjAXn8HfVVyEItXtXaBC1k9641lwBsIq
         Qh6gNby3QR6zwh2/Sa2TPPzK6/zvw1eiZOHs5kmGt9I/tJ0OV2CxyZ2tcJ9+2JcV6Qf7
         VFzkyYhCxe4PEDvvqHU0CYxHNMjzwGGtPscDIZh1hw2pIE8xAscqgeQQWN6Oh5k5hKsg
         ZBIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WIgNB13j;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WIgNB13j;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x224Yn+MSXcD6wKPRYCHctTG+z4eJko7nNlSdJ9ARjk4pZ2W6jOkDahnKqJEhGra3Y36TQzpQ7TzUzIS81O2QFVw=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180207010422.GU3404@piout.net>
References: <20180206221226.10511-1-alexandre.belloni@bootlin.com>
 <CAK8P3a3=DKk9XZN7mPCrVgH=uSmC6kVQc8DAbp4nCoWxTpQ+eA@mail.gmail.com> <20180207010422.GU3404@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Feb 2018 11:24:27 +0100
X-Google-Sender-Auth: LlIRb5psEknpMtVfxlU_63FJRvA
Message-ID: <CAK8P3a0QZNY+K+V1HG056xCerz=_L2jh5UfZ+2LWkDqkw5Zznw@mail.gmail.com>
Subject: Re: [PATCH] char: rtc: remove unused rtc_control() API
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591691353805740704?=
X-GMAIL-MSGID: =?utf-8?q?1591737391424384075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 2:04 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 07/02/2018 at 00:24:11 +0100, Arnd Bergmann wrote:
>> On Tue, Feb 6, 2018 at 11:12 PM, Alexandre Belloni
>> <alexandre.belloni@bootlin.com> wrote:
>> > Since commit 34ce71a96dcb ("ALSA: timer: remove legacy rtctimer"), the
>> > rtc_register/rtc_control/rtc_unregister API is unused. As it is highly
>> > unlikely to be needed again, remove it.
>> >
>> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> > ---
>>
>> Nice!
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>> I forgot what's stopping us from removing the rest of that driver ;-)
>> Since we can only build it on alpha and mips/loongson64 these
>> days, is there anything that this driver does that the normal
>> one doesn't? If it's just a question of testing, we could probably
>> just move it to staging and see if anyone notices a difference.
>
> I'd say it is a matter of testing. The loongsoon maintainers seem
> responsive so we may get testing for that architecture. I'm not so sure
> about alpha. Actually, I'm not even sure it is really used on alpha
> because arch/alpha/kernel/rtc.c seems to do the right thing.

The Alpha defconfig still enables it, and doesn't enable RTC_CLASS,
so at least that has to be changed. I've added the Alpha maintainers
to Cc, they can probably find out whether it works or not.

> I think I'll start by ripping of all the x86 and sparc specific parts
> and see what's left.

Just wait till we hear back from the others, removing it completely
would be simpler ;-)

> I would also love to get rid of drivers/char/efirtc.c but that probably
> means doing some testing on both an ARM/ARM64 platform with EFI and
> IA64.

On ARM/ARM64, we can only use the drivers/rtc/rtc-efi.c driver,
not drivers/char/efirtc.c, so it's only IA64, and they were also
the ones that sent the rtc-efi driver before the start of the git
history. However, the EFI_RTC driver is still in their defconfigs.

For the other RTC drivers in drivers/char, JS_RTC has been dead
for a while, since sparc selects RTC_CLASS. For DS1302, we
have both a driver that is used on m32r and a generic rtc class
driver for the same chip, but I wouldn't trust on that to work
on m32r. We can probably find a solution for this one once
the others are gone, e.g. removing arch/m32r, or adding some
glue logic to make it plausible for the rtc class driver to work,
without actually testing it.

     Arnd
