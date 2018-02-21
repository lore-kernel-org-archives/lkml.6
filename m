Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AH8x227Qe3cmrKOk8P5rdSwxKBgw+quuhfsDSZaX576LHQzkSZjc12RF43UotZEDwTcRGseQ/CJg
ARC-Seal: i=1; a=rsa-sha256; t=1519222980; cv=none;
        d=google.com; s=arc-20160816;
        b=cFfUB/TrBVjwpGVtLXY4sKAhoiLcRLf62cQAXzxAeC2P0nyf5ncxzTYGm2hssqWD0e
         9tA0mFBAxUea9ycku0y10pKP1Fj6S8Qdm4nb9iIkxjxSS+eRLvXmkQhDRg0LMVHcc/wn
         oB1mgR3K3ZE7/tgoz1Ngx061yMLBcqnj93nSxs8Q/rfgQcZs9ainv6DuVjoqYmS6j7Gx
         g/pGUGDFo/MHFTXy+Tjsy3aC+aCxXkDkhEwzxTk1W+uy9mrILPnOF0wbyIx4YKTED55R
         ycCq6rWvrqiuRE9TCybNAi5JjoHWqBiklD+KkkHJvsV0scn+G5bIrNpPaA12FPlHdd0Z
         AtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=kAL3ofeCArMWugAvZqueYjOEhyY1tMleUOIkUWUAKeA=;
        b=GrppHJfQ9Uh0/mKrXSPzbO6zSoqzLz4xU4Zc/zew1tLB0xAOkHHW3hisAzep3h1Vak
         U+oACMpU52FldG0ztKAvDWX5J+H91U41EFFM2kWrSf9oj+lWsBph+PMVwSSXl4s5xFHy
         JRAHRw2o/U35hWfOFM8W1DikdFLjLVsBmrRPa6Y82c9owgXoeDL5t7Y6Z47jUqBNT+CC
         aBgW+EDN0wqcB5yBcn8PaeyZOxvjJXd3unw2ngC/5YsApDCePe0d0j1AL2ca+0XUyMna
         zsI+8/Y/OCZdwgOvjgZKMn4hCOMBSYKI96mSdOxCNK/eMRysUtt3rOAQpxRVYav88YJA
         F6Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Wed, 21 Feb 2018 15:22:48 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang
 <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec
 <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta
 <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja
 Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka
 <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon
 <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares
 <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Message-ID: <20180221152248.5486100d@bbrezillon>
In-Reply-To: <20171219093643.GA3903@kroah.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<20171219085250.GC15010@kroah.com>
	<20171219100900.35c0f66e@bbrezillon>
	<20171219101336.337d0afc@bbrezillon>
	<20171219092119.GA32748@kroah.com>
	<20171219102858.001d4bf5@bbrezillon>
	<20171219093643.GA3903@kroah.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593020756592844196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Tue, 19 Dec 2017 10:36:43 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Dec 19, 2017 at 10:28:58AM +0100, Boris Brezillon wrote:
