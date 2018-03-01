Return-Path: <adurbin@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519939449; cv=none;
        d=google.com; s=arc-20160816;
        b=Z9xhFhEwxYwwy42zywsjjHhbueIfgYNEG6WINKolelOHsqbcFohEDP9T/3/IgUZAk1
         OqkTEdhhz7hHgvN9dgmpuZFP1Yq/G4pT1+95A1psfSNrWBQJ/rhsmT0tuPH6e4vsK0DJ
         7fC6s7J4PHoHQiHzhcUVNdt/+L8M12iB2+c0B/kD8VI0wsWNpLc+GGNj+wyizvLkYdPz
         n9x9VMwh4t+j4W0w0M9HvK8168mWznnXwDGkedYr4UFRKiivHU6Q35hYs3ZegDg0ETH+
         TypXb9yXULKYvgIRofjrDUGcb+ErTGajiO0GwJY1TQ+8IypXdXeo7zy/s6vxu4gYi10A
         zfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=6Feh5M0NXp0+mWVaYKxpjQSE+w8KrZs9lmeEI6DIBqE=;
        b=gh2bwejA9AqeQhdag/jYzgBNqrV9L0iVh4zNtyFW2Kp1sscbaA5huyHbYSanCaMPWO
         vdG4NHPtabLxSNDxe5x0A7kv8GmqP9tIo6Ydq7kUbjA36GEeLs97o+jopzQOD+SO60sn
         2MEA690fmjHkLc4PXZXBwuE8gmVrcddXGOw1eB++8Lgu7SvfMt2mGUNSjJyvsLzlaBjy
         fU3ltZe3RGIxBRunSxlvx0MzB+7oflx81r4TQue+mai54aG+FoKSNW2TVnWiFLqAFhy+
         tSUBfjcUmj+Vv8vVYSInK0BKTzku+SfzB/2RDwonvmjaYmSA/MFKrOsXEVfnt7qZ3e1U
         M/0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QLccx/Tq;
       dkim=pass header.i=@chromium.org header.s=google header.b=K2vkhuCH;
       spf=pass (google.com: domain of adurbin@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=adurbin@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QLccx/Tq;
       dkim=pass header.i=@chromium.org header.s=google header.b=K2vkhuCH;
       spf=pass (google.com: domain of adurbin@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=adurbin@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvmdXU2V25Rvdoq+qxNQqZry/SxMTjpl/Y2g2baqNJ+2GrP15KGd2+sS1pG60FBWmqOARK1YAtMdfVv/WD1gzU=
MIME-Version: 1.0
Sender: adurbin@google.com
In-Reply-To: <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com> <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
From: Aaron Durbin <adurbin@chromium.org>
Date: Thu, 1 Mar 2018 14:24:08 -0700
X-Google-Sender-Auth: JN3mM_pz1HSb1QoFAIcxnScaKeM
Message-ID: <CAE2855vbQyMwu8pmH-Sq1kA+=h5TJPWddTWPQoVdEqOn6sAyBw@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Aaron Durbin <adurbin@chromium.org>,
	Brian Norris <briannorris@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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
X-GMAIL-MSGID: =?utf-8?q?1593772028236092704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 1:02 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <andy.shevchenko@gmail.com>
>> wrote:
>
>> "earlycon simply does not utilize the information".
>>
>> earlycon parses iotype, mapbase and baud (from options).  However, it is
>> hard-coded to assume that the clock used to generate the UART bitclock is
>> always "BASE_BAUD * 16" (1843200).  While this may be true for many UARTs,
>> it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48 MHz
>> clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk" and
>> uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
>> actually a set up in acpi_apd.c when there is an acpi match for "AMD0020",
>> with a rate read from the .fixed_clk_rate param of the corresponding
>> apd_device_desc.
>>
>> This patch attempts to add a way to inform earlycon about this clock.  As
>> noted above, the information is actually already in the kernel and used by
>> 8250_dw - I would happy be to hear recommendations for wiring this data
>> into earlycon that doesn't require adding another command line arg.
>
> And it should not require that for sure!

But it does require that. There's an input clock to the uart ip block.
That is a design constraint by the hardware and is required to make
baud calculation work.

>
> I would look to this later. It's late here. I need to do a bit of
> research for the answer.
>
>> I see that support was also added recently to earlycon to let it use ACPI
>> SPCR to choose a console and configure its parameters... but AFAICT, this
>> path also doesn't allow specifying the uart clock.
>
> Fix your firmware then. It should set console to 115200 like (almost)
> everyone does.

It's not a firmware problem. Its the driver's problem in that it
assumes an input clock to the uart block that does not reflect
reality.

> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.

That's only possible if there is a clock divider on the front end of
the uart block. For this hardware that's not the case. I actually did
this very thing on intel chromebook devices, but it was only possible
because there was a hardware divider that could be tuned to reach the
assumed clock that the code currently assumes.

>
> --
> With Best Regards,
> Andy Shevchenko
