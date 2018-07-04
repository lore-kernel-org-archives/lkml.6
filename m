Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7DDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6362469B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="S349S7ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6362469B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeGDGQr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:16:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:21864 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeGDGQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530685003;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=YjKD8OXrCs3fNtPVis7IK2pWTSZo+eF7j0s4yztq97A=;
        b=S349S7ZEg1ky7+3fU1CtV2oWpRZ/pafC6LEuyAIVASPAPpd+dF+6I/JYRG5PIyDh04
        LCkGCyvqBTxM+FvKWKu0EfwWjcja4iJfgdZiAKaelu0+Jr6WSVage1WXC63AjcMJKS6m
        sBKRCjMhovIgvkH37BJ71OdekFGuSsdkza+XBoj7SnfX2Nz632A+80F83MmEqQGGGTOP
        ZR2P0i8hyARA7ccu2QGND1pSlAU1dPlY7+60ayMM0eA/S34BOXEbrHV7pCy5sqr09657
        /kqa/+Py8MQbzQVcD6SWB/i9Yt7eESkJhTJZFugAtIj/5A5cKTyA4NOVfc+LWxfeS+3e
        gT8A==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZGritxBCMxjzJPOoq+WpsG/2//HRFk/qN+Jd3w=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.11 AUTH)
        with ESMTPSA id n00f9fu646GR3jI
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Jul 2018 08:16:27 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Vinod <vkoul@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 3/6] crypto: Add Qcom prng driver
Date:   Wed, 04 Jul 2018 08:16:25 +0200
Message-ID: <2060153.p9Cf2LoRhr@tauon.chronox.de>
In-Reply-To: <20180704061035.GY22377@vkoul-mobl>
References: <20180703060434.19293-1-vkoul@kernel.org> <20180704041059.GT22377@vkoul-mobl> <20180704061035.GY22377@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Juli 2018, 08:10:35 CEST schrieb Vinod:

Hi Vinod,

> On 04-07-18, 09:40, Vinod wrote:
> > Hi Stephan,
> > 
> > On 03-07-18, 15:28, Stephan Mueller wrote:
> > > Am Dienstag, 3. Juli 2018, 08:04:31 CEST schrieb Vinod Koul:
> > > > +static int qcom_rng_read(struct qcom_rng *rng, void *data, size_t
> > > > max)
> > > > +{
> > > > +	size_t currsize = 0;
> > > > +	u32 *retdata = data;
> > > 
> > > How can you be sure that this cast is appropriate? I.e. how is it
> > > guaranteed that data is 4-byte aligned?
> > 
> > While reading we check the alignment:
> >                /* make sure we stay on 32bit boundary */
> >                if ((max - currsize) < WORD_SZ)
> >                
> >                        break;

I am not sure I follow your argument.

You cast a void (or u8 pointer into u32:

+       u32 *retdata = data;

You use it:

+       *retdata++ = val;

Followed by your check.

What I mean is that the initial cast and then the subsequent write operation 
is only guaranteed to work if the initial pointer is alighed on a 4 byte 
boundary. However, since it is an u8 pointer, it is not guaranteed to be 
aligned.

So, I guess you want to use memcpy (at least if it is not aligned).

Ciao
Stephan


