Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46E0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFCD2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5XXjmI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFCD2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeK1FIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:08:04 -0500
Received: from casper.infradead.org ([85.118.1.10]:56588 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeK1FIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ua8H6UU3jYjEv1ObkJcgmqyMo6pCP6bE58BHg3AYZcY=; b=d5XXjmI/ivSmvchHH6UsQT449E
        eokYVy2K5tYCmd7S2/2tpt5Kup+q9WBlPIrPX3JYkn1UJZ0wnl66PNSeExJjHL8/R59GDplcUS/8I
        4WhVWa8sp9Tzt3Ui4UrUylsaESN6WqkcFPoKlSHdvqRcYgDlW4DydK11n3BgpQmb1XCLDDleNzrm3
        0ww43tlRRXNfrbBCEsgteun/7nso4gOTKbSbbgXRbUNcUyGjEWfUHbTaPDehPoEZvlEnoYKyWk1P+
        gOTjuSL4RJHFDRJ5X+V6HqXS2AOIhRPovS/GqrW36w6GEj2efSJK2uoiWO5ZGb6t/qurMhNvu5oiw
        wtEDsUsQ==;
Received: from 177.17.130.159.dynamic.adsl.gvt.net.br ([177.17.130.159] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRhnQ-0003j2-JE; Tue, 27 Nov 2018 18:09:18 +0000
Date:   Tue, 27 Nov 2018 16:09:11 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     stakanov <stakanov@eclipso.eu>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ira Krufky <mkrufky@linuxtv.org>,
        Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>,
        Malcolm Priestley <tvboxspy@gmail.com>
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Message-ID: <20181127160911.2e4ba1fc@coco.lan>
In-Reply-To: <45396912.h74atscUxZ@roadrunner.suse>
References: <4e0356d6303c128a3e6d0bcc453ba1be@mail.eclipso.de>
        <1673172.qrKGPYx0fj@roadrunner.suse>
        <20181127104946.195487ec@coco.lan>
        <45396912.h74atscUxZ@roadrunner.suse>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 27 Nov 2018 16:58:58 +0100
stakanov <stakanov@eclipso.eu> escreveu:

> In data marted=C3=AC 27 novembre 2018 13:49:46 CET, Mauro Carvalho Chehab=
 ha=20
> scritto:
> > Hi Stakanov,
> >=20
> > Em Tue, 27 Nov 2018 11:02:57 +0100
> >=20
> > stakanov <stakanov@eclipso.eu> escreveu:
> > > In data luned=C3=AC 26 novembre 2018 14:31:09 CET, Takashi Iwai ha sc=
ritto:
> > > > On Fri, 23 Nov 2018 18:26:25 +0100,
> > > >=20
> > > > Mauro Carvalho Chehab wrote:
> > > > > Takashi,
> > > > >=20
> > > > > Could you please produce a Kernel for Stakanov to test
> > > > > with the following patches:
> > > > >=20
> > > > > https://patchwork.linuxtv.org/patch/53044/
> > > > > https://patchwork.linuxtv.org/patch/53045/
> > > > > https://patchwork.linuxtv.org/patch/53046/
> > > > > https://patchwork.linuxtv.org/patch/53128/
> > > >=20
> > > > Sorry for the late reaction.  Now it's queued to OBS
> > > > home:tiwai:bsc1116374-2 repo.  It'll be ready in an hour or so.
> > > > It's based on 4.20-rc4.
> > > >=20
> > > > Stakanov, please give it a try later.
> > > >=20
> > > >=20
> > > > thanks,
> > > >=20
> > > > Takashi
> > >=20
> > > O.K. this unbricks partially the card.
> >=20
> > From the logs, the Kernel is now working as expected.
> >=20
> > > Now hotbird does search and does sync
> > > on all channels. Quality is very good. Astra still does interrupt the
> > > search immediately and does not receive a thing. So it is a 50% brick
> > > still, but it is a huge progress compared to before.
> >=20
> > As I said before, you need to tell Kaffeine what's the LNBf that you're
> > using. The LNBf is a physical device[1] that it is installed on your
> > satellite dish. There's no way to auto-detect the model you actually ha=
ve,
> > so you need to provide this information to the digital TV software you'=
re
> > using.
> >=20
> > [1] It looks like this:
> > 	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Astra_lnb.jp=
g/
> 240
> > px-Astra_lnb.jpg
> >=20
> > The "Universal" one is for an old universal model sold in Europe about
> > 15 years ago. It doesn't support all transponders found on an Astra
> > satellite.
> >=20
> > For those, you need to use the LNBf that it is known as "Astra 1E"[2].
> >=20
> > [2] The name is there just for historical reasons. The actual Astra 1E
> > satellite was retired, but another satellite occupies the same orbital
> > position (19.2=C2=B0E), and they keep adding/retiring satellites there =
as
> > needed (https://en.wikipedia.org/wiki/Astra_19.2%C2%B0E).
> >=20
> > As I pointed you on a past e-mail, when you set the DVB-S board on
> > Kaffeine, you should have explicitly set it.
> >=20
> > If you start Kaffeine in English:
> >=20
> > 	$ LANG=3DC kaffeine
> >=20
> > You'll see it at the following menu:
> >=20
> > 	Television -> Configure Television -> Device 0
> >=20
> > (assuming that your device is device 0)
> >=20
> > There, you need to tell that you'll be using a DiSEqC swith. It
> > will then allow you to select up to 4 satellite sources. Once you
> > set a source, it will allow you to edit the LNB <n> Settings
> > (where <n> will be 1 to 4). Clicking there, it will present you
> > a menu with all known LNBf models. Astra 1E is the third option[3].
> >=20
> > [3] yeah, on a separate discussion, we should likely rename "Astra 1E"
> > to just "Astra", and place it as the first option. I'll do such change,
> > but it will be at v4l-utils package (libdvbv5) and it will probably
> > take some time until distros start packaging the new version, even
> > if we add it to the stable branch.
> >=20
> > > I paste the output of the directory below, unfortunately the opensuse
> > > paste
> > > does not work currently so I try here, sorry if this is long.
> > >=20
> > > Content of the directory 99-media.conf created following the indicati=
ons
> > > (please bear in mind that I have also another card installed (Hauppau=
ge
> > > 5525) although it was not branched to the sat cable and i did change =
the
> > > settings in Kaffeine to use only the technisat. But my understanding =
is
> > > limited if this may give "noise" in the output, so I thought to under=
line
> > > it, just FYI.
> > > Output:
> > Looks ok to me.
> >=20
> > > [  649.009548] cx23885 0000:03:00.0: invalid short VPD tag 01 at offs=
et 1
> > > [  649.011439] r8169 0000:06:00.0: invalid short VPD tag 00 at offset=
 1
> >=20
> > Those two above are weird... It seems to be related to some issue that
> > the PCI core detected:
> >=20
> > drivers/pci/vpd.c:                      pci_warn(dev, "invalid %s VPD t=
ag
> > %02x at offset %zu",
> >=20
> > I've no idea what they mean, nor if you'll face any issues related to i=
t.
> >=20
> > Thanks,
> > Mauro
> The two are known annoyances especially the cx23885 complaining in the lo=
gs=20
> about a "wrong revision". But as they AFAIK do not cause major issues or=
=20
> havoc, it is not a problem, at least for me.=20

Ok, good!

> Now, the card suddenly works. The only thing you have to do (limited to t=
his=20
> technisat PCI card, not applicable to the Hauppauge PCI-e mounted on the =
same=20
> machine) is to set the "square" to high voltage, limited for Astra. Hotbi=
rd=20
> scans better without this, with "no setting send" as I do for the Hauppau=
ge as=20
> well.=20
> This must be something weird related to our sat dish.

That setting is needed if you have a longer cabling, thinner wiring or
loses at the connectors. Not really an issue. Just a setup that makes the
DVB card to use a higher voltage when powering up the LNBf and switching
the polarization, in order to compensate for cable loses.

>=20
> But the GOOD news is: yes now you made it! The card works. And yes, you s=
hould=20
> really rename ASTRA E setting. Maybe also be more clear or give some hint=
 in=20
> kaffeine when hovering over it, about how to set it, for some reason it c=
ame=20
> straightforward to me to click on the right radio button to select the ty=
pe of=20
> satellite,  but I did not understand, nor did suspect, I would be able to=
 set,=20
> or that I would have to set the left button (must be a cultural deformati=
on,=20
> or whatever). Once you told me about I did find it, but in my very limite=
d=20
> experience, I think that could be enhanced.

Just pushed a patch renaming it. That patch will make Astra the default on
Kaffeine too:

	https://patchwork.linuxtv.org/patch/53172/

It is for the DVB library used by Kaffeine.
>=20
> So congratulations. It works and now I am officially even more impressed =
about=20
> Linux and the spirit behind it. Compliments and thank you all for your wo=
rk=20
> and time!
>=20
> Regards.=20
>=20
>=20
>=20
> _________________________________________________________________
> ________________________________________________________
> Ihre E-Mail-Postf=C3=A4cher sicher & zentral an einem Ort. Jetzt wechseln=
 und alte E-Mail-Adresse mitnehmen! https://www.eclipso.de
>=20
>=20



Thanks,
Mauro
