Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02515C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54D72089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54D72089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJBOr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:47:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41853 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJBOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:47:55 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 100668078F; Tue,  2 Oct 2018 10:05:54 +0200 (CEST)
Date:   Tue, 2 Oct 2018 10:05:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     rjw@rjwysocki.net, Dilip Kota <dkota@codeaurora.org>,
        dtor@chromium.org, swboyd@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
Message-ID: <20181002080554.GC19677@amd>
References: <20180927203523.60856-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20180927203523.60856-1-dianders@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In general Linux doesn't behave super great if you get an error while
> executing a device's resume handler.  Nothing will come along later
> and and try again to resume the device (and all devices that depend on
> it), so pretty much you're left with a non-functioning device and
> that's not good.
>=20
> However, even though you'll end up with a non-functioning device we
> still don't consider resume failures to be fatal to the system.  We'll
> keep chugging along and just hope that the device that failed to
> resume wasn't too critical.  This establishes the precedent that we
> should at least try our best not to fully bork the system after a
> resume failure.
>=20
> I will argue that the best way to keep the system in the best shape is
> to assume that if a resume callback failed that it did as close to
> no-op as possible.  Because of this we should consider the device
> still suspended and shouldn't try to suspend the device again next
> time around.  Today that's not what happens.  AKA if you have a
> device

I don't think there are many guarantees when device resume fail. It
may have done nothing, and it may have resumed the device almost
fully.

I guess the best option would be to refuse system suspend after some
device failed like that.

That leaves user possibility to debug it...

								Pavel--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzJuIACgkQMOfwapXb+vI5jQCfYeH7EypOPhY6xWmkmVkb96+/
r0YAoJQjxy0djxFFkgUyLzeVlEmkI7xF
=5M63
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
