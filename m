Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA3FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A2E20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DWamatl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A2E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLGBja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:39:30 -0500
Received: from ozlabs.org ([203.11.71.1]:56777 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGBj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:39:29 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439wB70w5Mz9s1c;
        Fri,  7 Dec 2018 12:39:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544146767;
        bh=GZbOethkaojKa+F2eN3CBgwTF4wEcCJlit2dBmXonkw=;
        h=Date:From:To:Cc:Subject:From;
        b=DWamatl31ye3iEHKvrAz7mJRMgPb9Wk46Ljae/NPceXdzshAGEh5CfcU1u3v/Z8DV
         1AW9+GDEQ145397AdBFVsSku4bE+24Yp/7jVycv6iqR7k322/gIsbdbB4niCOfXPz8
         JSlkxD6oRy3agjFQ4QL5leklNzCZMk9uh61okgit/Pnmehv+LP0vJ7+JK+fqwvogQd
         2z84+VCjlSGCf6y1xByqQXuidBlpr3XwRuE6osbNEpvZZFC0O4nGiEYCQvkt/ddyh/
         2MjLaHhLrHMn+R6xIjeN+tfoGzPVcFOue9rcMNkpVMZIcN4wt0Lkvk2N9+XGlbmhPs
         BhIFYYBvfsHzw==
Date:   Fri, 7 Dec 2018 12:39:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181207123926.0f82b9e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g+AEpj1my40rM4hE6m5k1.V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g+AEpj1my40rM4hE6m5k1.V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/dsa/master.c

between commit:

  a3d7e01da060 ("net: dsa: Fix tagging attribute location")

from the net tree and commit:

  dc0fe7d47f9f ("net: dsa: Set the master device's MTU to account for DSA o=
verheads")

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
index 5e8c9bef78bd,42f525bc68e2..000000000000
--- a/net/dsa/master.c
+++ b/net/dsa/master.c
@@@ -158,31 -158,24 +158,47 @@@ static void dsa_master_ethtool_teardown
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
+ void dsa_master_set_mtu(struct net_device *dev, struct dsa_port *cpu_dp)
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
  int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
  {
 +	int ret;
 +
+ 	dsa_master_set_mtu(dev,  cpu_dp);
+=20
  	/* If we use a tagging format that doesn't have an ethertype
  	 * field, make sure that all packets from this point on get
  	 * sent to the tag format's receive function.

--Sig_/g+AEpj1my40rM4hE6m5k1.V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJz04ACgkQAVBC80lX
0GwtLwgAnR3stvtENL8oloWFqae8YsHD8QIXx+0L6Zxu/lCNGz61IBfqfCVo9bMg
AOg5lWEpSM7Nd6rqFYdMcL3uAgsCUq0OGpz0iqYs5D4aNhEfE2DEJIu+aQI+rg2t
PInfToMrVI2bD3fVbMoDblUyknkOoVdtn47855Z/Ak5Uz3iyjNAFD5+QwdARxqr1
cVbV3abF8b3sGM/4iNX4Ddo8HgNmU/e0tGjYPpz9K+XFxP8vPs62t7gTNtr7QKbj
g6zmRuzvXqa1xnwiUV+T0vK5TzGjbiHMZUxMqokZcWP0MZ365tq60wNzILFDjK64
hTkGMHlDXAPVQEG1k03Qh5ahEVEWQw==
=6QWn
-----END PGP SIGNATURE-----

--Sig_/g+AEpj1my40rM4hE6m5k1.V--
