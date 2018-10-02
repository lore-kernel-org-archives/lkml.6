Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B7F2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q3SjIpll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B7F2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeJBPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:54:55 -0400
Received: from ozlabs.org ([203.11.71.1]:58321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeJBPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:54:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PYMT6Yb8z9s55;
        Tue,  2 Oct 2018 19:12:37 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538471558;
        bh=wt8N+RzRSTKiov4GEORZoCD7RnNIXUbWm2AzGPzDIjE=;
        h=Date:From:To:Cc:Subject:From;
        b=Q3SjIpllLMrA2HwQfaxV/2fTJrrF3UzgRa+3P3xZam4W9pqDrpRTfBzlmtXmjdous
         ozXRzYyMe0pG9+8ucGnneSRs8pfhR/Aofz8nzJMoIU/JtmwLadluQpXhKzXXOectUE
         cvJPRIkwTPgr3yRT5R1V0tW4NfHYqRnzp6F7PWBceglEBW/XNIe1pUNHRkky+o9j++
         bt2GRxVNsYHhkyBIKl+VzkHrVR4gaZFXID9h8TGn1Rk61flr42Otr3qkTzs7H63nU0
         OrtbYvk+r2MJkVXDamiMUiboJXLGbsJQSKmJaVnGR10Evxa2K4Lr0cnmYJnPNkFYtz
         pdFlrQrd6/JOQ==
Date:   Tue, 2 Oct 2018 19:12:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: linux-next: build warning after merge of the char-misc tree
Message-ID: <20181002191236.0aa50539@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EluHv0xidCUDsi2vr6bU4ra"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EluHv0xidCUDsi2vr6bU4ra
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc tree, today's linux-next build (i386
defconfig) produced this warning:

drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined but=
 not used [-Wunused-function]
 nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
 ^~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  e888d445ac33 ("nvmem: resolve cells from DT at registration time")

--=20
Cheers,
Stephen Rothwell

--Sig_/EluHv0xidCUDsi2vr6bU4ra
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzNoQACgkQAVBC80lX
0GxxgwgAnE7f/0v1TZErS/gDfJZgMGRQql0EvwBXfU1hqKvpzTY8Db/u1j4+O7m4
+wMnshHVkEo8b32YcBI5/G5j1JAUYB7/elUUjNiPAjTzME39gwXak9NQ4RXlcxaN
3xzdvnotydRcMQ0yj24q3U0n3OwmpUmy1HQpOEGKL2IEkZQUuX4UviFPrfiFJndi
fYb7VZ228UUCWDsxoKi2dmPHcr67eR9f+0kx3N6LtF1cVikwE6W1W1kZ2bwoQQbj
i9XhErKLpJrkI4H3I9IhnIlGos4AMj2lrggE2K7P9eyjukKWZrmIhSxt0i12yEjv
ApkqtYOb5to6oOXLcjCI/toQ4uC/Uw==
=GC0t
-----END PGP SIGNATURE-----

--Sig_/EluHv0xidCUDsi2vr6bU4ra--
