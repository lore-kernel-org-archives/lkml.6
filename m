Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E118C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2079E20878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0dMHCNAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2079E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJCM7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbeJCM7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:59:33 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6FED20684;
        Wed,  3 Oct 2018 06:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538547159;
        bh=w6hPIk70WRfRNWpSRYI4OZ13rlUrV/5gPe/byZSVbJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0dMHCNAoggqkO51psuavdLB/Aqa4BNhz0rXDUgsSzivLPEStbmn/nN7GXbkjrsDPR
         BwS7+jWbRlxh0p1RHB+hjDpHRkgjz4bvUID9w0H14LeN3e5wYdmeRetAlPep4E6Pal
         5IvmEmQ/c+3m6oMi/IKAgeuRfO8Ug9SehJ5q6SVw=
Date:   Tue, 2 Oct 2018 23:12:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andy Polyakov <appro@openssl.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 11/23] zinc: import Andy Polyakov's Poly1305
 ARM and ARM64 implementations
Message-ID: <20181003061236.GB745@sol.localdomain>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-12-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925145622.29959-12-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 04:56:10PM +0200, Jason A. Donenfeld wrote:
> These NEON and non-NEON implementations come from Andy Polyakov's
> implementation, and are included here in raw form without modification,
> so that subsequent commits that fix these up for the kernel can see how
> it has changed. This awkward commit splitting has been requested for the
> ARM[64] implementations in particular.
> 
> While this is CRYPTOGAMS code, the originating code for this happens to
> be the same as OpenSSL's commit 5bb1cd2292b388263a0cc05392bb99141212aa53

Sorry to ruin the fun, but actually there are no Poly1305 implementations in
CRYPTOGAMS (https://github.com/dot-asm/cryptogams).  Nor are there any ChaCha20
implementations.

Andy P., can you please add your Poly1305 and ChaCha20 implementations to the
CRYPTOGAMS repository, so that they have a clear kernel-compatible license?

It would be great if you'd include a kernel-compatible license directly in the
versions in the OpenSSL tree too...

Thanks!

- Eric
