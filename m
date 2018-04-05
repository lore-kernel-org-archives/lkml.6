Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx481SNOy+oTmZrnp10IXnv10vje3/8StS4RxjFHCNSkVgNFnmBAMc5fmVOV64LCSV9gGiatK
ARC-Seal: i=1; a=rsa-sha256; t=1522928862; cv=none;
        d=google.com; s=arc-20160816;
        b=JZotSow/WOE6ZNk/LxRv7YhNQl+97b4oPeLHgKhfjfNCcollrU7gqhzkVw8H1GQh+j
         hTNNK2iIdzVLij/9syynQJG6/QvrIdTsWb9Hs5Qlp/Mt5pFOD8wZun52y81ozjsCcU6z
         ZcqeEQ/Iog3cCMYLuhQF2Xzr8kLLN8SW037b1ijdKTjGw2F5chSDug5zVd8lD8QVBMhC
         x7RU5seoABqFaDmyLJXPdtRAs5DUMgSiaO0A/bKix4GOW4I3uHVFr4wj8y1hNiVzOHab
         hEYpTdz7SjL8ky9FJRYFVrRCq2tT+IJEpErAXWdKJfvNU9K5cpiwaFrhEwMFAmUyOdsC
         QJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=WxMunxcCdB/i/q2YiGXz8qa7M8GavVh5yB7vREIBOkg=;
        b=oedNxrS4VF7uzvrQDKuUnGHi0N9PXQ977k/lmwD/5sY14M42SGiYvRKSE+K6+cCtXQ
         T3LgF4T1jp/fv7E0kzFmeXX6JvWLmNoG9XoMnX9B8w938IwFMlFNrgrknegY1zU5sg5C
         yQfBkPUGApihNwJ3p9Jm2tY+ixy1kw9aPPovF+N7gXi94L4kJ6Eeg4LKpP19bfVYDlGI
         JENpHTGicrMaVJdXBu/wLL7C5FlNgoW3bie6ApuqCPNQu4A91/6M7qvfMLQQbcrb7JPQ
         PscvGAUPDYlRWsWuJ7RNPlBPzOBeDxX6aAWkWcRWyJ11QqU1UwCK3M7GaFWIxPXB+Lgk
         DOAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=shj7mY3n;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=shj7mY3n;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Thu, 5 Apr 2018 13:47:36 +0200
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
Message-ID: <20180405114736.GA12178@lunn.ch>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
 <5AC5FAA8.80409@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AC5FAA8.80409@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596906654775464019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 10:30:01AM +0000, Laurentiu Tudor wrote:
> Hello,
> 
> My 2c below.
> 
> On 04/04/2018 03:42 PM, Andrew Lunn wrote:
> >> I hear you.  It is more complicated this way...having all these individual
> >> objects vs just a single "bundle" of them that represents a NIC.  But, that's
> >> the way the DPAA2 hardware is, and we're implementing kernel support for
> >> the hardware as it is.
> >
> > Hi Stuart
> >
> > I see we are not making any progress here.
> >
> > So what i suggest is you post the kernel code and configuration tool
> > concept to netdev for a full review. You want reviews from David
> > Miller, Jiri Pirko, Jakub Kicinski, David Ahern, etc.
> >
> 
> I think that the discussion steered too much towards networking related 
> topics, while this ioctl doesn't have much to do with networking.

Hi Laurentiu

So i can use switchdev without it? I can modprobe the switchdev
driver, all the physical interfaces will appear, and i can use ip addr
add etc. I do not need to use a user space tool at all in order to use
the network functionality?

    Andrew
