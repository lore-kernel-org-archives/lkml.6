Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518103361; cv=none;
        d=google.com; s=arc-20160816;
        b=F2oXlm7BvBcqkE7k2CtoWKqlxql16R7Idem2yvgtvOLEv8mFpFWkkldJ13lRSxpJyE
         YRPwBVIyMqzaUuKp06gDov0h0nPktuSh967spwuI5gbT9iMaX6KJYqd1igs8Ox8DrsUv
         FET2LZfKm+Z8Zd+bMyMgwMQkrIrhWXZPYSLp2Ug6oqAkBOmFftbmMNE43HJWmkLW2pXs
         oJ7ZKHtDYDDoXOWMBVE73ZEbrWaLmPGkqL9Wky1Tj2jRk77hi7HyJD+eIUpHW5li/9gs
         /G5+9VhxwC+T/DS3qx588RLNtXYDq52DmHDcwhnJ4NRBVvMkiv0MdZXSTDQiohdGYBst
         rdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=X8wc6TAgtQHjGQYzrES1L2Ia676MyLNLpVAZhReTMH4=;
        b=jgnB3Hy7sDqXCjqvySMIi16ZWhXPAbt0bUG8tiwtOblVAGGKxEPODckFxldOXP+xTF
         G6WnoNULFSvtY0oIvGP7gMUDYA7GuuItaCehrFvOJlc6Mp52kQKDFQaJYvAHJOrwDVmd
         MjENmIRcBN1DqLIVDz/KnjvesMO0szLZ7i+cfdyL3oirzXpgh/sbUfMGi/gyG53jmwjd
         6eIC1p9ozDuyTa+tsMebegSc+OJyeF41aGAY6lQTRVMtf2JKE9CgXMLGe+l02c3/h9GN
         v8MLxbwnRMIM7tWbfdU4iEeKpO7cgZcXjC6d/VxBBnU9qxplv8LS+XOsyAxf2ACii7Y+
         yfoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PvJcT4ph;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PvJcT4ph;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x2276/7azXSKX8BA43fF6jQF2J1H4nfM5q6ZcS7H3jJgusQnK85cjH09JuJYb8tRZUN043wdXKLqVL2S6jwfzaCk=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180208134908.4b516794@alans-desktop>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517950494.3677.30.camel@infradead.org> <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
 <201802070918.18978.linux@rainbow-software.org> <20180208134908.4b516794@alans-desktop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Feb 2018 16:22:40 +0100
X-Google-Sender-Auth: u0VHc2hMoQtvJK2CgP0dBk1Y2yA
Message-ID: <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Ondrej Zary <linux@rainbow-software.org>, whiteheadm@acm.org,
	David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hugh Dickins <hughd@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jikos@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	Eduardo Valentin <eduval@amazon.com>, Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591846750566295367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 2:49 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> What about Pentium II and 3? I'm using 5 such machines (and also a Pentium
>> MMX). I've tried a spectre test before and it wasn't reading anything useful.
>> Don't know about meltdown. Is there a complete test program? (The web is so
>> full of crap that even google can't find anything useful.)
>
> For x86 speculation came in (as far as I can tell) in
>
> AMD Am5x86
> Cyrix 5x86, but branch predictors are disabled by default according to
> the docs
> Cyrix 6x86, branch prediction on by default
> Pentium Pro
>
> There are later processors that don't have speculation: Quark series, Nat
> Semi/Cyrix Geode, earliest AMD geode (I think), some Intel Atom
> processors.

Wasn't Am5x86 just a 486 clone? AFAICT, speculation only came with the
K6 (Am6x86 aka NexGen Nx6x86)

All the Geode are apparently derived from Cyrix 5x86 (I always thought
it was a 6x86, but the internet disagrees). For Geode GX, a
specification update at [1] mentions a special procedure for enabling
branch prediction, Geode LX apparently gets this right and always
has branch prediction.

> The more obscure ones - the Transmeta apparently may, the IDT Winchip
> documentation strongly implies it doesn't

The Winchip is what eventually turned into the VIA Nano, which does
have speculative execution, but I don't think the earlier C3 and C7 did,
they are much closer to the original Winchip design.

       Arnd

[1] http://support.amd.com/TechDocs/31533E_gx_2.1_specupdate.pdf
