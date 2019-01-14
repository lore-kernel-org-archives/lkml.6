Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6C1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E61B20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="goaSfbtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfANJcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:32:17 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:8485 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfANJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547458332;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ckWKvPEjo65lP74H3XY0sepf70GD8mt73ZzTz4AhfGc=;
        b=goaSfbtTT4nfLy9UTGynrJvmyKGFRF739cBj4hfvB2hNN07/0E6f6YmzZoEj4XzssZ
        s3fcH1AES/55YcMTD/VlbUltWniS35JkQbts1Xh9ajOL+wIklSxwAtzG+3hnwamyxTMg
        R9M7aqRcwkdhv9+D2LmhpaGOqos6T0KoRrknEmTXu34bNGMX/pMkylC/EfE30FrxeHx1
        fZ22MxasWVBuqaCQf6nI09XmMNiH4f2UEyLBYcxvhS5GyNI4enqCoZWXh9EomkaJxmYc
        XUTv2Kfb6fR4qxMiiyvW/Tx0VtlL4H4ztinWYpQsCs/M27rtMPjcH8w1kD5ESbLGce0x
        u1zg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWgdNs16dfA/c7fW145n"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 309bcfv0E9Vsq4I
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 14 Jan 2019 10:31:54 +0100 (CET)
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
Subject: Re: [PATCH 2/6] crypto: kdf - SP800-108 Key Derivation Function
Date:   Mon, 14 Jan 2019 10:31:53 +0100
Message-ID: <1573163.Xcg6e5WDL9@positron.chronox.de>
In-Reply-To: <20190112052758.GD639@sol.localdomain>
References: <20190103143227.9138-1-jlee@suse.com> <1830918.5I3Y3k8tQf@positron.chronox.de> <20190112052758.GD639@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 12. Januar 2019, 06:27:59 CET schrieb Eric Biggers:

Hi Eric,

[...]
> > 
> > +obj-$(CONFIG_CRYPTO_KDF) += kdf.o
> 
> This naming is too generic.  CONFIG_CRYPTO_KDF and kdf.c imply that this is
> related to all KDFs.  But actually it is an implementation of a few specific
> KDFs.  Can you give it a clearer name, like KDF_SP800?
> 
I am going to use kdf_sp800108 or CRYPTO_CONFIG_KDF_SP800108. The reason is 
that there are many SP800 documents.

Thanks

Ciao
Stephan


