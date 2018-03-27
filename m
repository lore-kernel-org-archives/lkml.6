Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-628284-1522189855-5-11797331355764111131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522189855; b=WGNBmze0lap47+Zyf6Hni5Fw1hwKhQit9PiYnbns8YwMLfv
    1RWCOq3venyaB/TI7stXAjBQ0wKdSclSrldnJxI8zEkCGbGLimNd5SfFcliqTIvs
    1u0uN0z448WF1QPJK0AdeUVXnRbOCNR0JHO5eMHaDUtvuxX3dS8qeSOSfbMKbdGj
    s/MwIX8jZ1VSI20IftEppoJe42PHN87Ev0h2s16DWztzkycZYb5PDBhXnaBmZ7Ol
    96GPBSCvBuEkR67wWcGQVLfkrFo75N9vh7lZA8j9ifcTPptAw8xYW1oVq3ko94Rv
    0flQ/vCM2Ku5lbAcn6htl1fhsGTDsMtK8HBDGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522189855; bh=um9IJ1XwjSa00WYxeutp5M2rcy
    ZLLzudR/zH2ibv3DY=; b=E60tpcV5JTLrpaZjGwKx1s3BC27La/ebtbBekcvGbX
    QHC1QKYI2yQVPACsqa+0Z09CNTwiEiCZOGlTqMeCrqH3v2uVkk39L7znGBe0ZEDo
    ZHkb5DtKab/utt+JxR1WIsm5F5HqVE2xDyw+l60X1+MQMtsLpI7Rzj8UPFjmfkzX
    5M4Vne4rb3hU3QzCG8vuYnc4zj5n9cbP64hTaC7USSlAzbALKFjXAwEcon36Ej7A
    oYQO2SYeWnt3T+EtN3x7HWLGz856pwHbu0cEeldmJVZc+deCPYSBj1qmkOIfLgRU
    T0XQxpVOElyzBnhMZcF/UZtLJJWDbmPmVZmhhPI73cZQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=j6Z/Mbks x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fc01TBS4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=j6Z/Mbks x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fc01TBS4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPvqWg82USvZugaw66gBdbguYY8rphm6Z45P6Qxx1W+/aAlfaSM5hiCSafD+1nWXz5iiWkp1lTCUD6dIdlyEh2EbhUJxclNEB8aNRjRpk4MyP/JKx5k4
    wFcKi1SqNq0cbiQRTVdrgmfrtEkKSCIizjZka80D1jmB83sV23LBqC7LkpO3AXHHWz1c/dhh6wMxwIqGwdjJj/AbC4ckkUgJs3JAWYeHhlLps/048Xt1+mAd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=I5jJpb0z_YgA:10
    a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10 a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8
    a=pGLkceISAAAA:8 a=Vxy2kpnnAAAA:8 a=12I7oOb-dBDRiuUTjJYA:9
    a=VFdix2E-JBYpglsc:21 a=_Cwm6sjscLJnVtKm:21 a=CjuIK1q_8ugA:10
    a=FC8YuEvSxKtzKqFrSQQA:9 a=ONNS8QRKHyMA:10 a=6heAxKwa5pAsJatQ0mat:22
    a=AjGcO6oz07-iQ99wixmX:22 a=mQL3ssppXrSh16SuiSjD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeC0Waw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 18:30:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52050 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbeC0Wav (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 18:30:51 -0400
X-Google-Smtp-Source: AIpwx48kDYFpXOWRAhC6BzQ4Zzlk7FoLA/rWWLBMjl7hK7850qbxGTz64spPvr7aIiF0wqnlvdBM1A==
Date: Wed, 28 Mar 2018 00:30:48 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zhi Mao <zhi.mao@mediatek.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on
 MT7623
Message-ID: <20180327223047.GG28163@mithrandir>
References: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
 <20180302105719.GC27178@ulmo>
 <1520030090.8089.186.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <1520030090.8089.186.camel@mtkswgap22>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 03, 2018 at 06:34:50AM +0800, Sean Wang wrote:
> On Fri, 2018-03-02 at 11:57 +0100, Thierry Reding wrote:
> > On Thu, Mar 01, 2018 at 04:19:12PM +0800, sean.wang@mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>
> > >=20
> > > Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> > > control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> > > programming on PWM hardware causes waveform cannot be output as expec=
ted.
> > > Thus, the patch adds the extra condition for fixing up the weird case=
 to
> > > let PWM4 or PWM5 able to work on MT7623.
> > >=20
> > > v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
> > > v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Zhi Mao <zhi.mao@mediatek.com>
> > > Cc: John Crispin <john@phrozen.org>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
> > >  1 file changed, 21 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6xhcACgkQ3SOs138+
s6GemRAAven23G0YiLEVbk8S+JKm4WpzNzax/Nsk3xja50+dVlf3+VoeRa/PCW/e
QguUdC8q9QyujEC/XzNJaaqxIa5T43kOcTePVuwrEHq54+2IFoNSDWi+OuUsCZyu
ujjK0B3w1Q67ExSqUw9EbeF6dnJf4EZSZCo9iej4TCY8I/bMTcwOaope6itRyKn0
Y6dp6v5Bpx4Frf4QEH9QObiCJmwsdCgKTNsoLdowqWYrXic3jXA9V1GQPBGXSCCJ
s8k8bH8vBiGR8FVqPU+DE6NYMb/FjvAxHXMNaFSPhGyMyZpTcPloA0Aq9JTLWfhW
0V7WrWI9oA0yomKC3nuNCOBFtByniUlrRIGncWLFrmU6vo/H4Th87TQzeDUc7ue3
9pHcvWfW3Py9LgR0xDffTw1FNbeAAiVsedahQf2WfLR1ecR5ys4RjrHOoH7Ajjw0
BnNPLxJN4jYyadlG+qtRTxnlExWEfVMyGvbmhaBtnpgqBTsrWL2T94QYWFKWc3AA
9JOa4iBQ18D+IWWJM06et+ftMkWzkENL5mIPiQ1RomCIiAOFL6+EhYHx9t8kD+0o
UR+LPVdYwmh+Yfj8uMNvghflJi4iIAijZ+0sA3M8SnhLyAmDPXWarissJ3Ei+5aG
++a6F7qDY1K9XSwTQICbWhS2DYsxx+DBvVGIcjy6O9xx3rLc+0U=
=aYXi
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
