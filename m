Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AEDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134D120870
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="ouEM/a0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfANJZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:25:49 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:16679 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547457946;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=AS3UVO9VUy/yA9TAuYUKM0GaFeRpzoT5J7TlCsaSwF4=;
        b=ouEM/a0Flkvy+Ja1BzzHcepwQM15zaHrULmODDHm0pubzqc7WCwRidHMWQU0Uw3Dij
        jyGduHHtDqrcN2BSoar2rzEs9H1dnAmRnBJzCt1Q8Os8+YYvv+8gIZYSn7GtqV2BGx0M
        khuVbSwRNOe37vOT4/kXVlA4bh5qoiZQJ4NK3LnT/OJzd2BKZG6EKEyLBY45qbwzwVoX
        VsZGAuA6z3oQwzWxjB9Ta0SRnwNNx/9XyRUDWIBvvwngUSxAqhaQq0Yq+k1aSld9g2Uq
        Vpwpg8EDa5wswQ0QHT+fmxw0E0Rvwrv7LL3o0Pijlt38b/4nukUaVHUjMrMBfdU2gUHh
        xvqA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWgdNs16dfA/c7fW145n"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 309bcfv0E9PHq0c
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 14 Jan 2019 10:25:17 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: Re: [PATCH 5/6] crypto: hkdf - add known answer tests
Date:   Mon, 14 Jan 2019 10:25:16 +0100
Message-ID: <2750733.sbdFDJOICv@positron.chronox.de>
In-Reply-To: <20190112051914.GB639@sol.localdomain>
References: <20190103143227.9138-1-jlee@suse.com> <9857029.1Sm7LFDBlJ@positron.chronox.de> <20190112051914.GB639@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 12. Januar 2019, 06:19:15 CET schrieb Eric Biggers:

Hi Eric,

[...]
> 
> > +			}
> > +		}
> > +	}, {
> > +		.alg = "hkdf(hmac(sha224))",
> > +		.test = alg_test_null,
> > +		.fips_allowed = 1,
> 
> I think it is dumb to add algorithms to the testmgr with no tests just so
> the 'fips_allowed' flag can be set. 

Currently it is the only way. But I agree that it could be done better.

> And doesn't FIPS sometimes require
> tests anyway?  I don't think the "null test" should count as a test :-)

Yes, it DOES count as a test (as strange as it may sound)! :-)

The FIPS requirements are as follows:

- raw ciphers must be subject to a FIPS test with one block chaining mode to 
cover that cipher with all block chaining modes (e.g. you can test ecb(aes) to 
cover AES with *all* existing block chaining modes).

- for compound crypto algorithm (like RSA with respect to hashes, KDF with 
respect to the keyed message digest, HMAC with respect to hashes), the 
wrapping crypto algorithm needs to be tested with *one* wrapped cipher at 
least (but also not more. E.g. if you have a self test for, say, all SHA-1 and 
SHA-2, you only need one HMAC SHA test or one KDF HMAC SHA test.

- in some circumstances, it is even permissible to test wrapping crypto 
algorithms where the underlying algo is implicitly tested. E.g. if you have a 
HMAC SHA-256 test, you do not need an individual SHA-256 test.


> 
> Perhaps just include sha256 and sha512, and have tests for them?

Do you happen to have an official SHA-512 HKDF test vector? RFC5869 only has 
SHA-1 and SHA-256 tests.
> 

[...]
> > 
> > +/* Test vectors from RFC 5869 appendix A */
> > +static struct kdf_testvec hkdf_hmac_sha256_tv_template[] = {
> 
> const
> 
> Likewise for all other kdf_testvecs.

const does not work with __VECS :-(

I leave it without const at the moment. I think the __VECS should be updated 
along with all test vectors.

[...]

Ciao
Stephan


