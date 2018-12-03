Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BADC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207302087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207302087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeLCPyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:54:45 -0500
Received: from anholt.net ([50.246.234.109]:51566 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeLCPyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:54:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D77AE10A156D;
        Mon,  3 Dec 2018 07:54:41 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id X5RPmkNxuH1d; Mon,  3 Dec 2018 07:54:40 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 994FB10A0388;
        Mon,  3 Dec 2018 07:54:40 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 363D92FE36E1; Mon,  3 Dec 2018 07:54:40 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] drm/vc4: Add a debugfs entry to disable/enable the load tracker
In-Reply-To: <20181202081440.0ec235c4@bbrezillon>
References: <20181130161104.16352-1-paul.kocialkowski@bootlin.com> <87r2f2patf.fsf@anholt.net> <20181202081440.0ec235c4@bbrezillon>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 03 Dec 2018 07:54:39 -0800
Message-ID: <87h8fufvwg.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> On Fri, 30 Nov 2018 12:30:52 -0800
> Eric Anholt <eric@anholt.net> wrote:
>
>> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
>>=20
>> > In order to test whether the load tracker is working as expected, we
>> > need the ability to compare the commit result with the underrun
>> > indication. With the load tracker always enabled, commits that are
>> > expected to trigger an underrun are always rejected, so userspace
>> > cannot get the actual underrun indication from the hardware.
>> >
>> > Add a debugfs entry to disable/enable the load tracker, so that a DRM
>> > commit expected to trigger an underrun can go through with the load
>> > tracker disabled. The underrun indication is then available to
>> > userspace and can be checked against the commit result with the load
>> > tracker enabled.
>> >
>> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>=20=20
>>=20
>> Given that the load tracker is going to be conservative and say things
>> will underrun even when they might not in practice, will this actually
>> be useful for automated testing? Or is the intent to make it easier to
>> tune the load tracker by disabling it so that you can experiment freely?
>
> Yes, that's one goal, though I'm not sure IGT is supposed to contain
> such debugging tools. But the main benefit is being able to track
> regressions in the load tracking algo that makes it more (too?)
> conservative. I think people won't like this sort of regressions. The
> idea would be to settle on an acceptable load tracking algo (maybe
> after refining the proposed one), record the results (both good and too
> conservative predictions) and use that as a reference for the IGT
> test.=20=20

Yeah, I think I'm sold on it at this point -- having a tool that isn't
an automated regression test, but an automated thing that can help a
developer see how accurate the estimate is, would be useful and is worth
a bit of kernel code to support.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwFUb8ACgkQtdYpNtH8
nujBbA//X9Cj3ddTo7qwTzKJCthzrOC6ysbnyT/nXZnbUi4sO39gW5NxLhc7485k
UYv3frUkXkMI+y9TvvnSaamBlqOTvXVZXiWLiVQyF4vgramlugwxeiJKZv09DZQe
E+T5/zQd0WS7rCeqb2dcjkAjZTWrWTjAY7sMG0b0IXYhmw2lniDp9mbS3cyFrERp
qFWf3Sdt8dmhlrqjzaj4Nf7P2fEATSxq/Ujv0WcSZu2AXX1fgNDzD2CMeT0xmyIm
yqR1JWjw7hlwcSLmfjcsyJPjuq3v0uqP4a+Hs8MARNOZT7di6DBwughSd3reRvL7
cShlGwpPmZVgcCeYkXcTsp2k+P72+l+hw0VIiIY8CkDx69/Qo2O6TqxwDT89ffwy
ivmT4dkNoQ+ls6HoUHwtOSC2Qng8UHj1vhX2iQtYqZQkAssWU1p1l5ySKuCHCDhY
qkY45d/2Q1jtPopXTAKMLA8fqQWS/hcpZy7gWagfMBKGqG2wIuzMVNV0S1b0/cn5
GcIuylcqYlb9wM/vt/vkaasLmNZVDIoXgxV3mBc2JObcKPATdbYSGHtIeuxwk0BV
m+GXVlgEvpCoDIdWRgSatIb4lCgxgUXCjqkmq7ZOHRPdW3COlKk4gfueJbyWqdh+
dICj5cO/CtizgNMYk6bYQu8Z+zI98GD2EnEbZthk9aq8KpnBrzo=
=kQ/F
-----END PGP SIGNATURE-----
--=-=-=--
