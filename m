Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E2DC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94E621A0D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dBWisTEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94E621A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbeHFUAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:00:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732994AbeHFUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QYw4gXF7Klx/au6ypo5XNt5KNSd9SQUIXHTVsEqktBY=; b=dBWisTENPtBA1RFmdvWfXGfx6
        Z2E9Acl2VHTltxA2H2xJ9RfwwrO22bePL3h1uL8Dh+3RudSDKtD1bdGKhQdjCD3mKsTnZqj9yaJng
        bxje/beF30qa+lIx9dI7RlIsHwuocJ7Dgw6MQzsSi5bZXkQJcQSptq4AkpTi0AH3/qiG3ztoqtftw
        CtMNm5IOUQR+HjBKaIGsuaDN8UFAA/vlzKB6gCxh3invhw52TYYESCTQt/nPaF+OHF00K9JlBy2o/
        Ooc4RsNrKz+TCUmA53V0x5p08xPxWWaDvnLe6oXhR0b5TWIX4SWcx9yiL6G92mB+e1WbNkq9ffxIE
        jY8paXa8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmje3-0004d5-Pi; Mon, 06 Aug 2018 17:50:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 549792058A225; Mon,  6 Aug 2018 19:50:13 +0200 (CEST)
Date:   Mon, 6 Aug 2018 19:50:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        luto@kernel.org, x86@kernel.org, efault@gmx.de,
        dave.hansen@intel.com
Subject: Re: [PATCH 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
Message-ID: <20180806175013.GB2476@hirez.programming.kicks-ass.net>
References: <20180801100255.4278-1-riel@surriel.com>
 <20180801100255.4278-12-riel@surriel.com>
 <20180803155618.GB2494@hirez.programming.kicks-ass.net>
 <1533314448.28585.101.camel@surriel.com>
 <20180803172516.GM2458@hirez.programming.kicks-ass.net>
 <1533317992.28585.103.camel@surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
In-Reply-To: <1533317992.28585.103.camel@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 01:39:52PM -0400, Rik van Riel wrote:

> > At the very least the Changelog needs to explain why we cannot do
> > away with the swizzle now and how doing the swizzle without the
> > refcounting is not completely broken (I think I see, but urgh).
>=20
> The changelog for patches 9 & 10 explains, I think.

They hint at it :-)

> What is missing from my explanation?
> How would you like to see it explained?

Maybe a few words like:

"Since ->active_mm is still used in a few sites, we must keep the
current tracking, such that we will not hit a kthread's NULL mm. Note
that lazy_tlb_exit_mmap() switches ->active_mm to &init_mm before taking
out the lazy mm."

That said; I'm not entirely sure we'll actually touch active_mm if we're
not a user task. The perf thing for example will only touch active_mm
when user_mode(regs).

But whatever, this was the only hickup.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAltoilUACgkQdkfhpEvA
5LoMbA//QZL9D0E1M8RTfaw4YIR3LURfwijpyAfkFDSHCQZooC2wAM6ULhTLgnDT
yVdHaXE8f4fylA6dWWql0mx9KMsUD7AECk4yWYFhxYaJpym3EU0dvRfUOPxCyVb5
Sih9y92LJ9zg/dv1TuoC+A/wVjnCfWI4hBiTCaDUY1oV0PEmUe1vghBOPrLjXHzI
xWRb6hDbuVAOSJyoOA87RQUTKGerbQnNRIWKXl64itUpWwYCqTXX71+03Oji1Mad
bRyf0WyzP74QA7vKVr8HE2IJifT6XOTVAGyU6SEMTajru7221VO5pyp/PNLYVpCD
MGAfa5RVi8pa08NqnREl+iFCyZAxD5eBvPLmJhwY9ESqQygDGjlZT5F7Bv7k0IsO
tw+z4/DbZrNnS7zokNYl+9ObvLfhZHiuHoT9nI6qf9+ws029FTRliNV1hYDGGXFm
2pcjD9dRgwZJADT13yXc4wyYjsIx19UIa5YylSEoZCTQgFMWZrtJpMrMc8n4B21z
Yg9LCONktrg7b15u6hjvW32Uw7DtehV8myiuRmOArtkW0IP7BRIsog+8drOYGXDU
aJKDFQBY61HzDjv/7tEZ7M+kqHbEVJSZKsQGkEy2nJLXLIWlwR0jIGq4rM3Pq1+8
loi6cnUuAJ5aJUvilQl/PE1203Zacbkoo9DsbgMqM3Kh+vhpglE=
=Y+R9
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
