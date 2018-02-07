Return-Path: <alexandre.belloni@free-electrons.com>
X-Google-Smtp-Source: AH8x225mmh5bhgfPis8tAAMIwVeVl4PRuJcPnkFcDCc0b+dEchRjIR80mosklDcAnuU8fRumhMJw
ARC-Seal: i=1; a=rsa-sha256; t=1518018433; cv=none;
        d=google.com; s=arc-20160816;
        b=pWegCvzOHbtfVLM1HvIYS1Ys+Tzjli20epqWBVhPfcQeDys2oZPz1cfYQmfzICbWIV
         /uw83Tu2FHYg2wesyhQ1WsTXaic/rR3UA9BDd8CK5mRL4Ib+TLxCfcz/JvPw6J5W6cWh
         N+5BdhddA0KgMJ+Tbl3kHKZDkXkzooAXWBkZ3P3x5vRkIo5Y32XDtc333tvTdboanBd7
         gMqFNn/+P18iVqPQx4z8qg/x3F7ZIaJKisadCxYR4WvBEc9VQXQC9VyO5hQxPzHmbNM0
         4zkW9JAosI83Neloou6fF2bpuPHwDC9E+jf4Yd/PyzsGwShveQdrlvhMg3MaxJPCW19I
         show==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=IjhFi4RgqT6bpAGmhVNS1qNSBlbrP/8T0ZPczRBotUw=;
        b=Ru0ZxQj2+5oM5TNprZautg+BFpJztDCIPhXPtyVrAbjezyh7cWHMFTMtjIZHSPfsYO
         IeUUPVCgx9MWGyaCEFEluQnHjIMXKnS39oWfE20bK9pXHV6oclMDxNkVrFu7P3Qv20jJ
         wJu/S6/nqrJoHHfhnQWxwLtkOA2uuVEmvFYp2TaHD9gfjhIvON6GFKT3YmBXWkL1Z+DI
         SdHhFSqPc+2agto3/1FGuFtN4ynI/iKmkkpj/l6izvR+JvkkVZlunuik6UBmIIgfWPgw
         QxGLBMPhYiS/+az9LOk1JDweSysmkR4ZqMl0vcXMco1f5wawpwR559Nk+IfpD7xXiZoS
         xBUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Date: Wed, 7 Feb 2018 16:47:00 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] char: nvram: disable on ARM
Message-ID: <20180207154700.GY3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
 <20180207015509.GV3404@piout.net>
 <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
 <20180207124839.GX3404@piout.net>
 <CAK8P3a2HscUSs-iV_3dp7+htN+LPFK2LnmiZNTKamQZwMSVxMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2HscUSs-iV_3dp7+htN+LPFK2LnmiZNTKamQZwMSVxMA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591690923969903275?=
X-GMAIL-MSGID: =?utf-8?q?1591757696469115190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07/02/2018 at 15:00:04 +0100, Arnd Bergmann wrote:
> On Wed, Feb 7, 2018 at 1:48 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 07/02/2018 at 11:33:55 +0100, Arnd Bergmann wrote:
> >> On Wed, Feb 7, 2018 at 2:55 AM, Alexandre Belloni
> 
> >> >> $ cat /proc/driver/nvram
> >> >> Checksum status: valid
> >> >> # floppies     : 0
> >> >> Floppy 0 type  : none
> >> >> Floppy 1 type  : none
> >> >> HD 0 type      : none
> >> >> HD 1 type      : none
> >> >> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
> >> >> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
> >> >> DOS base memory: 635 kB
> >> >> Extended memory: 65535 kB (configured), 65535 kB (tested)
> >> >> Gfx adapter    : EGA, VGA, ... (with BIOS)
> >> >> FPU            : not installed
> >> >>
> >> >
> >> > I really don't think anyone is using that but I don't really know much
> >> > about x86 and the specification this may be part of.
> >> >
> >> > I see the info may be used in drivers/video/fbdev/ and
> >> > drivers/platform/x86/thinkpad_acpi.c
> >>
> >> The thinkpad_acpi driver seems to look at some other bytes
> >> in the nvram, which have a platform specific meaning.
> >>
> >
> > Yeah, I was more concerned that they need drivers/char/nvram.c for
> > nvram_read_byte so we can't simply remove the driver.
> 
> Ok, so the procfs interface may be obsolete, but we still need an
> interface into the CMOS NVRAM data.
> 

Actually, I just found
https://unix.stackexchange.com/questions/331419/is-dev-nvram-dangerous-to-write-to

So it seems to have real values for some people (even if they are
wrong).

That also points to https://sourceforge.net/projects/nvram-wakeup/ but I
don't think it is necessary. The RTC driver should be able to wakeup an
x86 platform.

All the other uses of /dev/nvram I could find with a simple google
search (i.e. saving and restoring CMOS settings) could just use
/sys/class/rtc/rtc0/device/nvram

> I see that the x86 version of nvram_read_byte is just a wrapper
> around CMOS_READ(14 + addr). We also have some drivers
> that call the low-level function directly:
> 
> arch/x86/include/asm/floppy.h:  val = CMOS_READ(0x10) & 15;
> arch/x86/kernel/bootflag.c:     v = CMOS_READ(sbf_port);
> drivers/char/mwave/smapi.c:     usSmapiID = CMOS_READ(0x7C);
> drivers/input/misc/wistron_btns.c:              qlen = CMOS_READ(cmos_address);
> 
> I suppose we could make the thinkpad driver do the same,
> or provide a 'static inline' version of nvram_read_byte somewhere.
> 

I guess we can do that, provided we take rtc_lock before using
CMOS_READ.

Thinking of it, I think this means we don't need the lock for powerpc as
nvram_read_byte doesn't take it. So I guess it is only needed on x86.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
