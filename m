Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B260C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA4920672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="CUPwzl2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA4920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLIT6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:58:11 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40664 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeLIT6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EKuBaLt8F2fRNvQlvlxleh8O2rLGlcuOcTeLNHUFfjU=; b=CUPwzl2Y2NCW5LR6TVXza8KYx
        qRI1/Rd0s3JamN4TC3tGWybwR9V+rNwuPVvZe0m15koVfqGFYFcsVYpWFD8oae/42TXft0MPV9Ynx
        wUGQPf6eXPFTjK5oBmNcUn7mkS7nI3XU1D+iZVjG1yVjMLfQu3Pwi4kJkPuTnyqGXlvhk=;
Received: from p5dc588d6.dip0.t-ipconnect.de ([93.197.136.214] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW5DO-0008OY-57; Sun, 09 Dec 2018 20:58:10 +0100
Date:   Sun, 9 Dec 2018 20:58:02 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gnss: sirf: fix activation retry handling
Message-ID: <20181209205802.081b64f2@aktux>
In-Reply-To: <20181205102149.21167-1-johan@kernel.org>
References: <20181205102149.21167-1-johan@kernel.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K/BWX42FcyBwOP/rYOWx/7+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K/BWX42FcyBwOP/rYOWx/7+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed,  5 Dec 2018 11:21:49 +0100
Johan Hovold <johan@kernel.org> wrote:

> Fix activation helper which would return -ETIMEDOUT even if the last
> retry attempt was successful.
>=20
> Also change the semantics of the retries variable so that it actually
> holds the number of retries (rather than tries).
>=20
Sounds sane. I rebased my patch series on top of it and improved my
testing script (the manual on/off toggle in between was not working
properly)

Regards,
Andreas

--Sig_/K/BWX42FcyBwOP/rYOWx/7+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwNc8oACgkQfb1qx03i
kyQgAQ/+KJOkalhBleKMdPbcTBg4JTfypb/G3+8liwEP6+GlYv+mXOuEC7nj8sOz
mwGjuAHoA/fRcJTjtlSPtm7iFHmxzIiu7yLrgiQDAub8Wks8fuX4n8eJRX5I672c
EZeGXN/1T2LUzuysjxYqU+HJygiJasVEeX//JE6CI7b6A2Hm9LN7kd/d6eRDBS08
EWwhDa/DGMcQUu+ztMtGAj2DV7bwNZ+zlG7ul2SGgM4e8dIdk93BbFYt6vlqA/oN
xVC89qKs5sn5SfQTCANxKzZLzk5xAqXDlt5NKhEoyth/gY0cUNXVDMaZi5Dciui6
3VIv87ACsMUd9Fk7r5a/em+EopQxr07fktahNvhmFC659U8lY5r6RtCD4A2ISOj9
PgRTk5deA/ea9tlvIP2LOtw7VPxnELHW83ps5EwrPdxLv27cgLtdDAwvfhL7chu9
jQEWLh9DSWSsGrZ2riFXhdODuHXNPfhWw1XoOHY6WuENSb4L3AJMVhnH987ZGI6q
7RuEzkH305UjaPks3moy01kNoXfBHcxSfJkRHbvONPTlNDnxTPS4OjZylyBxCsWX
kLRH262uhlAkuVgDVC546NEEc8j0Lz23R6MLzuE/RdBxo0/Zbnrl51e5TFZXvn8a
1zRIQxc05ZAXgv5oUdbq5Rf/yQPzG1I8F7J+L3qqcthds1Pe3xw=
=eEXo
-----END PGP SIGNATURE-----

--Sig_/K/BWX42FcyBwOP/rYOWx/7+--
