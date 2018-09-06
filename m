Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE11C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44EF206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pWzEffBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44EF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIGCwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:52:19 -0400
Received: from ozlabs.org ([203.11.71.1]:44981 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeIGCwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:52:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425vxs1PXwz9s3Z;
        Fri,  7 Sep 2018 08:14:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536272082;
        bh=GZzPQCbXPr/nTffdQV+rZ9m1JImXutOegKCZ5rGx9qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pWzEffBzpLaW2cFAG7FnubkDv/nWjkcUCqLUTayC6ZRkaBQ3pKRs8u+OxdqfEpLlP
         /VjRyAMHGmo2gCBNFZMLf2lYtzual8Hja5L7mMp4+ymz+sDON7Z1CEuCzsihf0tVbE
         /dXeDFgZ0kFNvDneKad5L0N/oaog76CSj2xpYqrvorP+4yLZFCQrsPnEZhX1a2ft4g
         Zo8TT5nj1pqVlSWDeGBqKSFFgtc6/dybWmcy2LwQKmEDljcEMuTQyD5yy4RKAstBl7
         ZaVc7ND1ely5d4ARhCh3pkYb0Wd7aF7aLgg8epAHy0WMf5jRqs81VIQpRrMCVUBNEP
         u7pCJmbvA6RRg==
Date:   Fri, 7 Sep 2018 08:14:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-ID: <20180907081440.38623043@canb.auug.org.au>
In-Reply-To: <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
        <20180828072333.36af4d5d@canb.auug.org.au>
        <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
        <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mAuTEhGWGuYjKf0qE9EQ4PW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mAuTEhGWGuYjKf0qE9EQ4PW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Thu, 6 Sep 2018 12:49:39 +0200 Peter Oberparleiter <oberpar@linux.ibm.co=
m> wrote:
>
> I've attached a quick fix that should address both problems. I'd
> appreciate if this patch could get some testing before I post proper fix
> patches.

I have added that into linux-next today ... I will let you know this
afternoon how it went (it looks sensible, though).

--=20
Cheers,
Stephen Rothwell

--Sig_/mAuTEhGWGuYjKf0qE9EQ4PW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluRptAACgkQAVBC80lX
0GzP9wgAnpgEZp+lekNmJfyRGjW2uA2qNQUmeu7yDKXTs7MYMI5II1RrVqJ/P6XY
kLj1hX08P1TfeZAjSWSKhPFaRpC+LinnYA+djaLKseLkwY4QgUOJmziUhLBUT6RD
bmUwfv9t1SCgSVLjTWlzyUmWU1W+1VtluOdJXB8JUiQ8vLg6jkd9exOsSCAMNJT3
8xn5mFr64H1AqmEhVpDqCAd4VRdAOW8FAOIBWjkDksz1XNGwYYRdyIYjkD/Oehl7
dV4aUUkN2EcozZMLjILxwuqGaEK1f1JJ42HNqVoBqMEl6fyEuN/btMDtB5jtZ0en
C1oUvCCoa+vrj9SKo6p3+2BGpLDhbA==
=QwFV
-----END PGP SIGNATURE-----

--Sig_/mAuTEhGWGuYjKf0qE9EQ4PW--
