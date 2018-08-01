Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27467C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC9E208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FPTqRPnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC9E208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbeHAH3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:29:19 -0400
Received: from ozlabs.org ([203.11.71.1]:40519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731897AbeHAH3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:29:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gMj14z58z9s3Z;
        Wed,  1 Aug 2018 15:45:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533102325;
        bh=iyWg9r3yeitdV+Acq3lJXIJZOm4f/I8De2tAkDHvUT0=;
        h=Date:From:To:Cc:Subject:From;
        b=FPTqRPnDapVJCnZVzFNo37q3xR4lh0xu2mfX+ajMk1FSwI3auLcYmapkhdCa9YdQT
         UimpNsb8kwL5TAYpMjyhKQwRhPHnBT5d0qMzkPphYKOktTPX7Yjd48skEWQ6hN0Bja
         5SeWQJlHPbtzPR/i6VaOGH0DMEWaZYIafeDaszbQASpO9cOclaApXtD6P6pnCM2UFu
         i1EE/w5gIdXgn9vqy/h24PZtne6dVXSRbTBax7v7mnCJlioUKx6X2NWuxXKSQHUfMd
         TLcfsgcOVh7+8zoCh89dd82Hz3dhXuEo0ilr/MZVXr2zN7k7nfouS/uviz+StO5JDI
         eNG1cTyGdQXDA==
Date:   Wed, 1 Aug 2018 15:45:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: please clean up the coresight tree
Message-ID: <20180801154525.79da6372@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EbsZMwJGm/K3bCEM7ON2/IT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EbsZMwJGm/K3bCEM7ON2/IT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

All but the last 9 commits in the coresight tree have been merged into
the char-misc tree as different commits (they were sent to Greg as a
patch series rather than a merge request).  Can you please rebase your
tree into commit ccff2dfaceac ("coresight: tpiu: Fix disabling timeouts")
from the char-misc tree to avoid further conflicts (and duplication if
you ask Greg to merge your tree rather than take a patch series).

--=20
Cheers,
Stephen Rothwell

--Sig_/EbsZMwJGm/K3bCEM7ON2/IT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlthSPUACgkQAVBC80lX
0GzQiwf9HU/p9258yQpHmB2rfndVNekCGdBQHIuferV1rL18CPlXPCd8vAzGUcnX
Dd3bXHdpFNnNVjticX2QA00C4nuyDTq/OLYXM/e86TdTmIHsbvKA/c91LTly4xg6
z6stxD9q49iizvsIO1ZodSY6RDICFSE4pvEIVPjklOeBFCEs2XoJoJpXgnOgPF19
P9X4QsKZz31zeLurcCzq5aKYy/8bRMM/ck0gmsWW8k6V1dXsJwLgKqzBASQY+hV6
OYYr6EZ3ZxRBMdyv5jZoF/53JtJ29Gn0wgQI+ohdvxOXBlCH9C/2DUMlfT59V2CT
Wdy7QdfunkyNV5UmEBuqnn7Mt7dyeg==
=3+Cb
-----END PGP SIGNATURE-----

--Sig_/EbsZMwJGm/K3bCEM7ON2/IT--
