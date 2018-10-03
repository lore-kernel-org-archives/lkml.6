Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA452098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKBz4zcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA452098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJCNgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeJCNgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:36:55 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E195420684;
        Wed,  3 Oct 2018 06:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538549394;
        bh=9t7ndurSMmuI3q97MNuQ4VgbN4uT7DKgPvKjf9zMjac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKBz4zcRTszuKaQUUqC+AUc8k2WOKP9QDw+luNzwwAQQ2BIhkjmzgWIm7SF8lPxcj
         PrD6pUt47N51sXX6l5tj911IwUjsKBJvinQIvWSutP+9QgKmrzz/+rPXjMxmqy+JJ6
         GHp5tbWWQF0YJyu2nneTQaFfhNfJ2cUxxYVOF+O0=
Date:   Tue, 2 Oct 2018 23:49:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
Message-ID: <20181003064951.GC745@sol.localdomain>
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
 <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au>
 <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
 <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
 <CAHmME9r6-DHLwePQGBGcnPUZuZgZ2GtSUX9arsWzLqhKxd=uDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r6-DHLwePQGBGcnPUZuZgZ2GtSUX9arsWzLqhKxd=uDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:22:47PM +0200, Jason A. Donenfeld wrote:
> On Tue, Oct 2, 2018 at 8:04 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > Also, I still think the name Zinc (zinc is not crypto/) is needlessly
> > divisive and condescending, and unsaying it (in v2 and up) doesn't
> > really work on the Internet (especially since you are still repeating
> > it in your conference talk.)
> > Jason, you seem to hate the existing crypto framework with passion,
> > and the name reflects that.
> 
> It's not divisive or condescending. I don't hate the existing
> framework with a passion -- this is patently false. The name even with
> its original acronym doesn't imply anything essentially negative. I
> see that you've repeatedly misinterpreted it this way -- which is why
> I removed that from v2 for the avoidance of doubt --  but that doesn't
> change the fact that its proper interpretation is not a condescending
> or divisive one.
> 
> Look, people love to bikeshed about names. I'm sure you'll be able to
> CC-in a large crew of people who have opinions in one way or another,
> and this thread could begin to have many voices on that front or on
> multiple fronts. There are real benefits of sticking with the name
> I've given to the library I've spent enormous amounts of time writing.
> And so I'm going to stick with Zinc, since that's why our library is
> called. Sorry. We can talk about this at Plumbers in Vancouver if you
> want, but I think you're not going to get very far with a mailing list
> naming bikeshed.
> 

It's not really about the name, though.  It's actually about the whole way of
thinking about the submission.  Is it a new special library with its own things
going on, or is it just some crypto helper functions?  It's really just the
latter, but you've been presenting it as the former, which is causing a lot of
unnecessary confusion and controversy.  And I think that largely because you've
started from that perspective, you've ended up with some oddities like your own
directories in lib/ and include/ separate from the other existing crypto helper
functions, and proposals to maintain it completely separately from the existing
crypto code including having a separate git tree and separate upstreaming path.

For example, we already have include/crypto/.  What's the difference between
include/crypto/ and include/zinc/?  How do users know whether to include e.g.
<crypto/chacha20.h> rather than <zinc/chacha20.h>?  And are users going to
remember and understand that "zinc" actually means "crypto" but not really?  It
would be much more straightforward and intuitive if we just had
<crypto/chacha20.h>, and your new helper functions were declared in there.

Dismissing these concerns as bikeshedding about the name is missing the point.

- Eric
