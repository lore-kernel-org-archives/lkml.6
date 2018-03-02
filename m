Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330670-1519986985-2-2204409420552206288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519986984; b=K9dmBL8zH4xMTGQwXFXZbfTpq77pKbA9AciO7JbYyeMD0Wj
    7Ti8Ii2JjCJUo/aM8FCMwL/WSLHEy8yYMbFWQyqSbyfxzZCK0vLVgdtH1YYOIzF8
    O1qnBbdjA1qHYi/rHTGCtHgTbVcQBB5H+2rQO6vsloPnalNtFUO7xa0RArIVZxFe
    4bg1wb3W4St63PZiJDkX9dRosnCvWctRZLu+1EPw7+Eh4omVqzeK+O/wBg867ND1
    xMjYKgiiu0Xf8wDXczIOvjZ+7VDZL5AzFCpYA1TPlQHFgULqmh2Eu1c6z/U/hJrI
    2vBI5yV6CMdTrnMY00zhlPR3eR2j8wigkKHqcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519986984; bh=X7cq7C8YdpxAiNnX8g0Fd0VAqZ
    wQOV5y4Fxz2D1qjTs=; b=detsoKD+a7RSqNyuJglL+89Dwgmj43W6TS89PrSHOI
    /BmSba3z4fF/7rToWsFeXCjt2S2t4PsPu1TIVJQWEPyUAzjA7gKIF5eq3ELazeUf
    DDXT0Vp5B5mczvOXJPbtiiDXs2Qp4bF9gwHVl9/0MrZUZhKZ0wemlsYYbBG4WaWo
    cxV/Db13mQS/sN9YiUe4wKbEPLxd/oZleY52UAOUbd1ymSUmMmGZoPs3AGPNSA+e
    OLXUr31/quezD9AIQtJYP2az6f1Ytuj6eX2iPvmjAQ8Ji1aYLWcsD1MU8ntdvMeb
    cZN+vU9zBhroY233ijPc1F8kxExmnNROzR/tVZeobi2A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426318AbeCBK3b (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 05:29:31 -0500
Received: from sauhun.de ([88.99.104.3]:53685 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426405AbeCBK32 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 05:29:28 -0500
Date: Fri, 2 Mar 2018 11:29:26 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Dooks <ben-linux@fluff.org>, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302102926.fuqmfyaxiujjwill@ninjato>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ar6xsfpbsx22zbj5"
Content-Disposition: inline
In-Reply-To: <1519936484-23132-1-git-send-email-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ar6xsfpbsx22zbj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> so do not treat it as an error.  If interrupt 0 was configured, the driver
> would exit the probe early, before finishing initialization, but with
> 0-exit status.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: stable@vger.kernel.org
> Fixes: e0d1ec97853f ("i2c-s3c2410: Change IRQ to be plain integer.")

Please configure git to use 14 digits here.

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to for-current, thanks!


--ar6xsfpbsx22zbj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqZJ4YACgkQFA3kzBSg
KbbOnhAAmMlAdAzlGNkDGU4DRpbMpAkScrAh9An4rjaRRPrAso5ZswfLGwlYrLMn
dH7cDirRv8FDSApDeISwdESGWgJeseDv6R2CRnDiOOUGTmSLOe3DeAtIPgASh4QI
drm83VyHB6/0fZu8vFCmQvZmQH7VHypFJkCgsRIwAIO3fECvKlWZbHz9Q+JEfak7
D6H/eHP8d4Pwd7uoCOrg+PPke3wpo+8/1chJWfmM4GUSv8CPHu92T7N2nlm8+60R
tKUx0IQp2hkUtG1blr3X3n8ILwC9cD2911iCv8izQpSAbtIgCDxT0LcNtgvhCPFo
0oJ7uUqLnGmeNgQyciTjPhIcS5avLl+1EVlwIUPO6xnsDAYImgniIxbu957KSfjr
VCm/e7QE8lL8RTrHQu5zoPoCLacwnPVWSqoX/PVThgMkyW18SRwXo5DjTuHFbtsc
Q+crYiMJIW1eooWEaBWqCuZ4e14/lAXxzDLGj/2JF1A3AjjvBMbXGSmIxThvv+gW
DDovRCigD5+L5LKKUfDvdjpZ0TLXlJmzhgL4kfu+f237paHvz/NE5f9k9wM9oyZB
tcJU9GPsIqmtvZFDMX64yJkjw5IksApXGWmCBt0Fs/ENf916c9ns//a/GhbmuyCO
4+SdQ5XMLyBrHF6IWyJdhAva1b2IpuDjMcdYDDYHyjkn2a9Gjmw=
=BRy3
-----END PGP SIGNATURE-----

--ar6xsfpbsx22zbj5--
