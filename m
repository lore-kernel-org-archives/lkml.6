Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42734C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07ED02145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Dzy75dMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfBEH7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:59:02 -0500
Received: from ozlabs.org ([203.11.71.1]:57989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEH7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:59:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43txmJ59Znz9sMl;
        Tue,  5 Feb 2019 18:58:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549353538;
        bh=ghOAZ/F6trDoGLk30/T2NZNm8VxGZcg+V9sKElMNopA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dzy75dMP1yW2knnb95S/OGQpVLTupqgn1sOpMelyGhVykjxnGOaX4XbZctgq0Q0CA
         N24GIkdcM1k2WPv52N8mWI32rykwA5GsDsfL4xogXDGfz4ASt+7tcebmW/IzCok7Za
         thtrQgVAo//vgb9kTiwsf47QqxGHtzvDPt18C1NEyNiIoCAV2zWOsCdr6Hr4dE/YML
         GPgsHUKBT14jEuas0GlB96UPEA8xFiz0KmEFkyphWDH3gI+Et88jK0wu+tnnZinpJc
         WBtZoxnGMC+h7OdiuwrvTvBN3vdk5unFcXZQqGWS7Bmco6nWxNEKVs28hxmdnkNrYM
         TgbzxSwU6Bv+w==
Date:   Tue, 5 Feb 2019 18:58:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: mmotm 2019-02-04-17-47 uploaded (fs/binfmt_elf.c)
Message-ID: <20190205185829.113a8812@canb.auug.org.au>
In-Reply-To: <08a894b1-66f6-19bf-67be-c9b7b1b01126@infradead.org>
References: <20190205014806.rQcAx%akpm@linux-foundation.org>
        <08a894b1-66f6-19bf-67be-c9b7b1b01126@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+HD3eexliaqabC4pbA07JGT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+HD3eexliaqabC4pbA07JGT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Mon, 4 Feb 2019 20:26:43 -0800 Randy Dunlap <rdunlap@infradead.org> wrot=
e:
>
> on x86_64 UML: (although should be many places)
>=20
> ../fs/binfmt_elf.c: In function =E2=80=98write_note_info=E2=80=99:
> ../fs/binfmt_elf.c:2122:19: error: =E2=80=98tmp=E2=80=99 undeclared (firs=
t use in this function)
>    for (i =3D 0; i < tmp->num_notes; i++)

This only a problem for !defined(CORE_DUMP_USE_REGSET) architectures,
but a problem none the less.

--=20
Cheers,
Stephen Rothwell

--Sig_/+HD3eexliaqabC4pbA07JGT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxZQiUACgkQAVBC80lX
0GxwRgf+P5QlePLLQEgqvTRa0Shz+SodC89zAUfN8U46W7XmYSmMjbfH4en9aAS5
LRZFLYwLDb0pTF1BKACQtmjcpSB981/iXf4+S3lGDdqL12eY22UCb9TkYArOGXhD
WJSnzABFZULOpnqbVwG7tLDSo0sOpoPEaaYPg1T++tLRDuryfgU0sdBtZ6kmUGjf
ktmuUnHfg+L0YEhPEOOemnb3/GV2m/R7ei2YpCB5J8I+WuBVc0exO14N6A09x3Qc
vDKgDkk9LTUzfzcBo+jlUjI+RoOOzE3dAEX5u1Wx3BIcSREWlUi4AWjaxatefXdY
qMw62ST26RJbtBiewhhTSIbCEpts7A==
=QLXe
-----END PGP SIGNATURE-----

--Sig_/+HD3eexliaqabC4pbA07JGT--
