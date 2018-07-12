Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B60C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1907920849
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="md8E4lEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1907920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeGLEio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:38:44 -0400
Received: from ozlabs.org ([203.11.71.1]:49447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbeGLEin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:38:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41R30L2Gkzz9s2L;
        Thu, 12 Jul 2018 14:30:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531369858;
        bh=c9unTYPiETWOIew1Xj7Nc8IJVRCM0ajJNuqaQKJeETQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=md8E4lEPiq3wwIaMk7qOnhnMWtTWz1dIXuHJJJBiWivJypgi1H2V0QRKlxT61NE2n
         VaDLcyhvu1s0CG3F5O4xOoeF0ZZc9jJbNaFawS/6npvstACXKldTb6pNJ+RF3Dfp6X
         YUWB2hjZZyWsmEtLPIClI+elSs4wTluPIY0uXVejvNpTTu+TGauqXMK6ue2jHj/Udp
         Udn50kOUz+dwPUsjI/wrZe62txEkSTVv7ZOrXQU+59CLosZma3tKODj5t9IoldsW27
         hMYvPr7/9d+BY1IEANQ+ejH5jcH2X6yArDTMCCg2kIRPk1wtAtYNIHJ75WaAnamXQU
         OVjMFRM/n+I5A==
Date:   Thu, 12 Jul 2018 14:30:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: linux-next: build warning after merge of the scsi-mkp tree
Message-ID: <20180712143057.49bfcab5@canb.auug.org.au>
In-Reply-To: <20180711141737.57c1e26f@canb.auug.org.au>
References: <20180711141737.57c1e26f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QpsxAeG3Hm0fA0SqnzCuzmo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QpsxAeG3Hm0fA0SqnzCuzmo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 11 Jul 2018 14:17:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the scsi-mkp tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>=20
> In file included from include/linux/spinlock_types.h:18:0,
>                  from include/linux/spinlock.h:82,
>                  from drivers/scsi/libfc/fc_rport.c:61:
> drivers/scsi/libfc/fc_rport.c: In function 'fc_rport_recv_req':
> include/linux/lockdep.h:347:45: warning: 'rdata' may be used uninitialize=
d in this function [-Wmaybe-uninitialized]
>  #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
>                                              ^
> drivers/scsi/libfc/fc_rport.c:1832:24: note: 'rdata' was declared here
>   struct fc_rport_priv *rdata;
>                         ^~~~~
>=20
> Introduced by commit
>=20
>   ee35624e1e4e ("scsi: libfc: Add lockdep annotations")
>=20
> It is actually complaining about function fc_rport_recv_plogi_req()
> (presumably it is being inlined) and this looks like an actual bug :-(

This warning now appears after the merge of the scsi tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/QpsxAeG3Hm0fA0SqnzCuzmo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltG2YEACgkQAVBC80lX
0GzzMwf/RUfZU0nUt9kl6fQB6BP2pu9MFDudXIqjRdYcd3S+GcbuIpjitzD40gnc
5qMFknUXC6W7xJMhJdBSfKGCEZ8OS4yYS0p7RbRt4RJO/bAZkMx786rK7oP492EC
fQqQFTWm/5bk5Yob4LtuNA/mdD5fR+tewsOAjc2R128ZfvFak6AqDhEEISZS9S7f
vyUEx9JCkf2y37hQCOPBOQURrzM9VhHbQ/7jLSYTbcxW9/etLiJUsggdjjAKv/Lf
yba63YcyW6+WjeQO2PFboroddtpbwLWeEl4bm/8/s8Mj4zY5jSlPJl67CZ5BCHwK
R4OIaWYC1bzy2qLwygkTSdWJwc0HzQ==
=6XiN
-----END PGP SIGNATURE-----

--Sig_/QpsxAeG3Hm0fA0SqnzCuzmo--
