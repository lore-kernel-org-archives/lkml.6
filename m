Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124D5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61602089F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bvFKtUzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395446AbfBNDqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:46:17 -0500
Received: from ozlabs.org ([203.11.71.1]:38855 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387562AbfBNDqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:46:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440MkZ0pc2z9sMp;
        Thu, 14 Feb 2019 14:46:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550115974;
        bh=7GyvjSTJQG0SkpqUGQDMwIk29jFZjqBoC5VIbYt+p7k=;
        h=Date:From:To:Cc:Subject:From;
        b=bvFKtUzwy5NagqZNvQjX+hQSq0KlaDuZbOk0He46c6ClGIlGEqysnDJtXOVsO7V8U
         +WYDuIdHwNIjx2DgyDbAqkbOY2NNeWaE8KulMj6Vd/8W5JYg9SLuX6NgfgD9mwMwBp
         +l1Vg2cPjZCIcpgZrNMShEug4PXAzwGkfj0icSiLvBIJY/n/mZMMZaCRd5eVkIVyCw
         NI9NsMsAVRqz+96CRlWGPIicBaqHwWILmgXrqas5Pp5yIFGJ+QiBuPN5b4CPEkJRIa
         Y+EXWORx3ujs2DcZsmJ4Mh4AH1WWnEavH6SqImkl01ljD7dPXsLRvx7VhrYmoB0qAo
         lHzcDqdAOZO6g==
Date:   Thu, 14 Feb 2019 14:46:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Kazior <michal@plume.com>
Subject: linux-next: build warning after merge of the leds tree
Message-ID: <20190214144610.3672e9d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H2THokzX89Ba/ZuAYJAh2TO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H2THokzX89Ba/ZuAYJAh2TO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jacek,

After merging the leds tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/leds/leds-lp55xx-common.c: In function 'lp55xx_firmware_loaded':
drivers/leds/leds-lp55xx-common.c:217:1: warning: label 'out' defined but n=
ot used [-Wunused-label]
 out:
 ^~~

Introduced by commit

  905c2157dd19 ("leds: lp55xx: fix null deref on firmware load failure")

--=20
Cheers,
Stephen Rothwell

--Sig_/H2THokzX89Ba/ZuAYJAh2TO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxk5IIACgkQAVBC80lX
0GyRAQf/TKhSksH6I9jPAssqIRA81LLgLzSzlUsfiVFWhrY5J1jAY8/UV5IU6Ema
SP+oM4G3O2oN3ZIGgQ44AmF22tfECeArEVzt5Jl3CWKizBhY5gT3XbEUa9E8bj1j
veheUsKZ1bbh2pd3Crbs+02kpRfFRAvxsgrxco8u3MofHeuxo84cQvZRs3QLybzX
fNFWbGu3IidTYYZ+7sE/XJcuVR07+Xu3L1vuqzICHAndWPjhFleY5JweVZ/x/uXf
/fmC2mv+JzzOaGiKU4TmCOJEX39/P12mVef/9o6MO5JX/oDH3noAUozT9HkyXvXq
eE6jw4jSIaiadTQ6wkRvHxlW9earHg==
=Vtch
-----END PGP SIGNATURE-----

--Sig_/H2THokzX89Ba/ZuAYJAh2TO--
