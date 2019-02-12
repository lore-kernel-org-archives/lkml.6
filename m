Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84FE21855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgVqQ/Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfBLAz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:55:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45004 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfBLAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:55:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so1020841qte.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uljWyiI9G/rIv1+F8Bdm7MKqtS7+wq27ZIM1WmEiZ0g=;
        b=hgVqQ/TeO9xLTAsyRxCrIK7rIk9yJBwhl4tXGfiCn9V0z4d4QVwe9zX9kMq/i233Xb
         bSrSfzxG9zujyvl+cif2ZqGvuKkIs+4M0URO7vBLBntYnzy80ei73hwyMkOcIa7I5UJ7
         +t1xsFHKrzsL/qQL9iYeV8VmyESDrTxiAEJIgWVFkOihwQYshMWYMBnLcNheg55naFLY
         Wah1HlbtWk1qQYuQnStdkioqDvniF+1jbyEfwq36i7QoP2zU50UEGW6uY+hBSG2lQFHC
         nMMoEZn4FuDVHfV8takGwKpN6zMgmQ/+f+99ZBT7Jf6DbqnJFIge99aayzRFY0lKot/l
         kM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uljWyiI9G/rIv1+F8Bdm7MKqtS7+wq27ZIM1WmEiZ0g=;
        b=D2nTYLotNGfOvn+kqPpM5mROUZk94Y80pueW9pj2XAjF2898DkI+mQRrNEWvF8nTCI
         3NF3cTlmQfl8avxk83PllLQ4ha6OwoGo88j6p0PaUZgrcfB37zf1FmG2ulNyzxx+gUoY
         1Nl7MgR+BY+MGcZIl7E99Sf8AladzjXm/4B+cTMJnk3uQqVZKbhKCtLCkZKVh7VNHW1k
         ROZe1A5NuvqL3zGjKdRcroL4JIvzAP0cN0kADlSj/ZlIAbzfRSGd5cR8E8GEmUf/zCwN
         yAhzsaQz7urjTMdML7c6vJPs67jZCTLtBJdsG+fRD9l+yYbmaHyKqk4armL3pCmNZlrP
         MHuQ==
X-Gm-Message-State: AHQUAuZOcV3fE+DqgRcM5eNyDqBjF3MWL3DYup3XglLyxruWS88vn5LQ
        Mp2nsptB1p3QQR35SrBRdbY=
X-Google-Smtp-Source: AHgI3IZW91c+nj3cgP+09rcVw9U1sm1T+uxByZ87cle8Mc+u7RYMmFOPPSQhdHLmoaZqEKc8EtXAvQ==
X-Received: by 2002:ac8:2d7a:: with SMTP id o55mr849387qta.158.1549932925319;
        Mon, 11 Feb 2019 16:55:25 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s67sm11671752qke.56.2019.02.11.16.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 16:55:24 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id B34A12329E;
        Mon, 11 Feb 2019 19:55:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 11 Feb 2019 19:55:23 -0500
X-ME-Sender: <xms:ehliXHVP9MZhzCTNTndeVOLw7vBh2BxXqWRLP_yfc10aMAqKCjwksQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddttddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeeghedrfedvrdduvdekrddutd
    elnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:ehliXJY6sF5FapldRmcNT7lpAb9FCuAa5r7qJaJXoLnDrapqbcxTOQ>
    <xmx:ehliXCOhnMFHTCR6Ydh5O0mjn1PLxX0YJxrag_CKmq592xYuX6C8-Q>
    <xmx:ehliXNs3H63jwYm8m_R3OCqlLKzYQWZ7bgs8uFIJODF0nn4R0aqquA>
    <xmx:exliXPlOFmKGKPPdvSr9xrAFy0m43en1Durm6CkscuLHNiqR7yXgPQ>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B460E4438;
        Mon, 11 Feb 2019 19:55:22 -0500 (EST)
Date:   Tue, 12 Feb 2019 09:03:55 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/atomic_t: Clarify signed vs unsigned
Message-ID: <20190212010355.GA11137@tardis>
References: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 06:09:43PM +0100, Peter Zijlstra wrote:
>=20
> Clarify the whole signed vs unsigned issue for atomic_t.
>=20
> There has been enough confusion on this topic to warrant a few explicit
> words I feel.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

FWIW

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  Documentation/atomic_t.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index 913396ac5824..dca3fb0554db 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -56,6 +56,23 @@ The 'full' API consists of (atomic64_ and atomic_long_=
 prefixes omitted for
>    smp_mb__{before,after}_atomic()
> =20
> =20
> +TYPES (signed vs unsigned)
> +-----
> +
> +While atomic_t, atomic_long_t and atomic64_t use int, long and s64
> +respectively (for hysterical raisins), the kernel uses -fno-strict-overf=
low
> +(which implies -fwrapv) and defines signed overflow to behave like
> +2s-complement.
> +
> +Therefore, an explicitly unsigned variant of the atomic ops is strictly
> +unnecessary and we can simply cast, there is no UB.
> +
> +There was a bug in UBSAN prior to GCC-8 that would generate UB warnings =
for
> +signed types.
> +
> +With this we also conform to the C/C++ _Atomic behaviour and things like
> +P1236R1.
> +
> =20
>  SEMANTICS
>  ---------

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlxiG3cACgkQSXnow7UH
+rggxgf/Z74RiIKVYHQi1sRF5noEoZRCZUTvIdpheJbnoTU3YE6zr31rzkjCEiB9
q6sVa/o6GON8XE/HWr/2mnWKgT2kZecUYJfsKq995QfJ4u6/ejxX4bmlqaN0fwDR
QVdwuNNnwjM/prPIe6vF9Vhu819FtqcnjQ7Q5h32wJzrB6nxJvZA1V4c5+zaU40Q
lTQKq4lrQU8xrSXRURz6BoZo7DI8AvH/tQQQicDMEpeSL829jRSC3E/fp5GQ5XUX
5BE7xWEzQCX2hC94i5sFpOmD7aSdhBsycBusk2mp2fDL9DGlbm94nY5el8UcAg3I
fmiN24znVlj6yoK51jTQRIFHwZ/YVw==
=tNud
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
