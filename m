Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3139683-1528082457-2-12583945107714842466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528082457; b=cANrEdzXEtbJXfm566qE2q2NQtCLgFynVoWKyIofpjxSDYtsLa
    qCwxHGa47K33OymHDklJA24wgAGqwcTkTsXMx99htEgzjK62qsxZPaVn6XIyPNsU
    ydfShDDaPt1fytA0AuE4IPnyXt0izfb1NpG5laCMsy9/FEL0DJT9c8USfxGfLYvY
    DcsiEiKVlwnWC9gyCeru95VyZL22uXrIncBTYSOE+uJ5DD6wymE6hfHr7V+01uMR
    W5Q4wJMOJnv7+rD3YINPtfkx/WfCPC9q8Nj6vIuuLU5tq254C54v4OC5skAdCSzi
    UID4l62tPC/1+Iyr4CuIxtxQNvK41hNlalYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528082457;
    bh=mT0B7gjsZpthLoHLeyNRS5cJAJZodzu7puSeOLEIVys=; b=SlIu4oVzRpJ1
    Nt4cljGYaWvV3yASNh2J+AQEyYq/ixeoOlGrgBfPVbj33AxMIaju57obdkURClAu
    1MEUUg4RvgbQrjwBiH+RC6ep3Vu23C+/uXEzAvh98TCpQry+XL4L2VkDIBJ46CK1
    yX2ZGKsRrKqHR4Ku6R6jkI5QWpl52aZIPb/zPHqAqQXMCqcE2BkeztgwVUFHy7ed
    WbOiVAhDGHrmaUa2dOv5VjfmBznKKKLNfNb0InHy58/WAZhSbIhQWR2auP4x1Kik
    hBROFhHOcNqhJhCYkFSVwo5HUMYj2NZNG4qTbe8MiDRapjkEEAPHniBvuYpOPyk5
    HobgPVTAyQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EwaII3Wa
    header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canb.auug.org.au header.result=pass
    header_org.domain=auug.org.au header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EwaII3Wa
      header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canb.auug.org.au header.result=pass
      header_org.domain=auug.org.au header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCvo/cU68Tu0lQrBbsiJKhPk1TYqLI1rEMw6V6EHWXoGY1iALuxcHsagaA4D6fa+VhxrqJvtIuQ88bu/moWaGb0nu0zJh137cNznpAvTBQ0BCmwBaRGi
    7wjjTxKdqGCBSdxajr9oiyHIPvNpYqXgeoTraNCn+h6k9iThRAxt8OjLqzSNb7nChrGzj6j43Csjesg8QS+mp754AbqFwpSW73BH1lppGy6iDi3J4wXeWI7a
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=Jk-UD360Ie56WAJnNqYA:9
    a=CjuIK1q_8ugA:10 a=Jh360gsMpRqMmxZRAMYA:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeFDDUy (ORCPT <rfc822;linux@kroah.com>);
        Sun, 3 Jun 2018 23:20:54 -0400
Received: from ozlabs.org ([203.11.71.1]:46547 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbeFDDUx (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Sun, 3 Jun 2018 23:20:53 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 4 Jun 2018 13:20:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Clark <robdclark@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: linux-next: build failure after merge of the drm-msm tree
Message-ID: <20180604132049.117952be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wUgPFeLpZT0Y/Cu=kxnCwQY"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/wUgPFeLpZT0Y/Cu=kxnCwQY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

After merging the drm-msm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/gpu/drm/msm/adreno/a5xx_gpu.o: In function `a5xx_gpu_busy':
a5xx_gpu.c:(.text+0xcc): undefined reference to `__aeabi_uldivmod'

Caused by commit

  dd4ff3063899 ("drm/msm: re-factor devfreq code")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/wUgPFeLpZT0Y/Cu=kxnCwQY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsUsBEACgkQAVBC80lX
0GwwyAf9FIRSiZXmpBSwLztMljQDFRBNWMtC6yuEJ3jNvsCg+JuoMRHutoEvil/1
YLM7DndxEwZXnE1bwh76AlIWmEWQS5NyeEGuxHwU5GQPXPcv78yDbYpiiVhKB+T8
4HiEv25ygJp3H6zLBx3ynWbjh4WXhceLm2Y4kJsSsg8QzZEC/182Qhgnkg6C4ZVG
qq6aTx60c7phlxcxs+Pisuvyz+Qye9hTxdnlicYFOebB7jMCi/UtsBifuGslVb0b
IufAe0aErv+by1hOQvdMiERYHaqJTLOddK+aT5UjRF+u6bYZK10KJxaG7U5EJN1W
ZSYCirzVRm6hxpFGPKjykAdoXoIK4w==
=G44I
-----END PGP SIGNATURE-----

--Sig_/wUgPFeLpZT0Y/Cu=kxnCwQY--
