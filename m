Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543CB20661
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Gae9CgEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfAHXy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:54:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43466 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfAHXy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:54:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so2642696plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0NXIEprZBUufgpmdQuyOnwoc3RHjnrXf2w7NJy6aLVU=;
        b=Gae9CgEyzAiUliCjXZwGypIC4RPUBYVTa4Hfbc8QT5uB1f/VUG8AJtY1n43Ze7H514
         jlLeFger8Cekm9A0I1Ju/DFauNRMHBMErtXPsXWiph/aTHnm5MsB5r/1CpMZ7eK0De+B
         OQUxr7cEnBonOUA/1CGVl/ka/ceAymFWszUOAMKKeOa/x9iOKJ8Y45HPe7O0UiqpHaSl
         QKH9eYsYAOqobGruqYXeMxI9mC0vfXS24/VZjyaMfIFBtX6t/mDEOxuFbF2xlAfd49Ht
         n9b0NVphpjJfh/irB9e4deoT2HMKDi/XTTh8tBbZ0Wz/e5bXbvL5M63425nl9zBhv/h+
         qopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0NXIEprZBUufgpmdQuyOnwoc3RHjnrXf2w7NJy6aLVU=;
        b=FvjkAo3zOWhC1n0KMejA6t2WiFX6LmHBuyCBi5+nEIvO9Zq9ryLPqn/MyJmL/kqKvA
         99MtWRChGZREepVsum6Nspcjwk3RlkWSeiM2YlbcFtmrCEEE2t6iN9cow/Xu83/vlaT4
         vqtJaj30PDD3f4EuSNULxCvvw8DXgXOdQsWfYg+MNahXnqFQeR2mz/OP+HloGqqE0zWp
         sfZ28A3Tne19+0JYnDqAaSST0Als/xIVk+rEW2B+DG/GwiuZ1QP5cmydXcfrA6Kt7bpV
         t/C7ZgTIG7UQilf/TODtuXXhL25dI32RCj+0aNKmL/v9aXBCR2UHI7/lcrPJKUb1JG/1
         22sQ==
X-Gm-Message-State: AJcUukfVWX/CGPX57gwI2pi/3iFV6UJKGR4FR0qSzw+pJyALPeSHA+Uo
        81a+ZFm6u5VEtWTlxjA9HBuk9A==
X-Google-Smtp-Source: ALg8bN487jclGfZVfC+BtgsTUx6xzpJ4dATfjdK0kgxIlYcDw3wtVKiiKvh9CGBD85f1jLnBQa8jUQ==
X-Received: by 2002:a17:902:4624:: with SMTP id o33mr3719588pld.289.1546991665174;
        Tue, 08 Jan 2019 15:54:25 -0800 (PST)
Received: from ?IPv6:2600:1010:b01c:527f:fcaf:25c:3d43:d2b0? ([2600:1010:b01c:527f:fcaf:25c:3d43:d2b0])
        by smtp.gmail.com with ESMTPSA id o1sm107475977pgn.63.2019.01.08.15.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:54:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <1565399.7ulKdI1fm5@tauon.chronox.de>
Date:   Tue, 8 Jan 2019 15:54:22 -0800
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
References: <20190103143227.9138-1-jlee@suse.com> <4499700.LRS4F2YjjC@tauon.chronox.de> <20190108050358.llsox32hggn2jioe@gondor.apana.org.au> <1565399.7ulKdI1fm5@tauon.chronox.de>
To:     Stephan Mueller <smueller@chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 7, 2019, at 11:09 PM, Stephan Mueller <smueller@chronox.de> wrote:
>=20
> Am Dienstag, 8. Januar 2019, 06:03:58 CET schrieb Herbert Xu:
>=20
> Hi Herbert,
>=20
>> Are we going to have multiple implementations for the same KDF?
>> If not then the crypto API is not a good fit.  To consolidate
>> multiple implementations of the same KDF, simply provide helpers
>> for them.
>=20
> It is unlikely to have multiple implementations of a KDF. However, KDFs re=
late=20
> to hashes like block chaining modes to raw block ciphers. Thus a KDF can b=
e=20
> applied with different hashes.
>=20
> My idea was to add template support to RNGs (because KDFs are effectively a=
=20
> type of RNG since they produce an arbitrary output from a fixed input). Th=
e=20
> KDFs would be a template wrapping hashes. For example, the CTR-KDF from=20=

> SP800-108 could be instantiated like kdf-ctr(sha256).
>=20
>=20

I think that, if the crypto API is going to grow a KDF facility, it should b=
e done right. Have a key type or flag or whatever that says =E2=80=9Cthis ke=
y may *only* be used to derive keys using such-and-such algorithm=E2=80=9D, a=
nd have a helper to derive a key.  That helper should take some useful param=
eters and mix them in:

- What type of key is being derived?  ECDSA signing key?  HMAC key?  AES key=
?

- Can user code access the derived key?

- What is the key=E2=80=99s purpose?  =E2=80=9CEncrypt and authenticate a hi=
bernation image=E2=80=9D would be a purpose.

- Number of bytes.

All of these parameters should be mixed in to the key derivation.

Also, an AE key, even for AES+HMAC, should be just one derived key.  If you n=
eed 512 bits, ask for a 512-bit key, not two 256-bit keys.=
