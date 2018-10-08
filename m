Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5735EC6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA6B2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Rz4Mym7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA6B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJIHFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:05:17 -0400
Received: from ozlabs.org ([203.11.71.1]:46965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeJIHFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:05:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TcZH3psnz9vZs;
        Tue,  9 Oct 2018 10:51:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539042663;
        bh=yroEqqV0NWUpGSeI2nMme2pJXf79Non/OTFybBGu4sA=;
        h=Date:From:To:Cc:Subject:From;
        b=Rz4Mym7GsLqjRB7O8t/tHvFZVTevNwKomUEuumhlKLFGQdWvJyCjuLJrpzY9YESAl
         pvrJkrN7xq51DIiZitt3b+fQLlZcf2yr/Dc928OplAEN3ELKDHmhrd8nyYJdkJVlDZ
         OCAiAXkPrwwLE3+sBb5sn3TA3l1B4vB09DRclQCyJfiReUlVhQbyw7wr6tXWFkXza0
         k3vG1lZMZD8jxzvD5bXTfsgsd0CzmIBnxrSTev7pwG0Zp7t/kgJ+7n+qw+pYyystUW
         fHOAVaVAH639BRXwfIDLRJDoJY+3qzLjAczCaHCH0oPZzaZUWz4U0lE1fbLg3uGVUk
         TpMg2Ia4+W0Tg==
Date:   Tue, 9 Oct 2018 10:51:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the ext4 tree
Message-ID: <20181009105102.752dd9ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VE.6rR8QIzaC+fBcZYboxmY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VE.6rR8QIzaC+fBcZYboxmY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ted,

After merging the ext4 tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/srcu.h:33,
                 from include/linux/notifier.h:16,
                 from include/linux/memory_hotplug.h:7,
                 from include/linux/mmzone.h:752,
                 from include/linux/gfp.h:6,
                 from include/linux/umh.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from fs/ext4/super.c:20:
fs/ext4/super.c: In function 'get_qf_name':
fs/ext4/super.c:931:40: error: 'struct ext4_sb_info' has no member named 's=
_qf_names'; did you mean 's_mb_maxs'?
  return rcu_dereference_protected(sbi->s_qf_names[type],
                                        ^~~~~~~~~~
include/linux/rcupdate.h:358:12: note: in definition of macro '__rcu_derefe=
rence_protected'
  ((typeof(*p) __force __kernel *)(p)); \
            ^
fs/ext4/super.c:931:9: note: in expansion of macro 'rcu_dereference_protect=
ed'
  return rcu_dereference_protected(sbi->s_qf_names[type],
         ^~~~~~~~~~~~~~~~~~~~~~~~~
fs/ext4/super.c:931:40: error: 'struct ext4_sb_info' has no member named 's=
_qf_names'; did you mean 's_mb_maxs'?
  return rcu_dereference_protected(sbi->s_qf_names[type],
                                        ^~~~~~~~~~
include/linux/rcupdate.h:358:35: note: in definition of macro '__rcu_derefe=
rence_protected'
  ((typeof(*p) __force __kernel *)(p)); \
                                   ^
fs/ext4/super.c:931:9: note: in expansion of macro 'rcu_dereference_protect=
ed'
  return rcu_dereference_protected(sbi->s_qf_names[type],
         ^~~~~~~~~~~~~~~~~~~~~~~~~
fs/ext4/super.c: In function 'parse_options':
fs/ext4/super.c:1976:26: warning: unused variable 'grp_qf_name' [-Wunused-v=
ariable]
  char *p, *usr_qf_name, *grp_qf_name;
                          ^~~~~~~~~~~
fs/ext4/super.c:1976:12: warning: unused variable 'usr_qf_name' [-Wunused-v=
ariable]
  char *p, *usr_qf_name, *grp_qf_name;
            ^~~~~~~~~~~

Caused by commit

  cc1ee227e890 ("ext4: fix use-after-free race in ext4_remount()'s error pa=
th")

# CONFIG_QUOTA is not set

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VE.6rR8QIzaC+fBcZYboxmY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu77WYACgkQAVBC80lX
0GwFfQf/beYY8Rb0CwovvRZExqfioGpQdO4p2FILzHIpV/k+wJ4W+5po5o8knv9v
0Ll/4hepLCQ/yISS7Ry3LTOcZ1ZLraLOxRGUuMlId5IsGsWDjY7Qd8n0XbYMNwNU
GsHSmg4zgPFiAYDYcRv/40YVVqRboC1/FbDUhvhJZ5t32q8Q00eawm4KYdX/nB6m
lze0Bu+cGJ/3FazoUxPFh2R3U3iUXy1WxpyLnYTpySf7l+TqRGpTG72Vt0jqsY5u
81MZkflb9uvt8pgbEOWJXD6H7haFhflJzgQ+QXLYeXqOWzluEpc9mem2oDABGD2h
ydrNCFLEgd8rde/mdGqkIxZXgO+yAQ==
=AbQd
-----END PGP SIGNATURE-----

--Sig_/VE.6rR8QIzaC+fBcZYboxmY--
