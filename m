Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6160C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D2B20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="L5jrlTMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfANTSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:18:20 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:20868 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547493497;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ruNGl6IL1R0cLWsOjqtzI7WYAcpoPSicC26aThCRNhM=;
        b=L5jrlTMuclVwdCIzA6O9pEXVPsOtCk8+XdpQ9Ygr4J8/T4kpEXP8ij7hM5TiQoO7Ob
        OL+8kJ09uuwV9PL02Vz8BkjxDLA0TiIrLUqVhEAD34AFPIdFqPEYxUbZn98wiQk+gM8l
        wKlNw49/2Hd8i8xQi2M6U5V8+BFgSK58Rjq10Uu3cacQI+gkhGsZQKJhNvAfiL0hTMJY
        W3kJSwHwSlcaWtnIuq8RUFwgWTfyioyVphMgt0HsdBz9WcC9D7rBPQZdc3XAjYrg+oq4
        SuL+K/QZEbT/mrIucgPiPgZVNQqJ2lXmiW9F4j90iWvvvmDTr+pTeb37s7p47H1fGhAO
        /PIw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmkBKV/U3+81ReqJahw="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv0EJHitrw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 14 Jan 2019 20:17:44 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
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
Subject: Re: [PATCH 4/6] crypto: hkdf - RFC5869 Key Derivation Function
Date:   Mon, 14 Jan 2019 19:44:22 +0100
Message-ID: <1693060.JDmgY16SMQ@tauon.chronox.de>
In-Reply-To: <20190114175315.GB7644@gmail.com>
References: <20190103143227.9138-1-jlee@suse.com> <4734428.Gj5BGI4uxL@positron.chronox.de> <20190114175315.GB7644@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. Januar 2019, 18:53:16 CET schrieb Eric Biggers:

Hi Eric,

> > I would not suggest this, because that rounds contrary to the concept of
> > the kernel crypto API IMHO. The caller has to provide the wrapping
> > cipher. It is perfectly viable to allow a caller to invoke a specific
> > keyed message digest.
> Sure, but it would not conform to the HKDF specification.  Are you sure it
> is okay to specify an arbitrary keyed hash?

Technically, I see no issue why this should not be possible. You see that with 
the SP800-108 KDF implementations where using CMAC is perfectly legal (and 
which I also test).

Though, using another keyed hash implementation like CMAC is not covered by 
the HKDF spec. If a caller would use hkdf(cmac(aes)), it would produce 
cryptographically strong values. Though this implementation does not conform 
to any standard. I do not think we should prevent a caller to select such 
combination in the kernel crypto API.

IMHO there would even be valid reasons why one would use cmac(aes) for a kdf. 
For example, when you would want to use a hardware AES which somehow also 
employs a hardware key that is inaccessible to software in order to tie the 
KDF result to the local hardware. This could even be a valid use case for Ext4 
FBE encryption where you derive a key. The KDF could be used to link the 
derived key to the local hardware to prevent the encrypted data could be 
copied to another system and decrypted successfully there.

Ciao
Stephan


