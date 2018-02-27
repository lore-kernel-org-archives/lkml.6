Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519715057; cv=none;
        d=google.com; s=arc-20160816;
        b=KzohXimFXeJYyN0yqeMmuU+4ZVFofVUdB3RDHiDKD2Lw5vIhMBIIfYKvKukPv/oyNK
         76dGbra8Dz+Eil6EnPMyIk3OYMlfY/sAMhRtFxVUaKOnC9vkPBlpZxWBG1l596k/NrAu
         R4jEG2aC8yzAIINBPcL54RDAxrlWy0BQSYixkxTL7g59h5BdPREWN9C+CfJKWNOIy3pv
         n2Ujgj4teWloD8+8qzAD4+vF2lwKxqZ6VuG4LbIZA8TUiqwI5OAvH2qpDG/p8ZpvOI/k
         Xg++jKhbwmYjK54aCUxvjDtNgMJySy4zPQX/cA5O1CaxZQXpkAhrSX54tv2en81mnk0u
         UCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=kFy6x7ArzeMpbWDRmUo6gWP2WSZ6+qhyb5BzjX0f96w=;
        b=B0BSDCrHR79pdmF/AOQYV46QBiTq1e/B8R1XvGYRp/GdZD5AIA/bcbFgXCG3X7lJYe
         cI8y3rz1jWzxjsFGN5LUBFXiLSZ9keH0wSDFOWjf0YgU1EMeLjy3WtlO+mjijRmxyudM
         O0RyeA39y0ijBQfjeJK8cKgE+eZuxv75mSgCuBcrTDfr310la4aRZNzCjQSK54998+PK
         MSwGruRqjZms163Yk8oP2ge2dNWUodWnrSCVqUgOuk6gfmalneHZ778CfncOmpGVOSTq
         itYAZYXv668OFROw17SUnbiJ/TpCFXYkwnEN/8T+3gMl7DRKq9tyZvURuiKkO3U1vUKA
         9qLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gwNoV91C;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gwNoV91C;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AG47ELs5+RZ+4iwhdNvBQ5Y0h42SihfjLRgdkm4Fqug91eRwFVWb3PermSUF4p6vMdZPKk7zUb9ZFQ==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Tue, 27 Feb 2018 08:04:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Johan Hovold <johan@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Mark Rutland <mark.rutland@arm.com>,
	DTML <devicetree@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	kernel@pyra-handheld.com,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Message-ID: <20180227070415.GB18666@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <20180212152618.GC13962@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212152618.GC13962@amd>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1593536736221967617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 04:26:18PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Let's restart this discussion and focus on the main roadblock (others
> > > are minor details which can be sorted out later).
> > > 
> > > If it feels like a hack, the key issue seems to me to be the choice of
> > > the API to present the GPS data to user space. Right?
> > 
> > Or even more fundamentally, does this belong in the kernel at all?
> 
> Yes, it does.

But not necessarily in its current form.

> > Now, if we'd ever have a proper GPS framework that handled everything in
> > kernel space (i.e. no more gpsd) then we would be able to write kernel
> > drivers that also take care of PM. But perhaps that's unlikely to ever
> > be realised given the state of things (proprietary protocols, numerous
> > quirky implementations, etc).
> 
> That is what needs to happen.
> 
> > The kernel is probably not the place to be working around issues like
> > that, even if serdev at least allows for such hacks to be fairly
> > isolated in drivers (unlike some of the earlier proposals touching core
> > code).
> 
> Oh, kernel is indeed right place to provide hardware abstraction --
> and that includes bug workarounds.

Right, at least when such hacks can be confined to a driver and not be
spread all over the place.

Johan
