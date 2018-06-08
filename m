Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pi7wLQrVGVvKVgAAmS7hNA
	; Fri, 08 Jun 2018 01:07:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1BD7F6074D; Fri,  8 Jun 2018 01:07:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YPCj6qzy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9C892606FA;
	Fri,  8 Jun 2018 01:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C892606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeFHBHX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:07:23 -0400
Received: from ozlabs.org ([203.11.71.1]:51913 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeFHBHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:07:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41245339xZz9ry1;
        Fri,  8 Jun 2018 11:07:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528420039;
        bh=IAmQasfGz6oNr49RPRcw/nwCS+HqWxb9cEb3MuNSKxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YPCj6qzyEBd5xIIMesa+64IPmCtyGvFd01Z7uwg4XpM5f5uCYNG+VxH/qeDos5qFY
         OFF6lNSJlXhlnovpBvDHmaeX80OXMX70wW31DzZELKVe0+ZSaZ5iVUu70Xvaw8Lz0R
         /m6IPrFObcgrWAigq+snhQq9nq9cTVGISeinTjmMPTBiM9yx3uHMa28iRZpGfQbx3Q
         87JGPB3xWMfrqTxwg30epupRPHJx5CTs2ijhWA857clahVe1eV83PQwKB/uoxCwWuW
         0a43P4dEC2Eba4DCogm3Nudl3G4DJ5gmf8tU/wX20SFEtiR1pz2v988+tYwI3K89yn
         AYG140gWDrDlQ==
Date: Fri, 8 Jun 2018 11:07:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: build failure after merge of the thermal tree
Message-ID: <20180608110715.29081e25@canb.auug.org.au>
In-Reply-To: <20180608105120.2e232f44@canb.auug.org.au>
References: <20180608105120.2e232f44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_Tya2BKs_+uro/uaB=KpTxi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_Tya2BKs_+uro/uaB=KpTxi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 8 Jun 2018 10:51:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the thermal tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/thermal/qcom/tsens.c: In function 'tsens_probe':
> drivers/thermal/qcom/tsens.c:144:31: error: 's' undeclared (first use in =
this function)
>          num_sensors * sizeof(*s), GFP_KERNEL);
>                                ^
>=20
> Caused by commit
>=20
>   6d7c70d1cd65 ("thermal: qcom: tsens: Allow number of sensors to come fr=
om DT")
>=20
> interacting with commit
>=20
>   0ed2dd03b94b ("treewide: Use struct_size() for devm_kmalloc() and frien=
ds")
>=20
> from Linus' tree.  It looks like git somehow screwed up the automatic
> conflict resolution.

OK, this was caused by a bad rerere entry in my tree (from my recent import=
 of Andrew's mmotm patch series).  Sorry about that, I have fixed it up.

--=20
Cheers,
Stephen Rothwell

--Sig_/_Tya2BKs_+uro/uaB=KpTxi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsZ1sMACgkQAVBC80lX
0GwWWggAgqKYV8dMqSbBhrlPkFk/SY2l1fG65Bn6VUbTNt1YsGHJTPiE5/POMFVz
kG9WHb1keYYyfYC81WLVrBjq2r7lMFWyakLR/3IQL0lur227JYKnlEJMEkueZCPz
kT+qfkNbibgL+Ye8Lz/P/FL6ukGpaAVJm6otYb2E46B360SZSm5LPTMmI2wTow4R
fc7XtzGL+MbHlMTQQqZ7G1fwIl5XF/CjVx+F8ESUXcAl4P5sSvzvgwGHfV8WPV0I
mfdv1mzgx5Tm5UJFLYFY3J9G5yJSmShlOT962HF/cAf32f61ENpmuaI8GDkYm00S
ZfLMZL8TJOqLnrxHmwOfMGYku3sxcQ==
=GRTJ
-----END PGP SIGNATURE-----

--Sig_/_Tya2BKs_+uro/uaB=KpTxi--
