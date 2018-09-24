Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42AFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFE42098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFE42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbeIYAya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:54:30 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36428 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeIYAya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:54:30 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g4Vwc-0002x9-U6; Mon, 24 Sep 2018 14:50:54 -0400
Message-ID: <74020842196c81ae6b3910690931fec09b7eac1c.camel@surriel.com>
Subject: Re: [PATCH 0/7] x86/mm/tlb: make lazy TLB mode even lazier
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, songliubraving@fb.com,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com,
        luto@kernel.org, npiggin@gmail.com
Date:   Mon, 24 Sep 2018 14:50:54 -0400
In-Reply-To: <20180924183759.23955-1-riel@surriel.com>
References: <20180924183759.23955-1-riel@surriel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dXQpvxIXiF6bWZw6csso"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dXQpvxIXiF6bWZw6csso
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-09-24 at 14:37 -0400, Rik van Riel wrote:
> Linus asked me to come up with a smaller patch set to get the
> benefits
> of lazy TLB mode, so I spent some time trying out various
> permutations
> of the code, with a few workloads that do lots of context switches,
> and
> also happen to have a fair number of TLB flushes a second.

I made a nice list of which patches this code
is based on, but I forgot to copy it into my
intro email.

The patches are based on current -tip, plus:
- tip x86/core: 012e77a903d ("x86/nmi: Fix NMI uaccess race against CR3
switching")
- arm64 tlb/asm-generic branch, including
  - faaadaf315b4 ("asm-generic/tlb: Guard with #ifdef CONFIG_MMU")
  - 22a61c3c4f13 ("asm-generic/tlb: Track freeing of page-table
directories in struct mmu_gather")
  - a6d60245d6d9 ("asm-generic/tlb: Track which levels of the page
tables have been cleared")

--=20
All Rights Reversed.

--=-dXQpvxIXiF6bWZw6csso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlupMg4ACgkQznnekoTE
3oNmjAf7B/aWZb4eaq5tczysldBRvcmPzyMRZu/v3e0MB/BSF+WeWQy66RMMDBxE
hQWCI8X5c0hSv/bClNbsBxSx68Zk76/I+Oc+Vnbg/T9qgynuSlHz8dqX5dW6PkDO
HezgHZsaagVCuzsnpE2QcD+cwTD8q54IKGX1m0hyttRE1C2XUy/2bFYAVTPe4dhs
f6XJBnUA+l29ChfcPGicZ6ruYA56OipIpYsb2I51nuPJRsHs0WewOmLOCxfynXRQ
nEaFeVDbKaEsUKhr+H6iJ5wyCef4O7t7KTWO6Mq61W281oxB8t2ZRbtpSl2RHp7a
1hnSlcFO6XNx3Xx2pb74k62bGj8xvQ==
=LllL
-----END PGP SIGNATURE-----

--=-dXQpvxIXiF6bWZw6csso--

