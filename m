Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-628284-1522190003-2-14727644668691670928
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
    t=1522190002; b=iTgh2vN2oM/L040oaoHVZrvqP3gUrA/ZkdDGXns4LptewnR
    VifbFwoLRdV/GqPm4Rco6nOZOJgDWEWA+LYw0TAWWLQqyEFqt3a6ajD+/TDXRjsT
    2MW3eHbqjlHuP6qodhGwQFJA58I21VcXNrr2jnGAbkImT9eaa9LPnLHM0JsBKDdZ
    MW2m06MjGazf66h1Fbj4GNyryVTKu+RWS1rx66ge+d3aqOnmMj++P/aZxI2KEpLZ
    tboHiAI5BfvVWVtPbNqH3X6qh1fGX/OHpn2JH3iNLzPNfVd+rLQj1Pw+y6mPVAbQ
    WYdxNvmxQ8Ub6JAYX8wv/N3ZBPwS/4EzdsZ9niA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522190002; bh=IUO05CDcUVfzZvVPsSCNgBLsGe
    Z5b7xwa12RE9dnno8=; b=PiJwD0GzIRwri8zG52HyN2qNl23I+G4vMLVpOR0y9K
    eMQSrRYRr5qTZ51gKngsf5XtTdwKr9SjMlMP7kDqXlHpxU7fxT5rNYs3GzVVb13s
    VF5dFJOVz4pAMm9MCEZ86/UjOo7/I0TE5ixYjD0BQSd8duaSA8vU0jr+uhfyZX53
    JY1rKeJDqSiRIEAKOWIk1oV6Jk4tAkpjgYqUm/2+4Px6ogzLUhrwqL31GI7IZsNi
    Kn6+NyUbtbNuUnEWErmB1B/4E22R1ZAakMOVwD/JSaTtJ+AJ/Ld5S7cJiTPapwF4
    NDWy1PI0MzENY6FOh0wAy8ibL4kx4Lsc70sJM3QTDVEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ay3AYhj9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JLNnGlta;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ay3AYhj9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JLNnGlta;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDV3aMRm3vJpM5EFYvSr7MUjRvQ/ECmk8yUTUASOtuExbAICNl9p0/qX1kYtCJQu2FdbNeeeZN1lX9d44PL2EylsUlv1CRwGhr6lsntT6RRit0X84lRP
    OZ1zFXmTfC12IQryEZK4lNsrwIlYsMO+54TR9dfW/wR7QpoGDj3pKlApok3Mu/zerFT+KzZZ0rclLuo9Km32uC/3yazJnAw+BrzMDuzRNfMz16U96wfRmo1g
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=I5jJpb0z_YgA:10
    a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10 a=mpaa-ttXAAAA:8 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=K5FuqnCOEb49mLD4sfUA:9 a=AELozh5JGdfiRjgV:21
    a=wBAtAoaiaq0SkGrT:21 a=CjuIK1q_8ugA:10 a=fHSMZwuQgDQA:10
    a=MDZPUUTaiW4ZE0QFHiEA:9 a=ONNS8QRKHyMA:10 a=6heAxKwa5pAsJatQ0mat:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeC0WdT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 18:33:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37350 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeC0WdS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 18:33:18 -0400
X-Google-Smtp-Source: AIpwx48rk/53DLADz1UAbEqVmh0NapnswMxh+EpMWqriXc2RnT3Dzvse+3s+k8FczKOMV2u4yUr52A==
Date: Wed, 28 Mar 2018 00:33:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] pwm: mediatek: improve precision in rate calculation
Message-ID: <20180327223314.GH28163@mithrandir>
References: <72b74a30ced1c7e7549dcbb56d6123fc27fac405.1519980119.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
In-Reply-To: <72b74a30ced1c7e7549dcbb56d6123fc27fac405.1519980119.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 04:49:14PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add a way that turning resolution from in nanosecond into in picosecond
> to improve noticeably almost 4.5% precision.
>=20
> It's necessary to hold the new resolution with type u64 and thus related
> operations on u64 are applied instead in those rate calculations.
>=20
> And the patch has a dependency on [1].
>=20
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2018-March/012225=
=2Ehtml
>=20
> Cc: stable@vger.kernel.org
> Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6xqoACgkQ3SOs138+
s6GCRRAArW5dSAE+wDWE+7hBfS66wYIK87ZXIPUO69YVGLG5H1GaJ/OGo1JepDJU
ibVXdNZiAcJLiBWBYVuL/8YycVFUCMXZTj5IWaooczKWOj+p2vNIPorzYAkMPgZ8
qLtJxi5fEGO5DqQlAGKBPMhlIIgG/PB1WPxNiaVzngJD81ioAY1H8gTC5+Yxwigp
67wIBtxSHML3lqzpUHBitaIFNHmDQWng3eP8LU5rUqGYYsS3bq08JUQw3uA6/U50
utBcXrzgPQdREhs2j6hyJMDPrdID9DZtcsfm4Z9VIN7cfBtqlNqA9bcrTKHIq6OF
QO8BzGonimfsZk4JqBeVDdCnR3j442SYlrF4Iccat+fqHxGrNKtE8bvaPZqxCQeG
uy3hx14uKOjUkR8vYbC0Oov+cN0WtSkI1VtUxwei/LBDwPWjznLl6W7Nv+NW41k+
funPi3FjiEWC/54dQd0+0iIQZSB+spb06WTKeN3PzO7Qa0Sit3ybJthCSbLKXK+/
A5JCNMlVKRelW0EFQ6eoZyUVeHKWyBGt827ZEDEfPjon5OYbe30zd/1E8owtjSje
nSSJMmLSdinM2npCCmIlCMpYTVZ1tbL2VJ9ZdO7AuVDDHkRiR/3kq1VkphKrwqxi
e4tzFc29xff40FkvhQkU5px1TsRYwv4bQbVTwuAWLH3uy+1k8qY=
=Bg+w
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
