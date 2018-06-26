Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3724C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EE226B84
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EE226B84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935522AbeFZNqQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:46:16 -0400
Received: from sauhun.de ([88.99.104.3]:52782 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933522AbeFZNqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:46:15 -0400
Received: from localhost (unknown [82.202.112.231])
        by pokefinder.org (Postfix) with ESMTPSA id D550256A485;
        Tue, 26 Jun 2018 15:46:12 +0200 (CEST)
Date:   Tue, 26 Jun 2018 17:46:07 +0400
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Message-ID: <20180626134606.h4ciolw23t6qnrjb@ninjato>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-2-peda@axentia.se>
 <20180626023757.l54suaryim2fieq3@ninjato>
 <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hauj3d2ynysbmlnz"
Content-Disposition: inline
In-Reply-To: <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hauj3d2ynysbmlnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't think it's that easy as I just thought about another problem
> with lifting the locking from the emulation function. It calls
> kzalloc(..., GFP_KERNEL), at least in some cases, and that's not a
> very good idea from atomic/irq context...

Right. However, we could simply bail out early when we are in atomic
context. Simply no DMA then...


--hauj3d2ynysbmlnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsyQ54ACgkQFA3kzBSg
KbbisxAAgJ1Hqsg7KSWJ8Nhdf/n/x4KMtajyVDYr6gcblvLd6vm4JNmmBscMtJve
LfHaU1qFRJMMmEUQOzjNcLdC7q5ZnFWEz6YgX2yuoRp4VMw9RAFVmlM16zoZyMOA
0jKNfJ8nTudVonSBB/4nfGYUqGbKEqJqklaGhqu4Ga7SnF1JWgrWyAbXGEHiQSez
Xzpm76VeDCyp2/WYP8V1Lw46zC5j5Zkh3PH7sStw2BMCIDOYK8ipXzU3rl8akdbi
DM0FuB9CzY2MnTfhvhIM6RsNBeJo1KDMlzYG9WY2yTI4kQ/GcNO2lqFsSUTxsrKT
sJ8vRiVhgY0KmBKBB3hsGCVvYt6meof1TaLHb2iUK2IYjc1XAlC26JM9hLSEg+X4
6qi3gr/xi8vU53Fgmjs3KkA6rUr+ivaXU4pkIy0WFTWwRpJQ4pBLzEzdQEQ7VE0J
MPWQ1WWVMcI8FkCL+krUsaPdR1yhVZH7DNAj6xxfGu9QDdBGNLz/c8pd2ghk4CuP
2kIIjC1v4oIOx5kxFXoBe3NhtAWhYY7MrTJnUDKIUnVtj2Z+FZiQIcJisu8e7Zob
5LdQdcFa1qhBw8jRkgUlQhAsil4sycWQcwSoaV/CCxquP2Yc0LYCJ9nzThn24p2H
V66XHFValUM+jOqxQkFg5SA7wXu9U+Omm6gZTObiJEza0LzFhpY=
=cn0W
-----END PGP SIGNATURE-----

--hauj3d2ynysbmlnz--
