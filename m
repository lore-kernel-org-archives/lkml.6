Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1810880-1520512053-2-15049468065465040645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: to='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520512053; b=lqou0V/l6NSRLNpMhy2YWBgG7hVsRVvPk5ERSIOjX6IJlYy
    4FRFl9ZnQSzdUu0Sc/6mfzLp9T3ZqB6uUmvNIFPQSZgxzGcM88OQThYl33YkECcT
    SAthpVDSY0jSLQXeQYQtGfcHyUdtXrzxYNnvMI6lNoKqPMMF3ACiF35Akzy7B1Yo
    JsC9JMn6+SDn82VzfOyoNFRcgw8LuNbDryBjOo8GVPxzKA595wsJQm3rcn6xnq+3
    Otr8j9DZcQBwk3/8r90w/48Um9XF8WDVp/gUstTp/Wl5euJp8Jgs49YnG0c+dsrY
    /kvXGqNKJKl8ch5Z9NU0eJ+XlRBBIus/SxYWoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520512053; bh=15F/G2BxERbeJpHRtMF0r5/Rrv
    D0Q8beZcPVGigLjuw=; b=ZNyNN4NW7L80Qe7lna/EpyaBzR5jEwreV4CPN0vsLK
    O5sx5xMcftTqiBYxyrG6TkO6rljDz8ucCHpPhLYw2U3CLwHgbZzib7x8pqwnqnYj
    r3F55trT8ADNnPkcG3yWtG750zw7or3+FVgzXRHYTkwvlfr0h6+Vq1cr+tFnjWK+
    pMAKyEbx7tRAJO9Z/+jzhXhBhXg4K4U+nM1bRF6y3VLIG8LdP2ovqp3bGhNq0z/2
    kQybe1IwMCKJAxaBaDd6VkadsyBsTjVzlFF7iz/2vMZrZlMn2YxXgOat0KTRETcO
    BtOYi1odT1mrSTy02dMzsngBkRbFGJiR6mn76PJFN+XQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755756AbeCHM1S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 07:27:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54069 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755491AbeCHM1R (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 07:27:17 -0500
Date: Thu, 8 Mar 2018 13:27:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alex Shi <alex.shi@linaro.org>, pali.rohar@gmail.com,
        sre@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com,
        khilman@kernel.org, aaro.koskinen@iki.fi,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com,
        serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net,
        martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Message-ID: <20180308122715.GB21514@amd>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Resent without non-upstream patches.
>=20
> This backport patchset fixed the spectre issue, it's original branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=3D=
kpti
> A few dependency or fixingpatches are also picked up, if they are necessa=
ry
>  and no functional changes.
>=20
> No bug found from kernelci.org and lkft testing. It also could be gotten =
=66rom:
>=20
> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream=
-only
>=20
> Comments are appreciated!

Not entirely related to this patched, but... I have few older ARM
boards here, and Nokia N9000 I really care about.

AFAICT Meltdown is arm64 only?

Spectre affects the older boards, too, right? Was there any work done
on that? cpuinfo says "ARMv7" for N900.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqhLCMACgkQMOfwapXb+vKjNACeKpHd2stS7slqeiar3+0Blbi4
1jAAoIAlanyNXlwN2zVblKniBvT3FDbK
=OKfP
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
