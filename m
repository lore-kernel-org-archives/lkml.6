Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx49G62OoTE8yQx1o01dO16a97XVHQBsPBujy5BayN530cmmOO+Bhg7iuesfOFpY+p0REZhxt
ARC-Seal: i=1; a=rsa-sha256; t=1522760643; cv=none;
        d=google.com; s=arc-20160816;
        b=D/Y5KaxgUI8WA2VeMhOjGlXKLYZkVf7EAeZ40E1KTPCtxoVH8svYxJqdpmzuotq/RQ
         OWbhnBtLdZOL1mHqdNaFjrERDcFXhF/xdjfwy4Z7DU2RHpGdi7RJnyqO5ng32NPkHwAG
         pgV3Ms/5b0FU0MoXH6nmvLHt/kHur8fGK+BU78sQb6Kb0cfHhHgxrVNx5A+aQHFM8T5F
         U50yvkEquiso42M9JA5eJJ12BEzbdVOBhYKoxoJ6wJpRx9ercSpYBDk4PGqykrLIWRwI
         uygEXOp4BLpfh9pZ39DSjLv7YBzLJ/SBAsidMddxNIzOP3VjwDcgoqEkajA8fWFOIQsA
         nfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=4EG7mkai4asAscMY5ZY6lFALKP0IUJAHA43hs1H7ohg=;
        b=xLzH0qFV6446GbkeTiqjV4fLa36xaQeAG/iZyzzRGJeMNZQOh3Zk5B505uW0pbTqEv
         KPvplHu39Z57lanrUqy0pY3F60odz9O91lH9udhnVzuUB5W5N3hZIiIMm0b40wz4CFJF
         b1MLK9pQyErxsVXmCIWRaf4RyIrTxinKeQUY2pfunXT7F3Peoa0sBpE34CBnAfYDI4wE
         R/aBeyXUTy0uZSl8CVOPpzzZ9WlJb0FQTUbbiGs/xKqa4lT/pfCeiJA78MCqXc5r4UI7
         L1sZHMU57y1+9dzRZYIOM0OilqtnYRuTSWFW7n/dftY8GhgtZ13X1MPy3htPNhkJ94Tk
         VIaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=lCh50d0E;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=lCh50d0E;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Tue, 3 Apr 2018 15:04:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, gregkh <gregkh@linuxfoundation.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180403130401.GB31740@lunn.ch>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <20180328162811.GB15827@lunn.ch>
 <HE1PR04MB32127E14E0953910746A6363E0A60@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <20180402134441.GB10520@lunn.ch>
 <AM3PR04MB07439B79DD857CD2F8033623E6A50@AM3PR04MB0743.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM3PR04MB07439B79DD857CD2F8033623E6A50@AM3PR04MB0743.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596730264824852311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 11:12:52AM +0000, Razvan Stefanescu wrote:
> DPAA2 offers several object-based abstractions for modeling network
> related devices (interfaces, L2 Ethernet switch) or accelerators
> (DPSECI - crypto and DPDCEI - compression), the latter not up-streamed yet.
> They are modeled using various low-level resources (e.g. queues,
> classification tables, physical ports) and have multiple configuration and
> interconnectivity options, managed by the Management Complex. 
> Resources are limited and they are only used when needed by the objects,
> to accommodate more configurations and usage scenarios.
>  
> Some of the objects have a 1-to-1 correspondence to physical resources
> (e.g. DPMACs to physical ports), while others (like DPNIs and DPSW)
> can be seen as a collection of the mentioned resources. The types and 
> number of such objects are not predetermined.
> 
> When the board boots up, none of them exist yet. Restool allows a user to
> define the system topology, by providing a way to dynamically create, destroy
> and interconnect these objects.

Hi Razvan

The core concept with Linux networking and offload is that the
hardware is there to accelerate what Linux can already do. Since Linux
can already do it, i don't need any additional tools.

You have new hardware. It might offer features which we currently
don't have offload support for. But all the means is you need to
extend the core networking code which implements the software version
of that feature to offload to the hardware.

The board knows how many physical ports it has. switchdev can then
setup the plumbing to create the objects needed to represent the
ports. Restool is not needed for that.

> In the latter case, the two DPNIs will not be connected to any physical
> port, but can be used as a point-to-point connection between two virtual
> machines for instance.
 
Can Linux already do this? Isn't that what PCI Virtual Functions are
all about? You need to find the current Linux concept for this, and
extend it to offload the functionality to hardware. If Linux can do
it, it already has the tools to configure it. Restool is not needed
for that.

> So, it is not possible to connect a DPNI to a DPSW after it was
> connected to a DPMAC. The DPNI-DPMAC pair would have to be
> disconnected and DPMAC will be reconnected to the switch. DPNI
> interface that is no longer connected to a DPMAC will be destroyed
> and any new addition/deletion of a DPNI/DPMAC interface to the
> switch port will trigger the entire switch re-configuration.

Switches and ports connected to switches are dynamic. They come and
go. You don't expect it to happen very often, but Linux has no
restrictions on this. You need to figure out how best to offload this
to your hardware. Maybe when you create the switch object you make a
guess as to how many ports you need. Leave some of the ports not
connected to anything. You can then add ports to the switch using the
free ports. If you run out of ports, you have no choice but to destroy
the switch object and create a new one. Hopefully that does not take
too long. Restool is not needed for this, it all happens within the
switchdev driver.

	  Andrew
