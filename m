Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B69C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E4721A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="m3/M/HDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E4721A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeHGF2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:28:06 -0400
Received: from imap.thunk.org ([74.207.234.97]:44294 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeHGF2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JE/EEXRoZaB+Aju222RAWGGDZcx8vcBl5wwipdsTA4E=; b=m3/M/HDSy7xbYn5iF6KPBxGqY2
        8KkNYTjRVp0Gd0Ep3Msne3marx4zId8+Aix3TQGIOjZAZn2N8bC5Csyz4WyFmIozC8vbeCR0UVsg1
        FnO2+jLr3bYd3bTiWtikDxDT1Rjv3H84tVy63WdNmP13P8UfqTaDFWHyyuCYprs7cV0A=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fmsT1-0006OF-G8; Tue, 07 Aug 2018 03:15:27 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 72FB37A64CD; Mon,  6 Aug 2018 23:15:26 -0400 (EDT)
Date:   Mon, 6 Aug 2018 23:15:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        stable@vger.kernel.org
Subject: Re: [PATCH] crypto: remove speck
Message-ID: <20180807031526.GD5048@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>, stable@vger.kernel.org
References: <20180806223300.113891-1-ebiggers@kernel.org>
 <20180806230437.21431-1-Jason@zx2c4.com>
 <20180807011937.GA133621@gmail.com>
 <CAHmME9oTApV-zHD60QPryaoQf45ODpG25Da5FgB8c+LO162gWQ@mail.gmail.com>
 <20180807031237.GA779@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807031237.GA779@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 08:12:38PM -0700, Eric Biggers wrote:
> I mention this because people are naturally going to be curious about that, e.g.
> speculating that Google found a "backdoor" -- remember that we do have some good
> cryptographers!  I'm just stating what we know, out of honesty and openness; I
> don't really intend to be arguing for Speck with this statement, and in any case
> we already made the decision to not use Speck.

Let's be clear --- the arguments about whether or not to use Speck,
and whether or not to remove Speck from the kernel, are purely
political --- not techinical.

						- Ted
