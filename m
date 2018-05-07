Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZqGu2S9Kt95dne0M1akNQOkTXqHeyx8uhkoUCCrrx22S2Agnwkz0fPGi8KnISlcPDT8dnmw
ARC-Seal: i=1; a=rsa-sha256; t=1525707919; cv=none;
        d=google.com; s=arc-20160816;
        b=v58I7VoaFCaa6927vJlh/qO8NEbdx/LLPqVy2Vkft8jeALHu5MecEU0QKD53oeTUXU
         fID/iAoiObS1VJgo78xQ9A2i7eXdtgacL6WmnAVC2VAWRVczPYeqAOy06ZeePvjj27PW
         GaP2XFKF9mBjCOMiF36JaCubELoUqIafuWxKRgs7skmpmCUC0j0gaVGwpj5kafKrlPqs
         npXf+V5tqxx1ElkKXpkx/ILdDi3/E1GXiiSvRctIZVLFmHKj42BWZavefdWGPJRRXNbw
         y/7OGlgeWiO6RdZEEr+vB9RTC64JW/rRt8k7fo340v48CZ4kK1YA2WRjpTBY3XodfqSd
         YEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=7P7i3urNlJrAvafCKEiZBcWtnLQnarSmu6FmWN5HiLo=;
        b=EDdL4a7CId6HomcVFwMevlidjOhbT+Gz8jBhu6HjqaXvRukC/TBrNlK6lwF5pjR5Xt
         bg0Fx26bY/1H63hCuBt7ImRv5FQQxGa7AvS9Y+YYnS5vxL5gUtV8eHVP8mojqiFbLeCV
         6kJ8k1ew+R2r//8DIX7jDn2eQ111MVaedURJ35SyuQiCQfonqUGtAZQpfDkwBp5W+jI9
         7wu/jGQ4SrqR0FVEFPs3cfvp3o9fQarPspXMRkrozv5CLRqaTCb89Tiq3isDi71dsgK8
         aVhW0MYZ86lxthJ8MJsIl4NEg+k8Pc3vRcpiaSDRFxVzJ8UHE9r1kB8Ki6morOML+4w/
         WohQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Mon, 7 May 2018 08:45:15 -0700
From: Tony Lindgren <tony@atomide.com>
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180507154515.GP98604@atomide.com>
References: <20180424163458.11947-5-johan@kernel.org>
 <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
 <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507100135.GS2285@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599820706790347160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

* Johan Hovold <johan@kernel.org> [180507 03:03]:
> On Fri, May 04, 2018 at 01:42:13PM +0200, Sebastian Reichel wrote:
> 
> > Having said all of this, serdev does not yet support runtime PM (at
> > all). Tony is currently looking into it. Fortunately serdev allows
> > us to enable runtime PM by default (once implemented), since we know
> > the remote side and can (hopefully) avoid losing characters (i.e.
> > with sideband wakeup gpios).
> 
> I'm not sure we want generic runtime-pm support for the controllers in
> the sense that the slave device state is always reflected by the serial
> controller. Similar as for i2c and spi, we really only want to keep the
> controller active when we are doing I/O, but we may want to keep a
> client active for longer.

Yeah i2c seems to do the right thing where the bus takes care
of runtime PM.

> Take the u-blox driver in this series for example. As I'm using runtime
> PM to manage device power, user-space can chose to prevent the receiver
> from runtime suspending in order to avoid lengthy (re-)acquisition times
> in setups without a backup battery (by means of the power/control
> attribute).

Sorry I don't seem to have that one, care to paste the subject
line of that patch?

> Note that serdev not enabling runtime pm for controllers is roughly
> equivalent to setting the .ignore_children flag, which is what we do for
> i2c and spi controller, and possibly what we want here too.

We currently don't idle serdev at all even if not in use. What
I noticed is if I have these in my .config:

CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y

And no hci_serdev.ko driver loaded, then the 8250 port still stays
active and there are no sysfs entries to idle it.

Are you seeing this with your series?

Regards,

Tony
