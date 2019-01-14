Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929BE20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="FbNN8gLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfAOQAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:00:36 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:51972 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbfAOQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WiksQJdXitBtyKoazXrz7uLmJ7KtELkPGCoAE0rEw5s=; b=FbNN8gLjkhoh9CFnFQg0NkvWP
        EstRZGGRFF5RxQJ2yvDbnvjVHxhnKKqQ4HjFtB6+rpWnpRrHkpHLiCjAJrvOA7fsDH60jK4Hys+b8
        qYb0L/39FwmZndKUQSQJTNT/rtvsaLAHV8DmRbLBUNLeLpmKO62FXoHkGf3RiLM0ZHzBs=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjR8g-0002Vz-Vp; Tue, 15 Jan 2019 17:00:31 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gj17r-0005J9-Nq; Mon, 14 Jan 2019 13:13:55 +0100
Date:   Mon, 14 Jan 2019 13:13:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 2/5] gnss: sirf: power on logic for devices without
 wakeup signal
Message-ID: <20190114131346.4d476055@kemnade.info>
In-Reply-To: <20190114105129.GE3691@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
        <20181209195150.5192-3-andreas@kemnade.info>
        <20190110121038.GA9725@localhost>
        <20190110230223.18ecbd87@kemnade.info>
        <20190114105129.GE3691@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H2LTfQ6y3PanNW8K.0kxQa_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H2LTfQ6y3PanNW8K.0kxQa_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jan 2019 11:51:29 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Thu, Jan 10, 2019 at 11:02:23PM +0100, Andreas Kemnade wrote:
> > Hi Johan,
> >=20
> > On Thu, 10 Jan 2019 13:10:38 +0100
> > Johan Hovold <johan@kernel.org> wrote: =20
>=20
> > > On Sun, Dec 09, 2018 at 08:51:47PM +0100, Andreas Kemnade wrote: =20
>=20
> > > > Additionally it checks for the initial state of the device during
> > > > probing to ensure it is off.   =20
> > >=20
> > > Is this really needed? If so, it should probably go in a separate pat=
ch.
> > >  =20
> > Well, it is the main motivation for the new try of upstreaming this aga=
in.
> > You know the loooong history...
> > It has several times messed up my power consumption statistics. As I try
> > to test patches on top of mainline, this has often led to false alarms
> > regarding pm bugs in other drivers.
> >=20
> > We could also come from another kernel here via kexec having the
> > device in another state.=20
> >=20
> > And why we do not want to check for uncommon things here? We e.g. do
> > multiple tries for changing power state.  =20
>=20
> You still need to argue why it is needed (e.g. the kexec case) and that
> needs to go in the commit message of a separate patch adding something
> like that as it is orthogonal to supporting configurations without
> wakeup.
>=20
yes, totally agreed, there is already a separate patch with an extensive
commit message.

> This may also be better handled by a shutdown() callback which is where
> such kexec concerns are supposed to be handled, and that would also take
> care of the reboot case. This way, not everyone has to pay a penalty on
> every boot for the arguable rare use case of kexec.
>=20
there are more possibilities than kexec.

> > GPS chips will have usually some boot messages. So it is not the
> > "send nmea data set every X seconds" for the wakeup case, it is
> > another situation deserving IMHO another name. =20
>=20
> Ok, but unless all supported (sirf-star-based) chips have boot messages,
> we'd still need to wait that long for wakeup.
>=20
I have never seen one without. But that could also be attached
to the dtb compatible name or a separate property.

> Are these messages you refer to output also on wake from hibernate, and
> not just on boot?
>=20
also wake from hibernate.
I mean
$PSRF150,1*3E


> > > In pseudo code we have:
> > >=20
> > >   activate:
> > >    - toggle on-off
> > >    - wait(data-received, ACTIVATE_TIMEOUT + REPORT_CYCLE)
> > >      - reception: success  =20
> >=20
> > Note: we can also get the goodbye/shutdown message from the chip here
> > so there are chances of a false success, but since we initially power d=
own,
> > we will rule out wrong state here. =20
>=20
> Good point. Unless we know the current state, we'd need to sleep for
> HIBERNATE_TIMEOUT before waiting for data reception.
>=20
> > >      - timeout: failure
> > >=20
> > >   hibernate:
> > >    - toggle on-off
> > >    - sleep(HIBERNATE_TIMEOUT) =20
> > we could also additionally check here for=20
> >    if (last_bytes_received =3D=3D GOODBYE_MSG) =20
>=20
> Caching and parsing the stream for this could get messy. And is the
> expected message clearly defined somewhere, or would it be device (and
> firmware) dependent?
>=20
I think so but I must check.
$PSRF150.0

But as said, these ideas are be for a possibly later patchset.

Regards,
Andreas

--Sig_/H2LTfQ6y3PanNW8K.0kxQa_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlw8fPoACgkQfb1qx03i
kySFrBAAvpGg96XdxyLbKXGNzKqjw29OVeG6TKHXRwgEHzYS9Y01CrQwVAEec5Gv
p8OfGryP5s1uhBlaCJnPO3fbu/bEPAZCApQlWP115xf7pFX/83511zH+nflz6aqa
tB5UZsxO2viJFJszukwg8/ThdZ0rHbdwsG2X+ABl5QJxAx51QA5e8ouYtBjwUQgC
DfnNP7b67WJZ8q2stCI6BP/efvuhyeWcsH4Fj86ZuAY+zUCYlP3Qj7F6tjz03tZx
sdV6ayfL45QjvLOeZp69UrabMz0s2lgGuNzbgvFWJLpwUqr8KLmiFg6CRtKvzzFy
iKU3dbzi4RKzwS4any34SGLwGXBDSwnohOH7RGv9uMnZqL9KJKzCHcNyDXpCYI/1
uNqBQdDdNNVeZkHcTh5Ca90a1Q5p0QY6p3nifJP2TWtgsgjSE4bJQ+bmkFwrXFcr
ifSEJtSukCTH3+g+AeK+hRrekf+QAIcvAbZh5R1X3thiwINuxtVFp6wU1jpcRRXm
3CAF4Vjinz8cNPJWw1iRH+GYuGUEFVbiYvje7V09kv/t4pJuY9dIXzZIl7PYKroO
hm+gT1Y9lcrxLX0+hsxxazp7C/nx5s6FDOnkl00wAsAwf6RKiQBYD0ohlwry1qx5
hqwWXKE9L8VbjxMtGf2XjFF3cgxtO8DQcBdulpT6an4QohXQHO0=
=jeL8
-----END PGP SIGNATURE-----

--Sig_/H2LTfQ6y3PanNW8K.0kxQa_--
