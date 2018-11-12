Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08AFC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FDF224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Jm+4Ie3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FDF224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbeKMGym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:54:42 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:33622 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tGOAz8gw/uAQySRartYdRIvcbf1KlRooSE+XehrA7Eg=; b=Jm+4Ie3ztGhHpE8OCN9aoV+Xg
        HI2zEW8HbyBNQbvULYE5/0axg08j8hxATfMzU/svlw/4N9aKl6X9e6zE8xrm6rjq9cbrq5i+5TxwZ
        mGYXsZ1aHZRHTfv1+10XoLlBirRny7PNuuJQ4G/bKp9u9vKZULfsSjVJlZguzV84STjDU=;
Received: from pd9e2f2f1.dip0.t-ipconnect.de ([217.226.242.241] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gMJJ8-0004NB-UJ; Mon, 12 Nov 2018 21:59:43 +0100
Date:   Mon, 12 Nov 2018 21:59:34 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
Message-ID: <20181112215812.18ebca35@aktux>
In-Reply-To: <20181111024648.7rt7rlhaqihtqecv@earth.universe>
References: <20181110232034.17277-1-andreas@kemnade.info>
        <20181111024648.7rt7rlhaqihtqecv@earth.universe>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aWdB_CefDoLhkjCidefch86"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aWdB_CefDoLhkjCidefch86
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 11 Nov 2018 03:46:48 +0100
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
>=20
> On Sun, Nov 11, 2018 at 12:20:34AM +0100, Andreas Kemnade wrote:
> > This is a first try to be able to use h4 devices specified in
> > the devicetree, so you do not need to call hciattach and
> > it can be automatically probed.
> >=20
> > Of course, proper devicetree bindings documentation is
> > missing. And also you would extend that by regulator/
> > enable gpio settings.
> >=20
> > But before proceeding further it should be checked if the
> > general way of doing things is right.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > --- =20
>=20
> Patch looks good to me, just one note
>=20
I found one thing myself:
Shouldn't we have a generic compatible string like "generic-h4".
ehci-platform.c has for example:
        { .compatible =3D "generic-ehci", },

Regards,
Andreas

--Sig_/aWdB_CefDoLhkjCidefch86
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvp6bcACgkQfb1qx03i
kyQjnBAAvdRtlj7zGjvLbgzTX7vCh9rFv3v3Nw28EezbMuaKmMAZmp3FSibfRUbx
D6BkAHc2244r8gy3cizNUzOCeN3w2MjDFCp3ZBka1ff+oonW7nQTiV4fZt/XCW5h
ieSMHH8pem5fpuGdgYVSnH51VbrDcSB2adw1Y1SHBTAeYpSIl4AGtx+Yavn8qS+9
RsbUTGd1fAE38KbpOoRNgjN/UtagBD8a9rrj39c+6l44RX4YioLFivY8xP21cZNW
pEgUFEhr6hCs4EathF5vmmMVYjwA6Tx69rPjuAfd+Cle14FcAQVgVrDa8y8J/s4X
dMpEYc1ZJL2JTkvBW+TqKmhs3TQiR0gbGLDgdRyf3DLJGRFbcqskzErk1ZhyWqnu
E5R/cwjBTuSu5JEN7guPefrbfN9slKnfTOdYWG+33v0U47uftt7F+zGNDBG2zjoL
sznthXrDLsLoqoCXsnmqQp/RHUB80gzk1tPtFe2jMj0QvHJi53EVd5GLqsK7/7B3
Ai7OOMuF34KMSvZ9I/sMkw6Yg9nwtdL09NHyfJXABbNgkFskseGV849JngeyeLiT
Dlrc3l08yovs3dYZBJnDCD8U1iaXBaXx653B1+m0xtVeY9o+wfRbtgL/tDNsaqBf
4KlfOWUxWUvhojh7MPSfD4oMji0QDeEpSM3BvY6WhVTXrLkeZGc=
=49KN
-----END PGP SIGNATURE-----

--Sig_/aWdB_CefDoLhkjCidefch86--
