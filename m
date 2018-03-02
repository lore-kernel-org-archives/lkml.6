Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1633200-1519999162-2-9165091509741269060
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
    t=1519999162; b=RQLZFr2lhKhumB9ptlb8zF5ayI4Eh0FO1atOG10ErR+A4AF
    pUXgou+r4msF1tLz3YsRHg6hEKxx7uPGA937L1cNMSi+ws07tVayEKmkwOIPM+q5
    ZYiprXOFs4mtu9/pqkqZPytMUaUTF53SUvlqfDLr6iLXb3QGjHncPT/I2ezD2sxx
    79ZRdoGJWmZzh2zp065Cui2B0Don7g3ePk9pIJJXDxejgpxZ+N84InobK1xTuRJ+
    OKOar7RoOe0vBQjP1xxNttswpQfHQvaJNVRMSIdGsrcLNXqd6mzcTaLx3754pkuw
    pVOKV7Hd7DA9yi5JqUi78nzQf2u5IPUYbqmI4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519999162; bh=FIJ7krFCsWyfrbA6B0q5TvCbEq
    EsaFep2tuuCRZXwLo=; b=wr7pCe+lPGGQ+IlgBFB28nWqq0GpApE957CfmtwVPT
    h2XY7dH5QFQONmPHuiDXFnkrG5QoE5hb6ZqmPDGp5838S1h12nzjlf5UIbwMIrIP
    4VkRcevwbAt0JVi3AFXo1ppJL+Rqm4uvzHwezdz6mHmMcP004KByWBinu7jOPVRB
    H/wPNIpk8fmQa+hkah+dFsbV6mB9E22FscQAe6AaJb+nCCFDpw7hI5U4p2vs+BLw
    dD7HlWSnL1q3WcUQqgDFLaRwg58S94BfVabcvJtpYH/5Uv1WPB1vfzLklkhW2NbG
    xsshpN3jvkZoCGbea3EYJ1y7sKlGSNBmeZAMS1nlHWZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424621AbeCBN66 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 08:58:58 -0500
Received: from www.zeus03.de ([194.117.254.33]:47872 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424546AbeCBN65 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 08:58:57 -0500
Date: Fri, 2 Mar 2018 14:58:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302135854.76ue5jzsg7lvxjxw@katana>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qduyl4kuhqqt64zz"
Content-Disposition: inline
In-Reply-To: <20180302125907.GA9418@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--qduyl4kuhqqt64zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> It needs platform maintainers to be motivated to fix it, and one way to
> provide that motivation is for subsystem maintainers to say no to patches
> like this.  If patches like this get accepted, then the "problem" gets
> solved, and there is very little motivation to fix the platform itself.

Yes, I can see this. I will drop / revert the patch.


--qduyl4kuhqqt64zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqZWJoACgkQFA3kzBSg
KbbwWA//QJ9t2r/ZctCbRotFORB7QcXSS64fK5vjCKr9VutQG6McyfbKRh4jqbkm
KaE1RWdz1pMqMVRqc+gRfOM626ehi6skfbDC36SBi5DjuMhyi/JarkOBkhIOmeEt
dHhuLGzRZYTG4ZRVMJNlk8Jbji/CZoq30b4ZZc4koQ5Eg2uT254gfAzFhgRkK8OH
D73o1AYqA544eyMWOiaIVMPaPaywwoYWWXYlVD0tc5KbjkYXe/kcPFi4aRfBvzoU
U6v6+TfRMjQYITpth93nJtr4RAy+2wiCBLRgTwf8SK6u30wtUXSks9jOEfK1/ZaN
VReruiSYOlztKIj1jUYnRXw8XLdpKYBKweTti7LQWfCmTfl3eVUwGNRneZdrSPBG
3+L0bIXesKuvmTHTZMYN7E43Qdt+nNh0sokKmR1ePmex62iV/jhlXVoWLK/2R+r3
eLgp21NpTd3TnXgPsVQeEbBnaG9BaAg0zzhIQXlVa/GTZ/74Wvnvn+oh16FnDnQ3
Fm5Zequ2guDJeVYTL3ApN8pxoKIzpysZBarc1FWjSXRL6nomduanIxk6YWz3yD5H
uG7nVw/TQU4np2v1E/vZBhV7PxO62W1ljVAtK322ACHTWrDoAEfTk8xFLGavrzZX
RbYuHJk9mi+M57Bw18EyclLFuqBkdnSzI1gSqQrAyT4LruehgdA=
=5sEx
-----END PGP SIGNATURE-----

--qduyl4kuhqqt64zz--
