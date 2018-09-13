Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F245FC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551562146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sKRFjFLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551562146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIMI1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:27:49 -0400
Received: from ozlabs.org ([203.11.71.1]:39505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeIMI1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:27:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 429kRg4jzlz9s4V;
        Thu, 13 Sep 2018 13:20:13 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536808816;
        bh=I55sgPsSrhj/lYs4tQtAEyMkW4oTrIFrOxxuG7pvorw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sKRFjFLhC2c3SE4MHtEf1GDn7nOilcYxKkU/0cehzHmqZ88UP3iN2yYxi5A5KQ6bU
         do0JQJJf1KXdihf1Z/6d6z8nOGCasUOOUBhxsVxU4XFs+dkuUs6oLdtfggVVCmNcsM
         wNUmQBTAXGMa5vUx4qZlXofHhoQGgF+4efhjrNDXvIcLLXK7dMsKU34ifX7OmUUWg3
         T7h1eXgMoowUXudSVBI6NzoPGzvORaEG3ouMFXd6Ar1ax+fJYNbRkPtSGlU6OTWgyr
         ViE2oa9DqWq8+H73B9N3zvBcbWxARSSqeXv8ldiJP0I0gFMQITKQTL0V7yOeWKfBFk
         4AHvqp1W/zUcg==
Date:   Thu, 13 Sep 2018 13:20:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2018-09-12-16-40 uploaded (psi)
Message-ID: <20180913132012.1506f0da@canb.auug.org.au>
In-Reply-To: <20180913014222.GA2370@cmpxchg.org>
References: <20180912234039.Xa5RS%akpm@linux-foundation.org>
        <a9bef471-ac93-2983-618b-ffee65f01e0b@infradead.org>
        <20180913014222.GA2370@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A0EZjjD/ORosSL0xF1vKrbv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A0EZjjD/ORosSL0xF1vKrbv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Wed, 12 Sep 2018 21:42:22 -0400 Johannes Weiner <hannes@cmpxchg.org> wro=
te:
>
> Thanks for the report.
>=20
> On Wed, Sep 12, 2018 at 05:45:08PM -0700, Randy Dunlap wrote:
> > Multiple build errors when CONFIG_SMP is not set: (this is on i386 fwiw)
> >=20
> > in the psi (pressure) patches, I guess:
> >=20
> > In file included from ../kernel/sched/sched.h:1367:0,
> >                  from ../kernel/sched/core.c:8:
> > ../kernel/sched/stats.h: In function 'psi_task_tick':
> > ../kernel/sched/stats.h:135:33: error: 'struct rq' has no member named =
'cpu'
> >    psi_memstall_tick(rq->curr, rq->cpu); =20
>=20
> This needs to use the SMP/UP config-aware accessor.
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>=20
> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index 2e07d8f59b3e..4904c4677000 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h
> @@ -132,7 +132,7 @@ static inline void psi_task_tick(struct rq *rq)
>  		return;
> =20
>  	if (unlikely(rq->curr->flags & PF_MEMSTALL))
> -		psi_memstall_tick(rq->curr, rq->cpu);
> +		psi_memstall_tick(rq->curr, cpu_of(rq));
>  }
>  #else /* CONFIG_PSI */
>  static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}

I will add this to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/A0EZjjD/ORosSL0xF1vKrbv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluZ12wACgkQAVBC80lX
0GyQDgf/R2XVV++XEvoRc1HlT8r5XB6DziGyJq2s5SGzvzF4nqVChOYkL7aEBpxZ
qr5DVdFGqZigJ0eT8SWLGhNoYFyg9QOBIk3t4JNlDENfWIyQl6LPAPMo0AmtHKDK
mkJfpt9pk2Gn4s64xvtjHuW9fmBP+DIP5GxDhAa7/K3LRFZO92FnG961/yauZBXy
PWg90KvKpkbhPIV0xbr40WiY7JDC7hdPoLIBofdmLgMI5rijwcdD2lTIUoF3hPW6
NQ/0eoUv8wml4XcedidUV0jSuDC+ohfifD1n8OH4xUvJTYpgiH0pGhERrrm+msBF
AAJU5BRC8YDJNnwJQyg3Qj0+bZs4qw==
=Fhk5
-----END PGP SIGNATURE-----

--Sig_/A0EZjjD/ORosSL0xF1vKrbv--
