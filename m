Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB28BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A52173D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vp0Z/4vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643A52173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHYVGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 17:06:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43042 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeHYVGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 17:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=27o2dxpWTRCqYzjrpuQJ665NihhUEeNPbYXZRHx1xEo=;
        b=vp0Z/4vkf7B8n0iVl/svLQMPHZ/vfXF5SZZL+t5deUat43dj0yknoXuS3kmokiJgGLYqQ6O6pMKqe3vTQG3TedgggUsvYCMqTfciNwA2wxpRUueEImx1DudHwyKklm4Ca1J9iN5+0g3Iycdm7MDG9/SYN0A3wJxZEET5a0dhywo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ftcKq-0006IO-2V; Sat, 25 Aug 2018 19:26:52 +0200
Date:   Sat, 25 Aug 2018 19:26:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 02/17] zinc: introduce minimal cryptography library
Message-ID: <20180825172652.GA23992@lunn.ch>
References: <20180824213849.23647-1-Jason@zx2c4.com>
 <20180824213849.23647-3-Jason@zx2c4.com>
 <20180825062951.GC726@sol.localdomain>
 <20180825164005.GA7748@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180825164005.GA7748@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 10:40:06AM -0600, Jason A. Donenfeld wrote:
> Hey Eric,
> 
> On Fri, Aug 24, 2018 at 11:29:52PM -0700, Eric Biggers wrote:
> > I thought you were going to wrap lines at 80 characters?  It's hard to read the
> > extremely long lines, and they encourage deep nesting.
> 
> I somehow noted this for the WireGuard side of things but assumed I
> didn't need to do so for Zinc. Hah, such wishful thinking. I'll have
> this wrapped at 80 for v3.

Hi Jason

The coding style document applies to all code in the tree. Plus some
out of tree stuff, like iproute2 if, you need user space patches for
that.

I've been running checkpatch on just the network parts. But i expect
at some point, somebody will run it on the crypto stuff as well, and
ask you to fix up some of the errors and warning.

There is also a general trend that you won't get in detail human
reviews until the automated review tools indicate the code is O.K.,

	Andrew
