Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F083C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A082083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PUOac5jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A082083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeIFEe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:34:57 -0400
Received: from ozlabs.org ([203.11.71.1]:39741 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbeIFEe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:34:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425LNX5cpsz9s47;
        Thu,  6 Sep 2018 10:02:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536192140;
        bh=WUQjIJZtYmZrPJHqs5zT02iDfOAOJ45XoD4iO1ywA+M=;
        h=Date:From:To:Cc:Subject:From;
        b=PUOac5jFIwcO4CaJpHPhiN61RiNSVXrNJ1L27Zowf38wMHWEUMKosgIO5WE9RPe2t
         /+OUNAT/uDA9ZLaozHl7T2rjxpunnHF2RtvSswrKJw0FZahdU0iuZ0IYb2l3sYg8yB
         EYtzBIWW0VthPc6qISMTG1dJoKgFOSGcFH64pukidRRRINZA9Yr91rGdrijqa+cW85
         1uR1DPrcWIUkRpe67DVqNWo+mT9t7Vft51F+ycFlvPjjfi2KmK+5/C2xfPtMUyXoL0
         zmQ9rltb03OYTKPnZkUqcAaw2oTtaKt3V7vPZ4tfivcJxLAyYU/dxzLYSsHD2xS4sL
         2Bf62ERe4QCRw==
Date:   Thu, 6 Sep 2018 10:02:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build warning after merge of the vfs tree
Message-ID: <20180906100220.4df8ac0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.LPULtNEbtKo+7d4njr6UeL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.LPULtNEbtKo+7d4njr6UeL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

security/selinux/hooks.c:2835:12: warning: 'selinux_sb_remount' defined but=
 not used [-Wunused-function]
 static int selinux_sb_remount(struct super_block *sb, void *data, size_t d=
ata_size)
            ^~~~~~~~~~~~~~~~~~

Introduced by commit

  dfcf373eab92 ("vfs: Remove unused code after filesystem context changes")

[For some reason this warning only appeared after I merged the net-next tre=
e.]
--=20
Cheers,
Stephen Rothwell

--Sig_/.LPULtNEbtKo+7d4njr6UeL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluQbowACgkQAVBC80lX
0GzJAgf6Apn0Y1bHENyqyUZT5g4g7tuB4gF9Igi5Z5bur11fVuHdQFoWqdSVAD8l
eQJ5HF/YBPR6YcNoRXZ1x0+2DhqiuQEgvg66vZBiR8eEnCc2iNQFSRsrdW6jsHHd
8DI669vq7wmXSa7voOWNiAGijRxodqpURyXEJNzVJuqpMWUX132dIJ4z+z9xm+Lp
LtEwp1o7bp35DVot/LehggINi7wncUaZRva80Vl9KWYqXnyPRSG8JawH3qagXVaW
9wKIGnj8mV/FPw+7H0gZR3i3KIl4KyCb6Ev8YKRAw+UeF3PFnAWpzV389tcn7UPh
se/cgSFUc1Ce8YPfp4aKYZazrWvUYA==
=xlC5
-----END PGP SIGNATURE-----

--Sig_/.LPULtNEbtKo+7d4njr6UeL--
