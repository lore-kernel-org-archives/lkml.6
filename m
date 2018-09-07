Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0CBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247CC2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kllTi29t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247CC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeIGE51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:57:27 -0400
Received: from ozlabs.org ([203.11.71.1]:46195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeIGE51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:57:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425yjm2jjVz9s55;
        Fri,  7 Sep 2018 10:19:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536279564;
        bh=gTQPDbjVgsYLeTiyAflWtPEdIbISyZ+KCSsXdDOk5gw=;
        h=Date:From:To:Cc:Subject:From;
        b=kllTi29tCoqUpizxsOySbZsZsT705j+Z7e+4vnZCFfYhkXv2voMzldsZr7KfaTPCb
         qyUSUuEBBnKgkSiz/rntDzKKzYNDXdwUzecQdP9byAWdmi4u8VNteGHax+IP8kKfEk
         UeVh0kI1NEWyOfFX7ARToFNw0hZONaY32bvgv1OZNwZJ8Pa8YK9BGvw7Se3uOM1M5R
         j9NuCrk0pU/YZisoBWfUlDNVnpNXsLOmzE34wGuBdBZCoHp3jNfaEeGpVUo7qZHdWv
         YSu3d3M7UlTAbFrxZQ7aYBf5b8cPIqWeJzAlVKKLYhvXwciVhAzMZkIztU7QU+gNCt
         8uVoJ/38D830A==
Date:   Fri, 7 Sep 2018 10:19:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBl?= =?UTF-8?B?bA==?= 
        <bjorn.topel@intel.com>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20180907101923.4d2a85c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qSYX_iRFPcE6o1KMvibSdYY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qSYX_iRFPcE6o1KMvibSdYY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ERROR: ".xsk_reuseq_swap" [drivers/net/ethernet/intel/i40e/i40e.ko] undefin=
ed!
ERROR: ".xsk_reuseq_free" [drivers/net/ethernet/intel/i40e/i40e.ko] undefin=
ed!
ERROR: ".xsk_reuseq_prepare" [drivers/net/ethernet/intel/i40e/i40e.ko] unde=
fined

Caused by commit

  9654bd10da60 ("i40e: clean zero-copy XDP Rx ring on shutdown/reset")

CONFIG_XDP_SOCKETS is not set for this build.

I have used the version of the bfp-next tree from next-20180906 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/qSYX_iRFPcE6o1KMvibSdYY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluRxAsACgkQAVBC80lX
0GwmEQgAiWmG1iITZcZF5FhWViHP1MiECvbv99kcl3NYUqxLPR0lMdtLkJbGxESd
+iSKb3AKxA2VFOh0xMSfxQbsTP/vw/WFoejIDk72q+VefR7pppkPf7VsCPsW4cdx
HZoUdPoTD6Z18iid7oGirCxr1JF9jgBaOWdcA3x8fn0v8IjZNfSNOriqkDQ7+mbj
wxsSiM08vcTINF9K/vWqf/6zgYpn7Xq6AG6opT7nmxZ1vr9qkUVXj28hPmUwWYNK
46703M6iZhLkMF47kgCNc68z2B1o91u+wa8vwoOCE90hlODw226DSeRHj9s0eopN
d5xGNXHbdspVN43ORS0ZFiuovMi+oQ==
=C2jJ
-----END PGP SIGNATURE-----

--Sig_/qSYX_iRFPcE6o1KMvibSdYY--
