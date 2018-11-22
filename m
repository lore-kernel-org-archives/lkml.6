Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B384FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A820672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPwdDobX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0A820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405915AbeKWC7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:59:18 -0500
Received: from casper.infradead.org ([85.118.1.10]:59254 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392027AbeKWC7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zVpGCxQkCuqqxxBqN/r6t1qB2KV38qGFsNbibAu3vds=; b=JPwdDobXttezkYdC+obVV8AcA8
        t96xuP7fDYCo4R9s0hGIxyAM5VePZR94cU9aSHg+Kml11kCZAevagEvuENllA0MeeNNdhNVVIe/y7
        czT8v6+DV407XfBk1OCZGkn600a2hUSdwJ3QMfLUSJkppJisx3p+TiPueb26sE4U4+MwgPZHUxCLx
        iFklxun4tW2SWeE52uFnY5hZr0632MzGJ9DaDJFfFjx5ddLqK8wIYaGzwdHg4cEQycouc6UEvsZaL
        e9bqnIeYC/5GHfCJ1+OnXPim65snVzq3ySldUANNwYtwU5IqbK0qNVvbSgwKiQUhxX6jZWT3ZNsNZ
        JXJN+VVg==;
Received: from 201.47.163.210.dynamic.adsl.gvt.net.br ([201.47.163.210] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPrhA-0005uL-Lg; Thu, 22 Nov 2018 16:19:13 +0000
Date:   Thu, 22 Nov 2018 14:19:08 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     stakanov <stakanov@eclipso.eu>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Message-ID: <20181122141908.1ef2bcae@coco.lan>
In-Reply-To: <20181120140855.29f5dc3f@coco.lan>
References: <4e0356d6303c128a3e6d0bcc453ba1be@mail.eclipso.de>
        <20181120104217.5b487bcd@coco.lan>
        <1593929.t9Y74Rdlh1@roadrunner.suse>
        <20181120140855.29f5dc3f@coco.lan>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stakanov,

Em Tue, 20 Nov 2018 14:08:55 -0200
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> Em Tue, 20 Nov 2018 14:20:01 +0100
> stakanov <stakanov@eclipso.eu> escreveu:
>=20
> > In data marted=C3=AC 20 novembre 2018 13:42:17 CET, Mauro Carvalho Cheh=
ab ha=20
> > scritto: =20
> > > Em Tue, 20 Nov 2018 13:11:58 +0100
> > >=20
> > > "Stakanov Schufter" <stakanov@eclipso.eu> escreveu:   =20
> > > > Sorry for the delay. Apparently my smtp exits are blocking me (for
> > > > whatever reason). I am trying now via web mailer.
> > > >=20
> > > >=20
> > > > In short, no it does not work. Only EPG, no pic no sound.
> > > > But the error message in dmesg is gone I think.
> > > >=20
> > > > uname -a
> > > > Linux silversurfer 4.20.0-rc3-2.gfe5d771-default #1 SMP PREEMPT Tue=
 Nov 20
> > > > 09:35:04 UTC 2018 (fe5d771) x86_64 x86_64 x86_64 GNU
> > > >=20
> > > > dmesg:
> > > >=20
> > > > [    6.412792] b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV re=
ceiver
> > > > chip loaded successfully
> > > > [    6.416645] flexcop-pci: will use the HW PID filter.
> > > > [    6.416648] flexcop-pci: card revision 2
> > > > [    6.423749] scsi host10: usb-storage 9-3.1:1.0
> > > > [    6.423842] usbcore: registered new interface driver usb-storage
> > > > [    6.426029] usbcore: registered new interface driver uas
> > > > [    6.439251] dvbdev: DVB: registering new adapter (FlexCop Digita=
l TV
> > > > device)
> > > > [    6.440845] b2c2-flexcop: MAC address =3D 00:d0:d7:11:8b:58
> > > >=20
> > > > [    6.694999] dvb_pll_attach: delsys: 0, frequency range:
> > > > 950000000..2150000000
> > > > [    6.695001] b2c2-flexcop: found 'ST STV0299 DVB-S' .
> > > > [    6.695004] b2c2_flexcop_pci 0000:06:06.0: DVB: registering adap=
ter 0
> > > > frontend 0 (ST STV0299 DVB-S)...
> > > > [    6.695050] b2c2-flexcop: initialization of 'Sky2PC/SkyStar 2 DV=
B-S rev
> > > > 2.6' at the 'PCI' bus controlled by a 'FlexCopIIb' complete   =20
> > >=20
> > > Well, the Kernel bug is probably gone. I don't see any other recent
> > > changes that would be affecting the b2c2 flexcop driver.
> > >=20
> > > If you're successfully getting EPG data from the transponders, then it
> > > should also be receiving audio and video channels too, as, for the Ke=
rnel,
> > > there's no difference if a given program ID (PID) contains EPG, audio=
 or
> > > video.
> > >=20
> > > At the BZ, you're saying that you're using Kaffeine, right?
> > >=20
> > > There are a few reasons why you can't watch audio/video, but you're
> > > able to get EPG tables:
> > >=20
> > > 	- the audio/video PID had changed;
> > > 	- the audio/video is now encrypted;
> > > 	- too weak signal (or bad cabling).
> > >=20
> > > The EPG data comes several times per second on well known PIDs, via a=
 low
> > > bandwidth PID and it is not encrypted. So, it is usually trivial to g=
et
> > > it.
> > >=20
> > > I suggest you to re-scan your channels on Kaffeine, in order to force
> > > it to get the new PIDs. Also, please check that the channels you're
> > > trying to use are Free to the Air (FTA).
> > >=20
> > > You can also use libdvbv5 tools in order to check if you're not
> > > losing data due to weak signal/bad cabling. The newer versions
> > > of dvbv5-zap have a logic with detects and report data loses, when
> > > started on monitor mode (-m command line option). It also prints
> > > the transponder bandwidth, and check what PIDs are received.
> > >=20
> > > It is very useful to debug problems.
> > >=20
> > > Thanks,
> > > Mauro   =20
> >=20
> > I checked again and:
> > [sudo] password di root:=20
> > [    6.412792] b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiv=
er chip=20
> > loaded successfully
> > [    6.440845] b2c2-flexcop: MAC address =3D 00:d0:d7:11:8b:58
> > [    6.695001] b2c2-flexcop: found 'ST STV0299 DVB-S' .
> > [    6.695004] b2c2_flexcop_pci 0000:06:06.0: DVB: registering adapter =
0=20
> > frontend 0 (ST STV0299 DVB-S)...
> > [    6.695050] b2c2-flexcop: initialization of 'Sky2PC/SkyStar 2 DVB-S =
rev=20
> > 2.6' at the 'PCI' bus controlled by a 'FlexCopIIb' complete
> > [ 6265.403360] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=
=20
> > frequency 10719000 out of range (950000..2150000)
> > [ 6265.405702] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=
=20
> > frequency 10723000 out of range (950000..2150000)
> > [ 6265.407120] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=
=20
> > frequency 10757000 out of range (950000..2150000)
> > [ 6265.408556] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=
=20
> > frequency 10775000 out of range (950000..2150000)
> > [ 6265.409754] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=
=20
> > frequency 10795000 out of range (950000..2150000)
> > [ 6399.837806] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=
=20
> > frequency 12713000 out of range (950000..2150000)
> > [ 6399.839144] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=
=20
> > frequency 12731000 out of range (950000..2150000) =20
>=20
> Ok. Now, min/max frequencies are at the same scale. For DVB-S,=20
> dvb_frontend_get_frequency_limits() returns both in kHz, so the frequency
> range is now OK.
>=20
> The tuning frequency is wrong through. 10,719,000 kHz - e. g. 10,719 MHz
> seems to be the transponder frequency you're trying to tune, and not the
> intermediate frequency used at the DVB-S board.
>=20
> That sounds to me either a wrong LNBf setting or a bug at libdvbv5 or
> at Kaffeine's side. What happens is that the typical European LNBFs are:
>=20
> 1) the "old" universal one:
>=20
> UNIVERSAL
> 	Universal, Europe
> 	Freqs     : 10800 to 11800 MHz, LO: 9750 MHz
> 	Freqs     : 11600 to 12700 MHz, LO: 10600 MHz
>=20
> 2) the "new" universal one, with seems to be used by most modern
> satellite dishes in Europe nowadays:
>=20
> EXTENDED
> 	Astra 1E, European Universal Ku (extended)
> 	Freqs     : 10700 to 11700 MHz, LO: 9750 MHz
> 	Freqs     : 11700 to 12750 MHz, LO: 10600 MHz
>=20
> Assuming that your satellite dish is equipped with an Astra-1E compatible
> LNBf, as you're trying to tune 10,719 MHz, you need to setup Kaffeine
> to use the EXTENDED LNBf, with covers the extended frequency range.
>=20
> Kaffeine/libdvbv5 will subtract this value from the LO frequency:
>=20
> 	10719 MHz - 9750 MHz =3D 969 MHz
>=20
> And pass the 969 MHz frequency for the Kernel to tune. As this
> is between the 950MHz..2150MHz limit, it won't produce any Kernel
> messages.
>=20
> Please notice that there were some bugs at v4l-utils and DVB-S/S2,
> so be sure to check the v4l-utils version you're using. The last
> one is 1.14.2 (released on Feb, 10 2018). I recommend you to have
> at least version 1.12.4 (released on May, 6 2017).

Did it work after using the EXTENDED LNBf on Kaffeine?


Thanks,
Mauro
