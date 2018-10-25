Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7488AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C95620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Xxx7XHgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C95620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJZACX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:02:23 -0400
Received: from imap.thunk.org ([74.207.234.97]:57214 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbeJZACX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iiAJt/GIr/3dWJFdv8RlqEi8ZS4ZR6qACJuaCxlJthk=; b=Xxx7XHgXKEBx3VG/BlXOujq+w4
        fU5BLtP5nra/qo+8NaLjlMY6CG2brk1kwZ6EXKfvuXYq/LMBP3UYrNY64mDgK1BKSz6GYFsNdMtOr
        FehLpXYNwIU1fE7rvQfI/QifeH7uMdiS0H0YxPwfp+aUtK3rnr3cqQHTMdpyZEJD/RsI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gFhZB-0001tX-M8; Thu, 25 Oct 2018 15:28:57 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E85EE7A447E; Thu, 25 Oct 2018 11:28:56 -0400 (EDT)
Date:   Thu, 25 Oct 2018 11:28:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Rob Herring <robh@kernel.org>
Cc:     AnilKumar Chimata <anilc@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: qce: ice: Add support for Inline Crypto
 Engine
Message-ID: <20181025152856.GD4970@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Rob Herring <robh@kernel.org>,
        AnilKumar Chimata <anilc@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
 <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
 <20181025145548.GA30244@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025145548.GA30244@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 09:55:48AM -0500, Rob Herring wrote:
> > +Introduction:
> > +=============
> > +Storage encryption has been one of the most required feature from security
> > +point of view. QTI based storage encryption solution uses general purpose
> > +crypto engine. While this kind of solution provide a decent amount of
> > +performance, it falls short as storage speed is improving significantly
> > +continuously. To overcome performance degradation, newer chips are going to
> > +have Inline Crypto Engine (ICE) embedded into storage device. ICE is supposed
> > +to meet the line speed of storage devices.
> 
> Is ICE part of the storage device or part of the host as the binding 
> suggests?

My understanding is that for this particular instantiation, the Inline
Crypto Engine is located on the SOC.

However, from the perspective of generic kernel support, the inline
crypto support could be implemented on the SOC, or in the host bus
adaptor, or as a "bump in the wire", or on the storage device.  And
whatever abstract interface in the block layer should be able to
support all of these cases.

I do not believe it would be wise to assume that inline crypto will
forever be a mobile-only thing.  I could easily see use cases in the
data center; for example, if you believe that Nation State Actors
might be trying to create "implants" that attack hard drive firmware,
per some of the Snowden leaks, creating an open design ICE engine with
auditable firmware and a trusted secure key store, and which sits
between the host CPU and the storage device might be one way to
mitigate against this threat.

					- Ted
