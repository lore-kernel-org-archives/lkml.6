Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FC0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F9320870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HcSjViDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F9320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbeKTMnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:43:08 -0500
Received: from ozlabs.org ([203.11.71.1]:46621 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbeKTMnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:43:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42zTpT5t9Cz9s55;
        Tue, 20 Nov 2018 13:16:17 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542680183;
        bh=yT3KkXzoFUtpHu3KndyIk1aeZYPLOeJn0rQb+Ya+Xh4=;
        h=Date:From:To:Cc:Subject:From;
        b=HcSjViDBrey1fKn7dCUBSFpdeKckm8LXa6yfoXvZ/xHhzfJivk9PdpxBpEAfF80Hk
         +81mCD72nMenH+4JQojX54GWumZKrikj1lBSi2iTK+nSNdTaedOiGmvB4G0Ql6HWUw
         DuCt1/mt29ZidPoXJD0iNPGrHbmryKBgD3MXlFqP6Yv2ebYSvk4FVW4Uytl3jPWgtC
         znrt6AMnmGMowJGMh2GKq8i3KUj0mLsMuz9423upLHaFDYZ2jtTON/WYPrEu2hvt6e
         X4NW1taaIbTUSbMEAY8G8OZN6a9RzQ57BNC9VCfJPD1nEHY4rTgBPTeBamcLMTYuyQ
         /xShaA3hxWLIQ==
Date:   Tue, 20 Nov 2018 13:16:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: linux-next: manual merge of the staging tree with the drm tree
Message-ID: <20181120131616.139a4c8f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cUx2DcwcpopJLZu4G_xYM5N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cUx2DcwcpopJLZu4G_xYM5N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/vboxvideo/vbox_ttm.c

between commits:

  a64f784bb14a ("drm/ttm: initialize globals during device init (v2)")

from the drm tree and commit:

  cd76c287a52f ("staging: vboxvideo: Cleanup the comments")

from the staging tree.

I fixed it up (the former removed the comments updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/cUx2DcwcpopJLZu4G_xYM5N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvzbnEACgkQAVBC80lX
0GyQNwf8DSZqSLWBzYeMudeN+V8gF6KOEZwIEidERw7FD7NsN7qpG7VDaSxfhqkq
rn8totQREaQP20i3Zh620QA18E02yW1dfB8GJuWq7a77Ak5TtqXpwB0vaAulaGE1
xV7FjznddD+NNOsdtd1tLEzR1NUp6hvFaoJvBZZ9PqswfWQNf8jmA/f9tBEZafl/
JzMuIA7Kb1baFqwHV/Vi7nihvX1NhC4B52VLoUom2oNW9Y9ciNiLMBCEzBRkuGBM
rMacShb0sBGM4NHMy29a44p1U3UfMm66G4ADH34T8UQGP7qO5GKWyZPlzWsrbA4y
wNj8MKYJYhWIT/KB6PCwx3ziPs7o9g==
=SeVy
-----END PGP SIGNATURE-----

--Sig_/cUx2DcwcpopJLZu4G_xYM5N--
