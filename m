Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2765436-1528062295-2-12642821847229839193
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528062295; b=diRrnf9HIrTE4ZYlai5hcjQ0xPsVnaCsGF9cScjf0uaPDz71Zg
    8nkxAe61tMvJ486bnRbvQw3Kt36aBa0MOgum8jlk57tTT5bkuMJBUUeE33wEB/IK
    3XbBpmwjo8a5gbhPPQnx3qMzdl7H7Z1sv05qMUJmI2zMnnYmWqOOY8NYD6xNiqdb
    kFZyGStaTQg5COaYwME1FwQpFVHBV1d79LtJlMhk2VZhIh6SKZYiUC6At4BtxTVB
    b5uJ8xQFJzAgvAhSu2Qgzk3JdIa+feY/xjUdg0s40m46/HnLuhZ2VoO++L0bmcUv
    oBRuXSh4iOVnRrhbn6f5V3Z5juElE5noGsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528062295;
    bh=nTeQyF49uByA/EmnjJHgwzNam5CiRazDT8LvZqBBSqg=; b=j7l47BujMY8a
    P39PxWHSvgNOElFHzoL2E/vqJzp8wxkJ3iKI4FBvkFm9RGXZC1DQoq33CB/qWzZ2
    RRIm3bOybxgLExMiAN72aIptd2YtyqzMP+wX9rZL6CQYzjQlRYy1ajpWO9Yp3OB7
    rP0pN+QwcIHE1uNwM4rek9z/A91DQeLMfX625rzZlyWhd4PLyP/fzJWUsKVhLb+6
    sSFE/hacbaOumfGD90okQkXInmsdw0fM02Gf+wOO+YyjwNEUP80MZaD6np6KXw00
    r7WJBpqX9RlGSix7JyvXCVag+SdkvwNcmbfn7NZ4uynIKpKu/IGI9tHNtwBkAivQ
    gvdNN9LFfQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=eMEMT6Fe
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=eMEMT6Fe
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
X-CM-Envelope: MS4wfCViBwpoELYhDaa/Ck4Bv76PNKkxCYkEOQDMF5DzFnWuCdzuXXb9vBy0ZZcu/MwihNWQp1ES0qdlIeqyzrI+kHdIvOMEmNgUlnG3q91UpL8v//MaA5lA
    SigHJYPLHt4CGOS5P0pe3BfAx9lah+TC0eoYH5XQbef6PNdn/wXaUsJEtdYmrG2u/etF34AhUgUVMe7bHhGvqqx2TVOGDmL2TO1tkwnFoU+fsb/4syK7QaiX
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=zEmUDdmpQayxNpYm9tMA:9
    a=CjuIK1q_8ugA:10 a=LeUDZd4onxjkp03BvNwA:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeFCVov (ORCPT <rfc822;linux@kroah.com>);
        Sun, 3 Jun 2018 17:44:51 -0400
Received: from ozlabs.org ([203.11.71.1]:37671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeFCVou (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Sun, 3 Jun 2018 17:44:50 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 4 Jun 2018 07:44:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Clark <robdclark@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the drm-msm tree
Message-ID: <20180604074431.399aabf2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9odY32j6grxYv2/V0NdlAq6"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/9odY32j6grxYv2/V0NdlAq6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Commit

  0c999b56810a ("drm/msm: Refactor complete_commit() to look more the helpe=
rs")
  240ca9286fcb ("drm/msm: Move implicit sync handling to prepare_fb")
  a744a6a9e98b ("drm/msm: Issue queued events when disabling crtc")
  efaa2af8b741 ("drm/msm: Remove msm_commit/worker, use atomic helper commi=
t")
  917d7e3c75ec ("drm/msm: Switch to atomic_helper_commit()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/9odY32j6grxYv2/V0NdlAq6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsUYUcACgkQAVBC80lX
0GyQ+Af+PSmMZ5Kl2ejgfwtY4M/dB4K4VWwZInmuOANwsI4BfoqINMKE85CC73uT
yTN778H/QcwX/TBzRrWFuurYnyWRYP0HjvK/khUKmFKFmrTOq+gNv61lqLGZzCYl
qteVjnypfZCDzzNHvxr+EYhAYWfnL2DFwhtBKNOhT/nd7sNu7Y1szYYXnXSUGRSp
Vwz6YL3ijv8pp+NXo960xHwlV0M+TxbD537rm/ARb6k9NA3l6kdJI9jZCsv8GX5b
78LJJiNMovuYzjTsYHNlhxk2ncztVfE/6nvnUKDSC5fKU5Rx6xagW/f4Ed3x3k0l
I0AxbkmifqYXKykK3cwVj4p/U0NDCw==
=2sxd
-----END PGP SIGNATURE-----

--Sig_/9odY32j6grxYv2/V0NdlAq6--
