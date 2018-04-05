Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx4/nDdr68kKAbaKz0vsYOyGgdDGYLeDAHgTf9OyuKgOEN2WiXsnjdDStVu7Vyzgy9ItOWZgf
ARC-Seal: i=1; a=rsa-sha256; t=1522932493; cv=none;
        d=google.com; s=arc-20160816;
        b=dqMkEompNA3SWI/2GWoEVdlH0W7uiGRF5MfJu/Mq4yuVlCdsI3crMAu9J5YnaXVekE
         Gy2G9qN2YGomPVrUimSsScz1GbOaUL0wnULztKX4ennjhq1BXnQqmnkaIVRA9Vknls1T
         N4O54IxqRdwN4z2n2C1vT3zij3VN6WBXWnZJmpvzfdk72guXFKP3uXJp1yg7wZo+72Xo
         mPXkAMTSwXK3FZu2+FmC2SIkS5aN3DjYWPSwWIzkmwDktHXKFJHg138PBx+4tPD9eE94
         ADyOLKVDBCiDHD7pLq3Ohz0UQTEEQIktYFNc2XU2mj7YPD+NlJf55ie82uxrWZo4vsqF
         Kgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=spyr5PpIxtRq95Q0o2TDt69IGtuAbef5XKGWkz4fVgw=;
        b=Cg+HW+Iqp/iOzXfPKAY1TdRLVd1dTHBIIujKw0IbzJrNAfLFW2qiGGfSrBIExUc3ZC
         AroiwGJX2NbjYHRn/ISXNThp6jan4GpwJb27YR9KQa2e8roqJldMkqAHSs/kBr7gaNrh
         T+H1MKJwCCLKLKhj/AiDHNpfzvyBbXWECI+V5Crq0grrCoINiy9tcQy3LvrQBUMxJ1Um
         3LOqF9/42sNJc0FHtMh2BXHELyAmqEEA/PNZ1at6wuhe5wWjecq8mUxCsCCsEQszuqOq
         lUpQynMmD4Tgvuf0DvNQngYVFw5cVtpUGf001oi31hIfwPr5EKARkOVqIZGqefrkPPeF
         OQdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=utczDIzV;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=utczDIzV;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Thu, 5 Apr 2018 14:48:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	gregkh <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180405124810.GE12178@lunn.ch>
References: <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
 <5AC5FAA8.80409@nxp.com>
 <20180405114736.GA12178@lunn.ch>
 <5AC61393.7090509@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AC61393.7090509@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596910462590466547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > Hi Laurentiu
> >
> > So i can use switchdev without it? I can modprobe the switchdev
> > driver, all the physical interfaces will appear, and i can use ip addr
> > add etc. I do not need to use a user space tool at all in order to use
> > the network functionality?
> 
> Absolutely!

Great.

Then the easiest way forwards is to simply drop the IOCTL code for the
moment. Get the basic support for the hardware into the kernel
first. Then come back later to look at dynamic behaviour which needs
some form of configuration.

> In normal use cases the system designer, depending on the requirements, 
> configures the various devices that it desires through a firmware 
> configuration (think something like a device tree). The devices 
> configured are presented on the mc-bus and probed normally by the 
> kernel. The standard networking linux tools can be used as expected.

So what you should probably do is start a discussion on what this
device tree binding looks like. But you need to be careful even
here. Device tree describes the hardware, not how you configure the
hardware. So maybe DT does not actually fit.

	  Andrew
