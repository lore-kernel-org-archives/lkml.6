Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBDCC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4A220874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4A220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeFUBoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:44:55 -0400
Received: from namei.org ([65.99.196.166]:60460 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754088AbeFUBoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:44:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w5L1iTh5031024;
        Thu, 21 Jun 2018 01:44:30 GMT
Date:   Thu, 21 Jun 2018 11:44:29 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        james.morris@microsoft.com, "Serge E. Hallyn" <serge@hallyn.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][RESEND] X.509: unpack RSA signatureValue field from
 BIT STRING
In-Reply-To: <20180620143807.fo7c5endwd5yy24r@gondor.apana.org.au>
Message-ID: <alpine.LRH.2.21.1806211144140.30225@namei.org>
References: <04f372f3-bc26-c629-2269-0e5d258f9d8f@maciej.szmigiero.name> <80e95323-eb7f-6af3-ad05-f174c69fb948@maciej.szmigiero.name> <9a9bfd23-d7be-7f16-925e-5fe00cbfba9f@maciej.szmigiero.name> <20180620143807.fo7c5endwd5yy24r@gondor.apana.org.au>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Herbert Xu wrote:

> On Wed, Jun 20, 2018 at 02:24:54PM +0200, Maciej S. Szmigiero wrote:
> > 
> > A friendly ping here.
> > 
> > @AMD people:
> > Without this patch, in-kernel X.509 certificate verification is broken
> > on AMD CCP RSA implementation.
> > 
> > For example, loading wireless regulatory database gives the following
> > errors:
> > > [   21.310361] cfg80211: Problem loading in-kernel X.509 certificate (-22)
> > > [   21.351717] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
> > 
> > Kernel modules signature verification probably has similar problem, too.
> > 
> > That's why it would be nice if you could ack this patch, please.
> 
> David/James, is there an issue with the patch?

Not from my POV.

-- 
James Morris
<jmorris@namei.org>

