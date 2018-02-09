Return-Path: <linux@rainbow-software.org>
X-Google-Smtp-Source: AH8x226Jwbs5NhWb80A9kTe1CZ24CZSGw7/r/SWXFsWW2tp4qeZs2eNYNPPNpUFV4uLxvU4lG0CB
ARC-Seal: i=1; a=rsa-sha256; t=1518165706; cv=none;
        d=google.com; s=arc-20160816;
        b=IwjJyaxqKlnZLMXp6gS0H0JwFbjBQqkZezocdWcRk7SoeDbNfQ/ZCvgNX2WwwWXiow
         fXUCqNPe6BbJ9wFpa/esUdaWT7BZfuYYPUBsxlnV1j1ZWpZqGlUILVymGjFJkyE6t6U3
         fbOgx4DouUAwlLOJBRXmqvoLy+X+lbOx7YSJh0G1zpnmUYr8yoUD1Wfo5oLlfX2G/IxM
         b/KEUJlDfSM/GtfPntsZmjSwPKjXJqy1qr+9NLqefz1vJ6mAUGqNl76WAuuOnUaxxtyY
         FmysngSqfwde57Zxxwme/faajTbwLInVjo0lVGwtryUk8FFv4Y8Bo/JfgVvfNQ65yO6q
         SQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-disposition:content-transfer-encoding
         :mime-version:in-reply-to:references:cc:user-agent:date:subject:to
         :from:dkim-signature:arc-authentication-results;
        bh=eaunVIETfFDLaA3GtCmW+EgrvBiMiGTL6uxNkHCthnE=;
        b=sL7kUDvtnldc4wQ6d/WM+xkglHUUjzK0NR07/++C7O6LNx8Ay1KYzxnsKraFpUmtFJ
         7Aksfy2L7g+456wxi0mHaDEBGpeh0pixd6w/e1tW0Jj7rM3JYxw2VUCNay8CIgH3+MJS
         zh6MZmk9wr0uTvLxwtve9zppBNkzYeGvAmmtP/6FFnnA6J6WABamaccq2UvtVqeFeSCU
         uKt/ZhW2fLsuEavlRJqgtJBZIG5L3ZH6xYBZUP21PHW4/HhVburkILOxOMSMT4ABiruH
         uwbm8vTA2/jDG5MghoR1l4JHenok1bCuAwmwamBGThNElEYCUXKtaMoX0pIFm+P35Vyg
         Qt1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@rainbow-software.org header.s=atlsmtp header.b=U85rqKjA;
       spf=pass (google.com: domain of linux@rainbow-software.org designates 80.94.52.26 as permitted sender) smtp.mailfrom=linux@rainbow-software.org
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@rainbow-software.org header.s=atlsmtp header.b=U85rqKjA;
       spf=pass (google.com: domain of linux@rainbow-software.org designates 80.94.52.26 as permitted sender) smtp.mailfrom=linux@rainbow-software.org
From: Ondrej Zary <linux@rainbow-software.org>
To: whiteheadm@acm.org
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
Date: Fri, 9 Feb 2018 09:41:41 +0100
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc: David Laight <David.Laight@aculab.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 David Woodhouse <dwmw2@infradead.org>,
 Guenter Roeck <linux@roeck-us.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Hugh Dickins <hughd@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jiri Kosina <jikos@kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 Kees Cook <keescook@chromium.org>,
 Jamie Iles <jamie@jamieiles.com>,
 Eduardo Valentin <eduval@amazon.com>,
 Laura Abbott <labbott@redhat.com>,
 Rik van Riel <riel@surriel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com> <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com> <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
In-Reply-To: <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201802090941.41782.linux@rainbow-software.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591912123462414830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday 08 February 2018, tedheadster wrote:
> On Thu, Feb 8, 2018 at 12:02 PM, David Laight <David.Laight@aculab.com> 
wrote:
> > From: Arnd Bergmann
> >
> >> Sent: 08 February 2018 15:23
> >
> > ...
> >
> >> The Winchip is what eventually turned into the VIA Nano, which does
> >> have speculative execution, but I don't think the earlier C3 and C7 did,
> >> they are much closer to the original Winchip design.
> >
> > We had terrible trouble getting (IIRC) the C7 to execute functions
> > that were called in 16bit mode and returned in 32bit mode and v.v.
> > (for boot code bios calls).
> > The problems seemed to imply that it was caching return addresses
> > and the translation (to uops) of the instructions that followed.
> > So it would effectively decode the first few bytes in the wrong mode.
> > So there might be scope for one of these attacks.
> >
> > OTOH these devices were so slow that I doubt any are used for anything
> > serious - and certainly won't get a kernel update even if they are.
> >
> > Also worth nothing that the difference between the cpu and memory
> > speeds is much lower - so far fewer instructions could be speculatively
> > executed while waiting a cache miss.
> >
> > Tempting to disable everything.
> >
> >         David
>
> You might think this absolutely crazy, but I would be willing to test
> such systems if I can get my hands on the needed hardware that I lack.
> I am already doing sanity testing on Intel
> i486/i586/i586-MMX/i686-PentiumPro systems, I just don't have the
> clone cpus (Cyrix, etc).
>
> While few people are using the 32bit kernel, I don't think we want to
> kill it completely just yet.
>
> - Matthew

I have a working Cyrix MII (was actively using it last year, now upgraded to a 
P3-based Celeron). Some AMD CPUs too - K6(maybe -2 or -3?), not sure about K5 
and also a Rise mP6. But never got a WinChip.

So the question is: what to test?

BTW. Kernel was not able to identify mP6 CPU 6 years ago, patches were 
ignored.

-- 
Ondrej Zary
