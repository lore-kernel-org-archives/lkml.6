Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCCAC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10372084C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="dKE4iCyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfAMH5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 02:57:10 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:30429 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAMH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 02:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547366227;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Kv7YpH7UFC824CoWKI87SXAHQztivulsiD1lK0fyIxk=;
        b=dKE4iCyqB3GN+dcsvbUBxfkJKJ//RymWMIehgSlP+45fou41JSNQ8T2H/+twCIGjf+
        nQN5DkH9f4Tz7RByJTl8YiIigXNys/PazEJCT6kuzBpg1JsEJAr2U1m3q87FK/KaYtps
        pQFA1sP8v3/+VhAawdQ6fAwcYXsMC8V8+nU51uT4UmKanX8ROxupEUGcHMUpGlaVUM9u
        wNgbK5C0+1KZD9uKNi5hP7l2QhkqJnT2VjUSl3jxEfbSjH/902ZNuuIzTcuATBH/M5q0
        15uSiPDFoGW0rF8VJYsDwOYobpjSEjPfZxyus7mVJyhKbFxgsyrpr2X5XEMmA1WragWu
        9OJQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9x2YdNp5Oujd4kpMBvCE="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv0D7uXkgw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 13 Jan 2019 08:56:33 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 4/6] crypto: hkdf - RFC5869 Key Derivation Function
Date:   Sun, 13 Jan 2019 08:56:32 +0100
Message-ID: <9795894.APlZEWIbOH@positron.chronox.de>
In-Reply-To: <20190112095535.36rh3ptnrf7yxacv@gondor.apana.org.au>
References: <20190103143227.9138-1-jlee@suse.com> <20190112051252.GA639@sol.localdomain> <20190112095535.36rh3ptnrf7yxacv@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 12. Januar 2019, 10:55:35 CET schrieb Herbert Xu:

Hi Herbert,

> On Fri, Jan 11, 2019 at 09:12:54PM -0800, Eric Biggers wrote:
> > Hi Stephan,
> >=20
> > On Fri, Jan 11, 2019 at 08:10:39PM +0100, Stephan M=FCller wrote:
> > > The RFC5869 compliant Key Derivation Function is implemented as a
> > > random number generator considering that it behaves like a determinis=
tic
> > > RNG.
> >=20
> > Thanks for the proof of concept!  I guess it ended up okay.  But can you
> > explain more the benefits of using the crypto_rng interface, as opposed
> > to just some crypto_hkdf_*() helper functions that are exported for
> > modules to use?
> I agree.  I see no benefit in adding this through the RNG API as
> opposed to just providing it as a helper.  If some form of hardware
> acceleration were to eventuate in the future we could always revisit
> this.

The advantages for using the kernel crypto API to add KDFs as opposed to=20
adding helper wrappers are the following in my view:

=2D employment of the kernel crypto API testmgr - invocation of the testmgr=
 is=20
transparent and thus already provided without any additional code to link t=
o=20
it

=2D FIPS 140-2 compliance: To mark a KDF as FIPS 140-2 approved cipher, it =
must=20
be subject to a known-answer self test (implemented by the testmgr) as well=
 as=20
to an enforcement of the integrity check verification. In FIPS 140-2 mode, =
the=20
kernel crypto API panic()s when a kernel crypto API module is loaded and it=
s=20
signature does not check out. As this is only relevant for crypto modules (=
and=20
not arbitrary other kernel modules), this is implemented with the invocatio=
ns=20
the crypto_register_alg as well as crypto_register_template functions. Thus=
,=20
when using a wrapper code to implement the KDF, they can per definition not=
 be=20
=46IPS 140-2 approved.

=2D The invoker of a KDF has one consistent API. This implies that the KDF=
=20
selection now becomes more of a "configuration" choice. For example, when y=
ou=20
look at the KDF use case for the keys subsystem (security/keys/dh.c),=20
selecting the type of KDF would only necessitate a change of a string=20
referencing the KDF. A lot of people somehow favor the extract-and-expand K=
DFs=20
over the traditional KDFs. Now, that the RFC5869 HKDF is also approved as p=
er=20
SP800-56A rev3, I could see that folks may want to switch to HKDF for the k=
ey=20
management. When we have a common API, this choice could even be left to th=
e=20
caller.

The question may arise why to plug the KDFs into RNGs. The answer is quite=
=20
simple: KDFs are a form of random number generator. In that they take some=
=20
input for initialization (aka seed, salt, key, personalization string). The=
n=20
they produce pseudo-random bit sequences of arbitrary length. Possibly the=
=20
generation operation can be modified by providing some additional input to =
be=20
used by the generation process (aka label, context, info string, additional=
=20
information string). Thus, the RNG interface is a natural fit for the KDFs.

Ciao
Stephan


