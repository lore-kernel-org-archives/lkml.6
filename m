Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3125135-1528081751-2-2130407728456631757
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528081751; b=jZErLRgu8aN7N4YXf1zSc3Tre8BjTRA0yzyhtdKmVDxRC+Dzey
    r6oD6qrEMeVyNm+PeoVcbMSznqpNoyvPwuW3UhZkaLDnqZUxRynrpBNGI3vdHLLi
    rfcB0DuBOoD6Lz3X/fidUQ01xsYffTW3nQSG2gRiZlBDy6UrmUFTsg6Fp99LhXLa
    vEzhJIrcLAea1VvPu6iPHfy2y3FNVfTcZn3og9/ngLEug1rSghLelok/CUc3ur3U
    GWKy5iVHWwrICdJ1vApALTuhD1bg7bwK+EZDyxzwcyC8GA+59PC8DP3DM7wlXMPb
    Gdvj2arAngnn66GdS3/9iZWVay1uv0IWKCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528081751;
    bh=dWbg1UHoQmOtqCDUkV0Mc5KWPx/z6Ii+2PzClugEzXI=; b=T3A/9y2gCXAn
    hOWawJdB79hG5CUrCVnOkYDMZz0F3AyPtng996+THV5/Kw2LSxW5adb9umjgeH8D
    TJvQZYPFYzOeGTDvyazCMrtLWxQMohXZq4ZcXvQyxUoBDo71Q9t+7FcyO9Br4+4V
    QoSm3XZtHjOStLDJ9Kpvg1gh0hcmiUIVOMpN8jT4i/wvHw+Ovaj/qDa2yRaZUZkC
    R+qNdu+9Avsn+m1Cb9N37wk/UbhDzMsK/J1sAlFbBKpfErr+SJVeg4+XUMwj+D3o
    kdHcEmiAZSuwIoq0aZcGh8q4k10rzU4KkxaRo2xMSQhQr9PxN4DMLa6oCM9nUn3u
    +V5XwTM3EA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tQyCq4HP
    header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canb.auug.org.au header.result=pass
    header_org.domain=auug.org.au header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tQyCq4HP
      header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canb.auug.org.au header.result=pass
      header_org.domain=auug.org.au header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGAO/IHGD1NbvXhh8hK+VTUUDFW6gaunIU74Vfe4fjCCEh+DDLMORllP+Oj+PD1xu0ZtOxUxxgKRokI2ufRm4h4lroXImYY3OKVIm8DoSow9bUnI8kXS
    Sa1RFb755bsPZ6azn910AfM9mZgAv9/1JpbjUO5vaeL4yugCdChwlfGvJErHwhNptQ0yOfpwa1tem1ck++XnkXwvsquxaShVbI/XiGRXg9Iw7eChAt8W0m0s
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=u-Y0lGIL-1t-5xPkIlwA:9
    a=CjuIK1q_8ugA:10 a=TAz9w8g1t1xc5HeqYHkA:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeFDDJI (ORCPT <rfc822;linux@kroah.com>);
        Sun, 3 Jun 2018 23:09:08 -0400
Received: from ozlabs.org ([203.11.71.1]:46787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbeFDDJH (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Sun, 3 Jun 2018 23:09:07 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 4 Jun 2018 13:09:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Francis <David.Francis@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20180604130900.07deb177@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/blmek0qS6/Swspi6Zx9D8.A"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/blmek0qS6/Swspi6Zx9D8.A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

between commit:

  a9e8d27574f2 ("drm/amd/display: Make atomic-check validate underscan chan=
ges")

from Linus' tree and commit:

  dm_update_crtcs_state ("drm/amd/display: Couple formatting fixes")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27579443cdc5,1ce10bc2d37b..000000000000
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@@ -4577,14 -4650,11 +4650,14 @@@ static int dm_update_crtcs_state(struc
  		/* TODO This hack should go away */
  		if (aconnector && enable) {
  			// Make sure fake sink is created in plug-in scenario
 -			new_con_state =3D drm_atomic_get_connector_state(state,
 +			drm_new_conn_state =3D drm_atomic_get_new_connector_state(state,
-  								    &aconnector->base);
+ 								    &aconnector->base);
 +			drm_old_conn_state =3D drm_atomic_get_old_connector_state(state,
 +								    &aconnector->base);
 +
 =20
 -			if (IS_ERR(new_con_state)) {
 -				ret =3D PTR_ERR_OR_ZERO(new_con_state);
 +			if (IS_ERR(drm_new_conn_state)) {
 +				ret =3D PTR_ERR_OR_ZERO(drm_new_conn_state);
  				break;
  			}
 =20

--Sig_/blmek0qS6/Swspi6Zx9D8.A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsUrUwACgkQAVBC80lX
0Gyn2Af+Lpg5Wdv71CFqwaPPxWZ4uIMePiomUygDKAFiJE4X69LCKvZPG6r7L3ww
KsqxwZ86hr70yEllebObtd0CdhypywI9DHEYH/VNMAu+rAVOgk+KNGKiAC94LBMG
vLwHSEEdOybfhRXHyZwh7KWccnmKUqk1lFy+wrHV7B/8m/uoIICqJ5Q1RzKkUdfe
pBkqkrQ7+rnpoYe/W69Nop18QXbllipPnLgMLZVKf4fBhBosItOB5ROCFK1GMixi
s6g9hOC4Pu5kYBYO5Ok8hdSnxjO22GbQMAhnFwwSgGYMhksqTbcBRtCxzLi85zKC
XrdE8frv3w+zxB2ZamP6xVHLtZDTtA==
=7zR4
-----END PGP SIGNATURE-----

--Sig_/blmek0qS6/Swspi6Zx9D8.A--
