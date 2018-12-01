Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F06C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AE421479
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFWK0+PF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AE421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeLBCai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbeLBCai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:30:38 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1069D20834;
        Sat,  1 Dec 2018 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543677473;
        bh=NGJlbQiwa9+fSsnEf1EOZn3darTjg47eXFSHEb+w8xM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qFWK0+PF9YuZIzoPT3Pu/huufXhGC3SR8RHlYtxCdN5PAjhV/mrEXJnoKuEiec/MB
         gYfEWaqbL42x8jf34wutX/NfT4k12yJwDgG4zvHEK8ZPNH5vQQWaeaG5uKiTfN0g6B
         1cOUCwDaZIok6jRjL8BiclKhZCcz0AnHpVR+ABlU=
Date:   Sat, 1 Dec 2018 15:17:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
Message-ID: <20181201151747.16522ff4@archlinux>
In-Reply-To: <a71bb89842260368353ebb66dff66b8f0583755b.camel@analog.com>
References: <20181121180443.tjgcpu2webrq53rh@smtp.gmail.com>
        <CAG4RSAHcEYj5bUpxT8apwXZZpWkPowFJ333tZiTHhb9VVn4m7g@mail.gmail.com>
        <1543316945.22768.35.camel@analog.com>
        <a71bb89842260368353ebb66dff66b8f0583755b.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 12:19:08 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2018-11-27 at 06:11 -0500, Popa, Stefan Serban wrote:
> > On Lu, 2018-11-26 at 17:24 -0200, Giuliano Belinassi wrote:
> > Hi, please see bellow
> >  =20
>=20
> One note from me here.
>=20
> > > Hi, thank you for the review
> > >  =20
> > > >=20
> > > > On Thu, 22 Nov 2018 11:01:00 +0000
> > > > "Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote: =20
> > > > >=20
> > > > > I think that instead of setting the gain directly, we should use
> > > > > the IIO_CHAN_INFO_SCALE attribute. At page 12 of the ad7780
> > > > > datasheet
> > > > > there
> > > > > is a formula from which the output code can be calculated:
> > > > > Code =3D 2^(N =E2=88=92 1)
> > > > > =C3=97 [(AIN =C3=97 Gain /VREF) + 1]. So, by setting the scale fr=
om user
> > > > > space,
> > > > > the
> > > > > driver can calculate the correct gain by using the formula above.
> > > > > Also, it
> > > > > would be useful to introduce scale available.
> > > > > Furthermore, there is a new
> > > > > ad7124 adc driver which does this exact thing. Take a look here:
> > > > > http
> > > > > s://gi
> > > > > thub.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/ad712=
4.
> > > > > c#
> > > > > L337. =20
> > >=20
> > > We have some questions about the code you provided to us:
> > >   1-) What is exactly the inputs for the write_raw function? =20
> >=20
> > In your write_raw() function you need to add IIO_CHAN_INFO_SCALE case.
> > Setting the scale from user space looks something like this: =20
> > root:/sys/bus/iio/devices/iio:device0> echo 0.000298 > in_voltage_scale=
 . =20
> > Furthermore, in your write_raw() function, val=3D0 and val2=3D298.
> > Knowing that full_scale_voltage =3D Vref / (gain * scale), we can calcu=
late
> > the gain =3D Vref / (full_scale_voltage * scale). We only support two g=
ains
> > (1 and 128), so we need to determine which one fits better with the
> > desired
> > scale. Finally, all we have left to do is to set the gain.=20
> >   =20
> > >   2-) Could you give more details about the math around lines 346-348?
> > > Is it correct to assume that the multiplication at line 346 won't
> > > overflow? (vref is an uint) =20
> >=20
> > It is correct that Vref is in microvolts, so for example, Vref of 2.5V =
 =3D
> > 2500000000uV. It won't overflow since we use the Vref as nominator, whi=
le
> > full_scale_voltage and scale are the denominators.
> >  =20
>=20
> [Regarding the AD7124] I guess I should be noted that the code can
> overflow, but in this case it shouldn't, because (according to the device
> datasheet) the maximum VREF can be 3600 mV.
> A user could specify (in the devicetree) something larger than 4300 mV (a=
nd
> that would overflow) but that would also make the readings useless as the
> external VREF would be invalid ; and there is also the risk of frying the
> chip in that case [something you really can't protect the user against].

Thanks Alex and Stefan for great detail here (glad you got to this before
I did ;)  One thing to add though is that if we have constraints like
this that would mess up the readings, it is sensible to check them
in the driver and at the very least put out a loud warning about the
problem, possibly even refuse to probe the driver.

The number of times I've spent hours chasing configuration problems
only to discover I was doing something stupid and the kernel silently
carried on regardlessly make me very keen on such commonsense protections.

I'm not going to review every driver to ensure they do this, but I'm keen
on them being checked where a possible problem has been identified!

Jonathan
>=20
> The internal VREF however is 2500 mV, so things should be fine from that
> point of view.
>=20
> Typically, in datasheets (at least from Analog Devices) it's good to take=
 a
> look at the specifications sections.
> [For AD7124] You will see that the internal VREF [page 8] is 2.5V (with
> approximation of +/-0.2%) and for external reference it goes all the way =
up
> to AVDD, which has typical values of 2.9V - 3.6V.
> So, for u32 this code should be fine and not overflow.
>=20
> One small thing that can be confusing about that code in AD7124 is that it
> gets multiplied with 1000000LL (which is signed long-long), but that shou=
ld
> be fine, since the operation should be converted to u32 (unsigned int)
> representation [by being assigned to vref], which ends up being fine in t=
he
> end.
>=20
> > >=20
> > > And regarding our code:
> > >   1-) The val in our write_raw function should be, in case of GAIN, a
> > > number that best approximate the actual gain value of 1 or 128? For
> > > instance, if the user inputs 126, we should default to 128? =20
> >=20
> > We should not allow the the user to input the gain, he needs to input t=
he
> > scale (see the mail from Jonathan and the above explanation). However, =
if
> > the calculated gain is one that is not supported, such as 126, we will
> > set
> > the closest matching value, in this case 128.
> >  =20
> > >   2-) In the case of FILTER, is it the same? Is the user sending the
> > > value in mHz (milihertz)? =20
> >=20
> > Yes, it is the same with the FILTER. You need to add
> > a IIO_CHAN_INFO_SAMP_FREQ case in your write_raw() function. From user
> > space, the input value should be in Hz, something like this: =20
> > root:/sys/bus/iio/devices/iio:device0> echo 10 > =20
> > in_voltage_sampling_frequency
> >  =20
> > >=20
> > > Thank you =20

