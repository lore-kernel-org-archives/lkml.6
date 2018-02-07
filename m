Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518012006; cv=none;
        d=google.com; s=arc-20160816;
        b=q9NkzAL7C7Xplj7yCYcTS0sgQ/hq34zfix/VwU6hvUroRsnPjKZRNYUAc+jdjEGU9o
         3oGc3HhOYB3K6XWdncFwVJfJUTIR5dNuAMNzsWpCCM3/Ggd3j2N9AabmnymUYxKGqycJ
         oBF5t3+uSkbUvZlpF2FOPdXRbPCIJjHszEnxWvSYmMMxF5yz/FwU9RfXDPQAMSqcKaMz
         9Ass/WlptCFWr6abtX+16PSUckrpsVOWUfjwOdpR6FEkqvUiPvr2yRbnyfxBQQbI84bV
         a7vBTn7SOLRecyvvIy1+90Dn2HIg2qtTVYaVIhw7LOsT3g/472dWhLd9jihmDiNqqSSF
         gXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=OKdKWtCrLbKoFYQkTSKsI4ZgkxsVjwhVQJxmmA13jHw=;
        b=bmXJcsZiObd/IqiYiRrc5N2Npve8Q3wSm/quZdKosGi4zXq20kNR2sFtT+gm78wPqS
         X0GAFcmWVCMNHS/HhPmxkWU6e3TMrnwnMhjYgCUV0+rCurW0FoMGMLXoR9ZeI3ExNEi2
         H9SXR/UWP26foyUck/LmEg7neohhzqioFR34bNvWUnuoI0WLUfVtSgxhE9D/eAJjBPwj
         frHijGQBmv4qfWivrbPQ3siEJBtTEGcEys5liMcpJSfnPvpLfW2csMWL+KCzVZ2rt9OC
         ZeO474I2uYQz+45NoST4BL2BYLjczuNMlZCuomoAvjzOkkAE3YGPt/rZY1ER2nEoVCt8
         uPKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kBsfzz/+;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kBsfzz/+;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x227Xt6naZ5ALJV5CTJoPn6Lnf9WHCGWXL/7+Qrvtk3pDLFrayoHA3Q88JGepy42t7r0IvyDB4InmHQOCZhJzkfo=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180207124839.GX3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
 <20180207015509.GV3404@piout.net> <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
 <20180207124839.GX3404@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Feb 2018 15:00:04 +0100
X-Google-Sender-Auth: vAYNUg3qO4Z-IgtTd8lGb7_2n9A
Message-ID: <CAK8P3a2HscUSs-iV_3dp7+htN+LPFK2LnmiZNTKamQZwMSVxMA@mail.gmail.com>
Subject: Re: [PATCH] char: nvram: disable on ARM
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591690923969903275?=
X-GMAIL-MSGID: =?utf-8?q?1591750957144895208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 1:48 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 07/02/2018 at 11:33:55 +0100, Arnd Bergmann wrote:
>> On Wed, Feb 7, 2018 at 2:55 AM, Alexandre Belloni

>> >> $ cat /proc/driver/nvram
>> >> Checksum status: valid
>> >> # floppies     : 0
>> >> Floppy 0 type  : none
>> >> Floppy 1 type  : none
>> >> HD 0 type      : none
>> >> HD 1 type      : none
>> >> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
>> >> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
>> >> DOS base memory: 635 kB
>> >> Extended memory: 65535 kB (configured), 65535 kB (tested)
>> >> Gfx adapter    : EGA, VGA, ... (with BIOS)
>> >> FPU            : not installed
>> >>
>> >
>> > I really don't think anyone is using that but I don't really know much
>> > about x86 and the specification this may be part of.
>> >
>> > I see the info may be used in drivers/video/fbdev/ and
>> > drivers/platform/x86/thinkpad_acpi.c
>>
>> The thinkpad_acpi driver seems to look at some other bytes
>> in the nvram, which have a platform specific meaning.
>>
>
> Yeah, I was more concerned that they need drivers/char/nvram.c for
> nvram_read_byte so we can't simply remove the driver.

Ok, so the procfs interface may be obsolete, but we still need an
interface into the CMOS NVRAM data.

I see that the x86 version of nvram_read_byte is just a wrapper
around CMOS_READ(14 + addr). We also have some drivers
that call the low-level function directly:

arch/x86/include/asm/floppy.h:  val = CMOS_READ(0x10) & 15;
arch/x86/kernel/bootflag.c:     v = CMOS_READ(sbf_port);
drivers/char/mwave/smapi.c:     usSmapiID = CMOS_READ(0x7C);
drivers/input/misc/wistron_btns.c:              qlen = CMOS_READ(cmos_address);

I suppose we could make the thinkpad driver do the same,
or provide a 'static inline' version of nvram_read_byte somewhere.

      Arnd
