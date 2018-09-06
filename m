Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACAFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E652075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E652075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbeIGBHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:07:18 -0400
Received: from shelob.surriel.com ([96.67.55.147]:43984 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbeIGBHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:07:18 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fy0ue-000096-1v; Thu, 06 Sep 2018 16:30:00 -0400
Message-ID: <fa7c625dfbbe103b37bc3ab5ea4b7283fd13b998.camel@surriel.com>
Subject: Re: [RFC PATCH 1/2] mm: move tlb_table_flush to tlb_flush_mmu_free
From:   Rik van Riel <riel@surriel.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Date:   Thu, 06 Sep 2018 16:29:59 -0400
In-Reply-To: <20180823084709.19717-2-npiggin@gmail.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
         <20180823084709.19717-2-npiggin@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QttmgVvdlWOXMEILqZsq"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QttmgVvdlWOXMEILqZsq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-08-23 at 18:47 +1000, Nicholas Piggin wrote:
> There is no need to call this from tlb_flush_mmu_tlbonly, it
> logically belongs with tlb_flush_mmu_free. This allows some
> code consolidation with a subsequent fix.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

This patch also fixes an infinite recursion bug
with CONFIG_HAVE_RCU_TABLE_FREE enabled, which
has this call trace:

tlb_table_flush
  -> tlb_table_invalidate
     -> tlb_flush_mmu_tlbonly
        -> tlb_table_flush
           -> ... (infinite recursion)

This should probably be applied sooner rather than
later.

--=20
All Rights Reversed.

--=-QttmgVvdlWOXMEILqZsq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluRjkcACgkQznnekoTE
3oOfdAgAgn63e88Lj0I9lDDOx5WKhEfgPfWM7o5JhGZg8FxNA8lfLlgA3tFPYd4+
mYWwbBpKSf+yLLRvy4V7V4pv7b0gk7jYTvxir3iOfFcFZ0OQVKYrbr2+txZJb6Xj
tosM9v5SsYMwJHGw+1cD0DQsvR/6uio0TthxchcpV4bNVvW1X8HlzFarPY32kpf8
HRU7NF/7gS2sxPQLPC/i+m4YgnuIq5xfseMOVVFp7H+uNI5BLCyrDm74zbFbtj1A
HtFG9Yp4pj0KX/Bq7oiLOQ9suEtcJUI46sERyergDvFFRhTwoBGRxJ/wbKRQkxIF
elqWT6jifgV0u6aRFHPPkEIuIUdTbg==
=/CHW
-----END PGP SIGNATURE-----

--=-QttmgVvdlWOXMEILqZsq--

