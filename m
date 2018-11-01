Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC50BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FF7204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FF7204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKBHLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:11:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55764 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeKBHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:11:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 254C0808B9; Thu,  1 Nov 2018 23:06:51 +0100 (CET)
Date:   Thu, 1 Nov 2018 23:06:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] amd-gpu: Don't undefine READ and WRITE [ver #2]
Message-ID: <20181101220652.GB27132@amd>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
 <154033907037.12041.8420716608719361104.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <154033907037.12041.8420716608719361104.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-24 00:57:50, David Howells wrote:
> Remove the undefinition of READ and WRITE because these constants may be
> used elsewhere in subsequently included header files, thus breaking them.
>=20
> These constants don't actually appear to be used in the driver, so the
> undefinition seems pointless.
>=20
> Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>=20
>  drivers/gpu/drm/amd/display/dc/os_types.h |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/=
amd/display/dc/os_types.h
> index a407892905af..c0d9f332baed 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -40,8 +40,6 @@
>  #define LITTLEENDIAN_CPU
>  #endif
> =20
> -#undef READ
> -#undef WRITE
>  #undef FRAME_SIZE
> =20

While you are at it... is undefining FRAME_SIZE good idea? It seems
like this is another bug waiting to be discovered.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvbePwACgkQMOfwapXb+vJPUgCeMTZ34bgsZ5UTB8DB74lkZZDd
leIAnjM91bWXpudUDqahcbOe/KWOYVQy
=Oh+v
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
