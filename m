Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4142DECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE11D214C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XJsXooW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE11D214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeIWPCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:02:40 -0400
Received: from ozlabs.org ([203.11.71.1]:33699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeIWPCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:02:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42J1dp5VSkz9s9J;
        Sun, 23 Sep 2018 19:05:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537693551;
        bh=yvZOulPJjljsAEAlKTxlXn0EJipUXbE7ECaYzGVWdIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XJsXooW1fjeYlo+x2A4ACzrFDIuduzwnVad02z5piNgIN9FE9C3+FjvkVTuX6c/UB
         LHrJVy+UKVDK66c9AIt0utroJbt5ahTbNShedi4r6j04mtaYOeH0IPumjEYHMBmGoJ
         Tazff53/2DfLaDtWWKElAnFTDqTx+6yeAyEAjriJKtMnUt+PKD78Q6IFCYWrA7keCd
         n/ZXrP3yUSiGZQC5FObhKVtYrxIFXNgZwXIH6hHmD8ouQCWwtocz3eRl/zP4cWu9GH
         orWpQIizjVDVuaI2AW3fVMkg8PclJJl8mWVvRc93vEpXP83kXrkwi5SqpHZJZ3IA2F
         W/Ggc5KsSIboA==
Date:   Sun, 23 Sep 2018 19:05:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] powerpc: Remove duplicated include from pci_32.c
Message-ID: <20180923190549.1de60304@canb.auug.org.au>
In-Reply-To: <1537690328-77353-1-git-send-email-yuehaibing@huawei.com>
References: <1537690328-77353-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WWIZE=ZAavuz4SP_FRcygZC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WWIZE=ZAavuz4SP_FRcygZC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi YueHaibing,

On Sun, 23 Sep 2018 08:12:08 +0000 YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Good catch.  It was added by 2 separate commits in v4.18-rc1.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/WWIZE=ZAavuz4SP_FRcygZC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlunV20ACgkQAVBC80lX
0GyHRQgAh2paAZg1pxKRLibvX6qiQV5EDyFHpjlyVlAoTJBHVrVLkGnci+r9Uaaz
HoY4az0poqh7jkKTpGj2WeoJKPvPmDk+KYSMGTZLdVxT+N8f3Y8djaUeBcq7dxpY
20xOoSJJsFxr8sCG3ey2+UE7PPKRuQRC1G0DmWX0F161tzBJ6HO+dFHC3NsD2EXG
Os2MGl0fIdttT+C258QBS9JfzjIVZd7p/9foXsC2GCPGMVqMQHfIC8rXpYfQpsf5
/NJ+pr2M9IN7YVwleQ/9L/ZpliQCjJ3eI4uvCi/5IBPdk4hxhkwH1I151W7rl7cF
euT0y+MzpttSOQCK9HfLTMIBoE1iSA==
=EiDL
-----END PGP SIGNATURE-----

--Sig_/WWIZE=ZAavuz4SP_FRcygZC--
