Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C64C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D099C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WhsXziFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D099C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeJKRZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:25:55 -0400
Received: from ozlabs.org ([203.11.71.1]:60115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeJKRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:25:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42W5z94rxRz9s3T;
        Thu, 11 Oct 2018 20:59:17 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539251959;
        bh=BdaC6cCRY/hAhQTLA2CT+WzroV8BO6ZXGdbQvr5W9ns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WhsXziFeskA4UwkhOkiAMvbwOQX+H7roUu75gahhzHXZmQwhk2XHmOJ6cC5tAiFxP
         g1V+NDhJ5VFaqibN6Waa0P2ZLWPYjhNUUC+wiTHBDPTfDaDuPwulJYdghQwqhOQgDz
         oaZ6d/jYjKk5T9rRyI1ctYT9Lre94hoYwCkknVehS5gBKrXYKrAORhyJYHqFQklulv
         ix/MQcy1s3ix/sCCYc0ebMxa/irrpc98WNjxUm2pWZJWiY8Gga+97Or+Xo7knwBvC7
         ekSt2ILMxeRro7qDkE2KgNJ6NTbtKSghJnLmHzDV5p+UHUYQcfjxy0Hfaj8LVT+EV2
         2JOxujH5Khr7Q==
Date:   Thu, 11 Oct 2018 20:58:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     arnd@arndb.de, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <gregkh@linux-foundation.org>,
        Linus <torvalds@linux-foundation.org>
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-ID: <20181011205849.6f6645fa@canb.auug.org.au>
In-Reply-To: <d5b166d6-461c-f382-e3d2-8993b845bd5a@linux.ibm.com>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
        <20180828072333.36af4d5d@canb.auug.org.au>
        <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
        <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
        <20181011114809.5590ecb3@canb.auug.org.au>
        <d5b166d6-461c-f382-e3d2-8993b845bd5a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EGgn+pDjhFAk.Ev/HHXFnOE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EGgn+pDjhFAk.Ev/HHXFnOE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 11 Oct 2018 09:44:36 +0200 Peter Oberparleiter <oberpar@linux.ibm.c=
om> wrote:
>
> On 11.10.2018 02:48, Stephen Rothwell wrote:
> > OK, I have been carrying this "quick fix" patch in linux-next since
> > September 7.  Is anyone going to pick this up and send it to
> > Greg/Linus, please? =20
>=20
> Sorry about that - I posted a modified fix at
>=20
>   https://lkml.org/lkml/2018/9/13/367
>=20
> but didn't get a response. I guess I should have reposted sooner. But
> before I do that:
>=20
> Arnd: Is this something that you can pick up or should I include someone
> else?

It would be nice if it could go in before the v4.19 release because the
commit that exposed the warnings went into v4.19-rc1.

--=20
Cheers,
Stephen Rothwell

--Sig_/EGgn+pDjhFAk.Ev/HHXFnOE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu/HtkACgkQAVBC80lX
0GyTegf+Ig7CBxbIa5giF6HtY4eEjmfP3pXGwhrQC7NLDPbPGx3uEheT+/X1L3P8
56v+bEZMpO7c1hISVSIy8y8b3LlH2+iCCn8FQauDIE71kxGZRy6Cz01shzs0UziK
Ya9afDxHS0RwaBrXnN93ds42V6GR3Vxkvc+SAhv+8+Rx48HJYJB9HS40lNVtMYB3
+svQ83T5YbK0NrOs5M/ilKJvXBoynHbj1Q6Efb+VmO0/d4dnYtL4dLjs+f9rXn6j
DZCzN/fN4mf2ivMt32OsM8/VizxubiwZUzc3wBzDT2x8r2z1vUYj7NdDREdCOOMW
8oJ04A4E8l1CbdM4pq+M4+cueH8vwA==
=Z44O
-----END PGP SIGNATURE-----

--Sig_/EGgn+pDjhFAk.Ev/HHXFnOE--
