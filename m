Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFDDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6E216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HztRA7MI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF6E216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeHCIho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:37:44 -0400
Received: from ozlabs.org ([203.11.71.1]:48199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeHCIho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:37:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hctP0p31z9s2g;
        Fri,  3 Aug 2018 16:42:53 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533278573;
        bh=KCLzCFHO16+QTpfWVWO1SYnPFYEGzMTD7fVCVcOStus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HztRA7MIo9VBaCLwZ8dqoTcrHHdzm4ZFO4o6qRX+gvVxSXWLexE+xFMQiqDd6UEVN
         TEX5FT/kqX/r/z7dSekr7syO/89Y0odfsduQJH0dn47k4nLtAt0Z9XsMcLymBndg/T
         ktmCIZWZntE3lk+Lm7BHal4dzErgoA/XuK+biZXSEwlJ5fuoFA6IFBGZw9fADYtm+s
         SYTcfRjeA2G9Jy6VVC9Pqvjc4yQ9YzLfOyjSuK3xNNE8EymFbQupYGk53R92GJWRX2
         mm52dDS2HM6DMdJIY+OTz0u3oXTOF9moiW7SfHccwpX/Dz0mKdosCuiz6/VoIAFQhQ
         8WgeL4N/9NLJA==
Date:   Fri, 3 Aug 2018 16:42:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: linux-next: manual merge of the mips tree with the kbuild tree
Message-ID: <20180803164252.5f519701@canb.auug.org.au>
In-Reply-To: <20180803064128.GA1715@lst.de>
References: <20180803092100.7d0fda13@canb.auug.org.au>
        <20180803064128.GA1715@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//6Qid3F994UQa5_AbKl8lym"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//6Qid3F994UQa5_AbKl8lym
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, 3 Aug 2018 08:41:28 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 03, 2018 at 09:21:00AM +1000, Stephen Rothwell wrote:
> > I fixed it up (see below) =20
>=20
> I can't find any fixup below..

Sorry about that - see below.

--=20
Cheers,
Stephen Rothwell

fdd83c534b114febc41ec115449cb25f421e1719
diff --cc arch/mips/Kconfig
index 06a633eb9777,642a56e2a1ea..2af13b162e5e
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@@ -2990,6 -2988,13 +2984,9 @@@ config PGTABLE_LEVEL
  	default 3 if 64BIT && !PAGE_SIZE_64KB
  	default 2
 =20
+ config MIPS_AUTO_PFN_OFFSET
+ 	bool
+=20
 -source "init/Kconfig"
 -
 -source "kernel/Kconfig.freezer"
 -
  menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"
 =20
  config HW_HAS_EISA

--Sig_//6Qid3F994UQa5_AbKl8lym
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltj+WwACgkQAVBC80lX
0Gx4sAf9GVRiLKOf4m5j4OctetBwbUwBSZp6OJaiDy5qfgqTbyJb0NGZDoDs4mGx
RWwHJeBdvYfhhv/6Z7QVP7S2MZK96KIsQS/YMI/eFVu5BY+0rFngFwpPT10JOjwG
IRt2xloJpQ/dc8ZS3xyctEBwtJN9QAnnLSI23/rszc2hikq8HF21kj1nV989wMrJ
i2n81rXqsGkeE8SxxCPv13lzVEAIxOQoK2ZpQxoVqBzul5ewk3y2rJS6xE1dYYAB
R21r3C+3OHnTQ/uIqk2xtzQMzVSVdpndXvu/u1vVd1NN5eJS74rLJUSg1T0NUfaK
50t+BAfo7/IT3TtaRxgjO+0zpzimDg==
=jdUD
-----END PGP SIGNATURE-----

--Sig_//6Qid3F994UQa5_AbKl8lym--
