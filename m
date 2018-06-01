Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357371-1527861168-2-15217337451131059023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527861167; b=j8sQ4v8v/WhN5EWk3+sEsKHmfbPN3sawhCpTVnGhOM6xMQITBi
    v20WJMZVwCglOqV9oD76/pfoUv7he10KwdxVWJKyGkQVgCot5x2zh/qvXwguAijq
    vs/9sND5VIh+BhnfuFhYB72ejNUdXLFPrRSJ3nLQlXIqBHb9OsG/nWOMium73bpL
    7hfzLcW1GokDQYkb73hlWNf+CBMya+e658WQxgdaqCGPjh4XYm3Gwo9WkeLSaqZ2
    XmRo909pLO3sTGHwQZmhXb98MZQQpa96z7nE+PC3XlL/+Bjrx8bgyFLMsniWVmTa
    /YAKH+DUXatA8cM07idcugDEKED+3RHBk7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527861167; bh=12+ZJ8ZSrY/k+a/Z3ZiG4ot7acJr4C
    7MCMBKCECjD+c=; b=QIoZqhtk+ByLnCd6xVe2CMDbhKLyVB2ArMdgxW+7eG3cF2
    isofZ+GpL/Vgh33ZoMThwtKDPUYu3hPffl46ip4QcS6uOSm5IAGIP/J5fNh3DlQX
    6O8t9nAHZRmJheMGsj6V9B6dMPJ8i2P42jtH+vya0vNU5D/YYBksvsudpVIQPbVb
    qeiTxfZV82+S5fFFE36n+c0kfpwFTfaQcdhEaXCm8muaquPBkRJDYiMLXK7ZeXxI
    rLrxgp+X1fJMrmY8A/lQ0Y2ivWv+Ep8QyiiqGYPhBtOV04nM4AASum910E2ptmNg
    4RY8HgoxbRcw0iS4uv3C6bLDwmCAABBCIFL1bPMg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9/E2KQJJNpOG/ik7ETV3Xci1fPID4qkAyJULhnclJzpGMSDB0ZBUwgOuMdqemx+yiaYWxI8qfs8+STa5kINPS3zQcvIqBiBXVVR4tW2rldceenOq5G
    128oGYICgOGutDU0Becs3x6ZuqTgVimMoiEA0oCNCNNfh6jc1CsGrBC2L1xU2MMxNvtReH7oWo4u1Mv2L25FO2TcUmUx5K6cWkc9p1Kt/tFRxSXX4xihzn0O
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=20KFwNOVAAAA:8
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=ZJwts9N_Q28zMSImHN8A:9 a=CjuIK1q_8ugA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=p6UsT3DMpU8pOh2WpmAA:9 a=ONNS8QRKHyMA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeFANwe (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 09:52:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751342AbeFANwd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:52:33 -0400
Date: Fri, 1 Jun 2018 14:52:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix NULL dereference when new_inode() fails
Message-ID: <20180601135231.GA26872@stefanha-x1.localdomain>
References: <20180524202004.7813-1-stefanha@redhat.com>
 <20180601092441.GA8687@stefanha-x1.localdomain>
 <CAJfpegsWRY6be5vwtJycAc+GUvveEcdm7Zwvvx0upSA-dwCa9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <CAJfpegsWRY6be5vwtJycAc+GUvveEcdm7Zwvvx0upSA-dwCa9g@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 11:28:31AM +0200, Miklos Szeredi wrote:
> On Fri, Jun 1, 2018 at 11:24 AM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> > Ping?
> >
> > Archive link in case I broke email threading:
> > https://marc.info/?l=3Dlinux-fsdevel&m=3D152719324102009&w=3D2
>=20
> Thanks for the patch.  Should already be fixed in:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next

Great, thanks!

Stefan

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbEU+fAAoJEJykq7OBq3PIHosH/2DOTHAo84kEfPRgRbsyJ1R7
RKcXSni3/Lt6/f/Z1RxYG5RcKZ/T7Te9entrWsKbi4K44Gn9al2UZJ2dsY8/yd7Y
HrB+DEfHdVpJ0eSHMYOGfue1gLe1uDXCzGIXs5oeE/6UDZT0Eed/V4zzkKOu0iF7
0qc+qjg9vuyA9gEqQnI9WK0zhiOtiUp9ozjUa3EJVuIJ0Q2Po/W9ERKh5eng8g79
PMhzHJy+E+RldV4wx+3L9ldKOsZfeS4zn1GxVwHw+KO//HcyWrtBajNNOElri7gT
DsKBcL/8g+6qtApd+kvkAzRRuNYGOBIp1axAn46HFMFNuY4YXZpPcvqh5A9V6WU=
=8DHZ
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
