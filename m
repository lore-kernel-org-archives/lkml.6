Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69061C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A8421567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sE4QLLr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A8421567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHXQRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:17:09 -0400
Received: from ozlabs.org ([203.11.71.1]:51451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXQRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:17:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41xgsm3Tmhz9ryn;
        Fri, 24 Aug 2018 22:42:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535114557;
        bh=4WH7/HEUsO2YfOlbm+bYgYYep2kjKto2tAQpjx7o1VU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sE4QLLr119dEJxtMJBdWZUaQsYQi8wo8jCtaQAfFBnZOO3Z/ByODDIcSEAaWJxHFo
         ugDvhqCmvXbouD295QlS1G/MrxnJyNygmojda4GPpAQAltKy4cLPwg6JfO2yhlp0lK
         XvjjFt9RSsSQ4v6uVqiz8nknzFTW9ZnKr8oPq4HOBzYWxFwJTCfsPrQpNRW5xMHn7J
         GSWYGpWWPdS4YUb0TJ7xTrAdYqQz7VZ1xerYX/HA700vUHy4Li77s4RxCrQLDQBBP+
         Jo2wLg7Dk8XpGq/oPhQKpxNDm4JiedHwegI/Sv7+3LelyVrTNVBtZd70eLlBL57fbR
         D/5Cn6f2TkfMw==
Date:   Fri, 24 Aug 2018 22:42:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-ID: <20180824224211.2934d7c0@canb.auug.org.au>
In-Reply-To: <20180824204756.e787765461975cd1e27502dc@kernel.org>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e9c6xvEObhgKwcLMESA5VWx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e9c6xvEObhgKwcLMESA5VWx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masami,

On Fri, 24 Aug 2018 20:47:56 +0900 Masami Hiramatsu <mhiramat@kernel.org> w=
rote:
>
> gcc-7.3.0 cross build ld shows below warnings.
>=20
>   MODPOST vmlinux.o
> /opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: or=
phan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.=
hash'.
>   KSYM    .tmp_kallsyms1.o
> /opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: or=
phan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.=
hash'.
>   KSYM    .tmp_kallsyms2.o
> /opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: or=
phan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.=
hash'.
>   KSYM    .tmp_kallsyms3.o
>   LD      vmlinux
> /opt/gcc-7.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: warning: or=
phan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.=
hash'.

I reported those a while ago when I started using the native Debian gcc
on my Powerpc build box.

> But it seems another warning, and I couldn't see your warnings. Could you=
 tell me your gcc version?

Currently, it is the Debian gcc 8.2.0, ld 2.31.1.

--=20
Cheers,
Stephen Rothwell

--Sig_/e9c6xvEObhgKwcLMESA5VWx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt//SMACgkQAVBC80lX
0Gw5+gf+MwH1M707OUGCMLgta/PsBCZiEcgIa5ryFx7YuugactRTexd8SpsdRxa8
MVRjHW2VJ9OIDwwEiBOVR38KhSPSRlhs4kkpiIwbNjjc0W4XXKTrVAeo0XCpoYVc
w7C59pRUYPklQLkUuIx7V4lwAzkzzxNN6XSYtd2GaxmLf+5AXXbt4dRHUTuIu5Yr
X/uiGAkMlWi5ldKMeX1Z31oMGn4uIZSmK/l69jgX+EHcbff6VtJEhpsX10r3O9uz
w9CAv3lbd81ExRKi7Ms4tfSapzFsICkn/vAH9Ujy9AHfCADVvfka/hAjigWTicCo
BNpcTNwlW2b6g1HOJI4OjFtk8us2Ng==
=ZEGq
-----END PGP SIGNATURE-----

--Sig_/e9c6xvEObhgKwcLMESA5VWx--
