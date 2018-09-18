Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BA8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4894021471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="umhHZriq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4894021471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeISD7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:59:46 -0400
Received: from ozlabs.org ([203.11.71.1]:56283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeISD7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:59:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42FHcF1MJCz9sBZ;
        Wed, 19 Sep 2018 08:25:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537309501;
        bh=xRV7qEK0ih3K71eX0hONDJU06F3lSSSPrJzYAG+Aglk=;
        h=Date:From:To:Cc:Subject:From;
        b=umhHZriqEvh1z6RqFoEtDczffgPt++O1rKwr1pTOno/05zZDx4vL4wNtl4tTcqbJS
         W94muNv7I1zJRgXabS4ZtYF7cHgR3eQP3E8RQHZSiK1BlG1opM25oEbIM3HuYL0mK5
         fkNkNkBf7gn0QNAZFf/8XvVtcjqrBDDeenhSElT2NNLC/HDODXR+4IWR2S/ijzT62e
         42WZeOxPY5NlJINbE67jTGycA+ZhxMyxiMY1PYF1RaTTzzih4KFOIGkJyr8azYqhRI
         CaxXWCKwddQNMGTtDfYGWVXTrPusRIjTknTYGt4lbjjtf8daSZhtVxib1M0qw5AlOR
         jOf0JVBWVxuIQ==
Date:   Wed, 19 Sep 2018 08:25:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: build failure after merge of the input-current tree
Message-ID: <20180919082500.74401754@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xRaItE2eXFCUdrRJ.vQJFjz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xRaItE2eXFCUdrRJ.vQJFjz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

After merging the input-current tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "mem_sleep_current" [drivers/input/serio/i8042.ko] undefined!

Caused by commit

  1685830e59d4 ("Input: i8042 - enable keyboard wakeups by default when s2i=
dle is used")

I have used the version of input-current from next-20180918 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/xRaItE2eXFCUdrRJ.vQJFjz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluhezwACgkQAVBC80lX
0Gy9IQf+LCFuj/N2zs1WCqHj0SfLR2b11CueYF3Q2r3o8x3sEf+D+cfmqxWTfNWZ
z2M0mQQTChh+PDvKzSotSFyvGlgMTff0OUj56aYimUjWsH5UGgRmJ+q5Yo+arRqm
l32ODxs1ivoWaw+Ja5QlV+A6Cri5ZZt4HySfDVZJdUfRObGCNfLNJTAn2Zcgc3tR
+I9ybvg/gXp3or6aGvN0c9ZH4NSEE5dlrkPmSTRdIkotm+5P9+oU4MOn8+twrwox
Wq/xD+BGSu4UozipeqgvYKsQh34SJI1C6fv9VY9Ati0ZQVKqzZP/qJTXV7NDkx7P
ih0dN92qf/BOs5Buq+1mKwQPeE9r7A==
=Jqy3
-----END PGP SIGNATURE-----

--Sig_/xRaItE2eXFCUdrRJ.vQJFjz--
