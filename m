Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AE9C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28D820831
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k7gmbj9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28D820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLJBbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:31:13 -0500
Received: from ozlabs.org ([203.11.71.1]:53639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeLJBbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:31:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Cls93P5kz9s3C;
        Mon, 10 Dec 2018 12:31:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544405469;
        bh=BLgWfaUY3vDoiLbqk5QTP1uyhxkbSGEdWLSM9pZVTP4=;
        h=Date:From:To:Cc:Subject:From;
        b=k7gmbj9heynLMVNrmCJYigyMquskLRJ+jarZHmUxtzdaG5eAn181zEj53aj6yarQR
         aXBeG9WDUqErT3qv++hAZO50P7PPGoVqJ51Ax4YTRf/i9jVVLF6QsQGWtuuDYk58jK
         7kqFZAWivSOsrg8XokQMKWSQ5erTbl2krejbxzxICLDhzXFn6B9/4xnJvlEVcyz+zm
         nnsuVyXtCKDyPUftnkEgGZp+kdd50xdHZSJgkAkbihxqLgG+Oeeo36Qa0CuBoBBNDU
         KRULUSn1vjJa9A5wrC4J3/YMkC9oqbmZedOtLIRvyMGKD2T1Rs9RIQyF7YvM4SkTp6
         heaKnkY+rLeSw==
Date:   Mon, 10 Dec 2018 12:31:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181210123107.5bd896b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v53H/qMN_qycCS0ws_ZtPnn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v53H/qMN_qycCS0ws_ZtPnn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/dsa/master.c

between commit:

  a3d7e01da060 ("net: dsa: Fix tagging attribute location")

from the net tree and commits:

  a60956ed72f7 ("net: dsa: Make dsa_master_set_mtu() static")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/dsa/master.c
index 5e8c9bef78bd,d7d5145aa235..000000000000
--- a/net/dsa/master.c
+++ b/net/dsa/master.c
@@@ -158,31 -158,36 +158,59 @@@ static void dsa_master_ethtool_teardown
  	cpu_dp->orig_ethtool_ops =3D NULL;
  }
 =20
 +static ssize_t tagging_show(struct device *d, struct device_attribute *at=
tr,
 +			    char *buf)
 +{
 +	struct net_device *dev =3D to_net_dev(d);
 +	struct dsa_port *cpu_dp =3D dev->dsa_ptr;
 +
 +	return sprintf(buf, "%s\n",
 +		       dsa_tag_protocol_to_str(cpu_dp->tag_ops));
 +}
 +static DEVICE_ATTR_RO(tagging);
 +
 +static struct attribute *dsa_slave_attrs[] =3D {
 +	&dev_attr_tagging.attr,
 +	NULL
 +};
 +
 +static const struct attribute_group dsa_group =3D {
 +	.name	=3D "dsa",
 +	.attrs	=3D dsa_slave_attrs,
 +};
 +
+ static void dsa_master_set_mtu(struct net_device *dev, struct dsa_port *c=
pu_dp)
+ {
+ 	unsigned int mtu =3D ETH_DATA_LEN + cpu_dp->tag_ops->overhead;
+ 	int err;
+=20
+ 	rtnl_lock();
+ 	if (mtu <=3D dev->max_mtu) {
+ 		err =3D dev_set_mtu(dev, mtu);
+ 		if (err)
+ 			netdev_dbg(dev, "Unable to set MTU to include for DSA overheads\n");
+ 	}
+ 	rtnl_unlock();
+ }
+=20
+ static void dsa_master_reset_mtu(struct net_device *dev)
+ {
+ 	int err;
+=20
+ 	rtnl_lock();
+ 	err =3D dev_set_mtu(dev, ETH_DATA_LEN);
+ 	if (err)
+ 		netdev_dbg(dev,
+ 			   "Unable to reset MTU to exclude DSA overheads\n");
+ 	rtnl_unlock();
+ }
+=20
  int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
  {
 +	int ret;
 +
+ 	dsa_master_set_mtu(dev,  cpu_dp);
+=20
  	/* If we use a tagging format that doesn't have an ethertype
  	 * field, make sure that all packets from this point on get
  	 * sent to the tag format's receive function.
@@@ -204,8 -201,8 +232,9 @@@
 =20
  void dsa_master_teardown(struct net_device *dev)
  {
 +	sysfs_remove_group(&dev->dev.kobj, &dsa_group);
  	dsa_master_ethtool_teardown(dev);
+ 	dsa_master_reset_mtu(dev);
 =20
  	dev->dsa_ptr =3D NULL;
 =20

--Sig_/v53H/qMN_qycCS0ws_ZtPnn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwNwdsACgkQAVBC80lX
0GyamQgAmjZgylhma/3BRD2UyxTFm1sN7sS0sZQQ2/s3NqkBkVlm5Xj3l80FW5kX
8rY2HKKNVJ9aI8UvE3LvjX/Gjij5Hq5bV895twzNl6lvF5L2lN9vpXDvFBG7VLWe
i1CdO4TcHmBFa+7BJSgof4Hl5ZQDRxUAh/6jEpqTwzHZyILbp4aeibran3hxQJkn
ad7RZO/QTboGSoFSDwtMcb7tXKrG6Y429X8XYYrNZcoEn73N5MgrKsmRlYPMOj/t
OCEX6wGGhdVYNmNAz5E0Ps9EoxpTs//ttE2KB8ZejNZ7JsZnYGmOomzgmo9gvYcm
g+IQpVvHcOwviqShR1/YqPyIEqyCXw==
=hVcU
-----END PGP SIGNATURE-----

--Sig_/v53H/qMN_qycCS0ws_ZtPnn--
