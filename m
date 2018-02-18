Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1833978-1518974747-2-13394531806657417369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518974746; b=QhmWNbYg30A0FGnHBYA98jEPqH3KrkKzZjLaMTe4g96Ykir
    CoWEuoGBL/uN8k5eO713AfLiVdVeSJwiC2OFhxWLDNteWPwVLQXBdK3gebmaJbDb
    A88Ccy7n3mxiCM2Os1KU7vh4ASn6TlHQjrGPV4w9jWzHloVQowt1nVt4HItE0ToG
    YeOj6jct1JG7NchoY0FGS2gnAK6sbz/4p53IYeoTqdO+U0/Ciar0S/Obl+/ITTaL
    Z5BoNhi9V24xeU++2xFfNNPIwnP1q9i/uEzkDrE9XXyvrE0JFhe7gE6va+ZI5Yr1
    zE3gZp5Ukk7xrOdlzj8IyCuGGsY1opAJl0cdevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1518974746; bh=KUYnHoLGeLX1B8jUngMYqTnjOa
    BbosVNXSKqVU0/nP0=; b=C3l/2s6SNLWj8YybYkR846YRm9GjNYiFVX8lmp9gDX
    Wb3n7hxhVWbgsLMaDYPiKFIsH/66wjYq64563LJd+vs5duyc2oAbI/4pHgu4rIjC
    gkcmeCMMcLnHqTewrbcL2ObHndp0rpDw4KjEB+irIUPZRQ2uEHeDHVl6NtNJ293T
    E20CIXLHRuUYibIWjan+WiCguW52sUt3O+RqscXC06i/a66r//aTJMvB5QoB23K8
    r2kqRJa6DeGO+W4lRWEsV52Z3BnF7HSFWmR5aaplsNgUklxDY8OJohUGz2TBCO3i
    JDJ4aj0EGvWJh8UELt1Ql3iPgYSFnaDGmhL7LLT8Yp3w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeBRRZm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Feb 2018 12:25:42 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:44830
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeBRRZl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Feb 2018 12:25:41 -0500
Message-ID: <1518974732.2542.1.camel@debian.org>
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
From: Yves-Alexis Perez <corsac@debian.org>
To: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Date: Sun, 18 Feb 2018 18:25:32 +0100
In-Reply-To: <3075ec06-df9e-3532-82fa-cb2ca227c86b@roeck-us.net>
References: <20180209133931.211869118@linuxfoundation.org>
         <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
         <20180213093651.GA29675@kroah.com>
         <7c1ed8b1-bd9c-4b9f-051b-f9f19591cdbb@roeck-us.net>
         <20180213152907.GA29190@kroah.com> <1518874313.9465.1.camel@debian.org>
         <20180217134556.GC28145@kroah.com>
         <3075ec06-df9e-3532-82fa-cb2ca227c86b@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BKr7lhYWIC7x2c/AG70B"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-BKr7lhYWIC7x2c/AG70B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-02-17 at 09:35 -0800, Guenter Roeck wrote:
> Hmm, that chunk really doesn't do what the original patch is supposed to =
do,
> meaning it won't provide the vulnerability protection it is supposed to p=
rovide
> (AFAICS that is Meltdown). Just a note in case anyone is concerned about
> actually providing that protection.

Right now my concern was really about fixing 4.9.81/4.9.82 build failure on
powerpc. Whether the patches backported in those two releases are enough to
fix Meltdown or not is a different thing indeed (and an information I'd be
glad to have too).

Regards,
--=20
Yves-Alexis
--=-BKr7lhYWIC7x2c/AG70B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqJtwwACgkQ3rYcyPpX
RFuHowf+PndUv3zmWA0Z1NhtABmlpTgfipv3QFh27SJlQPdD7IaPDY6QiYqQws3k
FKrjYAihPKGBsEUUvxvAMmQE+MVgEJWz0GEJNyv4w7dPfc7N+NvuDNtRlB/ob6r2
xNT5pFjc+6dAbZwmz1uBfKxypbjc/rhDe/0y8Z4oJmXzsq4mMCQhC1xVzqf/stMw
rFpOTxlFCg3f1uY/RC3k9HsSNpp2IJdSM4BJh16Ustj8lGXLAed9hI6TmAFGh+fW
znZSor2P03YefrK3Ibot4gRu/G8zvYjTIQtK0A5LmB+yFmISVoVvA60h3KNJPbva
5/GQ7uG/Xx/M/zrP8HFLdr86vbhHjg==
=IDiu
-----END PGP SIGNATURE-----

--=-BKr7lhYWIC7x2c/AG70B--
