Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F27EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E698C218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZwTmgo4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfAHJu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:50:59 -0500
Received: from ozlabs.org ([203.11.71.1]:45145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfAHJu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:50:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43YnZR1cbFz9sDr;
        Tue,  8 Jan 2019 20:50:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546941055;
        bh=eCPoVcFemxDFWVhLtIr/uJh5UL9XshQQl2lhEB5pCfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZwTmgo4xNKFlDVsX57p4U2gd7hOp6iaj9xUuqSFYDF+vpJXNcocM9w2eS1wSrk5Hz
         DpJLytR2cEyRBF5E9E3uiZYGw/FraXOD/hdw9Q4lMierhtSKhGpC5hpGdld/8tEdyl
         3yT5x+vCalRZMhr5jTD9yLr1JjaGyQtCTB30y2ZWvMTM8xHtEzSQaierBgLaLPiqhZ
         TmPaSkTbW3J85C9smb7tr6jyfXZ75uGRAi7h4q6RPzDOIo1xC43hl3ReG6wTaePKnL
         NKNYU/kcy63ts86mX0ojV7TqFfjo0LuKjTpHXKeW/hP40Wm/rHmg5rSyeu4LNpMvRg
         v6kbk0fjTl4Sw==
Date:   Tue, 8 Jan 2019 20:50:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190108205019.63ee0e04@canb.auug.org.au>
In-Reply-To: <78f2ee4a-9851-2b5c-18c6-ba3f3e6bd302@arm.com>
References: <20190108131141.730e9c4f@canb.auug.org.au>
        <78f2ee4a-9851-2b5c-18c6-ba3f3e6bd302@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/87.Na2.kJfnNg6cGqx_2SRQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/87.Na2.kJfnNg6cGqx_2SRQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anshuman,

On Tue, 8 Jan 2019 10:24:18 +0530 Anshuman Khandual <anshuman.khandual@arm.=
com> wrote:
>
> Just curious why the NUMA_NO_NODE definition did not get resolved from th=
e local
> numa.h which had the same ones copied over from linux/numa.h but anyways =
the fix
> looks okay.

I assume that <numa.h> is /usr/include/numa.h (i.e. the system include
file which is whatever the distro installed) while <linux/numa.h> comes
out of the tools/include directory (i.e. the one we copied over from
the kernel source).

--=20
Cheers,
Stephen Rothwell

--Sig_/87.Na2.kJfnNg6cGqx_2SRQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw0clsACgkQAVBC80lX
0Gyu+wf+Mi/Q5OCYzDZUasaeWYGUHXu/OXxjIu2y36/h5i02Ri640GLXplJJhqRL
o2gjCMgcjaI8KMdP80XKF32axAYFmM0119rZu7C/Y4yf/J/1BsdcLGB00e6SQ36X
aE6q9HhTjB9xVnNCvAYaoK8F9alvUc5+4vhdgQxeQfL39fw+4Fr/fcJvtj0O/+n2
oH1V7do26aq1x014NjLjEMXmtBKq0MIV1rEPaS2PsERIuN9doIFhJVkw/pTZIqen
powB9B2hBnWQs6X8ww0brtCSurMvt+Fp+CDQHevTpcuNDGfX+VBPkP1sEwjA+rT5
1sndaFfn7uI5jJewhzgrD519x1RpVg==
=sVHt
-----END PGP SIGNATURE-----

--Sig_/87.Na2.kJfnNg6cGqx_2SRQ--
