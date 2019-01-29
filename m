Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5F6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D9020844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PS/a9mpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfA2WjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:39:18 -0500
Received: from ozlabs.org ([203.11.71.1]:55189 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfA2WjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:39:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43q1dG4Mfcz9sBQ;
        Wed, 30 Jan 2019 09:39:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548801555;
        bh=BniT2tdG7AuK7acRWs7MwFWxF5oAs876VP5bHF1N7E8=;
        h=Date:From:To:Cc:Subject:From;
        b=PS/a9mpMYL6eR1wywmTKXg5uJZY7erbhVcV4mQ/AOoPazYmnqarNcMcjh6PkJHeIk
         1iJWH9O0f6lkDY5YBerMiMe4uVRcT2yd2eBJ1Cxo7P2smAlpwUue7drvc6ZdM4EOAn
         OG9PoifuwkRv+knQzrN6NDMTZu0huoaxN7YteoxXcIAkgOE7KUUayV3kzWHSfRxTnI
         dxgHwYumDocWYnDRCfEcJLg0yfLzfYh3wXSTG7aELuaN2cHgWFxpPm0TIoD6k1h/rS
         +y3wlrnYwb9tdr8ME122z4DF+NGeLGcWtcjngbEVThKFqPyMqGUSSXVmjEUrdUixm2
         3J+Ff5xOxnPNQ==
Date:   Wed, 30 Jan 2019 09:39:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Mika Kahola <mika.kahola@intel.com>
Subject: linux-next: build failure after merge of the drm-intel-fixes tree
Message-ID: <20190130093830.728e9d06@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//EuLT0clbUsC3uFs9.Gmalb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//EuLT0clbUsC3uFs9.Gmalb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel-fixes tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/i915/intel_display.c: In function 'has_bogus_dpll_config':
drivers/gpu/drm/i915/intel_display.c:15432:27: error: macro "IS_GEN" requir=
es 3 arguments, but only 2 given
  return IS_GEN(dev_priv, 6) &&
                           ^

Caused by commit

  a49a17226feb ("drm/i915: Try to sanitize bogus DPLL state left over by br=
oken SNB BIOSen")

It seems this was cherry-picked incorrectly :-(

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//EuLT0clbUsC3uFs9.Gmalb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxQ1gwACgkQAVBC80lX
0GytTgf9GZWitM+DC3u9Y/fcXzYCvMqy13W0wUhocGeY9qpeJ2fFyqgcKbQ42Kd+
w8avgWv61j/aLdO6kBqQBK2D46gbWf3om2BQ0vWNHJ0aVzj22lqJr9pNP84P+mvX
to8m8R2jU4gpoHq9wNByNhZDB+mCuzA/B0QLZo4o/arr43kStqeZ+nfNvoRcjjrT
VNGWYRmmg4N1ofrdvoioHiNBWCVFNPljP245eUUtKgMibg1fH/5UwZjpuYQP/ctf
jgdZ93M1F/qTRE/j2iTAQU7GMn4fRPTh/m/fTNh81hLKchbj8ra87D6mLcakIpf6
XniPMDJrzGbxBXf0x1rbYaI/54Ly/A==
=MmjD
-----END PGP SIGNATURE-----

--Sig_//EuLT0clbUsC3uFs9.Gmalb--
