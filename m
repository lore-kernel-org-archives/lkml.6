Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B539C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7C220837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7C220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeFUCcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:32:47 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:36902 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeFUCcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:32:45 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fVpOj-0001mE-Ut; Thu, 21 Jun 2018 10:32:34 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fVpOe-0001Rt-T6; Thu, 21 Jun 2018 10:32:28 +0800
Date:   Thu, 21 Jun 2018 10:32:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     James Morris <jmorris@namei.org>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        james.morris@microsoft.com, "Serge E. Hallyn" <serge@hallyn.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][RESEND] X.509: unpack RSA signatureValue field from
 BIT STRING
Message-ID: <20180621023228.wy3ly6yy7wdq3k3n@gondor.apana.org.au>
References: <04f372f3-bc26-c629-2269-0e5d258f9d8f@maciej.szmigiero.name>
 <80e95323-eb7f-6af3-ad05-f174c69fb948@maciej.szmigiero.name>
 <9a9bfd23-d7be-7f16-925e-5fe00cbfba9f@maciej.szmigiero.name>
 <20180620143807.fo7c5endwd5yy24r@gondor.apana.org.au>
 <alpine.LRH.2.21.1806211144140.30225@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1806211144140.30225@namei.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:44:29AM +1000, James Morris wrote:
> On Wed, 20 Jun 2018, Herbert Xu wrote:
> 
> > On Wed, Jun 20, 2018 at 02:24:54PM +0200, Maciej S. Szmigiero wrote:
> > > 
> > > A friendly ping here.
> > > 
> > > @AMD people:
> > > Without this patch, in-kernel X.509 certificate verification is broken
> > > on AMD CCP RSA implementation.
> > > 
> > > For example, loading wireless regulatory database gives the following
> > > errors:
> > > > [   21.310361] cfg80211: Problem loading in-kernel X.509 certificate (-22)
> > > > [   21.351717] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
> > > 
> > > Kernel modules signature verification probably has similar problem, too.
> > > 
> > > That's why it would be nice if you could ack this patch, please.
> > 
> > David/James, is there an issue with the patch?
> 
> Not from my POV.

Hi James:

I presume you will pick this up then?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
