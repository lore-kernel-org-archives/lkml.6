Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75313C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4BA2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lJuX+Wio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4BA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeK0Xrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:47:48 -0500
Received: from casper.infradead.org ([85.118.1.10]:47284 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeK0Xrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aYWh99saGVkxjqDit2oXLnW5SuBB9djXEKD+sXhnF3g=; b=lJuX+Wio4Sr0ZgvKNJnStIw1DX
        O9HnLv94265qBq5nhs+rBaGETxk8AR6tp3l2/a1pRYowwUbIQr4UZUCTfcRm4jDOHeg+HtQJjymG+
        +T8EfGOXHINhqJQN2moFFOT+jO8ACh2NLOCqwLQII1Slkhb4ajFn22b6zjQ0kutudW//AeG5aiLLd
        DOfVHCxIMFwOn59W9ck9zlSyWo76OqK5sbbs0bG3z4RPDGVDfywADETdZd4c02+rfvBTXU5czbtr3
        pirW9U9WIuwt7F83aCHvTKgTldUjJ974Wd5cMrmiNx4gYCipTIc4VsD3/d+A17xd6Me7OTWJIppE7
        1lLbMfjg==;
Received: from 177.133.7.55.dynamic.adsl.gvt.net.br ([177.133.7.55] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRcoL-0004Mc-8Q; Tue, 27 Nov 2018 12:49:53 +0000
Date:   Tue, 27 Nov 2018 10:49:46 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     stakanov <stakanov@eclipso.eu>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ira Krufky <mkrufky@linuxtv.org>,
        Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>,
        Malcolm Priestley <tvboxspy@gmail.com>
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Message-ID: <20181127104946.195487ec@coco.lan>
In-Reply-To: <1673172.qrKGPYx0fj@roadrunner.suse>
References: <4e0356d6303c128a3e6d0bcc453ba1be@mail.eclipso.de>
        <20181123152625.7992ceb4@coco.lan>
        <s5hsgzoynhe.wl-tiwai@suse.de>
        <1673172.qrKGPYx0fj@roadrunner.suse>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stakanov,

Em Tue, 27 Nov 2018 11:02:57 +0100
stakanov <stakanov@eclipso.eu> escreveu:

> In data luned=C3=AC 26 novembre 2018 14:31:09 CET, Takashi Iwai ha scritt=
o:
> > On Fri, 23 Nov 2018 18:26:25 +0100,
> >=20
> > Mauro Carvalho Chehab wrote: =20
> > > Takashi,
> > >=20
> > > Could you please produce a Kernel for Stakanov to test
> > > with the following patches:
> > >=20
> > > https://patchwork.linuxtv.org/patch/53044/
> > > https://patchwork.linuxtv.org/patch/53045/
> > > https://patchwork.linuxtv.org/patch/53046/
> > > https://patchwork.linuxtv.org/patch/53128/ =20
> >=20
> > Sorry for the late reaction.  Now it's queued to OBS
> > home:tiwai:bsc1116374-2 repo.  It'll be ready in an hour or so.
> > It's based on 4.20-rc4.
> >=20
> > Stakanov, please give it a try later.
> >=20
> >=20
> > thanks,
> >=20
> > Takashi =20
>=20
> O.K. this unbricks partially the card.

=46rom the logs, the Kernel is now working as expected.=20

> Now hotbird does search and does sync=20
> on all channels. Quality is very good. Astra still does interrupt the sea=
rch=20
> immediately and does not receive a thing. So it is a 50% brick still, but=
 it=20
> is a huge progress compared to before.=20

As I said before, you need to tell Kaffeine what's the LNBf that you're
using. The LNBf is a physical device[1] that it is installed on your satell=
ite
dish. There's no way to auto-detect the model you actually have, so you
need to provide this information to the digital TV software you're using.

[1] It looks like this:
	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Astra_lnb.jpg/24=
0px-Astra_lnb.jpg

The "Universal" one is for an old universal model sold in Europe about
15 years ago. It doesn't support all transponders found on an Astra
satellite.

For those, you need to use the LNBf that it is known as "Astra 1E"[2].

[2] The name is there just for historical reasons. The actual Astra 1E
satellite was retired, but another satellite occupies the same orbital
position (19.2=C2=B0E), and they keep adding/retiring satellites there as=20
needed (https://en.wikipedia.org/wiki/Astra_19.2%C2%B0E).

As I pointed you on a past e-mail, when you set the DVB-S board on
Kaffeine, you should have explicitly set it.

If you start Kaffeine in English:

	$ LANG=3DC kaffeine

You'll see it at the following menu:

	Television -> Configure Television -> Device 0
=09
(assuming that your device is device 0)

There, you need to tell that you'll be using a DiSEqC swith. It
will then allow you to select up to 4 satellite sources. Once you
set a source, it will allow you to edit the LNB <n> Settings
(where <n> will be 1 to 4). Clicking there, it will present you
a menu with all known LNBf models. Astra 1E is the third option[3].

[3] yeah, on a separate discussion, we should likely rename "Astra 1E"
to just "Astra", and place it as the first option. I'll do such change,
but it will be at v4l-utils package (libdvbv5) and it will probably
take some time until distros start packaging the new version, even
if we add it to the stable branch.

> I paste the output of the directory below, unfortunately the opensuse pas=
te=20
> does not work currently so I try here, sorry if this is long.=20
>=20
> Content of the directory 99-media.conf created following the indications=
=20
> (please bear in mind that I have also another card installed (Hauppauge 5=
525)=20
> although it was not branched to the sat cable and i did change the settin=
gs in=20
> Kaffeine to use only the technisat. But my understanding is limited if th=
is=20
> may give "noise" in the output, so I thought to underline it, just FYI.=20
> Output:

Looks ok to me.

> [  649.009548] cx23885 0000:03:00.0: invalid short VPD tag 01 at offset 1
> [  649.011439] r8169 0000:06:00.0: invalid short VPD tag 00 at offset 1

Those two above are weird... It seems to be related to some issue that
the PCI core detected:

drivers/pci/vpd.c:                      pci_warn(dev, "invalid %s VPD tag %=
02x at offset %zu",

I've no idea what they mean, nor if you'll face any issues related to it.

Thanks,
Mauro
