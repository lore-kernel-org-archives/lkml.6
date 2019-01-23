Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47780C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1596B218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NkvEvg4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAWXqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:46:16 -0500
Received: from ozlabs.org ([203.11.71.1]:42113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbfAWXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:46:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lMPK1cJtz9s7h;
        Thu, 24 Jan 2019 10:46:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548287173;
        bh=WEjcFWzZPXTLFTgMNIESM2mpXzQ2OLJY9y6eQ7Mj5Cs=;
        h=Date:From:To:Cc:Subject:From;
        b=NkvEvg4X5Qff9s79X5n7ZEZBe5WnQF9bP5LxP/ajqunCjkBeZuOm303yMEMnUgArt
         t9RHTGuAVXZElSbwTnalwVgx+W3VXmODP1cboDOmNKDJkXk4fw+fQnIKFt0VpAXXIA
         2CAbE1596Fd2vHtd7vqg81eEcn3pIZNnX+RqfwhgUWcLLOh+BDJwqrKZYaE+fae6+5
         g/y1fWZGXIm3EaFVV7LiVsmYkgP2gdNJ38hHIui4ktZ31SIZPGY3pk81XG10xIEItX
         EF8/fjavw0RChGSqMkM65FcGmT6b94JU5ms/i2wxM/rBdpF0AD+q1qr9Mm+QLz8dR7
         EUuaHVqV4lBug==
Date:   Thu, 24 Jan 2019 10:45:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: build warning after merge of the pm tree
Message-ID: <20190124104547.34632568@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7ND3.SG5kjGcQuGL11stxx="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7ND3.SG5kjGcQuGL11stxx=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/acpi/acpi_dbg.c: In function 'acpi_aml_init':
drivers/acpi/acpi_dbg.c:774:1: warning: label 'err_exit' defined but not us=
ed [-Wunused-label]
 err_exit:
 ^~~~~~~~

Introduced by commit

  9ec6dbfbdc0a ("ACPI: no need to check return value of debugfs_create func=
tions")

--=20
Cheers,
Stephen Rothwell

--Sig_/7ND3.SG5kjGcQuGL11stxx=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxI/KsACgkQAVBC80lX
0GyzdggApYeZJ7VDpHZOESPwoU0ccwt/Unm+IzRyl7xXCoK2KuNsDtw4XMB0ddTf
f0l9YstkRInLAzwTDD0N/YEmxt5kP0PMM7QLJyzKnSHXTUV0VFPGexSFWW6+h20w
X9VZiRwBXnurh12mB0L8ZTQedk0YZL8mDHBTQvsTOg4qMfO0OBVdKIZQ8M6qOmaG
HLmbkAQYhIyUP2aWDKUpmD/j8frZe4cErXS10JR6uIYsdJY+t4wOIw/VeKQxCk91
GEX6Na1T/Xh36fUd3K8a+TmL8ydOhkSmyj/HzQuBOsbTX6LXgSwAWj+6ERg5OhhZ
VvNqP68KujsoESx7D6Sh65MkwLQOSQ==
=LxYY
-----END PGP SIGNATURE-----

--Sig_/7ND3.SG5kjGcQuGL11stxx=--
