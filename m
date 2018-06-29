Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606F1C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA1827AC6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ra151Jz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA1827AC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755133AbeF2BHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 21:07:51 -0400
Received: from ozlabs.org ([203.11.71.1]:42407 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeF2BHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 21:07:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Gz5s2VhQz9ryk;
        Fri, 29 Jun 2018 11:07:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530234468;
        bh=pmi65KlAcGs37QjfIrBnTPqHxtA1+VKYUYjfeKnZhyM=;
        h=Date:From:To:Cc:Subject:From;
        b=Ra151Jz2RNFLLJXJb6ysSrLVlKQjGcTu0NntcpVNCpDo4j/t+lmYTLCF7OPfPD1ZE
         RVqiVg0Z6u3Le/fxLaLGqOJSR1s0o3+aQ9I7JhVu1e9ehTnKtl4tlIfzu/UOnnP3Su
         bYRt1JFxmcDAZsggU5f4ax4r2QgMjrMxfGiAVQ0M4yt7L8WQ0o6IYCPPWAi/luNfED
         xj02l7vZunpiXwO2catGB3OlX3cd08xsJnlTJbQuTJmrd3WZ8389CyARV/I7UUqA5n
         fnmzOaUThsQS9Nz1iv122kZ7cGun/jOJr4h62ut0ULxV7K45sSUvLIn3XFw5eBRdwy
         LDwzpnP+JKBcg==
Date:   Fri, 29 Jun 2018 11:07:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: linux-next: build failure after merge of the fbdev tree
Message-ID: <20180629110744.29b54355@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FzGKjTKmCinIQZX16HKmEJ."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FzGKjTKmCinIQZX16HKmEJ.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bartlomiej,

After merging the fbdev tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "dummycon_unregister_output_notifier" [drivers/video/fbdev/core/fb.k=
o] undefined!
ERROR: "dummycon_register_output_notifier" [drivers/video/fbdev/core/fb.ko]=
 undefined!

Caused by commit

  83d83bebf401 ("console/fbcon: Add support for deferred console takeover")

I have reverted that commit for today.

I note that this commit is in the drm-misc tree as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/FzGKjTKmCinIQZX16HKmEJ.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls1hmAACgkQAVBC80lX
0GyypQgAhNAhIQAYmTGEs5+Y0H5vz92mBk4+b4wnXWPFCV5oyDw1SVxC9ampJ5br
WjFViE7jAmVP86DQ05J4vX88tZHTQEAXMOwJOKwFFTZxQ5+dxOihuy8jd62YiU5W
OWayRsQJVovr4fGByVf6Chas9zrB6lL5yQphE57IO8DEReg22YE5vH4d7vwB/q9x
4tq7mAR8wQR+5gjPJNlOYWWZN6kObAIWHTxH7jEz/Oe+KM8ARLiyK0QYw8Do1ZqH
2woQdmJfFzT9gR1xBH3nD42l5HelE4vt37/kvI+bp1rBkCnTGVUSTJeQ5Bct2Pib
3z67UldMvPG6N0dclvu3/+mJUVnv+g==
=mzU9
-----END PGP SIGNATURE-----

--Sig_/FzGKjTKmCinIQZX16HKmEJ.--
