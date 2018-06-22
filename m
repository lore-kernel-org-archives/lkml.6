Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E218723C14
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E218723C14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934161AbeFVCru (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:47:50 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52167 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933932AbeFVCrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:47:49 -0400
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 04A24E0005;
        Fri, 22 Jun 2018 02:47:45 +0000 (UTC)
Date:   Thu, 21 Jun 2018 22:47:41 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Marcus Wolf <linux@wolf-entwicklungen.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: pi433: initialization of tx config in pi433_open()
Message-ID: <20180622024741.GB1914@hle-laptop.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcus,

I'm currently working on the following TODO:

 966         /* setup instance data*/
 967         instance->device =3D device;
 968         instance->tx_cfg.bit_rate =3D 4711;
 969         // TODO: fill instance->tx_cfg;

If a user calls write() right after open()-ing an instance, the driver
might try to setup the device with uninitialized garbage. In fact
nothing really bad will happen because the rf69 interface abstraction
will filter out wrong values, but this might be a confusing behavior
for the user.

What do you think about initializing instance->tx_cfg with the default
values of the rf69 datasheet[0] ?

Also, is there a specific reason why you chose 4711 as a default value
for the bit rate ? I couldn't find it anywhere in the datasheet nor on
the internet.

Thanks !

Regards,
 Hugo

[0] http://www.hoperf.com/upload/rf/RFM69CW-V1.1.pdf

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlssY0cACgkQLVy48vb3
khm7Vwf+Kq3+2rXk6LJz+9KnDUqd7dlskzi1rAiQ4d07hch8gBPtUEZARQaOLDsF
B+M6kvxTOAIUnv+wflQnny4V4GEliyiWeBtKsFkVJHU/cCCDBKUuIVVzi+c4zvuR
YNixHHZpPNU0s2IFflJSNdfaL6XbrbRofGY5qjw4/jS+re0SACHxafjjeXEId0PM
GGvmpJu4axQ8zv1iglBmLmPalmC4SLZ8V+9HqVC0cq8UtuZXKwBuoVn+i0uzId9P
43bgeOs5GK6jqi0XD9+SJw0c4zox/F5ovjFVwbrKXYQg74jP18xHtFk1r8KDH0tK
txEBnoMTDpGBUWPQoU7H8HVsArwPww==
=bhA0
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
