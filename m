Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CDBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C7421470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hcWA8xoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C7421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJKKmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:42:45 -0400
Received: from ozlabs.org ([203.11.71.1]:45255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeJKKmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:42:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Vx3Z0yS3z9s9J;
        Thu, 11 Oct 2018 14:17:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539227852;
        bh=grh4/HbiMAGGsVyo5+aYdKepY2GFrnhIiyee8m430UA=;
        h=Date:From:To:Cc:Subject:From;
        b=hcWA8xoXH5xFjpeS00pxPvKWNBb8IiQnwL3o89OUGgQ7dAo1fz28cT7M2mLjWUrui
         fPU5hfbqIo1Rz22O+OieJQ+TiVYzyQjZoFWqYxbOwpoMcTEhtOQgQJ5k7Kv+eSHd9i
         lJjJ3QEtpVvWOqs6WR82KgJPrnDy9UOnGer6rAO4YX1WsjCms3/8/w9S7aT6geHdHh
         1BPj6Hc++9ZhpQ84o9TwPGAWa8j8cRufMeVL3peK3H9j7mJH2YQR16cqEZlSPZ1z8f
         C2MdoqWp2ox0NJUsyBSxnrWJhYaAFVBL6bmSuGmqdfpOJ1YxZaII/wI0asQ84w447c
         seYow+AUmYg1Q==
Date:   Thu, 11 Oct 2018 14:17:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJl?= =?UTF-8?B?Y2tp?= <rafal@milecki.pl>
Subject: linux-next: build warning after merge of the pinctrl tree
Message-ID: <20181011141728.50b2d17c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8.DqxVfOzuY8hRVXYWhqNy0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8.DqxVfOzuY8hRVXYWhqNy0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

After merging the pinctrl tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/pinctrl/bcm/pinctrl-ns.c: In function 'ns_pinctrl_probe':
drivers/pinctrl/bcm/pinctrl-ns.c:288:29: warning: cast from pointer to inte=
ger of different size [-Wpointer-to-int-cast]
  ns_pinctrl->chipset_flag =3D (unsigned int)of_id->data;
                             ^
drivers/pinctrl/bcm/pinctrl-ns.c:310:27: warning: cast from pointer to inte=
ger of different size [-Wpointer-to-int-cast]
   unsigned int chipsets =3D (unsigned int)src->drv_data;
                           ^

Introduced by commit

  c12fb1774dea ("pinctrl: bcm: add Northstar driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/8.DqxVfOzuY8hRVXYWhqNy0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu+wMgACgkQAVBC80lX
0Gw/wgf9Fxbmn2osdiFhONHX+ecrEpvks39dvxzEBHBHAcL0VoZ5/HqKNg1zxpwp
DULh6/9Y3HeoBKq8FuM5kKuZj84dIo/wqEhOpVeA0jrpEMldK+LaoMu0tA4FX7cN
jtdjA1cz9Epv+J8cIiqC0yildKSEgyCpNRduLS8uaymxW43SLYiCZB7za92zC8+z
Qs+J/n6DGKTKasU4msEG6SVTNO+jI2rarroW/dV8BG6FYokZB+9qrEzvkY7sCsHy
OtR53RX1Q/W/duMIJbud+9u/Z/5gvWr+7Z0YyZipZWv+tiFNyG34pmn38dJn2wwV
z2RtrA0pPWxqunQ4o49UHrzeTFzfAA==
=xsJW
-----END PGP SIGNATURE-----

--Sig_/8.DqxVfOzuY8hRVXYWhqNy0--
