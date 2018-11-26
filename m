Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF88C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9392089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WJkH5Yni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9392089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeKZK6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:58:52 -0500
Received: from ozlabs.org ([203.11.71.1]:47339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKZK6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:58:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4336dx3VNWz9s29;
        Mon, 26 Nov 2018 11:06:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543190789;
        bh=AjAAJnUA0yyih/z+3dxvCvhSD1Ln8Fd2k9x3VLDl3nY=;
        h=Date:From:To:Cc:Subject:From;
        b=WJkH5YniF5oyKIFZ/MGulOOPDGmCN6d0KgGXueX1Y0J7go8Ds3VDaE40/PGb7qwPK
         s3uV2Dc0H/ELv+iDjVRv3WQ5/1BkI879ql3OauJoPJAB0BB6ZzZR5RS5vJkxAUdbqu
         gw2neLJXQlU09VSh8nHX2C6+qvROPZ9Uf42sRT2/PR/GUB4hm7jK5zbeA9KZ8pOxcz
         blhPQ7IliOLcM1KQoUqzyXUHXPJR/R5CxdlTlTD/qC/Gtc/lhuT9knpqq5wO+Q4suc
         CyTg8YWqhcNxtdbDVR+3AwMDfZ/QU9cM7U90wXD1x/LpcFbtfHaV89P4Zstdm5YGyx
         vRJu3+PRrnqfg==
Date:   Mon, 26 Nov 2018 11:06:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>, Kees Cook <keescook@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: build warning after merge of the btrfs-kdave tree
Message-ID: <20181126110629.45969c51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NY1.eIclTa7R63+zM52V_6P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NY1.eIclTa7R63+zM52V_6P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

After merging the btrfs-kdave tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

In file included from include/linux/string.h:6,
                 from arch/powerpc/include/asm/paca.h:19,
                 from arch/powerpc/include/asm/current.h:16,
                 from include/linux/sched.h:12,
                 from fs/btrfs/volumes.c:6:
fs/btrfs/volumes.h: In function 'btrfs_op':
include/linux/compiler.h:77:22: warning: this statement may fall through [-=
Wimplicit-fallthrough=3D]
 # define unlikely(x) __builtin_expect(!!(x), 0)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/bug.h:72:2: note: in expansion of macro 'unlikely'
  unlikely(__ret_warn_on);    \
  ^~~~~~~~
fs/btrfs/volumes.h:395:3: note: in expansion of macro 'WARN_ON_ONCE'
   WARN_ON_ONCE(1);
   ^~~~~~~~~~~~
In file included from fs/btrfs/volumes.c:22:
fs/btrfs/volumes.h:396:2: note: here
  case REQ_OP_READ:
  ^~~~

Introduced by commit

  cf8cddd38bab3 ("btrfs: don't abuse REQ_OP_* flags for btrfs_map_block")

exposed by my new use of -Wimplicit-fallthrough

I am not sure why this has only turned up now (as opposed to earlier
today).

--=20
Cheers,
Stephen Rothwell

--Sig_/NY1.eIclTa7R63+zM52V_6P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7OQUACgkQAVBC80lX
0GxrKQgAnO359KtN/3xmOk8Bo3Qx881zdG8xFgAMpV44xOEF/eOdV6nmgs+Bx6K4
ogWVSzdOM/xLIbeglvpTCUeiiU+H8eB2VJU9xIaXRroxXvgWp6SZp3V6PPoDS0I5
b2H/ZHzkQbIgJLK/WoneqJSZanSW0iChijeoHCn7W+HB2tK1EUowKsZz4D6sBL1l
+mMDZgqXkwLit4OwCtqsiAuRp9NgR5g3Llr9l2l70RoxyBvD/rtSILkt4WKtZQpz
CRNe1RigFsxmSxC1xgv+m6/+z5AenqSCfmOJ0i1u0O72/KAkLUFPhMgzaQv2vUNt
A98AC1wEv4GWROuw+bERZ7MswY6BKw==
=wpGx
-----END PGP SIGNATURE-----

--Sig_/NY1.eIclTa7R63+zM52V_6P--
