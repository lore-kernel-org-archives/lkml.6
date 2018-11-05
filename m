Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE11C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4818220882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="iBdKJyDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4818220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeKETtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:49:18 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:26286 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKETtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541413815;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=4QL3+oFWCDg7qLuFwO8KKYdOtR8FpvoaWflQ6P0pwUs=;
        b=iBdKJyDTXax6plInntytk3o670NX66PJ9W05bhPci++6jo7I7bGB3L08ziBmJGmz13
        22PDOwGYZudEzZ7eNEaqT6SPac8DdekzvdWQeoUGvSjEn69z+CImQS1fc2Utc4iLnc1g
        NveVeHgzLztNknMADRR+ny8jTEmAWMeUXpZF8WFp817HZfO9Uvq7wkDS2aPY8uynShjP
        oa4mgq0kBUDVBGhpkg5W96NPlzodupH1UyYyLVfhFKAHT8aiqJfgzR0JRI2LFd+JmPZ4
        mwpaXQ0EusoylcDZWrAabroYsQLR9uFhVi/baxnHFe1Q6X6imcfzh2e4U6vxv5zOjPzE
        wLGA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSYiH4="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.3 DYNA|AUTH)
        with ESMTPSA id w08d48uA5AUDEiW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 5 Nov 2018 11:30:13 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Yael Chemla <Yael.Chemla@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: mark cts(cbc(aes)) as FIPS allowed
Date:   Mon, 05 Nov 2018 11:30:12 +0100
Message-ID: <8348637.N0ntbUeCvJ@tauon.chronox.de>
In-Reply-To: <CAKv+Gu8x1LRKq4xJTrWfu7vQDPSzxYwEYGXG_o3Xv+Zsch9S-g@mail.gmail.com>
References: <1541325924-14777-1-git-send-email-gilad@benyossef.com> <CAOtvUMeRth4zrTZbEy6Co=+CR4==5oSDbaf760Yh4fj8UAf8bQ@mail.gmail.com> <CAKv+Gu8x1LRKq4xJTrWfu7vQDPSzxYwEYGXG_o3Xv+Zsch9S-g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. November 2018, 11:20:28 CET schrieb Ard Biesheuvel:

Hi Ard, Gilad,

> On 5 November 2018 at 10:18, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > Hi Stephan,
> > 
> > On Mon, Nov 5, 2018 at 10:50 AM Stephan Mueller <smueller@chronox.de> 
wrote:
> >> Am Sonntag, 4. November 2018, 11:05:24 CET schrieb Gilad Ben-Yossef:
> >> 
> >> Hi Gilad,
> >> 
> >> > As per Sp800-38A addendum from Oct 2010[1], cts(cbc(aes)) is
> >> > allowed as a FIPS mode algorithm. Mark it as such.
> >> > 
> >> > [1] https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
> >> 
> >> There are several types of CTS approaches. Only three of those are listed
> >> in the SP800-38A addendum. The source code only refers to some RFCs.
> >> 
> >> Did you check whether the CTS implementation matches one or more of the
> >> types listed in the addendum? If yes, may I suggest to add a small
> >> statement in the code noting this fact?
> > 
> > Yes, AFAIK the software implements CBC-CS3 as described in the document.
> > You have a very good point about this not document anywhere. I will
> > send a patch.
> 
> I agree that it makes sense to document this.

Thanks for adding this. With this statement, the initial patch of adding the 
fips_allowed flag is:

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Ciao
Stephan


