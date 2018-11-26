Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F0A20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F+Ej0qWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F0A20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeKZQwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:52:07 -0500
Received: from ozlabs.org ([203.11.71.1]:46825 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeKZQwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:52:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 433GSm1FX3z9s5c;
        Mon, 26 Nov 2018 16:59:04 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543211944;
        bh=1+YqDkqytSzb4aIojLZWrcIK4GIRlXWXH3Ek9Ys4Ru8=;
        h=Date:From:To:Cc:Subject:From;
        b=F+Ej0qWXDXDhGK0Xt+Bnw6sGIW7N9AEQPg5rz+/o7CE9pZaMHzcANRg11TaWMabgb
         jVgPa96YRqdWbQ5RFZd5O4AqRSctge+K92WAzYzHmANi43ghd7rANofqZols6PeI6t
         lwvGKoQ2fgB0iivtUwaLKxh5vzuSyPAizDC+HGlMTK3KbHhfQo0YgK82f3Yh4vW4Sm
         an6N9oGtEm+GwH7buOmDl753Uf2ENy1hh4t2RgTS38McimWX7XfL9RnskHoUitVUDN
         P+4dZP9CeJHlg/RWfI/xfDTViT+gj7RoSI4LG98M49fQLbT6OCDLb7omy9Vudz+Wsv
         pd0C3j/yo4M2w==
Date:   Mon, 26 Nov 2018 16:59:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20181126165903.33b1d872@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ksmqb21AMh4WREzYD+BsDzZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ksmqb21AMh4WREzYD+BsDzZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

After merging the slave-dma tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/dma/coh901318.c: In function 'coh901318_config':
drivers/dma/coh901318.c:1805:16: warning: unused variable 'flags' [-Wunused=
-variable]
  unsigned long flags;
                ^~~~~

Introduced by commit

  627469e4445b ("dmaengine: coh901318: Fix a double-lock bug")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ksmqb21AMh4WREzYD+BsDzZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7i6cACgkQAVBC80lX
0Gw0tQf8Csjahcy+/StWF7NgyoZVKwUbq0BQDqz4+Hqa16/eJU8E/1N6EyqiFeWt
jzmZskqG75+4uhAWlB3WGmKYr+1XT06VxXPtYo2ryvcjgFR2IE9YWJmn2WR6Wxvy
I9muX7t7gaYX3IzuWFGdb94GA7B54xo2I9tX3lYGmZ6d/GaUF3rIiIo9yFzHIzFq
yHWsAfcp0fZcQJI2n5Y6Uh+/m+bJwUxMiqTZi73Pqb4aESiYWbJTJV/RRdzMsjKO
SjJvofKxNoozsbbaU01HOcKxm/joXP2Ah6INhjD+sgY7fqFwbRunqSgAaV2+AeGg
cWINGha+Rk20N3e7BQX80067MJ5N3g==
=aFRh
-----END PGP SIGNATURE-----

--Sig_/Ksmqb21AMh4WREzYD+BsDzZ--
