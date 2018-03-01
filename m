Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519934545; cv=none;
        d=google.com; s=arc-20160816;
        b=MfFRygEFxXgy9J+QdnsVQgN0P/cwm61Yr7rgfEWYqlqiFIDE1g5RRgrMjmc3NNNtsV
         W7gqE/Z6F6WfC6QYlGBSptfXK1enSkwAdxTeEa2GG7ZtFIw4/iVZkLmLzN+3Tx7kuX0O
         cFzQreztnoumJEt8p4wplgiCLT/aG3yz/h2K3uVDN21eq/0h6MsS1yFjcGIFR2kr4ek8
         Y3cizipAR3KJTZf+YhLEydQaGa8IzkCKtP9PO6QjR700uRgNUBCPgkM5fSF6bUZxMKph
         3eC8RrLxsRUpVN4eLF7lxLy1XGncsmHrhuZG7lF8ltsJy6syYm1YCJHZ9psyv4ksOS6W
         h9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=WDyIH1krvqTZxOKUIpkFGl78BGSAW3guXkG36iui3MQ=;
        b=SRHAA3Pd6A++RSpuwNvpSwHYAZnnf3HUR8zW9y1yos2U8xOu92LBsCh7fr2XAQamlc
         8YRhjeIFHMFZlJYuNT3ZXx30Lals8y23CGIXAFOMk5NInismK2qlCbHa/dq4oGWA/59z
         Ib1AmxdVPMhZOrbkjTCAETLqVVIXRRqN76h6jlpME/P8HmIZ2P5Gy69igw30b+NxjZ8m
         fUBopwV9LTukBy7djVx80Vk8j6BZUML/5rTviT/g2ffMOL4mbk1t5k4+SNFgFLHb46fC
         rGmQkB/khk5dI9NWQl+jOWMCvymtH3cgNUIbjljba5u2E2InRv8/8WCJov0XaxfgeY5p
         XCcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MSYaADQP;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MSYaADQP;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtXp/Ubc+XGWVVJn88UX/r1X/ceKi/uBXTiVNSHZPLukGeJ8WmePjjZltetoOEhRlhA3KXaXLdh/UeSQvalkbs=
MIME-Version: 1.0
In-Reply-To: <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 22:02:24 +0200
Message-ID: <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Christoffer Dall <cdall@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Tom Saeger <tom.saeger@oracle.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	Linux Documentation List <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593761931178460290?=
X-GMAIL-MSGID: =?utf-8?q?1593766886258533859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <andy.shevchenko@gmail.com>
> wrote:

> "earlycon simply does not utilize the information".
>
> earlycon parses iotype, mapbase and baud (from options).  However, it is
> hard-coded to assume that the clock used to generate the UART bitclock is
> always "BASE_BAUD * 16" (1843200).  While this may be true for many UARTs,
> it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48 MHz
> clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk" and
> uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
> actually a set up in acpi_apd.c when there is an acpi match for "AMD0020",
> with a rate read from the .fixed_clk_rate param of the corresponding
> apd_device_desc.
>
> This patch attempts to add a way to inform earlycon about this clock.  As
> noted above, the information is actually already in the kernel and used by
> 8250_dw - I would happy be to hear recommendations for wiring this data
> into earlycon that doesn't require adding another command line arg.

And it should not require that for sure!

I would look to this later. It's late here. I need to do a bit of
research for the answer.

> I see that support was also added recently to earlycon to let it use ACPI
> SPCR to choose a console and configure its parameters... but AFAICT, this
> path also doesn't allow specifying the uart clock.

Fix your firmware then. It should set console to 115200 like (almost)
everyone does.
Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.

-- 
With Best Regards,
Andy Shevchenko
