Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525687672; cv=none;
        d=google.com; s=arc-20160816;
        b=s0faxMvVZYy85UWu2U+bNVg+M/bGOygRvkDYUkDN6JtFKbr28fGgpsPhVKovxA8nqI
         KbdnRXGJg3IVBxpA5ZlfYplVn7VM1AVaoZeoXkvuNYTl/P1Hi5erbu5/DJjP6zvhHkvy
         a9VTsvRdP4YLQU94ObHei7SCbHaJ2vtFYUPFyUBqMqCNAVqP9AbaONFvX6TpFEdT2Iy5
         Kl2CtuRbi1IJpsPY71L8g5R63TlPsNPwJJNMYL8zfuZUt2um+mjazCBF0zVUiJcgIAW8
         BR93ZH2y/mGA7XLdS+STW5Mk2axT/kc7HtG28DoID2Ni+iOS69rOVxAnIMw9NviEemER
         cd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=H5AsGQK117GBDtRaPYU4SWW7IPeBdR+I9XWa47zkxHk=;
        b=IQ8uTXW6//lpaZEdblZOm1iPf7Xpgukg42z2vPJWOB2hVmh3SowHeoEIGx5uMP/ENb
         j2qhz6cvSbMVUwh6HZvKshNq8zFZ+gEHkmwLwFz7cAHEEG1HrnaB51vPRjXRwshTUuYt
         nSQfpA8y5LWM2UFq2hya4TSrUhDVnhoPlOKJeHIZpDJdbV6jpu7KkZ581LmBON0XMcsF
         UIIUtAP2Wi7nto4TlGG7+SBn8gJHcJ9Ak60aCJRTBUCOLxKT9SuraaRGrsHtfiiomFcr
         eHA+lT4EMs4uhr1CFEvaB0PBeGu1v+hKZ4z4YO1KH0SzgkK33ZfzMKLVBVilL+ZpMcKd
         JvgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mZSL7mw6;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mZSL7mw6;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZrUIaJrPoMe87b89xKc+/CNQYfzZPXHCDIuCxelk1rNUVzvPzbP/Z6718YZufO9j8M2Qeo6Wg==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 7 May 2018 12:07:50 +0200
From: Johan Hovold <johan@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johan Hovold <johan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180507100750.GT2285@localhost>
References: <20180424163458.11947-5-johan@kernel.org>
 <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
 <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <FC3D0AF4-66EB-48A9-8E81-EC78DE43E105@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC3D0AF4-66EB-48A9-8E81-EC78DE43E105@goldelico.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599799476732854347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 02:04:15PM +0200, H. Nikolaus Schaller wrote:

> It should be possible to cover this by a timer that is started
> in this case. If there is serdev data received after assuming the module
> is turned off, the driver has detected the wrong case - and can safely
> close the serdev until we want to have it powered on again.
> 
> If there is no response after turing off, the module power state is already
> in sync and we can close the serdev as well - after the timeout (let's say
> 30 seconds). Then, the serdev UART can idle. We should open the serdev
> and start this timer also in the probe function to catch an initially wrong
> state.

Right, the only thing that worried me about that was that we cannot
really delay system suspend for 30 seconds even if a somewhat shorter
delay should be probably be sufficient (still a number of seconds).

Configuring the serial controller as a wakeup source which aborts
suspend or resumes if the driver gets it wrong might be preferred to
draining the battery in suspend however.

Johan
