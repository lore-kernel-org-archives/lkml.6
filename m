Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3914241-1517497957-2-16830178980466076684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517497957; b=u2J0KK5WS75/Yy999Mx9Rh4SqWRYCa9M/0YEqk1bkGRXZU6
    fbZA3d7LKD3rDrVhOcnCbzHH9zqljtXrQK5hT2PcczJ7ruA+zWdfM9a/umdWr+gV
    aPNFzFHpijAr/qSvAfCO7UPgf4rFqtbf+PC4eSmkK+cg8WokD+Sxk3f6Tc5oc2+y
    FngEwOiLCLb8Fg3vFDlU7x4IhAMWEncOQgv8OVLVNtxDxgrFoykoJIY0P5KstgnZ
    ODk8LmeOTIfD9BqmFD7OhfMcDPpDTCqNTlylz88aZJZ+Betdfq0+gUwXMuUs9/Yh
    I+473oS7xnuBrRhAAK6meLLbgmxHrrE+hThBoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517497957; bh=U82VkHGoO+zJMkeVtjNVYd365E
    wZFSQ44qUc0cHHSFM=; b=k4ou0bAmxrhq9EGi1M1qOh0vZJzfquZT/umLJbXh/c
    Gtc4ChFdxUmGDndZFoYeWPGmHkjKEkcObKmqZW6fxcul4xSSqSI1MCNg32zWWQ26
    x9xND63AtmhqbS13cdAHAdzfUl0LTBWvvVc0Brn345mimb+pQASv7ozVHlHGvxl7
    +M2esSIsE7qtPNQgp7VgaFdCHRtZ2oFSEnnkM3dELCG8/Nt7f0U45UCZNurRFRuv
    0suuzZTzWSP/8bOAYAPIp8cVlF5NCM4YPdFBlKzJC+eg9MfS8iplNfsYnQGEgaqw
    E9q7JQwtVlG0OkYa7bP/gVL+8OmXFCTLA1ydpUeZRA/w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aRByXO08;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aRByXO08;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeBAPMC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 10:12:02 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54795 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeBAPL6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Feb 2018 10:11:58 -0500
X-Google-Smtp-Source: AH8x226jBiSZMvkgF4hwLsf8t2/bsPVL6QdaZegV0MbeTmYaSHVQ/ebDCiZgLJezpfqQ8RYj26h34g==
Date: Thu, 1 Feb 2018 16:11:57 +0100
From: Moritz Fischer <mdf@kernel.org>
To: Wu Hao <hao.wu@intel.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v3 12/21] fpga: dfl: fme: add
 FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Message-ID: <20180201151157.44vecqprje6dqzjl@insfl13.etec.uni-karlsruhe.de>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-13-git-send-email-hao.wu@intel.com>
 <CANk1AXT4OiH=Wj3o5AjsS7DiUitudMetVu860Qz1RjodDfM18g@mail.gmail.com>
 <20180201051107.GB10273@hao-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="judw2s4lxvqf55cu"
Content-Disposition: inline
In-Reply-To: <20180201051107.GB10273@hao-dev>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--judw2s4lxvqf55cu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 01:11:07PM +0800, Wu Hao wrote:
> On Wed, Jan 31, 2018 at 09:31:59AM -0600, Alan Tull wrote:
> > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> >=20
> > Hi Hao,
> >=20
> > One fix again, otherwise please add my ack to subsequent versions.
>=20
> Sure. Thanks for the review.
>=20
> >=20
> > > FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones =
which
> > > need to be supported by all feature devices drivers including FME and=
 AFU.
> > > Userspace application can use these ioctl interfaces to get the API i=
nfo
> > > and check if specific extension is supported or not in current driver.
> > >
> > > This patch implements above 2 ioctls in FPGA Management Engine (FME)
> > > driver.
> > >
> > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> >=20
> > Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> >=20
> > > diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-=
dfl.h
> > > new file mode 100644
> > > index 0000000..b46d124
> > > --- /dev/null
> > > +++ b/include/uapi/linux/fpga-dfl.h
> > > @@ -0,0 +1,50 @@
> > > +/*
> > > + * Header File for FPGA DFL User API
> > > + *
> > > + * Copyright (C) 2017 Intel Corporation, Inc.
> > > + *
> > > + * Authors:
> > > + *   Kang Luwei <luwei.kang@intel.com>
> > > + *   Zhang Yi <yi.z.zhang@intel.com>
> > > + *   Wu Hao <hao.wu@intel.com>
> > > + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL version 2.
> >=20
> > Please remove above line.  My understanding is that we are supposed to
> > not combine SPDX with other license statements.
> >=20
> > > + * SPDX-License-Identifier: GPL-2.0
> > > + */
> >=20
> > // SPDX-License-Identifier: GPL-2.0
> >=20
> > As first line of file.
>=20
> Sure, I will fix this in the next version.
>=20
> Thanks
> Hao
>=20
> >=20
> > Thanks,
> > Alan

Thanks,

Moritz

--judw2s4lxvqf55cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlpzLjkACgkQUVwKRFcJ
cNj2rggAvchiYW0vY//rcKCT9Nt2yN6utat+EUipAIaDhRBS2Lpn5G+MAiHd+21o
EZhw7uJiGorwIUX1MlafsFhHznHnmo5/E6/PM87fclNcahPr3SxXVTOmHh5JDfrf
LFSwcw5iF1SKF8MMchOIKWdEFb2PVnKox9m6JV+JLHFnK2U7cZWTI7o2I1JoCS9q
x7OVYSKBsZ8Gjw6/H97l7wWTpWhnrbVXPQRH8MYeTZPGe+8y2swI0HXWO12NgMtH
eqxPS5VSLWF56yA9ZDCyXsrjgrUEETe47v1pv0eUvo1td2w/sQUqNPtVPlQwbOQE
7bCDLjjlaqjJwlF1wysa8LsC3rnpVw==
=ecPR
-----END PGP SIGNATURE-----

--judw2s4lxvqf55cu--
