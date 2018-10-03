Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41178C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71C42082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NFG/5XvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71C42082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJCKFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 06:05:35 -0400
Received: from ozlabs.org ([203.11.71.1]:43101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbeJCKFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 06:05:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Q1T32sXNz9s55;
        Wed,  3 Oct 2018 13:19:03 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538536744;
        bh=znnzNVPIyUbT7uMGyQcdUct4lxSaLLDMzcP/EaMzu1k=;
        h=Date:From:To:Cc:Subject:From;
        b=NFG/5XvDCQEwndH4X2h54D/XGw1TfQL7ar4Mt6wpqKIMGy9a/lXqa+vXhU6mChC3O
         gyHbDYFIEKPos9AWIXBjmmYAuFR3IAoYiN20ijQMpwfOOdv1ZJKpuiArqgMH0BbgLx
         EvGl5eLQzEdHDOx5cf6KpxCS3V1w4bLejh6DV5UAVweik+Kr3qAknEWqx0CePUXF2E
         1vI3pjaqsJzmxznk6zLK1ojBjhuAx3KgM0Zcrk0bxIGbmwxUWc4REjPaP0okW7svkK
         drpuCGbihT6QjJ+Wm/WmgdGPSqIZytK2kszGAPdGGIk13TX6rS28FaprhR4FiWSbG1
         jatSzGCwEiCOQ==
Date:   Wed, 3 Oct 2018 13:18:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20181003131848.4f76db59@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_LeNpFlzomfevWWMX4DcrUD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_LeNpFlzomfevWWMX4DcrUD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

x86_64-linux-gnu-ld: net/core/filter.o: in function `sk_lookup':
(.text+0x19219): undefined reference to `__udp6_lib_lookup'

Caused by commit

  6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")

I assume that __udp6_lib_lookup ended up in the IPv6 module.

I used the bpf-next tree from next-20181002 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/_LeNpFlzomfevWWMX4DcrUD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu0NRgACgkQAVBC80lX
0Gz+SAf9FKEDyJgjbfjBNflGzNVaQMQ8lrdsMs7E/IcFhvGKSinjtDBl3OQK7Dpw
dJhy20OOCfs1zr9ajCCSdeiWW2NlM6d9lToWiiu0scAhoVNJpMQYeHqwx+vziJhd
Wc1VuOdissh8i/Fc9EimXppmndOh0ko+ZuqBPfry5rUAQqVnRSzqsCwomW2LbK1W
6NenlhhFpoRiH8UkZbjY/r0XckvtAcUillbLZ+YGvsPuBRx6xRzYH1QEG3CRqaOf
+62s2kThTHjE5BQDcdjQx5eu6JmjU2+6rJ8xvjMpyTeoRNsu73fR9oJiukSA/E/f
dgsJ3pHMH+y0M7yta2KTvSHXZ2Z/kQ==
=5X/A
-----END PGP SIGNATURE-----

--Sig_/_LeNpFlzomfevWWMX4DcrUD--
