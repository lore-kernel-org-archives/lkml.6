Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A44C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8370208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LQFL3KcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8370208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeH1Gd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:33:27 -0400
Received: from ozlabs.org ([203.11.71.1]:45103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeH1Gd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:33:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ztPC5Rdsz9s4V;
        Tue, 28 Aug 2018 12:43:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535424239;
        bh=gk3emO6ghejKDB0OYBH0O8XMSlJBuMhIiv8Le+YiPlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LQFL3KcEkhJA/w5pIyAucQUTALSnFt2+fXyI1wVOvpwsqvHAMGqtWqrfOr/V4dTYN
         HzBeTcmmDRZJybdRxq47Gv8Ioa6l0Q3GE6rXVJQRCM9JuF10Jkqn+vn+ShrKtW1Ehb
         dGB0g8uXQWFi+IOb2E0hoQWXiBiyHtGarlAaUSQzBa7qrgcGyM2RZtu9wteZJNAp1S
         a2+G+nItEda2KV9KreKN/YY7U6LXNNwH7c531KCWJkG0PbSxqWAOxwBeLmhKOe+yBW
         XIUn4nzDQviExj9XTynCbUVDOIUNxUwVSEXrou134sDOM7QUGZIod6QBvRE9ql+pME
         oP0NVOk/NfvXw==
Date:   Tue, 28 Aug 2018 12:43:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: new maintainer/tree for the libata tree?
Message-ID: <20180828124358.13c711e4@canb.auug.org.au>
In-Reply-To: <0ee8b9e0-1576-c8c1-ed22-dd76a8d378ba@kernel.dk>
References: <20180828071944.02b13db4@canb.auug.org.au>
        <27ef8afc-c490-5984-5a18-1ee5ce51d556@kernel.dk>
        <20180828112851.19c64e80@canb.auug.org.au>
        <0ee8b9e0-1576-c8c1-ed22-dd76a8d378ba@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A0L5Tn_dm2+JzCSqsus.SAe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A0L5Tn_dm2+JzCSqsus.SAe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Mon, 27 Aug 2018 19:30:09 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/27/18 7:28 PM, Stephen Rothwell wrote:
> >=20
> > On Mon, 27 Aug 2018 19:15:23 -0600 Jens Axboe <axboe@kernel.dk> wrote: =
=20
> >>
> >> On 8/27/18 3:20 PM, Stephen Rothwell wrote: =20
> >>>
> >>> I noticed the maintaership change - so what shuld I sues for linux-ne=
xt,
> >>> now?
> >>>
> >>> I currently have
> >>>
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git#for-next =
  =20
> >>
> >> I'll merge into my for-next branch on the block tree, I'm don't plan on
> >> doing separate trees for this, just separate branches. And everything I
> >> queue up for the next version will end up in my for-next branch. =20
> >=20
> > So I'll just drop the libata tree from linux-next, then? =20
>=20
> Yeah, that should be all that's needed.

Done.

--=20
Cheers,
Stephen Rothwell

--Sig_/A0L5Tn_dm2+JzCSqsus.SAe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluEtu4ACgkQAVBC80lX
0GzplQf+Lc4ut/p37idKk+2DV8mZKPpFWIOcTLm2uyuUvYUthWA8viO6B5TOAhYG
7T2snyGZG5G/Ygdivp6h46iMS4bpoh2jw9wi5MgkVG8C4w6PGcKUaZzjtXU3QQ3E
vSPqrNOTLrXQ+iYYiveSrrrkMKn6+yeakmG/ThWcFpcZhFmcKgFYghOLch12/KI+
sMbjdks/SQRa1PR7gxPjOgUAPYL7fmrmSEXJs7EdC6Hf7jkBTc12l7I+mgFjdT3V
Htl8gbI55PaMDWy67ZovZuBYEvIO+wdSO50SKiXWro+ZGHFXm/RbEyavo50CGuIj
nhT2ULKeEuo4b/NS5YLCGCEnyEMa+A==
=xxXv
-----END PGP SIGNATURE-----

--Sig_/A0L5Tn_dm2+JzCSqsus.SAe--
