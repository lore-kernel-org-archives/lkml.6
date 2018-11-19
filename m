Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5916C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B2F20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LzZBnrss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B2F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeKTJex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:34:53 -0500
Received: from casper.infradead.org ([85.118.1.10]:41820 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbeKTJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mNPrxFplk3fQvtntwXvn6IitRLf+dvH9PsgvUwmY5F0=; b=LzZBnrss/9GX3hgZGFDdkD/28x
        6Fle7oCVSxiYfIzHEPd8ZWD6hYDkZkeyr1uDnX+aUdH2mQCIu5+AYx86sXvnVarND+eUTr5skVQ2E
        KVZsM5ikPJed0fAR5CdWcjGGOTnoT4K0utKQFG3F+dhLxUWe0l/6VscI1KI3ynzkn+1NjCCk5GjRI
        I/U7oUDSVmvz00NsGsXc0oXTiO9ImvVijuD1TyhHwEgFPXphbXhmg6xyODFBatjiveu3qNmP48c0w
        iTBGTX13A2FRxzbJywltUCIoR/D+UrEzYWNHN2qdkcc/q4sQZ+cx0dJlERDpuaZUdxigZd0zTrkC3
        n7OIWHLQ==;
Received: from 177.205.94.246.dynamic.adsl.gvt.net.br ([177.205.94.246] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOsex-0003e6-2A; Mon, 19 Nov 2018 23:08:51 +0000
Date:   Mon, 19 Nov 2018 21:08:45 -0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     stakanov <stakanov@eclipso.eu>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Stakanov Schufter <stakanov@freenet.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Message-ID: <20181119210845.38072faf@coco.lan>
In-Reply-To: <2988162.jBOhpiBzca@roadrunner.suse>
References: <s5hbm6l5cdi.wl-tiwai@suse.de>
        <20181119155326.24f6083f@coco.lan>
        <s5hwop8g88o.wl-tiwai@suse.de>
        <2988162.jBOhpiBzca@roadrunner.suse>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 19 Nov 2018 23:59:39 +0100
stakanov <stakanov@eclipso.eu> escreveu:

> In data luned=C3=AC 19 novembre 2018 20:47:19 CET, Takashi Iwai ha scritt=
o:
> > On Mon, 19 Nov 2018 18:53:26 +0100,
> >=20
> > Mauro Carvalho Chehab wrote: =20
> > > Could you ask the user to apply the enclosed patch and provide us
> > > the results of those prints? =20
> >=20
> > OK, I built a test kernel in OBS home:tiwai:bsc1116374 repo.  Now it's
> > available at
> > =20
> > https://download.opensuse.org/repositories/home:/tiwai:/bsc1116374/stan=
dard
> > /
> >=20
> > Stakanov, could you test it and give the kernel messages?
> >=20
> >=20
> > Thanks!
> >=20
> > Takashi =20
> Here we go, I did saw your mail only late, sorry.
>=20
>=20
> Result of proposed fix (rc3): card has still no function, does not sync, =
EPG=20
> works. No sound no picture.=20

This is not a fix. It just adds some new messages that should help to
explain why the frequency range seems wrong.

>=20
> entropy@silversurfer:~> uname -a        =20
> Linux silversurfer 4.20.0-rc3-1.g7e16618-default #1 SMP PREEMPT Mon Nov 1=
9=20
> 18:54:15 UTC 2018 (7e16618) x86_64 x86_64 x86_64 GNU/Linux
>=20
> output of=20
> entropy@silversurfer:~> sudo dmesg | grep -i b2c2  =20
> [    4.831163] b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiver=
 chip=20
> loaded successfully
> [    4.862648] b2c2-flexcop: MAC address =3D xx:xx:xx:xx:xx:xx
> [    5.094173] b2c2-flexcop: found 'ST STV0299 DVB-S' .
> [    5.094177] b2c2_flexcop_pci 0000:06:06.0: DVB: registering adapter 0=
=20
> frontend 0 (ST STV0299 DVB-S)...
> [    5.094248] b2c2-flexcop: initialization of 'Sky2PC/SkyStar 2 DVB-S re=
v=20
> 2.6' at the 'PCI' bus controlled by a 'FlexCopIIb' complete
> [  121.789236] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=20
> frequency 1880000 out of range (950000..2150)
> [  128.817325] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0=20
> frequency 1944750 out of range (950000..2150)

Are you sure you booted the right Kernel? I'm not seeing the new messages
here that should be printing the tuner and frontend frequency ranges.

>=20
> sudo lspci -vvv =20
> 06:06.0 Network controller: Techsan Electronics Co Ltd B2C2 FlexCopII DVB=
 chip=20
> / Technisat SkyStar2 DVB card (rev 02)
>         Subsystem: Techsan Electronics Co Ltd B2C2 FlexCopII DVB chip /=20
> Technisat SkyStar2 DVB card
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-=
=20
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 32
>         Interrupt: pin A routed to IRQ 20
>         NUMA node: 0
>         Region 0: Memory at fe500000 (32-bit, non-prefetchable) [size=3D6=
4K]
>         Region 1: I/O ports at b040 [size=3D32]
>         Kernel driver in use: b2c2_flexcop_pci
>         Kernel modules: b2c2_flexcop_pci
>=20
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
