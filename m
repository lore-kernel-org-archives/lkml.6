Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F58C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B8205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MUftMSUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34B8205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeIGINj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:13:39 -0400
Received: from ozlabs.org ([203.11.71.1]:55217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeIGINj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:13:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42633D33DFz9s3l;
        Fri,  7 Sep 2018 13:34:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536291288;
        bh=It9gzs3AmySZRiYnZXub36OYbtnqz4VpLuc3Elr7Amk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MUftMSUipyEJnM7qNRPDUyUYKSuq0qBj5zqgBqtdJ/vPcw+JIpjX1Fi3jsrOMlotD
         LLxQar4pd7CMyiR9UwhANLF1yrlJtcWVcBL3pYCbl0RahyymG+x9ZtUlRBur6sOROU
         4rP8S9jh1jrg8N2GJ4GhScZHadZYoTOp1G+/s7ZzMCKj0KwbH34JjPQCXIbEsYGU9Y
         MGpJfsTW0rgc9lavRUkAVti5Qi7tbLuXE2aRk/JLc8Z04OPRjuCQAAVP7kUA4s6g/N
         cJoEY+ysRHoHIe71x38dEy8S2fgTKzwiWyZiy0ti4bsKy3SnDiHn5cmdJGyEa61YQ4
         9MQ6v2tBjMixw==
Date:   Fri, 7 Sep 2018 13:34:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-ID: <20180907133447.4d4632a1@canb.auug.org.au>
In-Reply-To: <20180907081440.38623043@canb.auug.org.au>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
        <20180828072333.36af4d5d@canb.auug.org.au>
        <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
        <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
        <20180907081440.38623043@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8NjSV3GupDu4uliy6PByJr+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8NjSV3GupDu4uliy6PByJr+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Fri, 7 Sep 2018 08:14:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Thu, 6 Sep 2018 12:49:39 +0200 Peter Oberparleiter <oberpar@linux.ibm.=
com> wrote:
> >
> > I've attached a quick fix that should address both problems. I'd
> > appreciate if this patch could get some testing before I post proper fix
> > patches. =20
>=20
> I have added that into linux-next today ... I will let you know this
> afternoon how it went (it looks sensible, though).

It certainly gets rid of the PowerPC linker messages, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/8NjSV3GupDu4uliy6PByJr+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluR8dcACgkQAVBC80lX
0Gx44Qf+JJx6egPTqcyI1JQ+G4VGNypqXvhdvxjb5jCJfn9omFXcXYi2+lvwMGb6
OXkiTigNAcPoqd3Qe1vdxJwGguqs05+G150ajLVZvvR4AW5jIFDYF1kjM/gO1sp3
QdmrHTpWEt6tVPlcXftiGISmnjBmk+bE7JscYormD4yDwWZ3QmKCaPJCplU0FenJ
zWVM6dzdGmTGM4tb4RNTke9vGzOZ4K/ZOWWjH/+gHnN8MtENsd0yG6KCl64QHycE
ZblHYvk27jLQp3JWwiuF3nHS8Yv6st7OmTuA1K/jpitj/Vev+AgANUWEk7risbJs
V56tvybwtfndEIkjo9UNaLecjR+3Ig==
=EvUQ
-----END PGP SIGNATURE-----

--Sig_/8NjSV3GupDu4uliy6PByJr+--
