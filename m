Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELtlLPmdPQpU5jmFPoHonpq3mTlNLwyTTt0Wo63upXlM3Y46nBJCpLUme50/qcDAvBHOW2y+
ARC-Seal: i=1; a=rsa-sha256; t=1520694651; cv=none;
        d=google.com; s=arc-20160816;
        b=jSsm80bD7QhyZywwZWVjAwoPCj6wYx6bBVzI+MHXvR/rpg/bJwO3ZSCjhFmSkp0+Sb
         ooH579IzAcR0FrlECOREG4y/9vBb1kRRVfFaxnT1sqp42EiYB4fHkcDiaYe3FLvPfJEW
         SvEQsOzqmiTxL1CWGAfSqQtioOYRJmxJkjSOBADPIIL8oc2ecSio8KhTIIhLis0hv6IG
         O5IuVOuz2hU7bH7nptABY/BN1wCzM61nRup/pVWJg/3iUwh7bCIeivKzAtT6c/oMoKFo
         KJBkgQX781f50pguMYJfkazSJ797r08aXfgaNZfoYmgdnheovsgScNlKv/AiA/CJgFfr
         +jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=tkggtEhTV5UluDZ/jWcYyVkulj4AE52+ZGU9+6i7rvM=;
        b=swsudo54eNMVyFZP65trdUJ6px/sslYWrazakjRnKNzqJTKbWaZ18zrzBfLFI+L0fy
         /hjkgD+afPa6bueqHX7ty2VK02w9sbxFmbfLUBmzOVmZt2D37TeTDh168wmVfG2tieZQ
         oNFtlhZmiSJIlydPGV5AGX2oy2MuRqoXoVFsNfl20p+nu/x2VBn29pT60iQTCVM+eso1
         3RYuG/lZzLiUm1LwbHSZoF1z3x9nNr8UPwRAFAZcMv6wwro/a3/3QwwsR71Sw2Jg7a49
         gwvOKXhkKKtv+/GR76dyR8nKuTp/7yGPxzj6NzB8SMPfqobufxTdVFCO1/vRFXLzFKq3
         ewEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA238208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 15:10:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, daniel.baluta@nxp.com,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF
 by IIO_DEVICE_ATTR
Message-ID: <20180310151045.4570e85d@archlinux>
In-Reply-To: <20180309003733.aichruo53vqryafg@smtp.gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
	<3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
	<20180307200730.08ed3c2f@archlinux>
	<20180309003733.aichruo53vqryafg@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594237578169642590?=
X-GMAIL-MSGID: =?utf-8?q?1594563914725114380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 8 Mar 2018 21:37:33 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> On 03/07, Jonathan Cameron wrote:
> > On Tue, 6 Mar 2018 21:43:47 -0300
> > Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> >   
> > > The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, with a
> > > tiny change in the name definition. This extra macro does not improve
> > > the readability and also creates some checkpatch errors.
> > > 
> > > This patch fixes the checkpatch.pl errors:
> > > 
> > > staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) not
> > > decimal permissions
> > > staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) not
> > > decimal permissions
> > > staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) not
> > > decimal permissions
> > > staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) not
> > > decimal permissions
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>  
> > 
> > Hmm. I wondered a bit about this one. It's a correct patch in of
> > itself but the interface in question doesn't even vaguely conform
> > to any of defined IIO ABI.  Anyhow, it's still and improvement so
> > I'll take it.  
> 
> I am not sure if I understood the comment about the ABI. The meter
> interface is wrong because it uses things like IIO_DEVICE_ATTR? It
> should use iio_info together with *write_raw and *read_raw. Right? Is it
> the ABI problem that you refer?
The ABI is about the userspace interface of IIO.  It is defined
in Documentation/ABI/testing/sysfs-bus-iio*
So this documents the naming of sysfs attributes and (more or less)
describes a consistent interface to userspace across lots of different
types of devices.

A lot of these older drivers in staging involve a good deal of ABI that
was not reviewed or discussed.  That is one of the biggest reasons we
didn't take them out of staging in the first place.

In order for generic userspace programs to have any idea what to do
with these devices this all needs to be fixed.

There may well be cases where we need to expand the existing ABI to
cover new things.   That's fine, but it has to be done with full
review of the relevant documentation patches.

Incidentally if you want an easy driver to work on moving out of staging
then first thing to do is to compare what it shows to userspace with these
docs.  If it's totally different then you have a big job on your hands
as often ABI can take a lot of discussion and a long time to establish
a consensus.

Jonathan


> 
> Thanks :)
>  
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to play with it.
> > 
> > I also added the removal of the header define which is no
> > longer used.
> > 
> > Please note, following discussions with Michael, I am going to send
> > an email announcing an intent to drop these meter drivers next
> > cycle unless someone can provide testing for any attempt to
> > move them out of staging.  I'm still taking patches on the basis
> > that 'might' happen - but I wouldn't focus on these until we
> > have some certainty on whether they will be around long term!
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
> > >  drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
> > >  2 files changed, 20 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> > > index c44eb577dc35..275e8dfff836 100644
> > > --- a/drivers/staging/iio/meter/ade7753.c
> > > +++ b/drivers/staging/iio/meter/ade7753.c
> > > @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
> > >  		ade7753_read_16bit,
> > >  		NULL,
> > >  		ADE7753_PERIOD);
> > > -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> > > -		ade7753_read_8bit,
> > > -		ade7753_write_8bit,
> > > -		ADE7753_CH1OS);
> > > -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> > > -		ade7753_read_8bit,
> > > -		ade7753_write_8bit,
> > > -		ADE7753_CH2OS);
> > > +
> > > +static IIO_DEVICE_ATTR(choff_1, 0644,
> > > +			ade7753_read_8bit,
> > > +			ade7753_write_8bit,
> > > +			ADE7753_CH1OS);
> > > +
> > > +static IIO_DEVICE_ATTR(choff_2, 0644,
> > > +			ade7753_read_8bit,
> > > +			ade7753_write_8bit,
> > > +			ADE7753_CH2OS);
> > >  
> > >  static int ade7753_set_irq(struct device *dev, bool enable)
> > >  {
> > > diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> > > index 1decb2b8afab..c078b770fa53 100644
> > > --- a/drivers/staging/iio/meter/ade7759.c
> > > +++ b/drivers/staging/iio/meter/ade7759.c
> > > @@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
> > >  		ade7759_read_16bit,
> > >  		ade7759_write_16bit,
> > >  		ADE7759_APGAIN);
> > > -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> > > -		ade7759_read_8bit,
> > > -		ade7759_write_8bit,
> > > -		ADE7759_CH1OS);
> > > -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> > > -		ade7759_read_8bit,
> > > -		ade7759_write_8bit,
> > > -		ADE7759_CH2OS);
> > > +
> > > +static IIO_DEVICE_ATTR(choff_1, 0644,
> > > +			ade7759_read_8bit,
> > > +			ade7759_write_8bit,
> > > +			ADE7759_CH1OS);
> > > +
> > > +static IIO_DEVICE_ATTR(choff_2, 0644,
> > > +			ade7759_read_8bit,
> > > +			ade7759_write_8bit,
> > > +			ADE7759_CH2OS);
> > >  
> > >  static int ade7759_set_irq(struct device *dev, bool enable)
> > >  {  
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
