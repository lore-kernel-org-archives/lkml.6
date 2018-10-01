Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AA4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9FC2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9FC2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeJAWTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:19:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:47432 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJAWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:19:48 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g70K4-0007KU-Hv; Mon, 01 Oct 2018 11:41:24 -0400
Message-ID: <211a65a21d69ed8d358f3638d02c3f6ee63d3426.camel@surriel.com>
Subject: Re: [PATCH 2/2] mm, numa: Migrate pages to local nodes quicker
 early in the lifetime of a task
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Jirka Hladky <jhladky@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Mon, 01 Oct 2018 11:41:24 -0400
In-Reply-To: <20181001100525.29789-3-mgorman@techsingularity.net>
References: <20181001100525.29789-1-mgorman@techsingularity.net>
         <20181001100525.29789-3-mgorman@techsingularity.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bPx8Hj1pWOxURgOTygS/"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bPx8Hj1pWOxURgOTygS/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-10-01 at 11:05 +0100, Mel Gorman wrote:
> With this patch applied, STREAM performance is the same as 4.17 even
> though
> processes are not spread cross-node prematurely. Other workloads
> showed
> a mix of minor gains and losses. This is somewhat expected most
> workloads
> are not very sensitive to the starting conditions of a process.
>=20
>                          4.19.0-rc5             4.19.0-
> rc5                 4.17.0
>                          numab-v1r1       fastmigrate-
> v1r1                vanilla
> MB/sec copy     43298.52 (   0.00%)    47335.46
> (   9.32%)    47219.24 (   9.06%)
> MB/sec scale    30115.06 (   0.00%)    32568.12
> (   8.15%)    32527.56 (   8.01%)
> MB/sec add      32825.12 (   0.00%)    36078.94
> (   9.91%)    35928.02 (   9.45%)
> MB/sec triad    32549.52 (   0.00%)    35935.94
> (  10.40%)    35969.88 (  10.51%)
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Rik van Riel <riel@surriel.com>
--=20
All Rights Reversed.

--=-bPx8Hj1pWOxURgOTygS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluyQCQACgkQznnekoTE
3oOjhggAhKHjjlZ5+V2k2HFgnNIwP0BIaJIGI1w/SNNWSoK5lA33XfRVtj1u64Un
f4Vv8MS7uc/zThlSck2OOnXN29+oDv9xsYdjqk+8EpWELMcaMnmkgBKke82ftMaO
Y+kozORrA7iBMmghlnULz4cmg5VGNEWcGyewakvY9arezLd1GjIWPpbTnR4dZogw
QFyOjzRkLdsIdXo/gA5WFv6G98M3vTO6Bv14wbvEsQ1HVq3COJGCJgoXcAepIvxa
BUrwOG4OnjWwJFO+RjgyZW4imK59IZAdEBXiCCJLpyBzCHdn3nvAgHH8ph9hq82g
GtxME+JN5Z37IapgSQY7DOv5QumKCg==
=4kM/
-----END PGP SIGNATURE-----

--=-bPx8Hj1pWOxURgOTygS/--

