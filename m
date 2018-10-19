Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF86C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 03:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E382145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 03:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jHaaRB3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E382145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeJSL3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 07:29:33 -0400
Received: from ozlabs.org ([203.11.71.1]:49351 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJSL3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 07:29:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42brrx4ym2z9sC2;
        Fri, 19 Oct 2018 14:25:21 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539919523;
        bh=rtee8WIobVFDHiyv++6phgw5Eh+emisB85ZjXpuWTbQ=;
        h=Date:From:To:Cc:Subject:From;
        b=jHaaRB3MN1VhjgJ87DD32LEpoq6+nwa3HspClBzqGWLSAthTSIrWmiv9PF9IPkgln
         VFzBoyWs0mhFMHnqmdnj0/fHiNapcghg20c6WLMUEKCh43hSeQ0koZ006nTVZlYpHs
         n8lmAlD8UuKAT+FUouibM6haeGV6/bpF1xIQsxtpTYb+FfjBi+jBfu86D/LTq+b+wu
         A27mFt6euGxKVvlOElWifkgSqOfSWFE0zymthuaVX7Z0CY3f/b6lqDRb5QwyesLS/S
         uDfbpeHbvH67K/84pqMSMB5PmFCy5//9sQZOCc0bUgpCmE7/GgpCszc8sZzKr327PB
         ZkT1gSc9qgfkQ==
Date:   Fri, 19 Oct 2018 14:25:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: linux-next: manual merge of the kvm tree with the tip tree
Message-ID: <20181019142508.72650fa8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2CB9Ba.p/spzxBLrrZ/338C"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2CB9Ba.p/spzxBLrrZ/338C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  tools/include/uapi/linux/kvm.h

between commit:

  25fe15e54fe5 ("tools headers uapi: Sync kvm.h copy")

from the tip tree and commit:

  c939989d74e2 ("tools/headers: update kvm.h")

from the kvm tree.

I fixed it up (the latter is a superset of the former) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/2CB9Ba.p/spzxBLrrZ/338C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvJTpQACgkQAVBC80lX
0Gx+Egf8CQ7DNoiYjZHbVoyzcV8ARP63u7zlJ+MmmaX+DDeA2VyOxJZ1xH3ihCvV
eEjIMkx6anherK7UUHYNYvrHyUBZbeASboSKeVU3ibsUQwcS8gD5o1KV4N4nO20i
NjfgDKQdZAwco3GAqdXTzuI/vXFcV+3OSkt5y31xs/DSP8BdvpJPa66bx5GHEVu7
kqwAdMDR95X4MvyAkC32clXlESdcVxZEWDNdnf350blspUpjifK02dKenUMiY2Ut
9E1hRtc7eCzBnKNFg2r0IbjbtFW82Rgiuucj0QaGZP0XWuCfZrGKx/YFt9mXwE3q
+R3q2FaQUxhSi55MBWOzCWm0GRrnFQ==
=FxcI
-----END PGP SIGNATURE-----

--Sig_/2CB9Ba.p/spzxBLrrZ/338C--
