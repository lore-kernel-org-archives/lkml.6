Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9533DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4070A20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MXZlL/Y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4070A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeG0JOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:14:06 -0400
Received: from ozlabs.org ([203.11.71.1]:33497 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbeG0JOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:14:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cLmx2Hgyz9rxx;
        Fri, 27 Jul 2018 17:53:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532678002;
        bh=NE3LrdO3zrsEigl2yyMXS4jikYE5FJaanTHrCnEGp8g=;
        h=Date:From:To:Cc:Subject:From;
        b=MXZlL/Y1G9ZcdAnv9+h6FvnQM/SmjIBuBNZwW6mF+zQZRct1hBN3T82oaF71Jv5Vg
         /ujfM/wnFPZ0lv4N0oTSd/au/vKOiJhfDFB5J11T9kPMYVwCaths3Ovf2CZ7BN55xR
         qtdTmREzbPbfgv3puqdfViMgYYgbQkikt4WwcZ7opEScFCKqpiDn34vEY7YdvCAq07
         0tPeH5i6mE0YqN+PUhkdQu2UybpdA5CQybwYeaXQD9UdJZKMosiVoZnfXZJHkDJZbg
         at+t7/CNeAqdsDLJ23+29kSqTXEyyXEtmigbNJ+UTOXGRi+/tO4Fjm9PV5BuHN//Ms
         g1WvJ2/hhXAaw==
Date:   Fri, 27 Jul 2018 17:53:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Rob Herring <robherring2@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: linux-next: manual merge of the staging tree with the devicetree
 tree
Message-ID: <20180727175300.0a1fb512@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WNBfMglvghU829apFzZsnTg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WNBfMglvghU829apFzZsnTg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  Documentation/devicetree/bindings/iio/pressure/bmp085.txt

between commit:

  791d3ef2e111 ("dt-bindings: remove 'interrupt-parent' from bindings")

from the devicetree tree and commit:

  d2b863baf1c7 ("iio: pressure: bmp280: remove unused options from device t=
ree documentation")

from the staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/iio/pressure/bmp085.txt
index 5498b0688b6f,abcab02504fb..000000000000
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
@@@ -8,10 -8,7 +8,6 @@@ Required properties
    "bosch,bme280"
 =20
  Optional properties:
- - chip-id: configurable chip id for non-default chip revisions
- - temp-measurement-period: temperature measurement period (milliseconds)
- - default-oversampling: default oversampling value to be used at startup,
-   value range is 0-3 with rising sensitivity.
 -- interrupt-parent: should be the phandle for the interrupt controller
  - interrupts: interrupt mapping for IRQ
  - reset-gpios: a GPIO line handling reset of the sensor: as the line is
    active low, it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)

--Sig_/WNBfMglvghU829apFzZsnTg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltaz2kACgkQAVBC80lX
0GypHwf8DfJTFkjZktIrpfFPyhqZ9GIkAEAQUTpP1FgzxJTLwoomihxtC8k4uR06
pZt8dDC6cXNByDJNSsqOqm6Dc7e4Sq23vicRLsCoRPXCM/DAquPaze530B7aEfL5
TtLg9KU23rwIPi1MgoFvU/SYCvwNDAfjS78aL2Bx1kSHaAV5HQYyTYiLBTnDICht
IiiKch1pPerr18FXrLudZuqzKJLnWFxCfGhrg5VcQqcn1nV6p4S10C49pw+dgvoO
ezJs6abFxJYnRD3zvG28wRTo73MGYOibdMV85KykhJ6rL3gy0QaNGhOM37WQxcAa
JgOrG7Q1oQRk5zzt1A0NixlOKisusg==
=vSgt
-----END PGP SIGNATURE-----

--Sig_/WNBfMglvghU829apFzZsnTg--
