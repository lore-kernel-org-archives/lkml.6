Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16C6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F1E21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BM6/Jxdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F1E21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbeIUOgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:36:12 -0400
Received: from ozlabs.org ([203.11.71.1]:41221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUOgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:36:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GnLX1Cs3z9sC7;
        Fri, 21 Sep 2018 18:48:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537519700;
        bh=VLNM19WahhkJWIRZ060fN8mgE/UuvaFDeWIKS5lsHkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BM6/JxdoeN7qVZOCW/q1SxerFWi5JcfRvMfCMqyQ05a7t5T2BZK6emcaFIMzA69gu
         2IFwZXHrFMMDpVbTp2JaeZe+l5s0HrRbj8U5eLaARmjVijgoSIN3Yt3oGdEjAJtYlR
         hVQf0iqcr55Bfb0cpuKBNK8zkIroN2wWlsUb3o9MLB3hxxsP1tTdgDpYyI/+C3T0iW
         zOFIEZ8Uh4/XC/YZiW9EyNNW7KgZMmjg3+eQ1xb4aFkl0ATJaGXkrnUPwwaI1isHkJ
         9G3sa4fUzb9/7/ZsbGByeJ1PAIdtyp7jk2jCku1qZ3mxPHIP0J3vzWZubKWalNXpCw
         /4LtEjoTN1KAg==
Date:   Fri, 21 Sep 2018 18:48:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 6/9] signal/powerpc: Call force_sig_fault from
 _exception
Message-ID: <20180921184819.31e97d4a@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-6-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//oavHTfsofletcttCN6o5i3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//oavHTfsofletcttCN6o5i3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:47 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> The callers of _exception don't need the pkey exception logic because
> they are not processing a pkey exception.  So just call exception_common
> directly and then call force_sig_fault to generate the appropriate siginfo
> and deliver the appropriate signal.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks right to me.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_//oavHTfsofletcttCN6o5i3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluksFMACgkQAVBC80lX
0GyYsAf+OiYQG3ODygJsePBryYHacWy/HSB4up16a8tiS+Z7tUtZ2qvt1ws0pDt5
6m6Zezu956UM4xpHzbfyTkghJa0cWJkf330zzqNKEkfkIio9R2DMCW0ZQrM/U0Kf
lBz4rX5O9y1yKKf1fjSW3TmpyGoE+J0XWt2LHvP25uulsc3Yz8j0HP1W6NV49DSM
s2rxt3N2SFOIw/9yCxZGNhjBeT06hnTqlaLIbJtYxRrmc9ZNmz672SrMfC2AbG4M
bxuip5jj84XaKAAdOEeAtvESJoD0kDgaRNMx8tqomhkxWt5Vy3AO626jzs20OpG2
eJUo8DhIdxrx1I27p5xpI3/D8bHWhA==
=mCgH
-----END PGP SIGNATURE-----

--Sig_//oavHTfsofletcttCN6o5i3--
