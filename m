Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B5DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DEC20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="nv5kM9iD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfANJ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:26:34 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:15251 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547457990;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=xgRauBTiXdF+dBRc1NyD0+JM4m4TCB/mcjHmedwpxD8=;
        b=nv5kM9iDP4fwlc+fsZL0FAkFeJ6NEVXusDy5C6z2lBUZCbKfuApmfDi7ZeeTn4RqzO
        rIAcVd1Wb8o/INAwupzGUaSuJ0cnHg2+vmUMUlkcCLsM2Tob6q4aMIRMV50jnao36qHA
        solhWBp9ade8QMLfNXgMbAx8oZHhOwAdW94CyY+TbVF3N8Ewdbir3CuQ7pUjq5EoY5DZ
        lFaYUmu1pL1BqHl7tt1YDEvdvoafv9Lrxa04D+wJPqn0o1BodVUK/MYfYCp08sFB/9D5
        UHf1K98YUbi/091Zmi0Y8OZTRRwZ1CElLqn3YiQQZw+Tvw4uVs1inrKVGRNVxARI/WVh
        hLKA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWgdNs16dfA/c7fW145n"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 309bcfv0E9QCq15
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 14 Jan 2019 10:26:12 +0100 (CET)
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
Subject: Re: [PATCH 3/6] crypto: kdf - add known answer tests
Date:   Mon, 14 Jan 2019 10:26:11 +0100
Message-ID: <2231906.kSnl8ZBHjW@positron.chronox.de>
In-Reply-To: <20190112052645.GC639@sol.localdomain>
References: <20190103143227.9138-1-jlee@suse.com> <8456866.1rT4qWozqf@positron.chronox.de> <20190112052645.GC639@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 12. Januar 2019, 06:26:46 CET schrieb Eric Biggers:

Hi Eric,


[...]

Thanks. I integrated updates for all comments.

Ciao
Stephan


