Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83393ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAB620869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAB620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJSXXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:23:33 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45578 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbeJSXXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:23:33 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gDWWA-0002GZ-5r; Fri, 19 Oct 2018 11:16:50 -0400
Message-ID: <824154aacf8a5cbff57b4df6cb072b7d6e277f34.camel@surriel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
From:   Rik van Riel <riel@surriel.com>
To:     "Jan H." =?ISO-8859-1?Q?Sch=F6nherr?= <jschoenh@amazon.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
Date:   Fri, 19 Oct 2018 11:16:49 -0400
In-Reply-To: <a177875f-2072-ab55-b079-f2142d9b776e@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
         <20181017020933.GC24723@lerouge>
         <a177875f-2072-ab55-b079-f2142d9b776e@amazon.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wI8nA2L1ALPaFNJh5pkd"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wI8nA2L1ALPaFNJh5pkd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-10-19 at 13:40 +0200, Jan H. Sch=C3=B6nherr wrote:
>=20
> Now, it would be possible to "invent" relocatable cpusets to address
> that
> issue ("I want affinity restricted to a core, I don't care which"),
> but
> then, the current way how cpuset affinity is enforced doesn't scale
> for
> making use of it from within the balancer. (The upcoming load
> balancing
> portion of the coscheduler currently uses a file similar to
> cpu.scheduled
> to restrict affinity to a load-balancer-controlled subset of the
> system.)

Oh boy, so the coscheduler is going to get its
own load balancer?

At that point, why bother integrating the
coscheduler into CFS, instead of making it its
own scheduling class?

CFS is already complicated enough that it borders
on unmaintainable. I would really prefer to have
the coscheduler code separate from CFS, unless
there is a really compelling reason to do otherwise.

--=20
All Rights Reversed.

--=-wI8nA2L1ALPaFNJh5pkd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlvJ9WEACgkQznnekoTE
3oM/nggAmei8WMFFpIDkYV2ylWz0Qc5w9z9zdFoLkxj0Q8g1HtIbfJLSHYN6o9TM
gMMkX5lkXkeT8/cHy5KAQALnert835kB0a9ONLaPq+uwtk9/kGPfHAp9rrpKvO50
O/hhYtWzfL3QIwPaAkb564UC7+fHMraSpdNnq234qGhyJODgJsilEZx4ykk2fv71
HD6HwGOq6QKk5qN5QxOxu7Zvmv2NOxvX16/BYBMK1Aypbm842fd1vp7tk3M1Wo/v
nBTyDr2iACAWxjeF6iqBeBcb2hX8UV/4ERfsHERMlUV5gQ5U4iz0E55wGZOkGAFJ
mwXD//jw9ICUFHxJ3MUDHbvzvcHfzw==
=NclB
-----END PGP SIGNATURE-----

--=-wI8nA2L1ALPaFNJh5pkd--

