Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6676C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A7820843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rsT5yNCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A7820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeJ2K4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:56:01 -0400
Received: from ozlabs.org ([203.11.71.1]:58113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJ2K4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:56:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jyhk0X66z9s4s;
        Mon, 29 Oct 2018 13:09:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540778966;
        bh=Crec7F4dy2YeLbAXzdksmy9aRytEjjwHKUjazPJjvcQ=;
        h=Date:From:To:Cc:Subject:From;
        b=rsT5yNCFhT+KCWccnfHHvIsHZdjd0eNit2dduNPLuyTvyE8XobNT2Hs4bBPwBk8Kj
         gQalLXDKk5+3b2WCUUZSjKCgsAswHLP3qhs7Zx+7KZQeCSBw5S1loyu+27kvLrfdSC
         wNh3SINCOQFx1dS+XwJY89z4bjR7N3hlALrnJJf0i9zK8atyXeyKczmUqkU9+LcImF
         e/SlsFN2BngAOTDRXUn5M5TAGnrRw+iH4VMpB4S1fdep+CtyIiVCvEtyYGsxzmbu/2
         6YDBpOXNeREU7mfImqKathetkwYYi/rPdFJXbxaFlK3AllSpz7UQ0Jq8aQyjRhPv7V
         HOtGJJAxYQYYw==
Date:   Mon, 29 Oct 2018 13:09:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: linux-next: manual merge of the pm tree with the i2c tree
Message-ID: <20181029130925.60ea7830@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Yi5UDAd5LU=QdOHo+ui7Syk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yi5UDAd5LU=QdOHo+ui7Syk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Today's linux-next merge of the pm tree got conflicts in:

  drivers/i2c/busses/i2c-designware-baytrail.c
  drivers/i2c/busses/i2c-designware-core.h

between commit:

  9cbeeca05049 ("i2c: designware: Remove Cherry Trail PMIC I2C bus pm_disab=
led workaround")

from the i2c tree and commit:

  8afb46804dfa ("i2c: designware: Cleanup bus lock handling")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/i2c/busses/i2c-designware-baytrail.c
index 9ca1feaba98f,971b5cde7a93..000000000000
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@@ -162,18 -36,9 +36,9 @@@ int i2c_dw_probe_lock_support(struct dw
  		return -EPROBE_DEFER;
 =20
  	dev_info(dev->dev, "I2C bus managed by PUNIT\n");
- 	dev->acquire_lock =3D baytrail_i2c_acquire;
- 	dev->release_lock =3D baytrail_i2c_release;
+ 	dev->acquire_lock =3D iosf_mbi_block_punit_i2c_access;
+ 	dev->release_lock =3D iosf_mbi_unblock_punit_i2c_access;
 -	dev->pm_disabled =3D true;
 +	dev->shared_with_punit =3D true;
 =20
- 	pm_qos_add_request(&dev->pm_qos, PM_QOS_CPU_DMA_LATENCY,
- 			   PM_QOS_DEFAULT_VALUE);
-=20
  	return 0;
  }
-=20
- void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev)
- {
- 	if (dev->acquire_lock)
- 		pm_qos_remove_request(&dev->pm_qos);
- }
diff --cc drivers/i2c/busses/i2c-designware-core.h
index 9ec8394f4787,152bf56d8404..000000000000
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@@ -209,10 -208,9 +208,9 @@@
   * @fp_lcnt: fast plus LCNT value
   * @hs_hcnt: high speed HCNT value
   * @hs_lcnt: high speed LCNT value
-  * @pm_qos: pm_qos_request used while holding a hardware lock on the bus
   * @acquire_lock: function to acquire a hardware lock on the bus
   * @release_lock: function to release a hardware lock on the bus
 - * @pm_disabled: true if power-management should be disabled for this i2c=
-bus
 + * @shared_with_punit: true if this bus is shared with the SoCs PUNIT
   * @disable: function to disable the controller
   * @disable_int: function to disable all interrupts
   * @init: function to initialize the I2C hardware
@@@ -263,10 -260,9 +261,9 @@@ struct dw_i2c_dev=20
  	u16			fp_lcnt;
  	u16			hs_hcnt;
  	u16			hs_lcnt;
- 	struct pm_qos_request	pm_qos;
- 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
- 	void			(*release_lock)(struct dw_i2c_dev *dev);
+ 	int			(*acquire_lock)(void);
+ 	void			(*release_lock)(void);
 -	bool			pm_disabled;
 +	bool			shared_with_punit;
  	void			(*disable)(struct dw_i2c_dev *dev);
  	void			(*disable_int)(struct dw_i2c_dev *dev);
  	int			(*init)(struct dw_i2c_dev *dev);

--Sig_/Yi5UDAd5LU=QdOHo+ui7Syk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWa9UACgkQAVBC80lX
0GzqbAf+K5guPngSpCLhyvZXPt3dSdtogNVF36+anUCLFVUTpr/vzkhOIpnRr4Sx
BSKuC4LsQTzbYMSZ6/sWilsoghByhW5Sck+PdVgrtsEVe+nkcpQw/ppQip4OEbPF
kIN8MrnG4VG+0Bb2Pec4RtBtoXgq5XUQJuO2CCoLNGPBwKjmdlNDc1UZlFhRdHH8
j6BD/QuKoxhJYupS00/5B2Rq+38QxhRJry5ii8j+Dz6crAvIEbF/hFdhPU8j7Wah
7SmrKMGPsFXvNFRT/slRjvq0SlIRtQzGIx4URTN+sGaKJwDZzjhXG3tvqgN5idb6
RXLv/sYh/8+I9oJ2qMNZTlq8YMkV6g==
=TbQX
-----END PGP SIGNATURE-----

--Sig_/Yi5UDAd5LU=QdOHo+ui7Syk--
