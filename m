Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AH8x227uejJtsQ41YWhh2y3sjZw0nbPJCGddwJy/m1M6uoqOwVXqgs77UCGAuMiEbur2APJ7dUB7
ARC-Seal: i=1; a=rsa-sha256; t=1518097797; cv=none;
        d=google.com; s=arc-20160816;
        b=ihKV5Ambf2ZudsBG87S3k6RlsJCb7sfLuwe74NP5srcMeH/24dcK4myDyxUy4yy13n
         ejmJT0iIOMKyTBJQRlNuWxNunJ/kg1Biit0iz8IuEXyMygtHYLNLCKxfFwPOg1wJvFVW
         OUrKNbOVlpayY3uEB/1xs6Aq3hN50YIfzUetaPb6kPCjfIxz97HW3kQOfY4q5ZKtmPWg
         OHw/ST6SGqjWwe8aEbWrQDAggvHFpvlPYj+NGJV7ZvxNDSkAJpNs4Iynyq2Y/07kIWDM
         RSv7Nj3Ix6ifDDf4c4eEQeW+rd8w3LAte8S74dIh/QMlDxR+jA1q/Qre5vFIZc6ua05R
         S+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=+diRqNWzBlxsRAlhEdQYMIXtq6QkpgBNkTJezZ2VHbY=;
        b=uLNSD1NfAsFGZQC5kAv5wgaPokbuQVdAOD3QiAbSZ96k2YXL9gF55nC3aTUnwY5iOG
         Cxhn4sZeITP9YATozN72mU3VAaJmxys4X9IlfKGRCH1j1U/LSkIpYtPKwj0T8wYenwvc
         rID8FtEh9sDkVog5JWm7PsEYVG8uNAT62ZVL6QRN9kmdKQVJfJjfFA1Br194Sfm3HX0S
         GW//Opgoa1DodLa3LfZMztdh9o4aZ1N6gqWNiBvjHNfrhmT17WcEljEX3sAvB6dFRQor
         ffD9wKYTvvLV1Oy1LcVxNiiGcQ90oHjk4lwLQ7HxJ57jHD9x7PphCxRXUw0Zv04QSUVM
         tIZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Thu, 8 Feb 2018 13:49:08 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: whiteheadm@acm.org, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Hugh Dickins <hughd@google.com>, dave.hansen@linux.intel.com,
        jikos@kernel.org, Borislav Petkov <bp@alien8.de>,
        Kees Cook
 <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
        eduval@amazon.com, labbott@redhat.com, Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Message-ID: <20180208134908.4b516794@alans-desktop>
In-Reply-To: <201802070918.18978.linux@rainbow-software.org>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
	<1517950494.3677.30.camel@infradead.org>
	<CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
	<201802070918.18978.linux@rainbow-software.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591840915878930272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> What about Pentium II and 3? I'm using 5 such machines (and also a Pentium 
> MMX). I've tried a spectre test before and it wasn't reading anything useful. 
> Don't know about meltdown. Is there a complete test program? (The web is so 
> full of crap that even google can't find anything useful.)

Pentium MMX does not speculate. Pentium II does.

For meltdown there are some reasonably easy tests to run to look for a
positive. Proving a negative is much much harder however and as far as I
am aware nobody has done a full evaluation of processors that old.

For x86 speculation came in (as far as I can tell) in

AMD Am5x86
Cyrix 5x86, but branch predictors are disabled by default according to
the docs
Cyrix 6x86, branch prediction on by default
Pentium Pro

There are later processors that don't have speculation: Quark series, Nat
Semi/Cyrix Geode, earliest AMD geode (I think), some Intel Atom
processors.

The more obscure ones - the Transmeta apparently may, the IDT Winchip
documentation strongly implies it doesn't, the Vortex86 (aka
SiS55X/Rise mP6) says it doesn't and things like the NexGen I have no
idea about.

The problem is that it's very hard to definitively answer questions on
these processors and vulnerabilities like they are obsolete, almost
nobody uses them for anything but retro stuff and the return on the effort
of figuring out defiitive answers is close to nil.

Alan
