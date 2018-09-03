Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBE5C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D77B20841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eCOtOWe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D77B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeICGYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:24:15 -0400
Received: from ozlabs.org ([203.11.71.1]:46737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICGYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:24:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 423YGy4SW4z9ryn;
        Mon,  3 Sep 2018 12:06:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535940378;
        bh=TyK+irfRrcc77+LqjGRQARPqIdsa5ShKObOY3Z4NkJ0=;
        h=Date:From:To:Cc:Subject:From;
        b=eCOtOWe0+x/0nVbW6DGe9V7cI9T97WUEWZtkE8kDTPXApCwDkJqja/CB660wq+yB3
         W7K/3f6LljWeEqXC1fbNYPQEKysJK/v+K1gE7LJSOB9qlP+TAUR2GdnW/MQkyhFdT5
         mS3xdmFvo8NqaKJq9k0S/yyB0B0+pWZNGP/yt32KTb9j0vop0vgvAO73lDlcyLghHb
         GnlrMxJz5ufUJFHaMTd0XOgW2cZ6LNBgLW2TpnHCoFCG/phEiLhm1EssUVJ9UAhaMt
         shcaZJydyRNlfiBX/MJFb9fpO7H6n7cOr7HY/+4addGMstwQ8kgUK4t8BiusQqkV6/
         0oFy4aFuXA1Nw==
Date:   Mon, 3 Sep 2018 12:06:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: linux-next: build warning after merge of the staging tree
Message-ID: <20180903120617.34f4f8cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8ziYdG5Rf3hx_8tfgX_Io8l"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8ziYdG5Rf3hx_8tfgX_Io8l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the staging tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

WARNING: drivers/staging/rtl8192u/r8192u_usb: 'dot11d_init' exported twice.=
 Previous export was in drivers/staging/rtl8192e/rtllib.ko

Introduced by commit

  c01f06b7506f ("staging:rtl8192u: Rename Dot11d_Init - Style")

--=20
Cheers,
Stephen Rothwell

--Sig_/8ziYdG5Rf3hx_8tfgX_Io8l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluMlxkACgkQAVBC80lX
0GwHdggAgsUPIPUGs/FsX2BKvsOElKbJGO/bHj6j+388kRt64nC4efKcknbQp5Lu
AY6TpfUp2XGg6Ce7C4dMtlBlL2H6Uxgow5ErxHONStD9SzIxLtGu/+EWvoDyfEyb
M4EpTX3f91XSbQoix/EGy1l41d64enPBYbUP1HM0pXowBCXNRF8910XnLbelH8yV
EPOP8J7zvIFgM7pCNapqhqgRF1b8OSxBT7Nejnty55+slycbI8Z2K+nevuB1iNRk
3AmBf0v8nLwgqBeEvL5ZyQytJNcN2bz1ONrHCjHF9LcvHhYL3AN1OLa01/KdYW8a
bzwRSlzt6HMlT4uynBWBeJ0esk0izg==
=wTN3
-----END PGP SIGNATURE-----

--Sig_/8ziYdG5Rf3hx_8tfgX_Io8l--
