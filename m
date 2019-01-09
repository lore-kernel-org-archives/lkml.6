Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B354BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E72F206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="h4KOuosZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfAIPex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:34:53 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34170 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730652AbfAIPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:34:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5DF3A8EE440;
        Wed,  9 Jan 2019 07:34:51 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DUuIWG3ekyVq; Wed,  9 Jan 2019 07:34:51 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5DE4F8EE092;
        Wed,  9 Jan 2019 07:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1547048091;
        bh=76j4m/rQEHqv8vtM5RnAkEGh1JBxdhkcc6WuiDbWSBY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h4KOuosZsIRCTxjjhBSXtfE3NaAEI8hQ23ehr8iD659I63nXMwI1VvQM0T9r4JhO+
         GaJC6MWOrYS1OeBDGHvSKlRwFq741t5T21M63H2Ru8yNQ+UL/nDx1wWJu4IcuYQn6w
         WZpF5PaEiTawkq+T7tbh0EJKoHxyZ0DIhlPq3dsU=
Message-ID: <1547048088.2879.6.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
Date:   Wed, 09 Jan 2019 07:34:48 -0800
In-Reply-To: <1894062.aDvIuj92vB@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com>
         <309406107.k3W2fMQUza@tauon.chronox.de>
         <1547017108.2789.24.camel@HansenPartnership.com>
         <1894062.aDvIuj92vB@tauon.chronox.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 08:05 +0100, Stephan Mueller wrote:
> Am Mittwoch, 9. Januar 2019, 07:58:28 CET schrieb James Bottomley:
> 
> Hi James,
> 
> > On Wed, 2019-01-09 at 07:45 +0100, Stephan Mueller wrote:
> > > Am Mittwoch, 9. Januar 2019, 01:44:31 CET schrieb James
> > > Bottomley:
> > > 
> > > Hi James,
> > > 
> > > > Actually, it would be enormously helpful if we could reuse
> > > > these pieces for the TPM as well.
> > > 
> > > Could you please help me understand whether the KDFs in TPM are
> > > directly usable as a standalone cipher primitive or does it go
> > > together with additional  key generation operations?
> > 
> > They're used as generators ... which means they deterministically
> > produce keys from what the TPM calls seeds so we can get crypto
> > agility of TPM 2.0 ... well KDFa does.  KDFe is simply what NIST
> > recommends you do when using EC for a shared key agreement ... and
> > really we shouldn't be using ECDH in the kernel without it.
> > 
> 
> Thanks for clarifying. That would mean that indeed we would have
> hardware-provided KDF implementations that may be usable with the
> kernel crypto API.

Just on this point, the TPM doesn't actually provide any KDFa or e API,
so it can't be used for hardware acceleration (and even if it did, the
TPM is a pretty slow engine, so software would be faster anyway).  We
need these algorithms in software because the TPM uses key agreements
derived from shared secrets to produce session encryption keys to
ensure confidentiality and integrity (HMAC key), so we establish the
shared secret then have to derive our key in software and the TPM
derives the same key internally and we use the shared derived key to
symmetrically encrypt and/or HMAC secret communications.

James

