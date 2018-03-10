Return-Path: <jic23@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3601762-1520704763-2-4994720523398997666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jic23@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520704762; b=svR60mcz9sb8o+s6h9gBpitMumJqQHmwwuUwbdhnhO+fBmH
    Jo8pQuyGYqqVmicAH5wU6kdDurERqDl2/sy4225pv3aQGi6dUJzHWo5NTe6B+QYE
    Ik1Ah/K9SYz8LO3BQcUaVquwVK9q73t9I9ZS+FQzmvF0N8+GsQ4D5cSWrU4qnmUk
    IxbgOMH732+q1M4n+fZhALl67KegWTIZ4Td90LEnkLkdR4A8dnsPy16TnUvYzGra
    HF0DF6k3PJ4JB8eKmzeyDsV51qC0/U1GYLVVPjls2KVbYmM3WKqiPKvhMP/whBpZ
    AVUZh1BhjXa2FlhvxLUnQ8km43IbGUQN+uJDbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding; s=arctest; t=1520704762; bh=uI9eeHvb
    AcbR/RBkVbkSLC9wHudhMGAYPtrHqj4I6VE=; b=uts3+yvFLlvmXdtPPwdvWV2A
    WTjVTab9d1TftBq78Hkkh0e5249Epdh9GomhHJDy74+8wTkuDcfJh+Svyl2Vgf+i
    luT5QHKsdM7q8h51grv09DMMgREPFFOrvx9IIeSMcUdMNvnuxUGN4Z41H8bEmt/8
    RO6QpghVvwiJMuucE3WPiS5rkZtnbU7HRO9NDRtk9FxaVCSbTyrs7SuYigy27yxv
    h9BVM39y6ZiNBbm+89ol0KS0LeIQMKae+gjF6ITDkzP/d3okGJjSILCVGENJeWb2
    5dHscUt8S4rCSosG+fXyhKmOKXe3g16MNPbskx0vNt116Xv2BKpVwYpAS8FegQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=jic23@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=jic23@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA72E21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 17:59:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Greg KH <greg@kroah.com>,
 akinobu.mita@gmail.com, javier@osg.samsung.com, gregor.boirie@parrot.com,
 pali.rohar@gmail.com, sre@kernel.org, kernel list
 <linux-kernel@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org,
 tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi,
 ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
 abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
 sakari.ailus@linux.intel.com, Filip =?UTF-8?B?TWF0aWpldmnEhw==?=
 <filip.matijevic.pz@gmail.com>, security@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
Message-ID: <20180310175911.292dcf0c@archlinux>
In-Reply-To: <20180310120053.GB31614@amd>
References: <20180309221220.GA15272@amd>
	<20180309222821.GA16973@kroah.com>
	<20180309230124.GA17721@amd>
	<1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
	<20180310120053.GB31614@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Mar 2018 13:00:53 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> On Sat 2018-03-10 12:19:29, Lars-Peter Clausen wrote:
> > On 03/10/2018 12:01 AM, Pavel Machek wrote:
> > [...]  
> > >> What file are you opening to cause this?  
> > > 
> > > Strace says:
> > > 
> > > openat(7, "in_intensity_both_thresh_rising_en",  
> > >>> O_RDONLY|O_LARGEFILE|O_NOFOLLOW) = 3  
> > > fstat64(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
> > > ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) = -1 ENOTTY  
> > >>> (Inappropriate ioctl for device)  
> > > read(3,
> > > Message from syslogd@localhost at Mar  9 23:54:39 ...
> > >  kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM
> > > 
> > > So that would be:
> > > 
> > > ./devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/events/in_intensity_both_thresh_rising_en
> > > 
> > > And indeed, manually cat-ing that file reproduces the problem.
> > > 
> > > pavel@n900:/sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1$
> > > cat name
> > > tsl2563
> > > 
> > > I can not find tsl2563 in MAINTAINERS, file is
> > > ./drivers/iio/light/tsl2563.c . I added few people pointed by git log.  
> > 
> > The driver registers event attributes, but does not provide a handle to
> > access those attributes.
> > 
> > Now the question is how to best handle this case.
> > 
> > 1) Return an error when the device is registered and abort registration
> > 2) Skip registering the event attributes
> > 3) Skip registering the event attributes, but print a warning
> > 4) Register the attributes, but return an error when they are accessed
> > 
> > I'd prefer 2 since it offers a nice method of disabling all events for a
> > device (e.g. if not interrupt is provided).  
> 
> 2 works for me.
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> 
> Now grep -ri asdfasdf /sys finishes.

Hmm. I'd count this as a good general prevention of what is actually
a driver bug.  The driver should either have failed or as has been suggested
should have come up without the event sysfs attributes by registering different
abilities.

So I'm favour of this change, but from a semantic point of view I'd
like the addition of a warning for this case and ideally for the driver
to be fixed to not attempt to add them (two iio_info structures which
is what a lot of other drivers do to allow them to work with and
without the interrupt being available.).

Anyhow, Lars, please send a formal patch for the below and we'll
get that headed for mainline asap.

> 
> Thanks,
> 								Pavel
> 
> > --- a/drivers/iio/industrialio-event.c
> > +++ b/drivers/iio/industrialio-event.c
> > @@ -477,7 +477,8 @@ int iio_device_register_eventset(struct iio_dev
> >  	struct attribute **attr;
> > 
> >  	if (!(indio_dev->info->event_attrs ||
> > -	      iio_check_for_dynamic_events(indio_dev)))
> > +	      iio_check_for_dynamic_events(indio_dev)) ||
> > +	    !indio_dev->info->read_event_config)
> >  		return 0;
> > 
> >  	indio_dev->event_interface =  
> 
