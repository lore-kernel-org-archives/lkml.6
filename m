Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02636C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F3A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uvZykB3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfAaIfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:35:42 -0500
Received: from ozlabs.org ([203.11.71.1]:53877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfAaIfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:35:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qtpy4mQCz9sBn;
        Thu, 31 Jan 2019 19:35:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548923739;
        bh=xfBHUwQQNvJh9rH/G8lahQx5gYekEGK69zUWm1IP4/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uvZykB3pxHYTEe0q7pvf1p5h6ZZnzKSMYw2irOIXbMGbQmhokXCX7bKEX7U20rTmG
         paFH1hn9bQNYKVt5SPFHBHDcHGuFGbF2g/PL/1ZdLLte04xISLYHJdjRzkvbSD7O1+
         q2YMSgGGuaTugv7vFZmAFcw6H7kSFzvH1NEHq8W1mtgwWvNmjvpmTaed0b+EA038Qz
         TFjZx0Db9uIyuYxW2tWLxRWndaryuFShQRMgDNLQlKwEzXjNXmycMb3tFtlaySh17O
         F5/1o99CwyqDPGB0TFmaJPEcNo+8y1Od7ekgcw8IWR+sBOootAd9nXIy74uUaXLvUG
         s0mWEg9miLwpQ==
Date:   Thu, 31 Jan 2019 19:35:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: linux-next: powerpc le qemu boot failure after merge of the
 akpm tree
Message-ID: <20190131193537.3ee3c210@canb.auug.org.au>
In-Reply-To: <20190131074018.GD28876@rapoport-lnx>
References: <20190131163854.307e17ab@canb.auug.org.au>
        <20190131170629.2cc20600@canb.auug.org.au>
        <962e7dd7-779b-2c32-59db-9ced6751dede@c-s.fr>
        <20190131074018.GD28876@rapoport-lnx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3HCzB6POlHzSyJeaUMNsuSh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3HCzB6POlHzSyJeaUMNsuSh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Thu, 31 Jan 2019 09:40:18 +0200 Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Andrew, can you please add the below patch to as a fixup to "treewide: add
> checks for the return value of memblock_alloc*()"?

I have added that to linux-next for tomorrow (in case Andrew doesn't
get to it).

> From 854f54b9d4fe52f477765b905a4b2c421d30f46e Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Thu, 31 Jan 2019 09:18:50 +0200
> Subject: [PATCH] mm/sparse: don't panic if the allocation in
>  sparse_buffer_init fails

Thanks all for the quick resolution.

--=20
Cheers,
Stephen Rothwell

--Sig_/3HCzB6POlHzSyJeaUMNsuSh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSs1kACgkQAVBC80lX
0GxfEAgAkdFna3qHRxKrhWtPUWeVPybkdL8yOyiL4dLOnCTHVj68HzCxCH9LpwJa
DUb+ExtaTjcoz3MvHVnJXnZyAkzIkw63mHpYwpClgg/wt7tyA2rVtmHqF7+5TlHx
4YUq4V8N4wFoiU7/obW9eKEQWQaDHtn5XPuwZys4al/MgMX4BMD7/QhSmPNkYJk9
gfxnHLWnkeiOioebDuQ49TZgtdKYiGaMLjUjoxRqcL2z9TIeP4XroCT6H1g78mlB
epEReSKn85EBD/WWBMgXJ3ZwCL5X75UKhL+WuTpQ/afOmCZ15LDMt7PR5ZIGPOrl
FuTKp54kzDFNhSsE2ore2lxiK06MGg==
=0ZFX
-----END PGP SIGNATURE-----

--Sig_/3HCzB6POlHzSyJeaUMNsuSh--
