Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41989C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025C421916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aENWqMgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBHF4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:56:00 -0500
Received: from ozlabs.org ([203.11.71.1]:50373 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfBHFz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:55:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wkv12JcXz9sML;
        Fri,  8 Feb 2019 16:55:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549605357;
        bh=oGmdwbjLQIEdgZO8AREj1z+H1ccodVS301M2BRVel4Q=;
        h=Date:From:To:Cc:Subject:From;
        b=aENWqMgKFeQxFuaDuszTlilpAYaZgBganKriLkOHEPVJjqp7ZFoKeQzklgriwwLR/
         3HM+QzdZG0O0q+KdfcZgIlVY5JvLDmc7orygr9Vw9MdzeWsR5MWKF0r4gfmbz7F8dU
         q8tWaDO0S9HdkznrriqJ2CJ/CKCRtBAy/6n2vlc2V7KCViT6iLkACBF437shSAd/32
         vhcAH/RIpu527rp8IT/eKRTQoW1NxQi4ExQjozuYBWAjR1QgOFb2cTT/mM35da3WrA
         GQ4tgbVlnEFAzc9lNy7Fgac45kijT8jo4SCui2weJJ/jseWj1N7euyVu4sSTrK8IMz
         Qlom2BjxkymLw==
Date:   Fri, 8 Feb 2019 16:55:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build failure after merge of the rtc tree
Message-ID: <20190208165556.00c7f51e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R+xc41jAMQvlMdCd4s4qsh1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R+xc41jAMQvlMdCd4s4qsh1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

After merging the rtc tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/rtc/rtc-x1205: struct of_device_id is 200 bytes.  The last of 1 is:
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x78 0x69 0x72 0x63 0x6f 0x6d 0x2c 0x78 0x31 0x32 0x30 =
0x35 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00
FATAL: drivers/rtc/rtc-x1205: struct of_device_id is not terminated with a =
NULL entry!

Caused by commit

  08bb868190c2 ("rtc: x1205: Add DT probing support")

I have used the rtc tree from next-20190207 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/R+xc41jAMQvlMdCd4s4qsh1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxdGewACgkQAVBC80lX
0Gyjawf/a/LF1fDrbutNdXV0KPbb5K7GTfZsypi01DEVTFs9Q/c9Ng1CyGae14Y4
0m3DtJeMGnemEtwiOe5d2iyO6CbntR9oNux1UDkz70sQzJMW/OnWDYrB/xRWymj8
YlgQ88QwsMU6EQ7W84viOqMuYQIjKP1UOj28XWC8SiAmwsw+VqzeQ1YDrO5GCvRQ
tpyJ8D+NuHJstZvZqFLm2S9swFcbvIDH9aNgzsnxx6yWm29iPic+bft313dYsuDh
W8ld25izapRvaadCQIauoV+fIP20UJMBqLEwwaWKGaobCwMmqQcgpZ0larbXOzCt
ZYE+9qqMMoLN8ITLGcL0Q1LrU30m8g==
=xuvB
-----END PGP SIGNATURE-----

--Sig_/R+xc41jAMQvlMdCd4s4qsh1--
