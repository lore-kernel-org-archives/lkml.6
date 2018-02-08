Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AH8x224J4pBlga0r4NdjrsSAawDL7pABY7Gvlm8usIG5CsJocC4hsv+vQD+hKf1vip/VC3ey2+t5
ARC-Seal: i=1; a=rsa-sha256; t=1518124630; cv=none;
        d=google.com; s=arc-20160816;
        b=Y+CbriqSK6JLU4nhbg8/pyh4EPyBQm2U3wnChCzXDYzDlxMslPuciFEM0iujV+QA4m
         XaUu8IEibq4mHzlVE8xzogCPWqcdmU7BStlTJNBG/cSKl7E8lHNmMO2hQyu2pJOzS7b/
         tZd8VXMo21BccV3M8xn6+GCiqk+iHY4W3iBELAGtpOy5yWO+Vr7FSNoZ3/pzE6Y1cpX9
         QXEowJIlPKYGn3bjgR1m3n5hmLpD4RfJyB6dLypQBfc+t6TcdfxLgtruUvzXPUObzjD/
         oT6HMWCEM8nQgTq6Glv+W58wQ999Fhrnj+k4R/r7anJLUGfKlppIMzuPyJGOvr8IkwHJ
         tAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=xAcJeE4zJtWwFRbrqhP8g8xq6ykc7h83FRLi9gN0OFc=;
        b=YWojeV+VLJ4Nlo/hkiYrhvvNAjfDJ32S/c1HQ4Rzvn8v77bT0wL0ilAjYnmeeseRGI
         rVZtAH68LFgCTPtl9nk3kgkAeoNa1NxTEMh/bMBW1IHv+n9WDGZ4dqVQdbeVoaWxhZ8R
         jFMMl45UhnDOn32qzMX+X6FtodyxPfWbh5d1Q8D6JdkWl07NKb0h9wqzRyUslR5t3Wgu
         3GRcHI8zGEHKssl6XSb0OP6opoH6amkTtdhi+0OJj9aQAVvz9dvlHt679D31zzrAbIRP
         xWDLx7n10v1gmhoopQTxdkUGA46jLL78MgCg/FjohUQc5fv2mNh0v3hW7eM34b/u+Bwi
         m0UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Thu, 8 Feb 2018 21:16:36 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ondrej Zary <linux@rainbow-software.org>, whiteheadm@acm.org,
        David
 Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh Dickins
 <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina
 <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Kees Cook
 <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
        Eduardo Valentin
 <eduval@amazon.com>,
        Laura Abbott <labbott@redhat.com>, Rik van Riel
 <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Message-ID: <20180208211636.28d82edd@alans-desktop>
In-Reply-To: <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
	<1517950494.3677.30.camel@infradead.org>
	<CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
	<201802070918.18978.linux@rainbow-software.org>
	<20180208134908.4b516794@alans-desktop>
	<CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591869052267041762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 8 Feb 2018 16:22:40 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Feb 8, 2018 at 2:49 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> What about Pentium II and 3? I'm using 5 such machines (and also a Pentium
> >> MMX). I've tried a spectre test before and it wasn't reading anything useful.
> >> Don't know about meltdown. Is there a complete test program? (The web is so
> >> full of crap that even google can't find anything useful.)  
> >
> > For x86 speculation came in (as far as I can tell) in
> >
> > AMD Am5x86
> > Cyrix 5x86, but branch predictors are disabled by default according to
> > the docs
> > Cyrix 6x86, branch prediction on by default
> > Pentium Pro
> >
> > There are later processors that don't have speculation: Quark series, Nat
> > Semi/Cyrix Geode, earliest AMD geode (I think), some Intel Atom
> > processors.  
> 
> Wasn't Am5x86 just a 486 clone? AFAICT, speculation only came with the
> K6 (Am6x86 aka NexGen Nx6x86)

The AMD 486 was a 486, just like UMC. The Am5x86 was a sort of super 486.
But you are correct I'm muddling that with the K5 - which does speculate
or at least some of them do. The K5 branch predictor is software
controllable via the HWCR MSR but who has one today to test or cares 8)

> All the Geode are apparently derived from Cyrix 5x86 (I always thought

Not quite all. The older ones are Cyrix 5x86 related which indeed means
they don't have branch prediction on by default until the LX. Just to
confuse the AMD Geode NX is basically an Athlon mobile.

Alan
