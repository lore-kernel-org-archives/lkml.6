Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELvY8NnpmG7Abv/DLVeDVspwZ2Yr3krBdbeqpITNAZscQ9d1nOrlRFFcCyX8WVeN1QGayQ9z
ARC-Seal: i=1; a=rsa-sha256; t=1521813533; cv=none;
        d=google.com; s=arc-20160816;
        b=NpFfTTdex3aXqGcq66kEdSlGxK1v+2H1Ysh9Q+Uxkx8UKLv9gMKDxS/k3PoThe26xD
         L9KJVlS7JE4D0JIgccKbIUmo4zRPhkzviUM1EEDKoE2eFHltbBPYNuWhTqZLwKQ7HdLi
         vNmxk/xHRvvxSPtgy8pVtIi3y+NB6XCWwvbq52gVGMnEUz7+ffckpKrxPQHuVE422wIG
         5QrueRk2UFm0rVLK8ShpVHvniW+lCZ3/cnoQrtnsmfuRKBGEqbdAbd69f5/IKdcIYrY8
         cM++4woJec3JQsFLvwtjj4gMA2s7SmGPtcfW7YpQptcpahETMh2gU4P5dffoGhaDFNeS
         sLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=cKTZ62n3ay16nwKQjIUBRWAToaJ6GUjqMA6mFO+mWS4=;
        b=tEFyrhpVXRZxnfRlmh6+Kwwpm4vOCehiM6w00gHNFsh6eOfmAXC4hTtQKsnX2CDiZQ
         hozmivvQrc5aBi2HOPouckSdQErSwhYe9Md5uOlFSQt7s9SyeX7tf1+jfKcSJQzFOBkd
         PtIzmtfwMr26hJHqUA8uFkE6PwgdNV1gHSzPw4uymRWIXx0vP/oM+8DjfdwYTfQmFkP5
         V2H/d7RrehcO0nCgU8avJUgcmoRg3UA6RO/o3ZGxQ2NrzruivdsIm3dKNgvHmoPwytpq
         e6B0kFp7xu5DRVvgVoPMOKOKlWD7UzVFwbUtmgelGFL0Fp40Fo4+GAQNy0CQYgS2P83h
         s6cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Fri, 23 Mar 2018 14:58:51 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
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
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
Message-ID: <20180323145851.64997945@bbrezillon>
In-Reply-To: <beba0248-1a41-e39a-75fb-a1aa94337008@axentia.se>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
	<20180323110020.19080-6-boris.brezillon@bootlin.com>
	<beba0248-1a41-e39a-75fb-a1aa94337008@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725932611927845?=
X-GMAIL-MSGID: =?utf-8?q?1595737148079994826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 13:47:49 +0100
Peter Rosin <peda@axentia.se> wrote:

> > +Example:
> > +
> > +	i3c-master@d040000 {
> > +		compatible = "cdns,i3c-master";
> > +		clocks = <&coreclock>, <&i3csysclock>;
> > +		clock-names = "pclk", "sysclk";
> > +		interrupts = <3 0>;
> > +		reg = <0x0d040000 0x1000>;
> > +		#address-cells = <3>;
> > +		#size-cells = <0>;
> > +
> > +		status = "okay";
> > +		i2c-scl-frequency = <100000>;  
> 
> Another s/frequency/hz/ instance, similar to those reported by Thomas.

Will fix it in v4.

Thanks,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
