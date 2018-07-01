Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F24FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FF6257AA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DRZKJRG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FF6257AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeGAXee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 19:34:34 -0400
Received: from ozlabs.org ([203.11.71.1]:44675 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752566AbeGAXec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 19:34:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Jmtp3pQKz9s2R;
        Mon,  2 Jul 2018 09:34:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530488070;
        bh=Vi6vAoDWt/cFmd9y/1q5yHIrRD780wcYPqT6kr7+vVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DRZKJRG0hJra6E0BiEnGLfLdV+P2NjvG1aAX4nRW1NSSHevmjKU6hsnRpEa5GivOq
         EuHHFnm67aH30G7peumNr7Jkso0pF31ChwcXktOu0VVSMYSrICOQCAwQfbn81R2URI
         cGSZA5HCe4/7TxQW27dt0GZHH6GcD4xug090M5mrXHlQBXWJVYU/l/9499ch+oCG4K
         +o0ydj0nN9YTUbHxjF32TBdeET0USQp+KeDnVoZ3LxLPJ/6swh90BUWuEjeJ0vd8hz
         55slLFugPTPKwSzl1Ce2NuwBin6V5FueGyr7WI2Ip3laSuWYf6EUq6jKCJyakaKJcI
         +nLgaPaPppPtw==
Date:   Mon, 2 Jul 2018 09:34:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@suse.de>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] siox: don't create a thread without starting it
Message-ID: <20180702093404.747c4148@canb.auug.org.au>
In-Reply-To: <20180629073858.5gwpfwqo2ccb4jaa@pengutronix.de>
References: <20180626073134.GW2458@hirez.programming.kicks-ass.net>
        <20180628075742.8991-1-u.kleine-koenig@pengutronix.de>
        <20180629073858.5gwpfwqo2ccb4jaa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XZ.tc74IMPq1Qd/_=+KptGf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XZ.tc74IMPq1Qd/_=+KptGf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Fri, 29 Jun 2018 09:38:58 +0200 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@p=
engutronix.de> wrote:
>
> On Thu, Jun 28, 2018 at 09:57:42AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Greg, you applied the initial patches creating drivers/siox. I assume
> > you will continue to apply siox patches and tell if I should search a
> > different path for these. =20
>=20
> I put the two patches that I'd like to get in during the next merge
> window into a branch in my repository:
>=20
> 	https://git.pengutronix.de/git/ukl/linux siox/next
>=20
> I assume you wouldn't object to add this branch to linux-next?

Added from today.  Is this a continuing effort, or should I just remove
the tree once Greg has merged it?

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/XZ.tc74IMPq1Qd/_=+KptGf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls5ZOwACgkQAVBC80lX
0Gw63wf/UiObveADuneZX6MIVg0xuaVZ1xDD7OF4cLwimqA9vetj1Et0RVlRzdKg
H8NzHIxt8vSJUsWv9bhEL3S/UC0rPI87nWq/A837FMTrnNjTQDqhPJoMog+7SQS/
7DLuKVtOq+uv7vILTIZqJ45CyyfDXY7UYZL0hA0067TWPycYLQM6RYMzsfD1rMPJ
r4s7bEYyrV3SUiT9R8VGoKIJVjyY7Rfk8Knr9NX7xCSl0FAQcVREh3QZcBoVTGit
C65wtq3Yf937M6/hkZE7UjHo/LLTF666oTTOb5jumQDi+V9tQ1jwEuxtzo1FmqoH
Cd119+sW29ML+3gFoJYs5Mo23htA9A==
=VSYh
-----END PGP SIGNATURE-----

--Sig_/XZ.tc74IMPq1Qd/_=+KptGf--
