Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524733827; cv=none;
        d=google.com; s=arc-20160816;
        b=Kt6GbelrBTtJWg9pRC27jJ0QzbOWnF0quIi+g/8wAYg1KmB2ldypa1PVFBlULfeagI
         dAOT0otVWzz/pt/cC9cS/ivyjORFZ6HWqv81ZCqUjm/2l/vok0dJf3QFUH1G55fGFVYV
         j28GRZtRs+Jv+Y/qBrPlqK9bURFs5EX7Q2XDPPO2YZtkwzT/Zrmcc3iuvvIe/BqsKS64
         Jtb9gNN+VYolZEKVTy7Cgga+dw3rMFQ947BoLHJhNKO+PYg3j+klAbVU2OjVxHGaZJH9
         gQlfevtUC0PqzfrjzQ7BtGyn3slvxF/yeLnXTLHc/oqfkLuXHCCT9VkTS05xlD8ZVVq7
         15fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=GSFheHI/pLojwuItXKndv/nWl002mvwVRiD9qe7aqJg=;
        b=xtRrDprPW4DT97MlaggUUlj9y/rBQcGjrfwkg4V+YKvU9GILU7WtF7YkOu5fTXZ2Ro
         7AwPNWhoD1A9fXnU6nz4U1lLNW514ZWnAkIZKV5U7oRlIhnVtTpFKrBflLaSo0wwFLf7
         iyv892xHxpg3M+6sYh5fsUydbi9/aFtUtrolFmI03k9X3Fs2IyZfswrMhairEmdEHV/f
         Bs/RlKskwDdalph2iL7Vo/4x4l+0VQ/tcVH2EWn9OApUPTwRal18sb1FIlMJpUfDpKFx
         nMOqV5eKdeN2TZRpnfP3rZ0PTn6orh7fpPl5PJ54TM2F8/MWD9J45ptahLYiU+oFpZav
         5tBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EkCITlOw;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EkCITlOw;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZooXi2hnmOYgRdnLJDuVEcmcl4shCIg8tsHaiBgiLmPG+c20oaXuQ+3sIbnN9lNCW7WFS3+3A==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Thu, 26 Apr 2018 11:10:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180426091018.GU4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-5-johan@kernel.org>
 <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1598799297301641381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 01:16:58PM -0500, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 11:34 AM, Johan Hovold <johan@kernel.org> wrote:
> > Add binding for u-blox GNSS receivers.
> >
> > Note that the u-blox product names encodes form factor (e.g. "neo"),
> > chipset (e.g. "8") and variant (e.g. "q"), but that only formfactor and
> > chipset is used for the compatible strings (for now).
> >
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  .../devicetree/bindings/gnss/u-blox.txt       | 31 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
> >  2 files changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt
> >
> > diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
> > new file mode 100644
> > index 000000000000..bb54b83a177f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
> > @@ -0,0 +1,31 @@
> > +u-blox GNSS Receiver DT binding
> > +
> > +The u-blox GNSS receivers can use UART, DDC (I2C), SPI and USB interfaces.
> > +
> > +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> > +properties.
> > +
> > +Required Properties:
> > +
> > +- compatible   : Must be one of
> > +
> > +                       "u-blox,neo-8"
> > +                       "u-blox,neo-m8"
> > +
> > +- vcc-supply   : Main voltage regulator (VCC)
> 
> What about V_BCKP?

That's the backup supply for for the RTC and batter-backed RAM. In
configurations where a battery is not used it should be connected to
VCC.

How would you model that? I can enable a vbckp regulator at probe, but
what if someone then accurately describes the corresponding pin as being
connected to VCC? I guess we can check if the regulators are identical,
and then just have the driver ignore V_BKUP. Knowing whether there is
a (hopefully charged) battery connected could be useful.

I can't seem to find any other bindings that describe battery supplies,
but I'll add it here.

> > +
> > +Optional Properties:
> 
> reg is required if using I2C, SPI, or USB.

I'll add that (even if there is no driver support for these yet).

> Datasheet also shows an interrupt pin.

Not used currently, but I'll add it to the binding as well.

> > +
> > +- timepulse-gpios      : Timepulse (e.g. 1PPS) GPIO (TIMEPULSE)
> 
> Why the 3rd "TIMEPULSE"?

That's the pin name, which in this case is identical to the property
name, so I'll drop it here.

Take a look at the sirf binding; vendors use different names for their
timepulse pins and in that case I added the actual pin names (1PPS, TM)
in parenthesis after the description.

Note that I mentioned "timepulse-gpios" in the generic binding with the
intent of trying to enforce a generic name for pins with such a
function (similarly for "enable-gpios", which I guess is already
established).

Thanks,
Johan
