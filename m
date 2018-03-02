Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988913-2-11920477761646300314
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
    t=1519988913; b=N3OYvMZQ+ncClu0vo7V30/gCjcmuNz1DAxAirXrdAV1AV8b
    j8/9nWdk8BSNP4CmkkNVRR927d0XSC4lLSr+SVKiUrVghNYQH/1NTRGWoQhr+wFZ
    RBmzO6zi+M5ey0nBq2hkAv+xwy64WCd7IUB4o/g8CfWJSpzulM3J8BnNARZYLDML
    Gi5jwvqXmRKGYz+X2Wcl8We6VLTzF9W12Z83J+zyspqYfLW2Ak/ihqESctNzjhO6
    /MdQK38C3oX2dUyKSLSIqheybWz+YaCeEYOFNA5LwxksP7bIQeEFgS6PaD5Eqoeg
    NJwD4VbZzGjjMfqzZ8IWSEZk0X0SzNxTQSqw8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519988913; bh=hLuROCxKI8efrWvjfES+xDF1In
    X7uumYF75OU1DRkR0=; b=UN3ipqQrhhah9yywj3H9N+fmi1YtJ3DR2wBE9iP3ZU
    QrkG0m/qS5kMFo/+M2VhAa9sR9GJ8xXFL0dvXxJBdXCNJV1kIP164RqgyXwady2A
    5NMmxHMvvqZ0e9sNrdzN7wIj1ssNTQrRFIi4aNu9KTPaQvXMLcoF6By4fQQrcgNm
    5RQs8GHtNIHkD9DwziCy7eHo1N7kXW06ULYepc1PPdXvu9pPqrJoCFUslPkBhkDw
    sDyhewf/KiESLU269O4b/rpmuqpMHamms8/CUocQ/Z2sZs8mgLrpxVlgypRw5SJs
    ha9SL+J4I8eB1KCwdMSXf4bd9VhXL9Jti0bakylVZHhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423610AbeCBLIL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:08:11 -0500
Received: from www.zeus03.de ([194.117.254.33]:39762 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423524AbeCBLII (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 06:08:08 -0500
Date: Fri, 2 Mar 2018 12:08:06 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302110806.naskbf5n7eiugsjd@katana>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302102926.fuqmfyaxiujjwill@ninjato>
 <20180302110002.wmkvktobi7ssmin5@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vekmjfjlo5nu3242"
Content-Disposition: inline
In-Reply-To: <20180302110002.wmkvktobi7ssmin5@mwanda>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vekmjfjlo5nu3242
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wait, when did we decide that 12 wasn't enough?

I stand corrected. Sorry. I recall some discussion about using 14 and I
changed my git config according to that back then. I see now in
submitting patches that 12 is documented.

I will change my setting back. Sorry for the noise.


--vekmjfjlo5nu3242
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqZMJIACgkQFA3kzBSg
KbaB5hAAksGeCgwN25/AKYu44jL6fjXjGfRM+TdyE36ZTenZCXoicpR2LnDD5WbD
H1LoTw+KijlYYGy9PylW1MZsqS/u2Rq0DR7BNyNTag3SxQAuKz9MJmSnFo0M975V
57T+lD63X2qDA6AJlj4oU28s3kmf2URJXuItsTbTRD9uxQq+3Bsf/yUp5tWpiOxN
OBamLT3O/YLWZ8quV71lKFWL/Ayz+GzoO8yxTyqw6AF8YwpV5o6fI+1ZXkSgbhLE
34xB3cmO71i4HtH/sT2XhS8cGvNGM/U0pJ6adre27fIMZTyczMW84mMC7Pq/5BYs
pNSKGhMTTwGl9uOChFuR3tbT+vb1mzYak8YEInETblUEB12gCtMqBjX2INlP9gle
yL6eTw0CT+JxmtTFOG3CreN1ioI725id2dQeGnRUnYffB0GpSAZv3HiMsovsuwQw
DGJN0UHUJrsD4W3b0Om04sPlGQwM3rZlwFlENxzV55+/ALtYBoBZhG/gxiMJBh6Q
gi4rmpCOa8uJ0Pk5SkhPE2BA7/501J06+TZuxaY24MvekZCYnyVQ4gJF8dDEEoDN
R4u6y66ReShja4a5dL9JnPJp/gDWZIKPebFQ8MYK0ruq//8Y9g/E4CKaYp1H36tD
d4cvhdNsLymSJz4nn6aYTk86sBUkkzobBX6HO8Kq3Uw3Mn/J+zQ=
=YJzZ
-----END PGP SIGNATURE-----

--vekmjfjlo5nu3242--
