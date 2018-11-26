Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5910C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B3820855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P6Xx6xDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B3820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeKZRoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:44:46 -0500
Received: from ozlabs.org ([203.11.71.1]:55391 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbeKZRoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:44:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 433HdN3GP5z9s5c;
        Mon, 26 Nov 2018 17:51:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543215096;
        bh=7KySdAHDoaQFtqBZA8oe1CgfLyB5jW8Nu95GsxkUGpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P6Xx6xDH1/sQWbsMyl5W18YHGaQTPgo8Bd2CLKzsJeZzdi+AmlmZuaW8y2mJwzU2F
         C04n07/1vZsWBiFBzR8RrMCiFlCdB7+cByOarSURvxgt5v7h7pvVb9r7XfxN8o/T9O
         lLb4CY95gD9Kg9HhUxsJqLV85hJK5hMzQC0w7So6mSsLqmfx0WdqSlpV0KZSBtaP1d
         haXg3xteyboeN1TnYAftk+rxVYoEEc9IKTtdMAnFx8dt2UOdOF/mDO4BO6cfV79SMr
         meA7aKJi9wDrQnkCwVlU95R7ju8e7zxAgN6lUFpXYCw3DfuHRcJb4hMV8+ODJnladX
         2FsdfTTh2b+cQ==
Date:   Mon, 26 Nov 2018 17:51:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>, smfrench@gmail.com,
        sprabhu@redhat.com, linux-cifs@vger.kernel.org,
        Linux-Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the cifs tree
Message-ID: <20181126175135.0565aac5@canb.auug.org.au>
In-Reply-To: <CAGXu5jJDbUZBmbx1ODS72WJKfcv20aMZczq=k4p4OhG8SV0roQ@mail.gmail.com>
References: <20181126111415.5cf17f39@canb.auug.org.au>
        <CAH2r5mvtFzp=nYK+J92vh9y4tsNLT3rD4a2+mB9LMyWcFN-EHA@mail.gmail.com>
        <20181126115247.53cbf7be@canb.auug.org.au>
        <CAGXu5jJDbUZBmbx1ODS72WJKfcv20aMZczq=k4p4OhG8SV0roQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UEm_H+MQSISvw_W=pTyeV2T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UEm_H+MQSISvw_W=pTyeV2T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Sun, 25 Nov 2018 21:48:10 -0800 Kees Cook <keescook@google.com> wrote:
>
> On Sun, Nov 25, 2018 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > On Sun, 25 Nov 2018 18:31:40 -0600 Steve French <smfrench@gmail.com> wr=
ote: =20
> > >
> > > Both of those cases are intentional fallthroughs and there are
> > > existing comments in the code noting the reasons for them to
> > > fallthrough
> > >
> > > (also can see the reasoning for these in the commits which introduced
> > > them from Sachin c369c9a4a7c82) and dde2356c84662) =20
> >
> > I am not questioning that :-)
> >
> > The gcc warning can be turned off by adding a /* fall through */
> > comment at the point the fall through happens.  Kees and others are
> > working on the several hundred other places that need annotating. =20
>=20
> Right. The goal is to avoid adding any _new_ cases of this. :)
>=20
> > This one just popped up. =20
>=20
> It's already working! :) Thanks Stephen!

Actually this one was the product of how I filter out warnings ... it
was an old one, but the line numbers changed.   I have now started
ignoring these if just the line numbers change.

--=20
Cheers,
Stephen Rothwell

--Sig_/UEm_H+MQSISvw_W=pTyeV2T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7l/cACgkQAVBC80lX
0GxSXwf/fqJUCWHyZZqhrb1v7n3vzWH/3jC+zrJo8oh2mNXgwja9WVHHqnQT5iP8
eJnQOSw5PH5+lhLc+IKnSRI6l3UDHTMG363PXnik000cc4N9e7bhfv8glqgKMpOK
9yqTlx1ekwkzjo5t5+j6UJ79dAJ8JZkHel/LbS9PdH56FPZWv29rmuPGI4vqN+rk
VH3HJ0HWtv9JEtJOLOy69xqVUO0AbjrYcgI6J9uvxYG59Z1naqPWFRryo3yQl+me
oZ1qIn0D4BbHPjnuwxYgLoAaKbOMsqlU2suxd8RYI5GKL465u1LfdnyOiunyyiIS
HMiwkL5tilwbWjG14Ep+SEqoKBHTyA==
=7Cht
-----END PGP SIGNATURE-----

--Sig_/UEm_H+MQSISvw_W=pTyeV2T--
