Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-911174-1518425153-2-13813944989406499880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518425153; b=XYmrZMewLp6Hk2JfbAVstJW55vKxnWrwEuGWyvnuxpsiWfj
    ZDoWK/pn0jAWEyqbVsHejhMPHpGCjQltKlwniRZo66wC7G1BUxVGAMtC6TGTFUGF
    AXXqAlrHGbHPHhKjCMyd1wdtk6FJ1svn1I4mphNDjNFuPj48vr65JjSbr3K7A1aR
    xlmO1GDcNWyxwtBYCqw2biOJAX5fZlItCnPRq31F9VRsYATql9jQcgn7BDUpmr/F
    zY81LxPtRs9KFESabyqJeeR94uTpVjrdx3/8I2TgC60rLW2hakOBoGa+bUYR0vu1
    HpSxMexQV4IUOU3iE2Vn2w25LXVrkUhR6VKYbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1518425153; bh=Nq6wHHU5P3Ztu1AdOLUw5JTCHCVDp9mtzNrjEo
    5MVHE=; b=V8A5tZ5XBit4Mrvv8cEWengPdFRa4tieOEymOsIaMUEUgQ+kha6Ldc
    KMaOTjIirY8j6ofVNg9BpmPwwDM5SMG4WGu/iCePSEeAJvhPJJB6/BEX2b9mq8UF
    MXWkwcthY5GsxVHSEC3vSHwIPmLbCY2DiDW/4ZSXTd7dQkPMANwuW9BR6ezUjTun
    8JGmihpGnk73XqPu26qg+EY/D3AjiI1fXVttNoDOLyQFjWEHpuBP/kKfqhhEboah
    S6FAlqcrMr/RaLxYJ1VE+sx5djpaLrWxfYKP8swKzilCQmoRhJmoJdLFVBeSYxeF
    CTCv5Te8c3QVc2jcxpJ6HdQhMhj5aNeQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbeBLIpu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 03:45:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:26817 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932504AbeBLIpt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 12 Feb 2018 03:45:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="asc'?scan'208";a="29313401"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: vigneshr@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>,
        "linux-stable # \= v4 . 13" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume
In-Reply-To: <1515667087-4110-1-git-send-email-rogerq@ti.com>
References: <1515667087-4110-1-git-send-email-rogerq@ti.com>
Date: Mon, 12 Feb 2018 10:45:20 +0200
Message-ID: <874lmmbnq7.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Roger Quadros <rogerq@ti.com> writes:

> In order for ULPI PHYs to work, dwc3_phy_setup() and dwc3_ulpi_init()
> must be doene before dwc3_core_get_phy().
>
> commit 541768b08a40 ("usb: dwc3: core: Call dwc3_core_get_phy() before in=
itializing phys")
> broke this.
>
> The other issue is that dwc3_core_get_phy() and dwc3_ulpi_init() should
> be called only once during the life cycle of the driver. However,
> as dwc3_core_init() is called during system suspend/resume it will
> result in multiple calls to dwc3_core_get_phy() and dwc3_ulpi_init()
> which is wrong.
>
> Fix this by moving dwc3_ulpi_init() out of dwc3_phy_setup()
> into dwc3_core_ulpi_init(). Use a flag 'ulpi_ready' to ensure that
> dwc3_core_ulpi_init() is called only once from dwc3_core_init().
>
> Use another flag 'phys_ready' to call dwc3_core_get_phy() only once from
> dwc3_core_init().
>
> Fixes: 541768b08a40 ("usb: dwc3: core: Call dwc3_core_get_phy() before in=
itializing phys")
> Fixes: f54edb539c11 ("usb: dwc3: core: initialize ULPI before trying to g=
et the PHY")
> Cc: linux-stable <stable@vger.kernel.org> # >=3D v4.13
> Signed-off-by: Roger Quadros <rogerq@ti.com>

unfortunately, this doesn't apply anymore. Care to rebase on
testing/fixes? (give me a couple hours though, I'm still applying
patches :-)

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqBVCAACgkQzL64meEa
mQZnbhAAhJwu9qYh+550QthSdNh5letUqGKOSFfhkylqo3H70VDZK6qNEWJikHrr
k3cjjQGUGXNq18gsRtVwjDBHg2eITqFxm2q12uU6zV/k4cLj3goiWk0qD2Xwfl3M
Hsk4MD3KD2mJr8oVxdBV2iZvQj4+AZb7B5aQkSh8TcKgOMljySx/kopIm3eFteLO
yr5ClgCr6V8s7j+2vpEyK2NoI1/R8TJzrsIiK3+bj2UkxvRCkWKe8k/DPWE8UIys
w34fyqq3sRDmu6PEKkWMO48zXzGzB+qKCmnkQ7XDEqxgiPlG1cz0tsZdSfsg+zQh
iFRH8Dgjym0vAdk81yWsUfQSEfJvaaIGSaTVufl/iG6+b5+Vq7f3h0jaL67ibZcA
5AXShES1NSfr8ZU6cqVqyz4ievqsuj7kc59dFYcDjydhF4OGcfkLbB+Kp2fQ0YUo
lI2DwuCXMvGbLZHNqaN/HPTmJ6Lo64QNsVOJQS33Tq9WbNv/SQghowUG89TbgmPe
higfI+1SViDomaUq+6cIni47J3dv9IUsF+Vaz0V1wOhzxL//Xrai0B6MEt1KUgP+
BBC/snwIvlg5TfDr8SXYkJb2dViDawNgMLKjgy9xIIEAQZ+GO1PVPuZ9JA6Kw+Si
1q2xFmNkeArKOt50KnuKiIfFxtSbBc3AS5WCn717z7/p8+dk1G8=
=ojeh
-----END PGP SIGNATURE-----
--=-=-=--
