Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324F920863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="XAX7N2Ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324F920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeK3Rqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:46:33 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:59604 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeK3Rqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=smY9fYInNrPRz8Qs0Bp24IqgbOP8R39VB1gf/mqxCqE=; b=XAX7N2CtrKqrFsjN95nZHei21
        ViO40eDJUZX33c8QHZNA+hpUBtwLqaCRqGpxvlPpFVq5Nlay4dzrXfeSrllV91KeKZ1qOY5SehlCn
        lekOrQDRbSGYOxB9GFOFfQg/EyN5Y+j5Kar2w+mNysA78TzR8l0HgXk+OgK6Lorx35mRk=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gScRM-0002Q4-3m; Fri, 30 Nov 2018 07:38:16 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gScRK-0001Je-1W; Fri, 30 Nov 2018 07:38:14 +0100
Date:   Fri, 30 Nov 2018 07:38:04 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RFC 4/5] gnss: sirf: add a separate supply for a lna
Message-ID: <20181130073804.1e57226f@kemnade.info>
In-Reply-To: <20181127180356.GA32751@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
        <20181118215801.12280-5-andreas@kemnade.info>
        <20181127180356.GA32751@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BTjEbUtPs1dNVLJ671peYpD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BTjEbUtPs1dNVLJ671peYpD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 27 Nov 2018 19:03:57 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > Devices might have a separate lna between antenna output of the gps
> > chip and the antenna which might have a separate supply =20
>=20
> Might have.
>=20
> > @@ -340,6 +349,12 @@ static int sirf_probe(struct serdev_device *serdev)
> >  		goto err_put_device;
> >  	}
> > =20
> > +	data->lna =3D devm_regulator_get(dev, "lna");
> > +	if (IS_ERR(data->lna)) {
> > +		ret =3D PTR_ERR(data->lna);
> > +		goto err_put_device;
> > +	}
> > + =20
>=20
> But it is not optional in the code. Probably should be?

well, if it no lna regulator is defined in the dtb, the regulator
framework will return a dummy regulator. devm_regulator_get_optional()
would not do that and would require more error checking in the code.
But if there is some rule which says that devm_regulator_get_optional()
should be used here, I can of course change that.
Before sending a v2, is that the only issue here?

Regards,
Andreas

--Sig_/BTjEbUtPs1dNVLJ671peYpD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwA2swACgkQfb1qx03i
kySlihAAgI5DPKdMqJIbrhgXmk5vhH+z5xvplIxqHczGRwSfYt+7JKNRtJbvGhwX
Pxi4oVEb72fOeNRItULe4/pCsC/G5DY2fYdw5G7iiqbdb1/9PdvXctsop67G0Fvs
P48doJ5eR3XQi8UFGi/jHJ3sWIqVNz9sHTM4yL8kvtVUpfia4+j6ivFZhXgKm8XX
0YTCACWdd4a8wbdZCvQT5oNktirTLsuVHlyR/DlTEzrPD6SpR1J8aFUdo5PbQ/yw
kuwoGZl+vADWcXkW8tyD2ebL1eCu059m652JjNIEtCHz7yihQgRTVpAkIgHL/YXI
V6HgS8Tz3QVMPMbJA5ffwYlEubwFWrdrYaC20C4d2TbxPuosFTXpdnDXxmYKWqHl
XMHiV29o25UscGixG+QHIugHfV9tJpzle6Ogiv/p+HGRvJx39j+sXeioLdDlPmAR
iiORgk2ocZCERYxV+BvzWFX2PRhwQmlhgdEIy9XdC4pQHAKcOV5N3n2+9CSa3ing
5mapahXMe4p3XiNb0LMFcIJtMaI0x01qgB+PfXVXa35tjW3j2pNSOHoC8lQdXSuQ
6U6riISyyKg8QJ8MWugci2xipM1z35pZ52oD9YuvLAcsKgsWGGlEvZ24uCpZW7zG
l8CaQx1YyzChw57BDEWzaUh/+wvtSJqBlFoYnnqDUP+48ST2tR0=
=gVCe
-----END PGP SIGNATURE-----

--Sig_/BTjEbUtPs1dNVLJ671peYpD--
