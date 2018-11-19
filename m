Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E5AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585E22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b9U5/v7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585E22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeKTKY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:24:57 -0500
Received: from casper.infradead.org ([85.118.1.10]:45740 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbeKTKY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vdxY7ALyR6IaSA7NPLVW3CVtT98L1SzZKzjR7tvFbow=; b=b9U5/v7/jshLM46S/WR0iQK2am
        taVrDLeYZAvXv6YF5L6zhvj2A1FwArZU49fVmYyIUokG5d8c0pNH2G0ooL5xESqN+VuyYInYrnDgw
        fuG8Z6X+cX+TDvVEP5S5XoerGtY9x2y1PbjsYruKCrQzD40Xv0O2gh0wuf25Uxr0mpVHA01RCEhoa
        VV+Zj+E5YBtEgqxlsgCpOLM2xgeaw34cpCdmBdNeS9qaPS4Arud8puKzPfXlMUxWSgwJkYWxC4P83
        geriGSk6U75jcxi5ZRLm7sDR6am1+fv7KWb+0DIXSaSUBFWZZL3AhZApS45ahfx/VXGLSYyZXeFRb
        4Bbo/amg==;
Received: from 177.205.94.246.dynamic.adsl.gvt.net.br ([177.205.94.246] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOtRF-0005Zn-S7; Mon, 19 Nov 2018 23:58:46 +0000
Date:   Mon, 19 Nov 2018 21:58:41 -0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     stakanov <stakanov@eclipso.eu>
Cc:     linux-media@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Message-ID: <20181119215841.0a3abd37@coco.lan>
In-Reply-To: <1837109.xExTbI5ikD@roadrunner.suse>
References: <s5hbm6l5cdi.wl-tiwai@suse.de>
        <2988162.jBOhpiBzca@roadrunner.suse>
        <20181119210845.38072faf@coco.lan>
        <1837109.xExTbI5ikD@roadrunner.suse>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 20 Nov 2018 00:19:54 +0100
stakanov <stakanov@eclipso.eu> escreveu:

> In data marted=C3=AC 20 novembre 2018 00:08:45 CET, Mauro Carvalho Chehab=
 ha=20
> scritto:
> >  uname -a
> >  =20
> > > Linux silversurfer 4.20.0-rc3-1.g7e16618-default #1 SMP PREEMPT Mon N=
ov 19
> > > 18:54:15 UTC 2018 (7e16618) x86_64 x86_64 x86_64 GNU/Linux =20
>=20
>  uname -a        =20
> > Linux silversurfer 4.20.0-rc3-1.g7e16618-default #1 SMP PREEMPT Mon Nov=
 19=20
> > 18:54:15 UTC 2018 (7e16618) x86_64 x86_64 x86_64 GNU/Linux =20
>=20
> from https://download.opensuse.org/repositories/home:/tiwai:/bsc1116374/
> standard/x86_64/
>=20
> So I booted this one, should be the right one.=20
> sudo dmesg | grep -i b2c2   should give these additional messages?=20
>=20
> If Takashi is still around, he could confirm.=20

Well, if the patch got applied, you should  now be getting messages similar=
=20
(but not identical) to:

	dvb_frontend_get_frequency_limits: frequencies: tuner: 9150000...2150000, =
frontend: 9150000...2150000
	dvb_pll_attach: delsys: 5, frequency range: 9150000..2150000

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
