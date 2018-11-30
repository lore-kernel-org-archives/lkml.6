Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD38C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411412086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r/vvtPsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411412086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeK3NTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:19:43 -0500
Received: from ozlabs.org ([203.11.71.1]:36921 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbeK3NTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:19:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 435dDy0SsCz9s8F;
        Fri, 30 Nov 2018 13:12:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543543922;
        bh=Z1fZ2Crm3Ouc+ihJ2dxfkNmVWcS/1CQm7fPkFhSuP4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r/vvtPsjr+2r0Z2Awhe2iQKjpEvD8ZGreKvyaCDN1PRNCJnLJq9/Z17b3F8hnsNxc
         MVV3+MDnEq0NWw0agJU34MKDt2lKg0XS/OTyQqf37KwvyguyLYfxe862vnupppTOr5
         YcmLoEdiWz0k/+8m3W3ztgeRn+msjUdwKI+sE/w4OmaRT1zst8aclE03AMa1zwXKyR
         PkUMK/CAv7JhPLmDjFidvR6rUVdBXg8gSCAMTYiS+GVGZKyLwxIDRh2A0B4HGYYOSD
         TAoVfZBIA1vLgkFo/sLoMX0O2gKD7bc6RJWXVMy2bV7AfHRBnhk3WIOq0xKrHxPhwW
         8spDm/JfyINyw==
Date:   Fri, 30 Nov 2018 13:12:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kbuild test robot <lkp@intel.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
Message-ID: <20181130131201.6fc91dcd@canb.auug.org.au>
In-Reply-To: <20181129224234.GD32306@hector.attlocal.net>
References: <20181129163826.178670-1-swboyd@chromium.org>
        <20181129223600.GC32306@hector.attlocal.net>
        <20181129224234.GD32306@hector.attlocal.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uTnMOcHV6Tw7mxJCfUrnTQC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uTnMOcHV6Tw7mxJCfUrnTQC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, 29 Nov 2018 16:42:34 -0600 Andy Gross <andy.gross@linaro.org> wrote:
>
> On Thu, Nov 29, 2018 at 04:36:00PM -0600, Andy Gross wrote:
> > On Thu, Nov 29, 2018 at 08:38:26AM -0800, Stephen Boyd wrote: =20
> > > We need to check the call to cmd_db_read_aux_data() for the error cas=
e,
> > > so that we don't continue and use potentially uninitialized values for
> > > 'pri_count' and 'sec_count'. Otherwise, we get the following compiler
> > > warnings:
> > >=20
> > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_=
arc_votes_init.isra.12':
> > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count'=
 is used uninitialized in this function [-Wuninitialized]
> > >      pri_count >>=3D 1;
> > >                ^~~
> > >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count'=
 may be used uninitialized in this function
> > > [-Wmaybe-uninitialized]
> > >      sec_count >>=3D 1;
> > >                ^~~
> > >=20
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Evan Green <evgreen@chromium.org>
> > > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > > Cc: Rob Clark <robdclark@gmail.com>
> > > Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_r=
ead_aux_data()")
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org> =20
>=20
> On second thought, this needs to go through drm tree.

Why?  The commit that introduces the warnings is only in the qcom
tree ...


--=20
Cheers,
Stephen Rothwell

--Sig_/uTnMOcHV6Tw7mxJCfUrnTQC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwAnHEACgkQAVBC80lX
0Gzm5QgAoS5hbEm2DH6OlupYdISzBShylvu98CN3kkwvnYnWUaqc8FZ0RcVRRbdN
T9E2kznxCpp0dyan/ZEw+5w/RtbKqurg33bGnVEGljZ9XdskEtc3bv/wVqGIvNrN
wWN0pss6sjSi9r/SezK46NTq/9deR6Dm41xvRv6M62yesTSjp1/BssvGPQGm6SLQ
GIjXIR1wYy1jFKZGL3UgruwCHg1wb3TuvSsZmWhoIXjSdjR0Q1zhg27YWeDSit70
sihng+14RHSXHYbOYbPD0EdVcl+TLqlR8uMoyE8bVUPucJkhgCTVz2ba3wqPTw0O
EbJdRFtVUaohn2apbPGjpxY9CGEhCw==
=SDX4
-----END PGP SIGNATURE-----

--Sig_/uTnMOcHV6Tw7mxJCfUrnTQC--
