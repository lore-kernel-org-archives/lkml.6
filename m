Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CB321874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfADUOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:14:51 -0500
Received: from shelob.surriel.com ([96.67.55.147]:40916 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfADUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:14:51 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gfVrh-0004JB-JK; Fri, 04 Jan 2019 15:14:45 -0500
Message-ID: <a8e412e9e0983b380983099af9a90b9760f0edae.camel@surriel.com>
Subject: Re: [PATCH] fork, memcg: fix cached_stacks case
From:   Rik van Riel <riel@surriel.com>
To:     Shakeel Butt <shakeelb@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, stable@vger.kernel.org
Date:   Fri, 04 Jan 2019 15:14:45 -0500
In-Reply-To: <20190102180145.57406-1-shakeelb@google.com>
References: <20190102180145.57406-1-shakeelb@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-12qNsl9snEwifMAZ7N/9"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-12qNsl9snEwifMAZ7N/9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-01-02 at 10:01 -0800, Shakeel Butt wrote:
> Commit 5eed6f1dff87 ("fork,memcg: fix crash in free_thread_stack on
> memcg charge fail") fixes a crash caused due to failed memcg charge
> of
> the kernel stack. However the fix misses the cached_stacks case which
> this patch fixes. So, the same crash can happen if the memcg charge
> of
> a cached stack is failed.
>=20
> Fixes: 5eed6f1dff87 ("fork,memcg: fix crash in free_thread_stack on
> memcg charge fail")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <stable@vger.kernel.org>

Good catch. Thank you.

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-12qNsl9snEwifMAZ7N/9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlwvvrUACgkQznnekoTE
3oNgnAgAq6FDLf8JFXdxaI5a/OrCOHkZMEgApfIj4niwaw4iM9qXvM5krVAQ2X+r
vPFrxY7h0mcDljuUAuKxMoBbKnBVHZM72iLk/iD8T2mXT43aEtLsDYM/Nn/B6ric
uOcG+ScFutfcfOoF0B62pPFIQ/WjA9EY5Oc5yx19lRe1/tZpatwHZnOmCbQa7xvp
EGNr3C7dkz4xmgAOEv9k2+yPqgM1AstekA85rQBiQWY/8pNx+vAxOy97UKrfJa2Z
C3Ar/TgmuN2xUwCtPWNAIt4tt3tND5rtdgoczUu5duORPLPpCqlgPwQcizLq85bI
p+DF4agefINLKG1AnjiNta1jjpiACQ==
=tR4H
-----END PGP SIGNATURE-----

--=-12qNsl9snEwifMAZ7N/9--

