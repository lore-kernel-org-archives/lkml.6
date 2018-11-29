Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF59C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EC221104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XWRWx009"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EC221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeK3IHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:07:42 -0500
Received: from ozlabs.org ([203.11.71.1]:36121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbeK3IHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:07:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 435VKr06BJz9s9m;
        Fri, 30 Nov 2018 08:00:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543525255;
        bh=2KoCAbOwNJ0IJCcuSLg9h1jMJsQ5xr4lnHXWQSGPowc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XWRWx009jdb051ons/3fbglPO3nxQWcU1WFFPRdAeaTfyEwm+KKeIMuPHE5i+CcdU
         i5+1Sh4YI064zrWJELjw/8YF5OaVKMFw4Xo5AFOBeIDGsFk4yiWM7scq7gQpGdCbSq
         56iCJr0r+p6fD8lAQIxSbW7BVW1yMdxHgZi8/5QJkKpfxyLMwlK5oxzL4EBFNhuUl1
         csH7rFnc0Y+p6mXPI0e9FurClWl8vaHV09eMW0GGU+Uve2ZqgEMZVMP47sHvR9mznO
         YFnkn0GnQPEzs5CsEDR1qEyCsFEllrBo+ReQ+07a4xHxqm8NsSz+Aje17Q8uKJRLDd
         +D1tgc/l0QDuw==
Date:   Fri, 30 Nov 2018 08:00:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Subject: Re: linux-next: Tree for Nov 29 (drm/i915)
Message-ID: <20181130080042.41d1a926@canb.auug.org.au>
In-Reply-To: <3b893ae0-9787-e0ca-4aad-c71135c41ce1@infradead.org>
References: <20181129161257.4d1b872f@canb.auug.org.au>
        <3b893ae0-9787-e0ca-4aad-c71135c41ce1@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TJS66LrR4lk+lhVP4dLs3+6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TJS66LrR4lk+lhVP4dLs3+6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 29 Nov 2018 09:09:25 -0800 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on i386:
>=20
> 248 "multiple definition of ...".  E.g.:
>=20
>   LD [M]  drivers/gpu/drm/i915/i915.o
> ld: drivers/gpu/drm/i915/i915_irq.o: in function `intel_opregion_resume':
> i915_irq.c:(.text+0x58f0): multiple definition of `intel_opregion_resume'=
; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defined =
here
> ld: drivers/gpu/drm/i915/i915_irq.o: in function `intel_opregion_suspend':
> i915_irq.c:(.text+0x5900): multiple definition of `intel_opregion_suspend=
'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first defined=
 here
> ld: drivers/gpu/drm/i915/i915_memcpy.o: in function `intel_opregion_resum=
e':
> i915_memcpy.c:(.text+0xa0): multiple definition of `intel_opregion_resume=
'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defined=
 here
> ld: drivers/gpu/drm/i915/i915_memcpy.o: in function `intel_opregion_suspe=
nd':
> i915_memcpy.c:(.text+0xb0): multiple definition of `intel_opregion_suspen=
d'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first define=
d here
> ld: drivers/gpu/drm/i915/i915_mm.o: in function `intel_opregion_resume':
> i915_mm.c:(.text+0x30): multiple definition of `intel_opregion_resume'; d=
rivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defined here
> ld: drivers/gpu/drm/i915/i915_mm.o: in function `intel_opregion_suspend':
> i915_mm.c:(.text+0x40): multiple definition of `intel_opregion_suspend'; =
drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first defined he=
re
> ld: drivers/gpu/drm/i915/i915_params.o: in function `intel_opregion_resum=
e':
> i915_params.c:(.text+0x0): multiple definition of `intel_opregion_resume'=
; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defined =
here
> ld: drivers/gpu/drm/i915/i915_params.o: in function `intel_opregion_suspe=
nd':
> i915_params.c:(.text+0x10): multiple definition of `intel_opregion_suspen=
d'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first define=
d here
> ld: drivers/gpu/drm/i915/i915_pci.o: in function `intel_opregion_resume':
> i915_pci.c:(.text+0xb0): multiple definition of `intel_opregion_resume'; =
drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defined he=
re
> ld: drivers/gpu/drm/i915/i915_pci.o: in function `intel_opregion_suspend':
> i915_pci.c:(.text+0xc0): multiple definition of `intel_opregion_suspend';=
 drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first defined h=
ere
> ld: drivers/gpu/drm/i915/i915_suspend.o: in function `intel_opregion_resu=
me':
> i915_suspend.c:(.text+0x110): multiple definition of `intel_opregion_resu=
me'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defin=
ed here
> ld: drivers/gpu/drm/i915/i915_suspend.o: in function `intel_opregion_susp=
end':
> i915_suspend.c:(.text+0x120): multiple definition of `intel_opregion_susp=
end'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first defi=
ned here
> ld: drivers/gpu/drm/i915/i915_sysfs.o: in function `intel_opregion_resume=
':
> i915_sysfs.c:(.text+0x710): multiple definition of `intel_opregion_resume=
'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defined=
 here
> ld: drivers/gpu/drm/i915/i915_sysfs.o: in function `intel_opregion_suspen=
d':
> i915_sysfs.c:(.text+0x720): multiple definition of `intel_opregion_suspen=
d'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first define=
d here
> ld: drivers/gpu/drm/i915/intel_csr.o: in function `intel_opregion_resume':
> intel_csr.c:(.text+0x3c0): multiple definition of `intel_opregion_resume'=
; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defined =
here
> ld: drivers/gpu/drm/i915/intel_csr.o: in function `intel_opregion_suspend=
':
> intel_csr.c:(.text+0x3d0): multiple definition of `intel_opregion_suspend=
'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first defined=
 here
> ld: drivers/gpu/drm/i915/intel_device_info.o: in function `intel_opregion=
_resume':
> intel_device_info.c:(.text+0x14c0): multiple definition of `intel_opregio=
n_resume'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first=
 defined here
> ld: drivers/gpu/drm/i915/intel_device_info.o: in function `intel_opregion=
_suspend':
> intel_device_info.c:(.text+0x14d0): multiple definition of `intel_opregio=
n_suspend'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): firs=
t defined here
> ld: drivers/gpu/drm/i915/intel_pm.o: in function `intel_opregion_resume':
> intel_pm.c:(.text+0xad70): multiple definition of `intel_opregion_resume'=
; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first defined =
here
> ld: drivers/gpu/drm/i915/intel_pm.o: in function `intel_opregion_suspend':
> intel_pm.c:(.text+0xad80): multiple definition of `intel_opregion_suspend=
'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first defined=
 here
> ld: drivers/gpu/drm/i915/intel_runtime_pm.o: in function `intel_opregion_=
resume':
> intel_runtime_pm.c:(.text+0x2cb0): multiple definition of `intel_opregion=
_resume'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d40): first =
defined here
> ld: drivers/gpu/drm/i915/intel_runtime_pm.o: in function `intel_opregion_=
suspend':
> intel_runtime_pm.c:(.text+0x2cc0): multiple definition of `intel_opregion=
_suspend'; drivers/gpu/drm/i915/i915_drv.o:i915_drv.c:(.text+0x2d50): first=
 defined here

Caused by commit

  a950adc6c343 ("drm/i915: Stop calling intel_opregion unregister/register =
in suspend/resume")

which forgot the "static inline" on the stub versions ...

--=20
Cheers,
Stephen Rothwell

--Sig_/TJS66LrR4lk+lhVP4dLs3+6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwAU3oACgkQAVBC80lX
0GwSYwgAjkkv4eH7Qo1GFworz2e3kDt4jrGCWIxmrNyj32oWvvrPgtO8zQQPUFDS
sFn8ujRom68KXvwoc96zcwnQXhNh152xP+Z29c6irs+dq72539JknOH7TXPx/BvX
SsZAt/eF/x5WcrdBlM3A/eEhscZ2qJvWrX7A0ww+DFMnkYxEIdkEQU5uazt+2SRI
Kw5LrDJ+AvzRQIv+Bcd7oejy044nuFM9CO6Uiw7w2qTj6I8+Pww2KbdNMk+2pQJc
+3T73FV42OvnurxJ1hPTXDPVq4nto/fhZP7BRkuC4fOOFZktVsQBueV8YhIq6//W
92HgysiLKUQ8l+9cE+WOTP90AxGCmA==
=iwx2
-----END PGP SIGNATURE-----

--Sig_/TJS66LrR4lk+lhVP4dLs3+6--
