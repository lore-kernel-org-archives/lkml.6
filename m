Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D84C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A84206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FGtQgn6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A84206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbeIUOyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:54:37 -0400
Received: from ozlabs.org ([203.11.71.1]:45067 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbeIUOyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:54:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Gnlh2lQxz9sCS;
        Fri, 21 Sep 2018 19:06:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537520800;
        bh=TvqJhBqv/m9EPmG5OEUM72BQ8p6reWkSM2j8Pc4YyFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FGtQgn6wBoSIPjfzE6kt2uG/ruSlt4JvsWru9xClilIVe5PHVjFIRo9fDVH0F4RLf
         g4CQi9wdLDV7Vzsa97DR4xMtNuaK5sQ/BG9oiLQMXb3gKU/3I2pkTdJRjdNfl3IJpM
         UHx7RVLTD4ne3k5QxxG3EDvbEIAwjfXb29c1W+uoWPZUw7QquHRRHzG83a75Kyetz6
         SfdTx/H/vfBI0IaspXoGjrFPBX60zNUzbL27Kl4XpMV3tiwbVK5WwCGjQGX63wfYmt
         PuuruwuVLbgADKqMLU/eWFCm8iiha1zwKVF1vp4MiJ+cz1vLRS1WFXXlBKE4eDQULL
         N6XKAqAD10WfA==
Date:   Fri, 21 Sep 2018 19:06:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 0/9] signal/powerpc: siginfo cleanups
Message-ID: <20180921190639.36c4bcf8@canb.auug.org.au>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L83Adti=lF2bierENe4AgKL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L83Adti=lF2bierENe4AgKL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:41:09 +0200 ebiederm@xmission.com (Eric W. Biederman=
) wrote:
>
> Folks please review and double check me.  I think I have kept these
> changes simple and obviously correct but I am human and mess up
> sometimes.

Its always good to see a nicely set out patch series like this.

--=20
Cheers,
Stephen Rothwell

--Sig_/L83Adti=lF2bierENe4AgKL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluktJ8ACgkQAVBC80lX
0GzDLQgAjiA+cJSVkM6LtgzOLLTCs4Co5C770JYclf8Z1UezSfK0DvVUbyEL1FZs
ric3KQQVU5qyNzMM3qJX+UJjQUlFMumsFcbp9eRV4Uavyanvv0JQgnbYo/L/u9Fc
E+pjhUK3qSPF0tJs4nC+szglI+DMIvGFl64Y7RN2/CFev1w61uEvOanZgdkVlA4W
ArjpONz2GSebGRcKE6fJghjqLwQMGFe9pU9umSSLZSv9XuX1hINYGaTN6zqy8f+Q
1pgc4YvMgvNXcAPEoTM2B3fUPkDgw+F7WKMYVjX4nLsV1z9qE4BWli99UHGC6aTp
AWJ64EKghrxlKCDpEjKm9Iq7BhDiCw==
=Kblr
-----END PGP SIGNATURE-----

--Sig_/L83Adti=lF2bierENe4AgKL--
