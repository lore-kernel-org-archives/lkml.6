Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D199EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8679021476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Zbj+BzQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8679021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeJRBBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:01:30 -0400
Received: from imap.thunk.org ([74.207.234.97]:55318 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeJRBBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ess8nPuf+OrRlsSNOIyGuFLY8mrxZ0rNxSddFtoE7LI=; b=Zbj+BzQmpxo5B+6S+yN/mha16w
        3/6ZYeG5dwZU5ZX5dbl5/ijSOfsYRteiSUeqYAzDUm6vZSeOMYG37yOqN5QNKix5QyaPVwebXKkwl
        y1yVV7xbQvKi/4ZRPy4LHDUow8RGwUp5rxoNR2cq5kmGDoKpoLCAhnC4NweALJ7FGYV4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gCpFX-0002kc-CQ; Wed, 17 Oct 2018 17:04:47 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8409A7A5189; Wed, 17 Oct 2018 13:04:46 -0400 (EDT)
Date:   Wed, 17 Oct 2018 13:04:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     AnilKumar Chimata <anilc@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        mhalcrow@google.com
Subject: Re: [PATCH 3/3] crypto: qce: ice: Add support for Inline Crypto
 Engine
Message-ID: <20181017170446.GD29710@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        AnilKumar Chimata <anilc@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiggers@kernel.org, mhalcrow@google.com
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
 <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, thanks for the effort for working on getting the core ICE
driver support into upstreamable patches.

On Wed, Oct 17, 2018 at 08:47:56PM +0530, AnilKumar Chimata wrote:
> +2) Per File Encryption (PFE)
> +Per File Manager(PFM) calls QSEECom api to create the key. PFM has a peer comp-
> +onent(PFT) at kernel layer which gets the corresponding key index from PFM.
> ...
> +Further Improvements
> +====================
> +Currently, Due to PFE use case, ICE driver is dependent upon dm-req-crypt to
> +provide the keys as part of request structure. This couples ICE driver with
> +dm-req-crypt based solution. It is under discussion to expose an IOCTL based
> +and registration based interface APIs from ICE driver. ICE driver would use
> +these two interfaces to find out if any key exists for current request. If
> +yes, choose the right key index received from IOCTL or registration based
> +APIs. If not, dont set any crypto parameter in the request.

However, this documentation is referencing components which are not in
the mainline kernel.

In the long term, what I'd like to see for per-file key support is a
clean solution which interfaces with the in-kernel fscrypt-enabled
file systems (e.g., f2fs and ext4).  What I think we need to do is to
add a field in the bio structure which references a key id, and then
define a bdi-specific interface which allows the file system to
register a struct key and get a key id.  Use of the key id will be
refcounted, so the device driver knows how many I/O operations are in
flight using a particular key --- since each ICE hardware will have a
different number of active keys that it can support.

Until that's there, at least for the upstream documentation, I think
it would be better to drop mention of code that is not yet upstream
--- and which may have problems ever going upstream in their current
form.

(I haven't checked in a while, but last time I looked the code in
question blindly dereferenced private pointers assuming that the only
two file systems that could ever use ICE were ext4 and f2fs....  not
that the code used by Google handsets were _that_ much cleaner, but
at least we dropped in a crypto key into the struct bio, instead of
playing unnatural games with private pointers from the wrong
abstraction layer.  :-)

						- Ted
