Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525687298; cv=none;
        d=google.com; s=arc-20160816;
        b=BQ/4kvCM2zisBRdFDH8189P0z2wqkNaYj2GazDUA404zBJwmQ6LofWvKo/eBj1dtyq
         wZ1wSGc4JDUfgFDPIKSu89sxFaHcHBfCBgw/EmTkLiS2aFF4igh1+gRTS+DfBiXRGsh4
         wnr0VZ3TkRD/td0N1i1wfC5rnx27BO5E3TvRcYc0UHuRye//HPMb/nix+IAwHw5Lc9fb
         s6wgtP0PmG9UmH1DC4eUiTvq1lCqz0CvMUFzYfJr4fuLvwKvrn4NNtYn/vb+EtUrcqrt
         OXI8xFR+wgBzfoA9CcuA/sWR2s1FK2IzHsJ70LcPw1Ca4ulMawNhzJv2xWZQ/a4yoXet
         ylVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=04FKQ28tq2c8hsfvCPSvCWOd/dNkbTCoU5DcvHkDd+Q=;
        b=oEdxgI6xSq1UAhqPpw34AU2OU66eKBUr12DWWG1BuZFTRxNygLHIvjlz+hb2yc0eCF
         +b2PYYQyorMTkrGZBYhGD7w2SHPsV2dxmocOblMEDmMeYKqUVUPL5bX2sW34KM1HvNy0
         CGA+/0YhRnXGaKit6bdpP/s9k3xYVQQKn/2ae6A44D8G1nZUxWzqaa9Ryx2/CRMp3H5+
         zJ7N55FIlLMABjoMp7wXNcZxa9C7puj1JKY+1sN7dVqw8M6N4nYA+7Q2AHn/oCbv9qF3
         Hd4C+ffHM14wx5snJtFcSt1DyUyNrKrjNFKDRynX/PmrZcx7v18whtnTLLBjp/sAUD70
         QIbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XxCV36Qw;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XxCV36Qw;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZrUyEeySOru0FXsR2kwu1SCPa5e7U/rwvjMtg6Y1lYm2S3D1GoyGIf2m8f9pxK+DJYyJngplw==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 7 May 2018 12:01:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johan Hovold <johan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180507100135.GS2285@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-5-johan@kernel.org>
 <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
 <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504114213.3xlzqxe74n55tk5s@earth.universe>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599799084433598056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 01:42:13PM +0200, Sebastian Reichel wrote:

> Having said all of this, serdev does not yet support runtime PM (at
> all). Tony is currently looking into it. Fortunately serdev allows
> us to enable runtime PM by default (once implemented), since we know
> the remote side and can (hopefully) avoid losing characters (i.e.
> with sideband wakeup gpios).

I'm not sure we want generic runtime-pm support for the controllers in
the sense that the slave device state is always reflected by the serial
controller. Similar as for i2c and spi, we really only want to keep the
controller active when we are doing I/O, but we may want to keep a
client active for longer.

Take the u-blox driver in this series for example. As I'm using runtime
PM to manage device power, user-space can chose to prevent the receiver
from runtime suspending in order to avoid lengthy (re-)acquisition times
in setups without a backup battery (by means of the power/control
attribute).

Note that serdev not enabling runtime pm for controllers is roughly
equivalent to setting the .ignore_children flag, which is what we do for
i2c and spi controller, and possibly what we want here too.

Thanks,
Johan
