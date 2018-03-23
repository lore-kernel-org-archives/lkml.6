Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELv994ueUAVjZGh1Y/qYtzFvMLFYkZbuP525rWYrjtpTClkUbwAdM/BkJ1N34BiW+1tgUmcX
ARC-Seal: i=1; a=rsa-sha256; t=1521813567; cv=none;
        d=google.com; s=arc-20160816;
        b=L/41t9RBIIkApjwNO3clYxjWVuq0C1e8YkshBwNEpGOGEpc5pjG5lA8Rs/BVX+9JN0
         Vfzt73XIPpFqF+pSolaFQNxH4dopGFNPpAuF9uovetVviFJHgG0RezamwgWQugSI35Y9
         e9YisyNFql2paz8Ib3DDy3hc+2JXedpHxJzoRDjHM612Y3Yg2tQwHvoiQ5UZP6oMcBvQ
         KG8Ye3GPXw+peCWCtjujpGyMiGqV3g4axAbrOgUItR2SF1hcr5RfDvmo6koZ1mlcdNtL
         KMmFMDKnQk6r7DSMCoXAj2NUhFQfiJghxpitVWx9Y6Uu1GPWFrwnN+UKVoCKmUqgL2rB
         pvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=d6fFg6HCXSc1kUfV1x5M8R7pv0MiDHQp1C233BBQKhM=;
        b=Hu2h53goIdCbb2SKvvPGOPUyVeBt3XBSsaZ7FpBsYl3tIN5ct21D4EywTgumXZ1/4M
         HY0pAfdh7muAqirlMzpMJm4FWuYYuUr34yfGh+NX4Yr9XNUbmLTiNMcTgKrnHq8KfxkO
         j6sVrWIrptimw/3J5vmMXervtsvFZ3juLoNUDqnM4W23kJvA/oyV93PTF03z+Iyv7Zz7
         Eqxea3MklLIecbFyTqLRarA7GOXakpd1WvfXJzKMcFIF/I6GdQ1503mdVnPPHGujfH1K
         F7+XIX0mF0AILGNxd/wZYRCm0c0zXAEmi/Jzgvu9LTlgP5ZKqcirQtaidrIOWw5huCN+
         lxgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Fri, 23 Mar 2018 14:59:26 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw
 Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan
 Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian
 Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>,
 Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose
 <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon
 <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares
 <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Walleij <linus.walleij@linaro.org>, Xiang Lin
 <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org, Boris Brezillon
 <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: i3c: Document Cadence I3C master
 bindings
Message-ID: <20180323145926.29fa0ff8@bbrezillon>
In-Reply-To: <20180323121035.7dc27356@windsurf>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
	<20180323110020.19080-10-boris.brezillon@bootlin.com>
	<20180323121035.7dc27356@windsurf>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725934834963345?=
X-GMAIL-MSGID: =?utf-8?q?1595737183527962954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 12:10:35 +0100
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> Hello,
> 
> On Fri, 23 Mar 2018 12:00:18 +0100, Boris Brezillon wrote:
> 
> > +Optional properties defined by the generic binding (see
> > +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> > +
> > +- i2c-scl-frequency
> > +- i3c-scl-frequency  
> 
> These properties are now named *-scl-hz.
> 
> > +Example:
> > +
> > +	i3c-master@0d040000 {
> > +		compatible = "cdns,i3c-master";
> > +		clocks = <&coreclock>, <&i3csysclock>;
> > +		clock-names = "pclk", "sysclk";
> > +		interrupts = <3 0>;
> > +		reg = <0x0d040000 0x1000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		i2c-scl-frequency = <100000>;  
> 
> Ditto.

I'll fix that in v4.

Thanks for the review.

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
