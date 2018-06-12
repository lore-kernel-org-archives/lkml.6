Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4E54C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F92208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k4gJ6W8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F92208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934823AbeFLBXO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:23:14 -0400
Received: from ozlabs.org ([203.11.71.1]:54347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932893AbeFLBXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:23:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 414XFV5qxTz9s0W;
        Tue, 12 Jun 2018 11:23:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528766590;
        bh=bKUaGLVOFIgT26wLGUfy6K1gzXTM6ZkphVOUQ9gwaqE=;
        h=Date:From:To:Cc:Subject:From;
        b=k4gJ6W8h8Ir/1p4pvuQhZpLWRLoEAB10MmlLN/uX0v4wYcigjnbC+8403DqrqJrl2
         h5vQzvxPqWswFiVOjG9IMJPOBibQ77J0weN+4KX7/w5bzdpKA6a9pq1XUBxLCLMrdy
         kTL1XHPAg334ZbKwp8FF+JuCE3GpUjCctR43Gqmv26/S0HD0NH+oDoOTimCS/hAqne
         4CRzvi5/ayfPJarIubMQQgCMd2A85ZZYOxzRAoo+o1OaKEDO3pI+OJ1XvPDOTZlLbG
         D78dOQfk9SvGjzWd1OLc2ufarY60BnSNxiOw3gf/5SbpeIVsRKEZedN+e8PTnCZtI0
         wK4Fv/Sl+pMwA==
Date:   Tue, 12 Jun 2018 11:23:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: linux-next: build failure after merge of the drivers-x86 tree
Message-ID: <20180612112310.2d77e1c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/C/Fn3bIaRLIIzwXsLHngfG3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C/Fn3bIaRLIIzwXsLHngfG3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drivers-x86 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/platform/x86/silead_dmi.c:84:21: error: variable 'chuwi_vi10_data' =
has initializer but incomplete type
 static const struct ts_dmi_data chuwi_vi10_data =3D {
                     ^~~~~~~~~~~
drivers/platform/x86/silead_dmi.c:85:3: error: 'const struct ts_dmi_data' h=
as no member named 'acpi_name'
  .acpi_name      =3D "MSSL0002:00",
   ^~~~~~~~~
drivers/platform/x86/silead_dmi.c:85:20: warning: excess elements in struct=
 initializer
  .acpi_name      =3D "MSSL0002:00",
                    ^~~~~~~~~~~~~
drivers/platform/x86/silead_dmi.c:85:20: note: (near initialization for 'ch=
uwi_vi10_data')
drivers/platform/x86/silead_dmi.c:86:3: error: 'const struct ts_dmi_data' h=
as no member named 'properties'
  .properties     =3D chuwi_vi10_props,
   ^~~~~~~~~~
drivers/platform/x86/silead_dmi.c:86:20: warning: excess elements in struct=
 initializer
  .properties     =3D chuwi_vi10_props,
                    ^~~~~~~~~~~~~~~~
drivers/platform/x86/silead_dmi.c:86:20: note: (near initialization for 'ch=
uwi_vi10_data')
drivers/platform/x86/silead_dmi.c:84:33: error: storage size of 'chuwi_vi10=
_data' isn't known
 static const struct ts_dmi_data chuwi_vi10_data =3D {
                                 ^~~~~~~~~~~~~~~

Caused by commit

  2da502a0aea7 ("platform/x86: silead_dmi: Add touchscreen info for the Chu=
wi Vi10 tablet")

I have reverted that commit for today.  More care please.

--=20
Cheers,
Stephen Rothwell

--Sig_/C/Fn3bIaRLIIzwXsLHngfG3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsfIH4ACgkQAVBC80lX
0GwfTAgApD0ZSlIZcTAo6Mw/WEyTBVMSwkxwZemzF7CZmLVIaiYh1fyD0Qy27B3Q
InZTlRu5MXcQQNvavq6VBi0CihGFEgP+8/bCGWM2yXeRYgAwdp7oSMnzmIUh+WcF
LawiheNrljzou++wBPXElX+eYceSz5Zj/lZYoL37r5Hrd1us0XeCV1LjGv7/sRwS
3GKr5klgzy/dgCBzcJ+AJaUfiA5Nrp4D5sh1yHYkAN4/Fd0lqFxuw17mFhpFOiei
bvqen0s8FxIEDCFVsrXAcQasf0ND7i4lH6fIDyKrZfjysmGk2CfZkHtT2f0RDTTK
+93lFAv739WY2A38Kf2KMnUClTrf4w==
=rwvg
-----END PGP SIGNATURE-----

--Sig_/C/Fn3bIaRLIIzwXsLHngfG3--
