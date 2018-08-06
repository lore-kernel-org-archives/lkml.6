Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FD7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2895620685
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oA53RGkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2895620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbeHGAAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:00:45 -0400
Received: from ozlabs.org ([203.11.71.1]:49127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbeHGAAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:00:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41krsJ0p0Hz9s3x;
        Tue,  7 Aug 2018 07:49:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533592180;
        bh=cZhd+vxUmh6GzkAWzpmyGoGZ7C/Twqf6hsNS6qs5iAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oA53RGkVwi/VudZ5DES6aQbf0ywwatM3gtuXIhKDYs8rvrSSwO/xdwNCATavKzQ5h
         ZDLZm9KvXkQgVBHfDjx8aGmPpYDIFmjObyWi5g9kAicCqehbtCox1WX9Q2NpWCLtFV
         78qOTX2H6tJO7ahDLM8fkRppaviMBucz27im1EN9m/47qTY3B6/8iAd0Wvy/H2mVPw
         Sa9ZEs9FZtibJ+c6yJuHz6nUjA46CmqmumMvxXLVJlwhXAfqvF7EOaOchYJIOIwy2S
         ujJYBR03NXGmowIvZiGKWc+w+DxHD9Rv9DehCxgCgixB6+VTQNxDMNmRJjVfTY8aY7
         RSvnPazIxxvzA==
Date:   Tue, 7 Aug 2018 07:49:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20180807074937.59b086f0@canb.auug.org.au>
In-Reply-To: <20180806194142.GK5007@mellanox.com>
References: <20180806120131.169f70f3@canb.auug.org.au>
        <20180806194142.GK5007@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IXKzmnp/hrWGHFW2vmOo0AI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IXKzmnp/hrWGHFW2vmOo0AI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, 6 Aug 2018 13:41:42 -0600 Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> The resolution should end up like this:
>=20
>         srcu_key =3D srcu_read_lock(&file->device->disassociate_srcu);
>=20
>         if (!verify_command_mask(file, command, extended)) {
>                 ret =3D -EOPNOTSUPP;
>                 goto out;
>         }
>=20
> (ie take the hunk from for-next, discard the for-rc stuff)
>=20
> As commit 22fa27fbc64d01cbbe1e4da751e64cc22d24a6e4 also removed the
> 'file->ucontext' stuff

Thanks, I have fixed up my resolution today.

--=20
Cheers,
Stephen Rothwell

--Sig_/IXKzmnp/hrWGHFW2vmOo0AI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltownEACgkQAVBC80lX
0GyCowf+IA0A6LZG0Fimeo1Vvy67+yzwuWSEv8JUNG9Jgf9lz1wkly8wy0XGIqYh
sdY/XTMCwsD9hXgC8YaG5T1CNM2CDMykLWrS/N4Q1O/fADvOkDacjLZYswcjSj1X
ubww5ZdYccmPAfCcmNfv1NCMjrf8CQ7A+PAkdbWLesLvHo4NiMPWRhU3/A/tHON8
FBzH6OcKcxdfsKBAe+uxBbGyUybiRv1jDk4u6L0tc+f2YayW2Cp9GcP+91zgBR/r
9M8YLNxXJ5TbDeGUGmt2ligMZ8rgnc38IWfUz8qrbymD8nLd3qkpJxByAEbt3uBo
LV4OtzrK1jwqQ712Lhk1ArYcbYZPDA==
=qVIE
-----END PGP SIGNATURE-----

--Sig_/IXKzmnp/hrWGHFW2vmOo0AI--
