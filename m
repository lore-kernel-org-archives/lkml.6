Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523280572; cv=none;
        d=google.com; s=arc-20160816;
        b=Z+jANUibSXATotKV42N/g1UsodfFbzXgTaa51vr3k4QujNqiauSLiCmefVDcEtu8+7
         EjyxMFQVAyc737o9msuiPBbhMKzgHQtI73w5IrJpbQzKn7sfH7rrDMz/OVCJ2+Q3GOMY
         Fjyv8SiQ7FtC5f7G3VkqZIilmQYxLChASKCHHHV6+AFbRBSTtsXlbRdAZ3Uqyp48awRc
         GhNRY49aV9bpY7uq9lXU36LMuhRDrKIbowNEZ9PSGE1Wb3pf/OgmnJxTVCtA/C3NgPrm
         zmpCtIC/fpmVAknQ/i8iNNM3IKZv9DuaE6FtrXeiik71HhAvCulwdlGIzwF7D9ox0vvg
         /PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :arc-authentication-results;
        bh=iwTlc11A8zNBjNPb0iqmiXSbDnwLRTdTpNnK2H09uTk=;
        b=ZA0IrvsFEI6bFJwryj33EkWe0AQ0nMivkEzQmmQBn6C7iCzVPGw0izY2HZUIJgDwSl
         L7De54HCSyoBwcbDTPAyOBjhov9ohKZLZK9/doqJUJdy8HbkgYZmKelkGcxMaDf4A7IX
         CpA8d6YOD4Q1H+ygsNDLFgMgeFes5W76HRvm86YKgXciNJqqpW1tpBI/wfzsL4vuGQ42
         ElDrb7qcXiLSP6c/niSNj9CjcRsz5B1xHB4IA9nIlntywidQQLb14rJIdH+rrqlkxThX
         BBTbPtMe0mwlYGlCpHVJ7K12fjc79tvvPwhO51lAr2BEMGAcuyEpdLCYPaLOYFWE1asP
         FiUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D1IuE6ml;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D1IuE6ml;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx4+Tg07Ahggbgs+PJoQ9XR7prq61SqjHpbNhbYgD9QAIkZPFZEv7e9u9jJRWszU213fyXPJQrwyRx2znv2XClbU=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <2047337098.98106.1523186884813@email.1und1.de>
References: <1523178315-30562-1-git-send-email-geert@linux-m68k.org> <2047337098.98106.1523186884813@email.1und1.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 15:29:32 +0200
X-Google-Sender-Auth: t8XzGaTDbB_nSxs7b4_ZWcWYpkU
Message-ID: <CAMuHMdWua5swcrNsvB5pbiMpuSyHSSoQhYSaqeq0ctP2csPtTA@mail.gmail.com>
Subject: Re: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies
 return failure
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Scott Branden <sbranden@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Eric Anholt <eric@anholt.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.org>, Phil Elwell <phil@raspberrypi.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597168233130064314?=
X-GMAIL-MSGID: =?utf-8?q?1597275450287065332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Stefan,

On Sun, Apr 8, 2018 at 1:28 PM, Stefan Wahren <stefan.wahren@i2se.com> wrot=
e:
>> Geert Uytterhoeven <geert@linux-m68k.org> hat am 8. April 2018 um 11:05 =
geschrieben:
>> If CONFIG_RASPBERRYPI_FIRMWARE=3Dn:
>>
>>     drivers/gpio/gpio-raspberrypi-exp.c: In function =E2=80=98rpi_exp_gp=
io_get_polarity=E2=80=99:
>>     drivers/gpio/gpio-raspberrypi-exp.c:71: warning: =E2=80=98get.polari=
ty=E2=80=99 is used uninitialized in this function
>>     drivers/gpio/gpio-raspberrypi-exp.c: In function =E2=80=98rpi_exp_gp=
io_get_direction=E2=80=99:
>>     drivers/gpio/gpio-raspberrypi-exp.c:150: warning: =E2=80=98get.direc=
tion=E2=80=99 is used uninitialized in this function
>>
>> The dummy firmware interface functions return 0, which means success,
>> causing subsequent code to make use of the never initialized output
>> parameter.
>
> i think this is more theoritical, because we need to get rpi_firmware fir=
st and in this case it's NULL.

Sure, I just want to get rid of the ugly warnings when compile-testing.
Most dummy functions for other subsystems return error codes.

>> Fix this by making the dummy functions return an error code (-ENOSYS)
>> instead.
>
> Anyway i'm okay with the change.

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
