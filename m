Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9982ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866C22084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nIjW4grF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866C22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGTBwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:52:09 -0400
Received: from ozlabs.org ([203.11.71.1]:49121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbeGTBwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:52:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Wt4Z6KD7z9s3Z;
        Fri, 20 Jul 2018 11:06:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532048783;
        bh=ID9cMduxxKpcVjJv1yOYlFMZ7S6YT3YULnsj7YLOTg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nIjW4grFAJiavA9gtzfd3q2dkyEZQPXq5mMqlGvNSR98u5l/vb0fOJfK02TGQ3IfP
         5SM+ISjRnasZlyFg6c1uJPHdHvmdEEHpN0fGijnVgEVRlordygitLQwGRsbF3NP8Y8
         ASooFCHLH/gYOzXg4DoLh84U3lxLekssruspnt667gAmsL9a0xO+uGQpRqtbqJY7xq
         qIVF4P/xOhwqANYBq4du8gehCmmyGCKcLwqFs1pvH0jfD9zD2gACINi44INTXvax1Q
         GCQLuG7bxO0zVsXf8XgSy0xnKI2tn5Zb+7VUvQhBEzc/iyi8EsD+84JVmyQ4QTHU+x
         +e+Gg2GCv/Z+Q==
Date:   Fri, 20 Jul 2018 11:06:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20180720110622.639fd50a@canb.auug.org.au>
In-Reply-To: <20180719223521.GA30287@roeck-us.net>
References: <20180719120447.6e7ba23d@canb.auug.org.au>
        <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
        <20180719152940.0720e9c1@canb.auug.org.au>
        <6dabf12b-e3db-dfe8-101c-02772039e21a@roeck-us.net>
        <20180720080906.7a30c573@canb.auug.org.au>
        <20180719223521.GA30287@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zoHN.LmnUK75zxi/yJZfRCz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zoHN.LmnUK75zxi/yJZfRCz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, 19 Jul 2018 15:35:21 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> Yes, replacing imply with the dependency is what I did in the fixup patch.
> Sorry, I should have copied you: https://patchwork.kernel.org/patch/10534=
925/

I will use that as a merge fix patch when I merge the net-next tree
today (unless Dave adds it to his tree first).

--=20
Cheers,
Stephen Rothwell

--Sig_/zoHN.LmnUK75zxi/yJZfRCz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltRNY4ACgkQAVBC80lX
0GzHfQf9HBDd5wX1qD91tVPVa/sRX1eKR15llhqr33mudgAWfqyGqkv74lavb4b3
paEL205yjHsSp1OtFTjYl38GvzCnt08nxGNDnhfBlCF1bonjG7xJIBvd+KNFvKU2
k9+u7znxRu6CLBAX3v8Wub6HBx4WWEZtUJfWHE5yAc4qmSGV16E3IJoL1OEAwRcU
hhkhNBBVc83kIyRYs7vdEKWvx89GLgI8znydiIqcA49tNtyx9aCmuH7cNfhi/FTM
YdQOXbPa85//qXjLy17PVI47G/GsQlnhU9HJZSvfly/9zqaWmrF5vGtxp2bV11p6
oW7EwOWBxuKHh6DVLvsu2+gr4s+kWQ==
=LsPs
-----END PGP SIGNATURE-----

--Sig_/zoHN.LmnUK75zxi/yJZfRCz--
