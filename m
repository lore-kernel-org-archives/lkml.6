Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518112248; cv=none;
        d=google.com; s=arc-20160816;
        b=lJndSMwuqca9pbHqYxBgPXYHfUmThF1e+Hq1TPOkA9S+bpmmxAURE5v1Y47znE0wnp
         wgYbWqc2eSptTzGETms4ldWx/jkk4B5JcElAdLrKDib5GOBp+ViRbliDluAGlsLjhyje
         l3bD5Rkgk6eaLFYmo4D3fDHdJ5XbAsQJz/XmEYb1CofCPU3Nzq9OzLprnwooh+F0QNwJ
         WyMv2SvlwaS/3txPmMgCha7Yr7u2xT0uzsVOirtnArJlCa867XB0ukbMGosFwp4cRVZL
         EZ84UOoM8aw1y/YVhN/wqa3ydYDJQBqjmQ0qgi2EOF96R5yaSrgVmHMcE+eCVB1GfE6n
         /O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7qLhHLq7GgsQneXki9z7kk9Fc8dBcC0O7aN4Mba34Qc=;
        b=R+CuNy23wiecG5kzZYs/IKaZKjqz6XvfOL7Nz9dRX3Xc2DjCkLphuRMRaiuYg82Jhb
         juFJQGwjI+amsfgPFmolDAdGER54QzC8huRXKIfHi+u/zcS+8tuYVIuznVJWJCRKmmqm
         iu3DEErcgeCTUQ78RwkB8Ans07ozBoYFm25AVuay3piW22KvSz6A41nPiS/HXvikjZrq
         gxArSmLj+aM/FYvzaxjMMYjYMjmYR6cN9v8QAiP95e5IN+a3PVfeVdhFoKZPGdVPzhCO
         y9OW6AnN20tcvuw2D9t2C2KUHrkf37d8TwzjxYvMLHJ6Avi7VaPeFViRrOLJNlscq3hb
         bmIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ee+CzHey;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ee+CzHey;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2242pMTTndFTLcp+/Z9YbSGWf5iofkORcLoKYI0eJ7LPLxUEDIlU09ty5UB9J//oL4gOLUYQJgEbnBu2aISMjb4=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517950494.3677.30.camel@infradead.org> <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
 <201802070918.18978.linux@rainbow-software.org> <20180208134908.4b516794@alans-desktop>
 <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com> <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
From: tedheadster <tedheadster@gmail.com>
Date: Thu, 8 Feb 2018 12:50:26 -0500
Message-ID: <CAP8WD_bF4jFQL=hOXRx97cyciq40MTJ9j8QwvJzLsn+LQudkmg@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Ondrej Zary <linux@rainbow-software.org>, David Woodhouse <dwmw2@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hugh Dickins <hughd@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
	Jamie Iles <jamie@jamieiles.com>, Eduardo Valentin <eduval@amazon.com>,
	Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591856068852915447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 12:02 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Arnd Bergmann
>> Sent: 08 February 2018 15:23
> ...
>> The Winchip is what eventually turned into the VIA Nano, which does
>> have speculative execution, but I don't think the earlier C3 and C7 did,
>> they are much closer to the original Winchip design.
>
> We had terrible trouble getting (IIRC) the C7 to execute functions
> that were called in 16bit mode and returned in 32bit mode and v.v.
> (for boot code bios calls).
> The problems seemed to imply that it was caching return addresses
> and the translation (to uops) of the instructions that followed.
> So it would effectively decode the first few bytes in the wrong mode.
> So there might be scope for one of these attacks.
>
> OTOH these devices were so slow that I doubt any are used for anything
> serious - and certainly won't get a kernel update even if they are.
>
> Also worth nothing that the difference between the cpu and memory
> speeds is much lower - so far fewer instructions could be speculatively
> executed while waiting a cache miss.
>
> Tempting to disable everything.
>
>         David

You might think this absolutely crazy, but I would be willing to test
such systems if I can get my hands on the needed hardware that I lack.
I am already doing sanity testing on Intel
i486/i586/i586-MMX/i686-PentiumPro systems, I just don't have the
clone cpus (Cyrix, etc).

While few people are using the 32bit kernel, I don't think we want to
kill it completely just yet.

- Matthew
