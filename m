Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7F821A47
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z76bueo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392585AbeLVRgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:36:03 -0500
Received: from ozlabs.org ([203.11.71.1]:43281 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeLVRgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:36:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43MMBb44Mjz9sPW;
        Sat, 22 Dec 2018 21:27:35 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545474457;
        bh=hdnsth3jgykOQO/lDqWMCkrn9f5XMowa5z7e/RKFjZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z76bueo5LwbUB23rBancAbcZSHOCqpjLNxpTJNLTSaAbGqRATOEM8Oc/ckhmIxRw3
         W5/epF3/SnPO04pC9C95TAXpIXc1Br159+o6YW1ak9+IS3pi7W0z4WmOphTgvpw01E
         jVdzQgvpELXQhFulQvF4ceMZcorq+ykxEeWjoFmFE1dMtprORYgS6AzaUVypcZgrL/
         24iUMVU6yn2kXwKlRLhGz0CVjV9Z7UekSV+me6bNmK9cBCKNIE/7lSKEOmGXKZCYzj
         Cv7KzVV1m44K4phEgvFiifHDtIhMIjueZZrU9nydvVgMd5pTe5dvTI4UxwbSY7Yvwt
         O/tBUXJAhV7EA==
Date:   Sat, 22 Dec 2018 21:27:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] alpha: system call table generation support
Message-ID: <20181222212720.6637ef8e@canb.auug.org.au>
In-Reply-To: <CAEdQ38EY3ix6XAwAjY8H4OhFwRcT1Yuvk4ofLa_GVyh5COpkRA@mail.gmail.com>
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
        <CALxhOngxbsYFSbK1Y0okuiTmjWEQ8Zcd4vQ0OezhXBgXH82DtA@mail.gmail.com>
        <CAEdQ38FQNC0mnf6UWOeandwR2guLRGmbYaJAo8MrEKFn2U61Gw@mail.gmail.com>
        <CAK8P3a366UUWv8hXxWFQo9EQs++t5x4N+JmJ5abgD8BP99hECQ@mail.gmail.com>
        <CAEdQ38EY3ix6XAwAjY8H4OhFwRcT1Yuvk4ofLa_GVyh5COpkRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K95BLF44cm9c5f5+VcHpoTZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K95BLF44cm9c5f5+VcHpoTZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, 21 Dec 2018 11:46:59 -0500 Matt Turner <mattst88@gmail.com> wrote:
>
> Probably so. This is just a super part-time thing for me, so I've
> never figured out what I needed to do to be included in linux-next.

The requirements are:

"You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary."

Just send me an email with the URL of a git tree that has a branch that
I can fetch every day.

However, I am not doing any releases until Jan 2, so it will be
included then.

--=20
Cheers,
Stephen Rothwell

--Sig_/K95BLF44cm9c5f5+VcHpoTZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlweEYgACgkQAVBC80lX
0GzAZQf/ceFemIRud5chQHnpxdM8Q4WTwZPcT3g997vj97b35xydgjUw24JHscAi
OJN7B2qj6Ieus3yyy+yrveCkxQlIVkmv9dhKete6KHiGIHogCcmwBT7lpsQK1qje
CsdoKSEffgDUzPYe7uhGHGI2JdJnfM2OjfYXe/VgLdduUoMVD8S2z8qtAD6h27IC
/M5zUSPPXF/+j8TXBeRPhIUMANw2q5oWx5rH10DTsC2NJ1rDsgy2adJY2kdul99d
ORSsdvb/UqsjN8fjeoDFqsZEvGjicv9nN29IatD0Ih44cUZVdnPeB7S1OSCiwrsL
Fomphge7jlCE0BrSP1LetXSjSHHzsQ==
=KcoK
-----END PGP SIGNATURE-----

--Sig_/K95BLF44cm9c5f5+VcHpoTZ--
