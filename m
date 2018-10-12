Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9568C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6F12075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GhTKW/eY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6F12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJLMlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:41:32 -0400
Received: from ozlabs.org ([203.11.71.1]:50083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeJLMlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:41:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WbWv5bFVz9s55;
        Fri, 12 Oct 2018 16:10:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539321052;
        bh=wFEeBBtJx7diIgWcRj9/79VtfRPrBmn3BVu8Ya0UmSE=;
        h=Date:From:To:Cc:Subject:From;
        b=GhTKW/eY5MBvd/mwqj+vRv0wNbmXdnMvJnJhIObL4pX6JQ+U0BIrNa1ckRSE1drjb
         +yXMOQ3Ms745XXdA1V89EuZ08Dnsr6UXsyc5S1yja10c30o/OE6TPXiWsHMPsj0S62
         9AsbZZI4QpqcPHu5GtsqC3vTrTTmYGDjeUjrl/Lf4Jmi9Q1/7NxsgAigCBBE5zYtwR
         eaAZ8yjO0+1JBXuFIjKUdjlyQK+2j9Cd8mocQclqjzoVmjqHBm/EW86IpMqvjgO34k
         0u2becKjBivimcTwWn40OtyRHhLZ38HY1B80YgGVdX2j3qE8ZxZd3W3adf5Wh0xT0X
         Yw4Fq+tK8ilBw==
Date:   Fri, 12 Oct 2018 16:10:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Subject: linux-next: build warning after merge of the scsi-mkp tree
Message-ID: <20181012161051.34223689@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KHqK1_6L2xiani+aCG0g2.z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KHqK1_6L2xiani+aCG0g2.z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

./usr/include/scsi/scsi_bsg_ufs.h:45: found __[us]{8,16,32,64} type without=
 #include <linux/types.h>

Introduced by commits

  a851b2bd3632 ("scsi: uapi: ufs: Make utp_upiu_req visible to user space")
  e77044c5a842 ("scsi: ufs-bsg: Add support for uic commands in ufs_bsg_req=
uest()")

--=20
Cheers,
Stephen Rothwell

--Sig_/KHqK1_6L2xiani+aCG0g2.z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvALNsACgkQAVBC80lX
0GyV9Qf8CC42pjmBm+cWGHaPt+OS1yyHafI3aO6UrYXaueLBkNk186OZhGBf32Kd
FQQoVB7u22VNtlRlopYofiVdygR/s8QesHDm8ZWUsouPO2RIUoTRHvj7s/2qG/PI
QDpg0Xxmp1xY9QtrSXTAg31KqcFXwr86EjogWDHKm/8pmH/O/GcyFWwIsdhT6oWt
ViDpyXd1wFS6tj7xfqiIz4yidD6zNnIdMgpJkKIQOq/HnJsVzRy9o8eiZjzgIFIl
XC1bzLB0HhCZ9VukSmc2BgogbBQxUsR24JwxhVc0zotSFSvaGZrIW3K+M2cSW7M/
QhE9o8jwmwEgWk5+jCZ4L9QF6xkOtQ==
=F+6U
-----END PGP SIGNATURE-----

--Sig_/KHqK1_6L2xiani+aCG0g2.z--
