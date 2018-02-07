Return-Path: <alexandre.belloni@free-electrons.com>
X-Google-Smtp-Source: AH8x224/SIwNJTuOkvpkc16xX2TmI3NC1ffw4UHqq9m5Ouud+LQUkdAA6t0JHqi4lPLljajOTOB8
ARC-Seal: i=1; a=rsa-sha256; t=1517965466; cv=none;
        d=google.com; s=arc-20160816;
        b=RWroEGGaJIny6sJtGl731getKmV6UTdiN4Eb0TWOSWuHWO0Je0d0DxNVefSk+6U39C
         XHQCxcfbN+ElQJRUocXYCnh7yCqRWxAG2XQ+ft8KK3r7GdWkEQKr/qxSj/dctqO43c7K
         oxLidcoHwgdvQ+Z/jC0RKns1DHN+cODNXoCe1sAqdV4uwhSi+kPN1elAGntqXJMxKmKK
         +9OwaiI8JCVHOqP9ha4hzp+7AosIlU/1aVLJHKN9FWGjFZFAn8O6nvio8nyUwK+vJW6W
         d5G6gFuQqttVwvgjG7mS5xGod3fHYeQhTjZ803qUPEVB4CgAZxRTpiNXmqkqPH7NsSi9
         T5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=jrdTVZvaDysXIIr90/qKGaZPomN3IQSltP5pFbIqtPI=;
        b=UK8Y1x/59vB63bY2kSXTZdY44gT4zEQaaHc7oFNSUMv3DZi0b+70WvugJaYC8R6nPC
         dYB/EGkIjx8dKqOvDuip9o3h2WaYCKasblqs1RhC9GWL/FIPPdIfPRJHRDDCFK46YFPr
         qN4QR/GQ24VlGiPr7m8k6RXzlW9OKo0DhBt9LdAX9na1Pf6Pslz7mK9ZPwudhOCZkGi7
         0HIQbzrnuhzkPwT4XnGHcyNcjSwjpjWuWZQgEiCLvutpB2ZR1hy+TA9fhi2y0HyTRwXa
         OsyAq9c6ODYQj3yCLAJ9n24HVkKpvqIajJNkZGGwsQ9ydXlidMfXmJlmGqefv+WLo7lP
         ouVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Date: Wed, 7 Feb 2018 02:04:22 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] char: rtc: remove unused rtc_control() API
Message-ID: <20180207010422.GU3404@piout.net>
References: <20180206221226.10511-1-alexandre.belloni@bootlin.com>
 <CAK8P3a3=DKk9XZN7mPCrVgH=uSmC6kVQc8DAbp4nCoWxTpQ+eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3=DKk9XZN7mPCrVgH=uSmC6kVQc8DAbp4nCoWxTpQ+eA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591691353805740704?=
X-GMAIL-MSGID: =?utf-8?q?1591702157440423659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07/02/2018 at 00:24:11 +0100, Arnd Bergmann wrote:
> On Tue, Feb 6, 2018 at 11:12 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > Since commit 34ce71a96dcb ("ALSA: timer: remove legacy rtctimer"), the
> > rtc_register/rtc_control/rtc_unregister API is unused. As it is highly
> > unlikely to be needed again, remove it.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> 
> Nice!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I forgot what's stopping us from removing the rest of that driver ;-)
> Since we can only build it on alpha and mips/loongson64 these
> days, is there anything that this driver does that the normal
> one doesn't? If it's just a question of testing, we could probably
> just move it to staging and see if anyone notices a difference.

I'd say it is a matter of testing. The loongsoon maintainers seem
responsive so we may get testing for that architecture. I'm not so sure
about alpha. Actually, I'm not even sure it is really used on alpha
because arch/alpha/kernel/rtc.c seems to do the right thing.

I think I'll start by ripping of all the x86 and sparc specific parts
and see what's left.

I would also love to get rid of drivers/char/efirtc.c but that probably
means doing some testing on both an ARM/ARM64 platform with EFI and
IA64.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
