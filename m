Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A59AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8683E204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="iR/fBBhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8683E204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbeFTS1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:27:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:31760 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbeFTS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529519207;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Qo5KYj48W3vGAAw5PeP91M6xC83JtdWdTDZdSvqU364=;
        b=iR/fBBhpgUshE/bwsHjPBHrXNPAoX6YNHMrf6d+nspH0Gr1KoYa7waJ/65wJPD/ZBG
        7ENFL0fCAek0r5wH9mtDgZJxViNSqyE4216H0BYmxUAOI1eKuJbCPmNXkzkzjTFw3Tq5
        6lts876jG9ctwE9i0/szj2tM+mRdzFYzrj+pBLu2FgNZFEFtiM8nQGedJiYevpQ13yKK
        yFyO1329TN8mkHEc4/ufKH438bMKewkBGnXrSjoqfPx7EKgmKLpPdnGYVvabO2NLiIJR
        k1sWzUSHTyc/Z6wdJ+lDDk2G06mJrxCCU7N3ypmDlWsIkvk2HFJoBPRFmyk57Ivy2f2/
        ObFg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq/TxiJ4HVfAt7r8Gxra+ZJB+2fPl0OKHS0Ld8pV"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.10 AUTH)
        with ESMTPSA id j06b90u5KIQZ2R2
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Jun 2018 20:26:35 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au
Subject: Re: [PATCH] crypto: testmgr: add test vectors for skein
Date:   Wed, 20 Jun 2018 20:26:34 +0200
Message-ID: <1602937.V4TYxMrJ9m@tauon.chronox.de>
In-Reply-To: <20180620175638.GB76265@gmail.com>
References: <20180620105714.18359-1-j.m.torrespalma@gmail.com> <20180620175638.GB76265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. Juni 2018, 19:56:38 CEST schrieb Eric Biggers:

Hi Eric,

> > +		.alg = "skein1024",
> > +		.test = alg_test_hash,
> > +		.fips_allowed = 1,
> 
> Are you sure Skein should be on the "FIPS allowed" list?  I'm not
> particularly familiar with FIPS, but my understanding is that the
> fips_allowed flag is only supposed to be set on specific "approved"
> algorithms.  So if you're unsure, it shouldn't be set.

Skein is definitely not allowed in FIPS mode. Please drop that flag.
> 
> Eric



Ciao
Stephan


