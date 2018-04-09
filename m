Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1942698-1523306583-2-7905210663769120838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523306582; b=kbSltzrpfBLpi7SoIKmOlyYyJUtQF0PTcNb0fdpVpJkdKnInet
    0Ct1IGbX7Q44aEsqSkPvrpaCVZ+G+RVh65MJskyxRDwp7lPbH/AF6E3CyfHx0PQg
    ALweBkEe8EfEIrGypuTwoppEXBZjg4IBofxp1Mv3/7mXNjYQ67pTlO9ddUf4Gspj
    A0JwbPhBiWbO3XF8eqiiGnfDKBuH3Lba07gc5vkle/UEKmvHZluf6EMgBwBKx1xV
    7wQBXaEJBR/f3oG0NdIfwc1/0cesl5S8mbtl57RUcfsdYP3Plp/GwaLc5w19mN1m
    SITJ6Uy1jKFotEZvPnKfyGU2EfTitNefFPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523306582; bh=QI+A4TTeBuh3T5wQtyjh/byI5oYLbX
    FwSoKLZDr/fNg=; b=msufCZWSuRRRkJVCXf7XzV9FQ77Jr6tMU15ogDVvLNc+Nb
    MVRFup2v4+jaSgqYxdVF+3eCxlzUcjxHdZCZNFXxUxypzMTbTKmGLGBff3+w5VPL
    UIAJw4+5JM9JY0N0glxBMAiKF1RC6Ad8+6mg1D6N1U7kr0FR4mEm1LevOw0seHtU
    EXimUj6eZJf+V0U3atmxuTYEshQhBGqVRD/nkRoHe9E/g7AGTyatII42RwyAMnX6
    Y0EoO7681KOs5LMb9YgkphQSWI0vw9G0g/j4TZxKW8D73joJ6Oig33mx4UpNQ24f
    RSY4iREbDzkKh4u0KzyZO21d4wW/mKwvoYN0Sk4Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOl03ILWGKT70u2w3DRI6xLQAj9cAQuHDyWBNrOh8yzeuT1wSQqgLVIOYiphCsagqL0CkwarKeYPw4mDtvo0qBTwFLz7+qVsWR1ZMEqPLHg5xVmqgp1t
    RzeTnGk3ppf/JCoonlOByVd+YNKDcq8YQfNw0h3PNXPNLT3Xn3NZosoZTzeQuwU7OYx2hvL54Wf0PoD4SRTVHPMXMxpSi7Y25PnODn6Iz8jHF0jVouSgQMWT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=r_1tXGB3AAAA:8
    a=GuW_iZOGtcKOWHy0KIMA:9 a=QEXdDO2ut3YA:10 a=EkP_pH7zGGdojfNYPvgA:9
    a=ONNS8QRKHyMA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeDIUmh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 16:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754388AbeDIUmf (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE9721785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 9 Apr 2018 21:42:29 +0100
From: James Hogan <jhogan@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.9 173/293] MIPS: Handle tlbex-tlbp race
 condition
Message-ID: <20180409204229.GE17347@saruman>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
 <20180409002239.163177-173-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <20180409002239.163177-173-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:25:09AM +0000, Sasha Levin wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>=20
> [ Upstream commit f39878cc5b09c75d35eaf52131e920b872e3feb4 ]
>=20
> In systems where there are multiple actors updating the TLB, the
> potential exists for a race condition wherein a CPU hits a TLB exception
> but by the time it reaches a TLBP instruction the affected TLB entry may
> have been replaced. This can happen if, for example, a CPU shares the
> TLB between hardware threads (VPs) within a core and one of them
> replaces the entry that another has just taken a TLB exception for.
>=20
> We handle this race in the case of the Hardware Table Walker (HTW) being
> the other actor already, but didn't take into account the potential for
> multiple threads racing. Include the code for aborting TLB exception
> handling in affected multi-threaded systems, those being the I6400 &
> I6500 CPUs which share TLB entries between VPs.
>=20
> In the case of using RiXi without dedicated exceptions we have never
> handled this race even for HTW. This patch adds WARN()s to these cases
> which ought never to be hit because all CPUs with either HTW or shared
> FTLB RAMs also include dedicated RiXi exceptions, but the WARN()s will
> ensure this is always the case.

=2E..

> +	/*
> +	 * If the CPU shares FTLB RAM with its siblings then our entry may be
> +	 * replaced at any time by a sibling performing a write to the FTLB.
> +	 */
> +	if (cpu_has_shared_ftlb_ram)

cpu_has_shared_ftlb_ram was only added in v4.13, commit e7bc8557428f
("MIPS: Add CPU shared FTLB feature detection"). To backport this patch
you'd need that one too at least (and I6500 support was also new in 4.13
so you'd also have to drop that case from the backport of that patch).

There may be other dependencies too, I don't know OTOH.

Cheers
James

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrL0DUACgkQbAtpk944
dnqzGxAAnk8FHAtfIuBnHAWn4zo52YiO17tEzqjop4yu1MSgmlzilTMq1ebc1ziz
raCU6EBUPfvHxPsI+hFZs1IzyyGwNCCuvNdXH5L99FK/fku1sLzMm1wTP3cCiVaF
5G8ysaeZedI+QA5DkyV3O32otpmmTCEauog6it0nNSuazQ4vGHlEMey0HfVPFTal
ssGDCUGrigjsg2zyHZ50UzWjpcxXLHwR6xtSiipi1s9K2tRp07Ivj4N2cMO/qNqW
/qEY7lwEwj1o+uKO1lVzwF/r9H6To0C+okmA3D/5E2YH4ZfL/w1RjBcZcxC2iabX
V5HS5A21j9kx5gnPPn3/ynJ/wigisOFZk8cPJehwsF2NYTLgWxFD+nOislhi5n3m
N6oCW2+g6E4qJCXWeJazJ2ooN/LZ4r4qEk/0EKzq+Bc8nYbr1mS1eTlVxC5/pAdZ
qAZWAvWNh3NCFqTWinue5o0903ddIdOZ3Ovy1/eiyO0Ln8pyZhdrpYxZdurAujL+
3fQxh/BwkSmtx6leX9brwE4QJNEzngmjWcqAVM46OHXGrTgLDr4Njt9kpHFItrKa
OIoB+Wp6iXFy9I4/XIcZuV+SUaIhv6C2LVxxMC9Vy7JVGoVA9Pvp2q3Zssa6fYob
TXwYhAIbdCtTjvtxlVT67GPvYMEoZSXxgR2o0AOg9z2+mf1UGHM=
=UWpd
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
