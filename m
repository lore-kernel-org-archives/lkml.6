Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEBCC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208DA2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UCT2imHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208DA2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeJBKMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:12:49 -0400
Received: from ozlabs.org ([203.11.71.1]:54089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbeJBKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:12:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PPp85Mxpz9s3x;
        Tue,  2 Oct 2018 13:31:44 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538451104;
        bh=HydV3e0aQs1K10v+d6AoD9f7U8wrFOadY4qSFVgz0nc=;
        h=Date:From:To:Cc:Subject:From;
        b=UCT2imHqmTRLgJo42Oba8i+bQ79xsB8TOSJsyN3dEflN9ul0l1g084meSF2T9QcuI
         ziucfIjUL5FhBmOX1dq1JuAyH9hsVmNwqCiunxfRdKT4Z7++qP2esnIHEAs4ScOuEH
         FF74D7D7/7PB5bTTQip0NJra4AwOvoUeltoF/xSc+xH2UW3u2UqRpjWI/4ipYoJ9Lw
         lOqkH2fPCnacLLss2S6ROi3EKocUSWzUAF/D5olKzFaORKFiP8Dvjg8P/lCla+V627
         DcXmRVY0r5aUonO5fxmc0vOM3K3etaqIch7uCwaXE6VblWNxDdRujbUeZGgLQPClPO
         uVlLrgpKX9aZw==
Date:   Tue, 2 Oct 2018 13:31:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Andy Gross <agross@codeaurora.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: linux-next: manual merge of the devicetree tree with the qcom tree
Message-ID: <20181002133144.4ea80f23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5tcLE6c.4bdLcwazvQcTehZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5tcLE6c.4bdLcwazvQcTehZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Today's linux-next merge of the devicetree tree got a conflict in:

  drivers/soc/qcom/apr.c

between commit:

  4fadb26574cb ("soc: qcom: apr: Avoid string overflow")

from the qcom tree and commit:

  b2efb5b04591 ("soc: Convert to using %pOFn instead of device_node.name")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/soc/qcom/apr.c
index 716762d59c1f,4bda793ba6ae..000000000000
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@@ -219,9 -219,9 +219,9 @@@ static int apr_add_device(struct devic
  	adev->domain_id =3D id->domain_id;
  	adev->version =3D id->svc_version;
  	if (np)
- 		strscpy(adev->name, np->name, APR_NAME_SIZE);
+ 		snprintf(adev->name, APR_NAME_SIZE, "%pOFn", np);
  	else
 -		strncpy(adev->name, id->name, APR_NAME_SIZE);
 +		strscpy(adev->name, id->name, APR_NAME_SIZE);
 =20
  	dev_set_name(&adev->dev, "aprsvc:%s:%x:%x", adev->name,
  		     id->domain_id, id->svc_id);

--Sig_/5tcLE6c.4bdLcwazvQcTehZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluy5qAACgkQAVBC80lX
0Gyg1wf9Gxvpbo+KXpmdbSJkTrWo2gTHntDv/w2PivEmYLWqVvuTTcMOWEEFF7wS
j/pC2rpyPIXh2z4Vd83uV0lUoezukfs2Hq4s9fdWUvXmLDpTXr9e+hyOdM1y5QMZ
mQa1cFCqDz5bS9K21/tpDDtaDWiYQHOonkS5wXqcldC8OhRSmM/fZc09m321mm/W
8RKlZgM0ATMuzCNlbGHK+m38XAQDDbB1g08F1zB7pJNszDNfdK3XigVMjELanTpu
mXE+j7JcZj+Gm9t5ZJ5mlbDEJAzm/KPS6eShQLTpkzMUZ4ch+eqXV8l1SMmaHp7L
2b1qjXkf2ixLXnmCsMU86Lh3yS3dYQ==
=yk49
-----END PGP SIGNATURE-----

--Sig_/5tcLE6c.4bdLcwazvQcTehZ--
