Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71772081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bIwbH8cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71772081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbeK2I2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:28:55 -0500
Received: from ozlabs.org ([203.11.71.1]:41139 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2I2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:28:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 434txF2qnhz9s47;
        Thu, 29 Nov 2018 08:25:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543440353;
        bh=OZ04HJ4gj8XCVMPkv4JQPZYotR86j0nieGEJir0/B7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bIwbH8clBbkgCPQNbqyz/Kbn29kcu6vK7xqeYJcZoZSyF/gfC/Qf1jfpm8lrxp06g
         By+vXiC6Vc2CrRmMZ8qpgAe8dYxXgoLeCeOY6NV1ECyFB/sL2exviIEXIAF91dP+s6
         SfiMtQyTFhbGxUHdwXSW8eZs9+mC3KWCXG4sv3In9FxiitKffM99BvwmuDu/BP4CF9
         s/90xXMPyvIO66PdRvT4bar07JkFUQ1l/gyJwvr1hkpRk+iNcbB8nfgqe3rmZnO/v6
         HSXW3YPMrlT++Gc0FlCQjHyzTkZ3KEL0vLftFrAqPJQ+fRlosSEHinkAjRiMDYong4
         vS9AkXT1eXcEQ==
Date:   Thu, 29 Nov 2018 08:25:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@codeaurora.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: linux-next: build warning after merge of the qcom tree
Message-ID: <20181129082540.4ceafca6@canb.auug.org.au>
In-Reply-To: <20181116101059.18ad3fc9@canb.auug.org.au>
References: <20181116101059.18ad3fc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SN4eh0CRU8GVl=3z4orbLBe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SN4eh0CRU8GVl=3z4orbLBe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 16 Nov 2018 10:10:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> After merging the qcom tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_vot=
es_init.constprop':
> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is use=
d uninitialized in this function [-Wuninitialized]
>   pri_count >>=3D 1;
>             ^~~
> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
>   sec_count >>=3D 1;
>             ^~~
>=20
> Introduced by commit
>=20
>   ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_d=
ata()")
>=20
> # CONFIG_QCOM_COMMAND_DB is not set

I am still getting these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/SN4eh0CRU8GVl=3z4orbLBe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv/B9QACgkQAVBC80lX
0Gy62ggAlDWHi4LSmWRCg6HUZGvAE+NJA00y7bUKrFucfOuOpGKKJjkqd6ThzSDz
unzCwj7E0piXYRgNJdNJ0zu0R7oHd9fIKty353/gI7KfXThum9pgXotThulYm/UT
52pwxOGX4+PEKDsh4AT9O7mb6+9/I0235TkTH+v56CNDOb/zjnLYhcrjULhIW0D5
UhEutoBKKS+x+Jn1DXdgZZNhSraoCIl0q4K+yI8pQPjML11WTYak4SWdpaEUW9Zu
iJEIbUnEh97LVbtO4YSQ69gd/Jr1aqowl9tTHHp2AaglXVHOQ8IZWPjsNFXulmrx
jExalEAWG0XabYQGYxlyXsdeWf/5ug==
=u3Mf
-----END PGP SIGNATURE-----

--Sig_/SN4eh0CRU8GVl=3z4orbLBe--
