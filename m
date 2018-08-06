Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BABBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3368B219D0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OurrwIOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3368B219D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeHFH2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:28:24 -0400
Received: from ozlabs.org ([203.11.71.1]:57489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeHFH2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:28:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kQwX5gQWz9s0n;
        Mon,  6 Aug 2018 15:21:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533532860;
        bh=6jecpq8a7RGalSnYzaT5gLYp+xTdDYXTmixMfiKCWHA=;
        h=Date:From:To:Cc:Subject:From;
        b=OurrwIOSsb1CXtea7EB480lljXMI9p52NUr7yVXLnf0INZJQVEkOeGcxmzaYV3Gd/
         a9LEUotz/RIhlcchDkt9DKuICDWnUGZXLP5Aebw4m/MXPG3Ae3B3jnT2fiFL4eN3cd
         bMNLVKjoSmC0+CiMvkN0nsY9035/hG1ln/jJ8dVq0aD9b+u6boQPeN5jKQ37hbjSC6
         HyiZ090aB+5HJS7CxlMR5mmOkI/+WYYXzWlUqdZTUVO9phuLE0t1tPNjqup+AKnSON
         zq/ouvcIfXBqUXuYVUE82/IAameVg+88C0uUOlq0Dum1JzOrQeU/hG7dtm1PLnETqK
         dnslyuKytZQoA==
Date:   Mon, 6 Aug 2018 15:21:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180806152100.05589155@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R53ma/=8.4uMOEcQeyNSd1I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R53ma/=8.4uMOEcQeyNSd1I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/vmx.c

between a series of commits in Linus' tree and a series of commits in
the kvm tree.

I have no idea how to fix all this up, so I just dropped all the changes
from Linus' tree (all those commits only touched this file).  Please do
this merge your self or provide me (and Linus) with the necessary
resolution.

--=20
Cheers,
Stephen Rothwell

--Sig_/R53ma/=8.4uMOEcQeyNSd1I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltn2rwACgkQAVBC80lX
0GwoMwf/Sbs14WZIEagm9z7rfSXl3VvLXCJuPfimOQVoW2t2kEArUVFxAdXuI4oT
F1MC1cCth0AK98vrCO7gxSV1VPSRPFNQPpfJRrVrUXRoniM4fuLRfEYlsl9wzWaT
/Er9ZMUK/n5FaNoUmo/gxSolu47rV8Cf6cqc7beyJnYwqkN4AEf3mvPxHa985JU/
vkf37saLsll8QO/fTayBcGotqe2he4AhQo2DoVqjFqAssTNiainnARDB1fcRF+VT
n9TWfTixDdDH0v+nFjU33WX+v19fN2UbxRrv8BbrhDHrUXHFSSghFT54sNor/eKu
EngNbtvACirEEhBVQXfxqHql9qlBNQ==
=RdcZ
-----END PGP SIGNATURE-----

--Sig_/R53ma/=8.4uMOEcQeyNSd1I--
