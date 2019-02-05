Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2F72184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z+uCWaV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfBEXoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:44:38 -0500
Received: from ozlabs.org ([203.11.71.1]:42683 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfBEXoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:44:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vLlQ5ltNz9s3l;
        Wed,  6 Feb 2019 10:44:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549410275;
        bh=efUyDPjQoZeLCUBHeUOPt4mtiY+3lGvvpSdI/Gp9sGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z+uCWaV7rIa9D/B1SVxiqlhaV3xr+MuuD+DM/F0kR450c066qll/bNNqQ+ufm0pQ8
         loNkMXteEWynTuV7LIhdIstjQYVzSNOj39Q2jPGUOV7E0fw5oGxDW0bAKTwI95q75E
         AlX4FVMQD0D4ML0KpMA70xLogHOvtPalpR7CQ1xspURX37Sgl7NgrfFplEiC0axYPk
         hkXq9mOvr0WNBnbRm6nrsDFx+iAuB5vBq1/y+CC4O8Ds1ipvTGX9tiLMJjbSRn0cFi
         HM1qQKedDNd/We41LKYSb/2N8ecaF6Db+MoNTU3yyHfIeiQpURVR3xgY9cbl5Ed1TH
         DYgiAjWaKm/vg==
Date:   Wed, 6 Feb 2019 10:44:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>
Subject: Re: linux-next: manual merge of the mips tree with the mips-fixes
 tree
Message-ID: <20190206104433.1c832a0b@canb.auug.org.au>
In-Reply-To: <20190205233530.tnk6boxzxm7okgcr@pburton-laptop>
References: <20190206091736.73bd95ec@canb.auug.org.au>
        <20190205233530.tnk6boxzxm7okgcr@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I8EBZ///vtMYXyZ=Im65Tyu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I8EBZ///vtMYXyZ=Im65Tyu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, 5 Feb 2019 23:35:31 +0000 Paul Burton <paul.burton@mips.com> wrote:
>
> cmpxchg() doesn't need the added loongson_llsc_mb() barrier that
> set_pte() has in mips-fixes because for the affected Loongson 3
> configurations the smp_mb__before_llsc() that cmpxchg() already contains
> is equivalent (both will emit a "sync 0" instruction).

OK, good to know, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/I8EBZ///vtMYXyZ=Im65Tyu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxaH+EACgkQAVBC80lX
0GxYNQf/ftzRetfxC0vB4nWsaAsrCpC2G63z0791p/OZx1lMk217b1Z4q1pFZ4qo
KXn/v2C0UF4NJkUoDTCvmWhaxL+hj5Uj662iSFm3soYpXTyNRujLZ1DY+LyiOpyC
+UIFf0enA8JZ+KJlE9M3TKP1dR6S59OiGocpIqmcqInE9hpcc08qwxCh6/LwTGAl
w5nE7j0rJLxXnrSgPipV1SMMNT7PUANZ+6Hicm7d4p3vJVy+L39cH5GMlk0YB5XN
mgDkcIavnYRQJW563H+hkLqcvynohd0hBohrSZhpwcRB51k1NonggVkr+T2mtQcC
Xm/049xk1/DUktO1jtxovS2ORwASsw==
=7jT0
-----END PGP SIGNATURE-----

--Sig_/I8EBZ///vtMYXyZ=Im65Tyu--
