Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1601DC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EA621907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uLc+uukL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBHBiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:38:20 -0500
Received: from ozlabs.org ([203.11.71.1]:47239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbfBHBiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:38:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wd9j0d0pz9s4V;
        Fri,  8 Feb 2019 12:38:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549589897;
        bh=HaBYHsjlnx3+U3oeeXH6+eUJpCSkFW5V3+IoP+E0tAg=;
        h=Date:From:To:Cc:Subject:From;
        b=uLc+uukL8gEBddA2kxaT4uudA/YuhzOvPazHCvTeZtbOxRPRTX9ownkv8nt0ksr3f
         WFsL6JRWprYZe1V9x0ALUREjphXnfIVXDY5QZqgCeqWiYbLNmqwrNkDx18eGxesHxU
         r/8huJFj7eBoh23XgcArbyDXm3qhTCapAbC0uqIm1O5sPcdKeWPNOb5hdz55Avnpj/
         HgdMA23ZCTxfoMnPSIG30MwbznhVcgGXHhEPOUGfhSmQ9z5xjUtPhH0TGOG2joAAKp
         0WIpc7q4YWnZ+Gy6rE0ja8BwKRcgDL1YfNJwpz4NU3xU9QrjDSKkcqDRchWKZYdS8W
         yRPLrE4SC9ZDg==
Date:   Fri, 8 Feb 2019 12:38:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190208123815.64757bc5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s41kT1wJ9KiC_S1fzk_H/T9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s41kT1wJ9KiC_S1fzk_H/T9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from drivers/gpu/drm/arm/display/komeda/komeda_drv.c:13:
drivers/gpu/drm/arm/display/komeda/komeda_kms.h:87:20: error: field 'base' =
has incomplete type
  struct drm_device base;
                    ^~~~
drivers/gpu/drm/arm/display/komeda/komeda_dev.c: In function 'komeda_parse_=
pipe_dt':
drivers/gpu/drm/arm/display/komeda/komeda_dev.c:27:3: error: implicit decla=
ration of function 'DRM_ERROR'; did you mean 'DRM_IOR'? [-Werror=3Dimplicit=
-function-declaration]
   DRM_ERROR("get aclk for pipeline %d failed!\n", pipe_id);
   ^~~~~~~~~
   DRM_IOR
drivers/gpu/drm/arm/display/komeda/komeda_dev.c: In function 'komeda_dev_cr=
eate':
drivers/gpu/drm/arm/display/komeda/komeda_dev.c:127:2: error: implicit decl=
aration of function 'DRM_INFO'; did you mean 'DRM_IO'? [-Werror=3Dimplicit-=
function-declaration]
  DRM_INFO("Found ARM Mali-D%x version r%dp%d\n",
  ^~~~~~~~
  DRM_IO
drivers/gpu/drm/arm/display/komeda/komeda_dev.c: In function 'komeda_dev_de=
stroy':
drivers/gpu/drm/arm/display/komeda/komeda_dev.c:170:3: error: implicit decl=
aration of function 'devm_iounmap'; did you mean 'pci_iounmap'? [-Werror=3D=
implicit-function-declaration]
   devm_iounmap(dev, mdev->reg_base);
   ^~~~~~~~~~~~
   pci_iounmap

and lots more ...

Probably caused by commit

  e3b01f0d576a ("drm: remove drmP.h from drm_modeset_helper.h")

I have used the drm-misc tree from next-20190207 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/s41kT1wJ9KiC_S1fzk_H/T9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxc3YcACgkQAVBC80lX
0GwvPQf/e7ynhE4kY26XTf2XYCZR6ASXbbQb4Zmu5M+5/3q/wXB7sjheG0B7jCmf
LpLw3V+8bSAQ4Sx3+Qpdivt3LVfSupVLJH+36EB4twobks/Oj3K88HhbHHJoqFiK
fu10/NKZXJj46BO3/dHpEDFC8mPT0J0FnF60sAD2tgjZaO46h4l7jnekrEzWka37
rVTrAj+Fm6OTJQuTE9xpKU6wmzMmi4Y7RL9qgpYemphk6GpDSZPz6kttzSWLp++w
mczWlug1Yt+iaX7cODTtP/WNNDq9vGG1+ax/yihR1NoPQpvSLyKud6Nn1t0VmRix
C+71fRY8UudG1wETkmeihM3lDMsycQ==
=N8EN
-----END PGP SIGNATURE-----

--Sig_/s41kT1wJ9KiC_S1fzk_H/T9--
