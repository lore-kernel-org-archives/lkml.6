Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A5AC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A8B214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nSEXbJFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A8B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJJGas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:30:48 -0400
Received: from ozlabs.org ([203.11.71.1]:57077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeJJGas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:30:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42VCfB0QyJz9s89;
        Wed, 10 Oct 2018 10:11:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539126690;
        bh=OsW0LNuc2AHNR/iRrMwYlPCMbEZLjUIG82ixLHW8kR0=;
        h=Date:From:To:Cc:Subject:From;
        b=nSEXbJFkADkRiN95hvbMq1KFEfXTnyp0LVpB5PXeBLoje4PzE5azpYLmwvwSjy/4q
         hNjj4vdueFdoCJwaucOZi+sw2x2PdrZNJwKTjoY/XWmYe65sUVk26ZIbLAos4N2P3t
         KuRSIBzwEF83NFm7HZ055ddwf54gI3CTHEWCYzItqKo8b3ewh8WCbWv6JDaS5vqbWH
         jeBj2MEPtITUgCvjPFr7iIyseg7e85A4bbiAiQ6NguYm4Jn/e9BsCNKemdE1QQX8vF
         T9NPQyQcSXO/8VXr7Bd7wh6audJFUdCkyXk9e+9w5fW2/3BrWTtOlfFxD5BesmaaVw
         Gjn9ZtnatAljQ==
Date:   Wed, 10 Oct 2018 10:11:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the ext4 tree
Message-ID: <20181010101128.2b151332@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DqM3eeZDreT2TM4kopw+=rT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DqM3eeZDreT2TM4kopw+=rT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Theodore,

After merging the ext4 tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

fs/ext4/super.c: In function 'parse_options':
fs/ext4/super.c:1976:26: warning: unused variable 'grp_qf_name' [-Wunused-v=
ariable]
  char *p, *usr_qf_name, *grp_qf_name;
                          ^~~~~~~~~~~
fs/ext4/super.c:1976:12: warning: unused variable 'usr_qf_name' [-Wunused-v=
ariable]
  char *p, *usr_qf_name, *grp_qf_name;
            ^~~~~~~~~~~

Introduced by commit

  20cefcdc2040 ("ext4: fix use-after-free race in ext4_remount()'s error pa=
th")

# CONFIG_QUOTA is not set

--=20
Cheers,
Stephen Rothwell

--Sig_/DqM3eeZDreT2TM4kopw+=rT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu9NaAACgkQAVBC80lX
0GwZ/ggAnvMcmjfwnTmIpzYWPfYNjt6ySmbmwUxMf9hOmE/IshrJEdpEicznKmGa
PyCioYcFaIb2M9Vam+0Z5V+DjIcik89liblsUkieqRMTNuaieFn+5dcu4e7NUnTR
UJ29OXilkaBeGTgewZF6G2d5uHVKjsjxiZmZJspZguzEdRlQ35ehnANytnhXV5yR
3Rgp6e0Dedu7dumZVxfQaFl8elZws90FFZm0ATxpUlUb3AviVTOAUloxcGzJL7Dd
As7/nJqfpX4TBwa90ZwAbSAnOJfLe1qJP5v7gfklSZ+rBIpbYt4KXrEK5Y+zJSgI
ILVaH/FaKfnO4NxlgJsVcHbpKxihwA==
=LAU4
-----END PGP SIGNATURE-----

--Sig_/DqM3eeZDreT2TM4kopw+=rT--