> > On Tue, 19 Dec 2017 10:21:19 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Tue, Dec 19, 2017 at 10:13:36AM +0100, Boris Brezillon wrote:  
> > > > On Tue, 19 Dec 2017 10:09:00 +0100
> > > > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> > > >     
> > > > > On Tue, 19 Dec 2017 09:52:50 +0100
> > > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > >     
> > > > > > On Thu, Dec 14, 2017 at 04:16:05PM +0100, Boris Brezillon wrote:      
> > > > > > > +/**
> > > > > > > + * i3c_device_match_id() - Find the I3C device ID entry matching an I3C dev
> > > > > > > + * @i3cdev: the I3C device we're searching a match for
> > > > > > > + * @id_table: the I3C device ID table
> > > > > > > + *
> > > > > > > + * Return: a pointer to the first entry matching @i3cdev, or NULL if there's
> > > > > > > + *	   no match.
> > > > > > > + */
> > > > > > > +const struct i3c_device_id *
> > > > > > > +i3c_device_match_id(struct i3c_device *i3cdev,
> > > > > > > +		    const struct i3c_device_id *id_table)
> > > > > > > +{
> > > > > > > +	const struct i3c_device_id *id;
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * The lower 32bits of the provisional ID is just filled with a random
> > > > > > > +	 * value, try to match using DCR info.
> > > > > > > +	 */
> > > > > > > +	if (!I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid)) {
> > > > > > > +		u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> > > > > > > +		u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> > > > > > > +		u16 ext_info = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> > > > > > > +
> > > > > > > +		/* First try to match by manufacturer/part ID. */
> > > > > > > +		for (id = id_table; id->match_flags != 0; id++) {
> > > > > > > +			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
> > > > > > > +			    I3C_MATCH_MANUF_AND_PART)
> > > > > > > +				continue;
> > > > > > > +
> > > > > > > +			if (manuf != id->manuf_id || part != id->part_id)
> > > > > > > +				continue;
> > > > > > > +
> > > > > > > +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> > > > > > > +			    ext_info != id->extra_info)
> > > > > > > +				continue;
> > > > > > > +
> > > > > > > +			return id;
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	/* Fallback to DCR match. */
> > > > > > > +	for (id = id_table; id->match_flags != 0; id++) {
> > > > > > > +		if ((id->match_flags & I3C_MATCH_DCR) &&
> > > > > > > +		    id->dcr == i3cdev->info.dcr)
> > > > > > > +			return id;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	return NULL;
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(i3c_device_match_id);        
> > > > > > 
> > > > > > I just picked one random export here, but it feels like you are
> > > > > > exporting a bunch of symbols you don't need to.  Why would something
> > > > > > outside of the i3c "core" need to call this function?      
> > > > > 
> > > > > Because I'm not passing the i3c_device_id to the ->probe() method, and
> > > > > if the driver is supporting different variants of the device, it may
> > > > > want to know which one is being probed.
> > > > > 
> > > > > I considered retrieving this information in the core just before probing
> > > > > the driver and passing it to the ->probe() function, but it means
> > > > > having an extra i3c_device_match_id() call for everyone even those who
> > > > > don't care about the device_id information, so I thought exporting this
> > > > > function was a good alternative (device drivers can use it when they
> > > > > actually need to retrieve the device_id).
> > > > > 
> > > > > Anyway, that's something I can change if you think passing the
> > > > > i3c_device_id to the ->probe() method is preferable.
> > > > >     
> > > > > > Have you looked
> > > > > > to see if you really have callers for everything you are exporting?      
> > > > > 
> > > > > Yes, I tried to only export functions that I think will be needed by
> > > > > I3C device drivers and I3C master drivers. Note that I didn't post the
> > > > > dummy device driver I developed to test the framework (partly because
> > > > > this is     
> > > > 
> > > > Sorry, I hit the send button before finishing my sentence :-).
> > > > 
> > > > "
> > > > Note that I didn't post the dummy device driver [1] I developed to test
> > > > the framework (partly because the quality of the code does not meet
> > > > mainline standards and I was ashamed of posting it publicly :-)), but
> > > > this driver is using some of the exported functions.
> > > > "    
> > > 
> > > We don't export functions that has no in-kernel users :)  
> > 
> > But then, I can't export device driver related functions, because
> > there's no official device driver yet :-). So what should I do?  
> 
> Export them when you have a driver.  Or better yet, submit a driver as
> part of the patch series.  Why would we want infrastructure that no one
> uses?

I understand your point of view, it may sound odd to add a framework
for a bus that we have no slave devices for. But, as far as I can tell,
many vendors (both IP vendors and sensor manufacturers) are working
actively on creating master and slave I3C devices. Actually, I've even
been contacted privately by an IP vendor after posting this patchset.
So, I think one argument for pushing the current framework with no
users yet is that it may help others develop drivers for their device
early on, or even help them test those devices more easily than if they
had to develop baremetal code.

The kernel community has been asking hardware vendors for a long time to
upstream their code as early as possible. And this is exactly what is
happening with I3C: even before actual devices are shipping, we have
the opportunity to start merging support for I3C in the mainline
kernel. It would be good to merge it before vendors spend time working
on competing implementations, which will take even more time to
reconcile when they will be submitted for upstream inclusion.

Also, we're not talking about some random bus/protocol, I3C spec is
developed and pushed by MIPI, and for once, they decided to open the
spec, so anyone can actually make sure the framework is matching the
protocol description if they want to.

Now, if you still think an I3C device driver is needed to consider
merging these patches, I can provide one. As I said earlier, I
developed a driver for a dummy device to test the various features I
add support for in this series, it's just that this device will never
ever be available in real life and it's not even fitting in any of the
subsystem we have in the kernel, hence my initial decision to not
upstream it.

Regards,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
