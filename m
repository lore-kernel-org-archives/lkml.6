Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F41C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808CA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808CA2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJIPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:15:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41994 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeJJIPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:15:10 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gA2mf-0007el-5s; Tue, 09 Oct 2018 20:55:29 -0400
Message-ID: <eb192cfdb1a3b581532a0daba22e9aaa6ad3094a.camel@surriel.com>
Subject: Re: [PATCH 1/4] mm: workingset: don't drop refault information
 prematurely fix
From:   Rik van Riel <riel@surriel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Date:   Tue, 09 Oct 2018 20:55:28 -0400
In-Reply-To: <20181009184732.762-2-hannes@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
         <20181009184732.762-2-hannes@cmpxchg.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ouGNk51VEckTbiQffXyq"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ouGNk51VEckTbiQffXyq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-09 at 14:47 -0400, Johannes Weiner wrote:
> The shadow shrinker is invoked per NUMA node, but the shadow limit
> enforced for cgroups is based on the page counter, which isn't NUMA
> aware. Instead of shrinking shadow pages to desired_size, we end up
> with desired_size * nr_online_nodes.
>=20
> Switch to NUMA-aware lru and slab counters to approximate cgroup
> size.
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-ouGNk51VEckTbiQffXyq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlu9TgAACgkQznnekoTE
3oPiaggAspsShtaovQVpfvOwsDhbCZP54bnOk+EYcK4GMiIXDrtTuy883bbh8ptl
5QPtIxW6GgGLGm3nr6NeOH2ErhOODezvDLC8oZf4ERamRcYsxzjJKB8SYJRTxz8A
0VDRnRo2AOofQodaKOCxW6iYXUiO1QZX8NlPVGoa9WveNuo8mC2hp5k1gFMuhekY
1CTl5zpy3Opa5m+wS5SyyjIMm0iYq+ZgKkPARqeQ4wP1GCUfZj2uQ8yqqINZh4C7
FhV891Q+pzb5xggz19AX4K4rkBKzQK/Ug4bDn+vVjrC5lGzuXb2wSl4/sPDyZk0B
s16EXFprCUiSsisZHMmomfrQQ868+Q==
=51R3
-----END PGP SIGNATURE-----

--=-ouGNk51VEckTbiQffXyq--

