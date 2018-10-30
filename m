Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C24120664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SIxJsSWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C24120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJaA4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:56:50 -0400
Received: from ozlabs.org ([203.11.71.1]:48453 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeJaA4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:56:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42kx7m6N4cz9s7T;
        Wed, 31 Oct 2018 03:02:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540915365;
        bh=TWoEVcN+bVXpXahNgRuq+modmaYlTy2paSx4kl42hPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SIxJsSWSNQTqqzTGBuD/fT+jeZgWu/kwR/X6KieZ6HZ9S3k6nTUTmzyXcQP6KIZ+1
         mcC4DDzFgqYkyK8hhztULtTxg4mYfAKdVDFdUWDiDoO+mVk8MeGVBerqteyxPibBrr
         ho253QIokbNs/jRVh9eNZqfkrJ0OvR28A5rO+qHLAsYaCmCsPRTUBcmyrJy5hVFW4H
         VD9xRSm85RfxnBRduixI6OumW4kw9/BLMXKqUiC90aBMXw7gGTr60Yu6qdmuYaRL16
         bawSec58G1XiuO2gKJqwuUqH8+FaEpvJ4gNf4Lk+MFuTppAfb2J5mkiPTXUi++l7E1
         qqJudRp2bDjeg==
Date:   Wed, 31 Oct 2018 03:02:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        changbin.du@gmail.com
Subject: Re: linux-next: manual merge of the compiler-attributes tree with
 the kbuild tree
Message-ID: <20181031030229.725abfe2@canb.auug.org.au>
In-Reply-To: <CANiq72k2w2T0Cy0D--OEmE+sOPkjZtXpukBm+Mz1_xY6MCGg0A@mail.gmail.com>
References: <20181030104637.382c26d0@canb.auug.org.au>
        <20181030104941.4fef7dad@canb.auug.org.au>
        <CANiq72k2w2T0Cy0D--OEmE+sOPkjZtXpukBm+Mz1_xY6MCGg0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vIAPEUP4/SKJQ3GhL8KG7X="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vIAPEUP4/SKJQ3GhL8KG7X=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Tue, 30 Oct 2018 12:21:52 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmai=
l.com> wrote:
>
> From a quick look, it seems we want:
>=20
> #ifndef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> #define __compiletime_warning(message) __attribute__((__warning__(message=
)))
> #define __compiletime_error(message) __attribute__((__error__(message)))
> #endif

Thanks, I will use that resolution.

--=20
Cheers,
Stephen Rothwell

--Sig_/vIAPEUP4/SKJQ3GhL8KG7X=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvYgJUACgkQAVBC80lX
0Gx3JAf/eVJt0/EOhXwgRqYifJrD+FC89QhfNKyFYuAqmLBxUk7rHOnybQdOU3qi
R41el3/EYubyTXzvxNkLQlO91nWE9QgZ42M+DpWsoETl+5fvC9aJdGDTVVHUKMdL
mo4OPmRUQEwNEHUptzSQIMp4QIvCid7XDrYEFNwi8v6bs9lU31TTWcelZcJm4Slv
CK+B/tQov9Qz3tfWwl0Evnqnc5uq1sB+IcQOoJj2C6TYzVRh/0LqqjcvOc25TdVJ
X8KLY6/5rXHA4p2e7o1s+jSmYBI9exFSfRyMYZYsG0dLfKQGeQ8Pn8iuc8j2hFXa
/YldAe85E09Hs7+s+NTjf1nmOtNEcQ==
=7XJ2
-----END PGP SIGNATURE-----

--Sig_/vIAPEUP4/SKJQ3GhL8KG7X=--
