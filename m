Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZrdjxWWJDss8l06iPKlPlwB96MbDIIPGmUHMWRCNqmNYyGyqiSgNIxLxCEOmRQBbRgWeXyv
ARC-Seal: i=1; a=rsa-sha256; t=1525444202; cv=none;
        d=google.com; s=arc-20160816;
        b=RRT3tbJIzdOgAv3EMOrjniI4kAOH62XiQ7GZ7ZsC+3iieRzdHXFXm4gH5a7BBc2vUs
         lXpBtaqijBYsTFQcRXxSUmoaA3m68vN5/JbdH+/M5D5tP+dPPbiokOias+jH9tSsxdcj
         uX39KCT7DYBuAipyPLsou8d5SiORJlIwIpQDgBKMLccEmWcHv6dwLn5RqGn6KQ8zZdD9
         REPPvGr95coeaywgIrvX3fsXSHobqLHHCwHAaoFJG8sEzxM1wA/Oxiv6zJL0MXEofnyY
         LH+ho3dK60dHRI9A5w2wFvCe3MDeObU7WWdZq6d1q+d1VqOinyXO+SdVmTiw9qqmVh1v
         Y/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OE00LsZQtSvkCWTKBGwj9QPE5sppReFSj+Kq1xkcM7E=;
        b=M8QuDJ9FqR47OIxeOZJNRrVYDds2SedLSIU6sK2gE8xwWhxgmRvhUGvvtuOOoelzob
         cCFYYuXZ/50XXaUEPgx2BWRIoGnAskK/wtiwTIA5U4x8hrzHtBF4p6n0KP3pE1CPHAzX
         9W3VkhoGnvYw23aCZrktZq4zF/jBVEhZL2X+aHadMWuFbCfbzmBrXTMS+DhUP9ykzLep
         sgyYQG6Sf66l6OiRuf9SLRFBWMTqP+5e35LbwLmwO+1viARDSaHFDNL9dJYExzW2yJSK
         AH0/OVOqSgSU/7Qq/zvfWraJx+9UjZ9rYzmP2sQBeVJha9PzXx1z9/VFIjyzES89H//c
         MM/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Fri, 4 May 2018 07:29:58 -0700
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johan Hovold <johan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180504142958.GB98604@atomide.com>
References: <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
 <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <FC3D0AF4-66EB-48A9-8E81-EC78DE43E105@goldelico.com>
 <20180504133759.xauwewrqevsbhjyr@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504133759.xauwewrqevsbhjyr@earth.universe>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599544180257011845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Sebastian Reichel <sre@kernel.org> [180504 13:40]:
> Hi,
> 
> On Fri, May 04, 2018 at 02:04:15PM +0200, H. Nikolaus Schaller wrote:
> > > Am 04.05.2018 um 13:42 schrieb Sebastian Reichel <sre@kernel.org>:
> > >> I think it does not need much more (if at all) than a gpio controller on
> > >> the OMAP3 chip (I think the clocks are active anyways for use by the other
> > >> UARTs).
> > >> 
> > >> We had proposed years ago to reprogram the UART RX pin by pinmux-states
> > >> into an interrupt gpio but that was rejected because it was not general
> > >> enough and ugly in the device tree (an rx-gpios record where the rx-line
> > >> is already connected to the UART-rx).
> > >> 
> > >> Then we did experiment with tapping the UART driver and finally the
> > >> serdev API was developed to solve this problem. Hence we use it now this
> > >> way.
> > > 
> > > Having any UART active on OMAP results in the SoC not entering
> > > idle/off wasting energy. For normal (i.e. not connected to a peripheral)
> > > TTYs you can enable runtime autosuspend and configure the RX pin as
> > > wakeup interrupt. This will wakeup the TTY on incoming traffic, but you
> > > will lose the first few characters (since the serial device needs some
> > > time to wakeup). This is for example supported by the N900 uart3
> > > (debug uart):
> > > 
> > > $ grep -A4 "&uart3 {" arch/arm/boot/dts/omap3-n900.dts 
> > > &uart3 {
> > > 	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
> > > 	pinctrl-names = "default";
> > > 	pinctrl-0 = <&uart3_pins>;
> > > };
> > > 
> > > To get it working, you also need to enable autosuspend for the tty
> > > in userspace (echo 3000 /sys/class/tty/ttyS2/device/power/autosuspend_delay_ms).
> > > This is not enabled by default due to the character loss characteristic
> > > during wakeup.
> > > 
> > > Having said all of this, serdev does not yet support runtime PM (at
> > > all). Tony is currently looking into it. Fortunately serdev allows
> > > us to enable runtime PM by default (once implemented), since we know
> > > the remote side and can (hopefully) avoid losing characters (i.e.
> > > with sideband wakeup gpios).
> > 
> > thanks for explaining this! We originally had similar thoughts when
> > proposing a w2sg0004 driver for the first time (years ago), but we can
> > not accept loosing characters...
> > 
> > Now, I could imagine a potential solution. The key situation why we keep
> > the serdev open and listening is if the driver did try to turn the module
> > off, but in fact did turn it on (because it was not in sync).
> >
> > It should be possible to cover this by a timer that is started
> > in this case. If there is serdev data received after assuming the module
> > is turned off, the driver has detected the wrong case - and can safely
> > close the serdev until we want to have it powered on again.
> > 
> > If there is no response after turing off, the module power state is already
> > in sync and we can close the serdev as well - after the timeout (let's say
> > 30 seconds). Then, the serdev UART can idle. We should open the serdev
> > and start this timer also in the probe function to catch an initially wrong
> > state.
> 
> That sounds like a good plan.

I don't know the details, but sounds like you should might be able to
just the timer that comes with pm_runtime_use_autosuspend() :)

Regards,

Tony
