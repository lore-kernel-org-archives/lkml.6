Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087CFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E34E214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IBx0Lwo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E34E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeIQKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:33:38 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51791 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeIQKdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:33:38 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2b004aa4;
        Mon, 17 Sep 2018 04:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=8IX3puEaO8HMfEuPmriwZlgYS0M=; b=IBx0Lw
        o/0ppYnfSuqe13H9FtngChB8PxSqOyJtVsZ/JIkoOeFu5h5k2nMtSwBWdBcobN85
        NBKPioQFQ9EHXGSJBE7+RUlxAsWgTo9KGq6l9ZHyFTlwCcHsqVB+BCxrq2GA0B0h
        ckRPIy1bJ7i1WR9q5mZojVT9lfmYJCg8DNTVUMrfPxVNmqW+Ekmuad7RW1Oh+/qe
        oxGD4zs5nepcX7wP7OIU1JV7QBHADvMjP5hW7JGvocDJW87nVQyQGQ7p6bW4BIkL
        Vefes4e+//hBwO8Vp5GiHs9Q33TjC+/K4zPvgHnnmm+9njUukwI8PvSc2UKfnrzl
        h82lNsooLlkmovIA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6e9d1cbf (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 04:50:31 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id n5-v6so9994956otl.5;
        Sun, 16 Sep 2018 22:07:55 -0700 (PDT)
X-Gm-Message-State: APzg51CSg3cBzOE77nobqUgn+JGhhAfl1GNdz5WX/WDWW/3+aW6u1fr5
        ImuSH49dz7OqiilTN/zJFi/xqXrUbYAx1qGimM0=
X-Google-Smtp-Source: ANB0VdYFhbwD1t7S7HEoRsFMo/xS0//oNk7VjpZqDnOT8IK+kIDn/Z7Bft7rpbCqjuNleMP9XGXKMaslc2BAdMRKE8M=
X-Received: by 2002:a9d:2dc8:: with SMTP id g66-v6mr11109829otb.311.1537160874064;
 Sun, 16 Sep 2018 22:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
In-Reply-To: <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 07:07:42 +0200
X-Gmail-Original-Message-ID: <CAHmME9ohGPTX-fkhP6zaWdx3SbkiqO5kWkWE-bDk=pm-nUqYvw@mail.gmail.com>
Message-ID: <CAHmME9ohGPTX-fkhP6zaWdx3SbkiqO5kWkWE-bDk=pm-nUqYvw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy,

Thanks a lot for your feedback.

On Mon, Sep 17, 2018 at 6:09 AM Andy Lutomirski <luto@kernel.org> wrote:
> 1. Zinc conflates the addition of a new API with the replacement of
> some algorithm implementations.  This is problematic.  Look at the
> recent benchmarks of ipsec before and after this series.  Apparently
> big packets get faster and small packets get slower.  It would be
> really nice to bisect the series to narrow down *where* the regression
> came from, but, as currently structured, you can't.
>
> The right way to do this is to rearrange the series.  First, the new
> Zinc APIs should be added, and they should be backed with the
> *existing* crypto code.  (If the code needs to be moved or copied to a
> new location, so be it.  The patch will be messy because somehow the
> Zinc API is going to have to dispatch to the arch-specific code, and
> the way that the crypto API handles it is not exactly friendly to this
> type of use.  So be it.)  Then another patch should switch the crypto
> API to use the Zinc interface.  That patch, *by itself*, can be
> benchmarked.  If it causes a regression for small ipsec packets, then
> it can be tracked down relatively easily.  Once this is all done, the
> actual crypto implementation can be changed, and that changed can be
> reviewed on its own merits.

That ipsec regression was less related to the implementation and more
related to calling kernel_fpu_begin() unnecessarily, something I've
now fixed. So I'm not sure that's such a good example. However, I can
try to implement Zinc over the existing assembly (Martin's and Ard's),
first, as you've described. This will be a pretty large amount of
work, but if you think it's worth it for the commit history, then I'll
do it.

> 2. The new Zinc crypto implementations look like they're brand new.  I
> realize that they have some history, some of them are derived from
> OpenSSL, etc, but none of this is really apparent in the patches
> themselves.

The whole point of going with these is that they _aren't_ brand new,
yet they are very fast. Eyeballs and fuzzer hours are important, and
AndyP's seems to get the most eyeballs and fuzzer hours, generally.

> it would be nice if
> the patches made it more clear how the code differs from its origin.
> At the very least, though, if the replacement of the crypto code were,
> as above, a patch that just replaced the crypto code, it would be much
> easier to review and benchmark intelligently.

You seem to have replied to the v3 thread, not the v4 thread. I've
already started to include lots of detail about the origins of the
code and [any] important differences in v4, and I'll continue to add
more detail for v5.

On <https://git.zx2c4.com/linux-dev/log/>, have a look at AndyP's x86_64 ones:
- zinc: ChaCha20 x86_64 implementation
- zinc: Poly1305 x86_64 implementation
For the arm/arm64 ones, the changes were even more trivial, so much so
that at Ard's urging, I included a cleaned-up diff inside the commit
message:
- zinc: ChaCha20 ARM and ARM64 implementations
- zinc: Poly1305 ARM and ARM64 implementations

How's that level of detail looking to you?

Thanks again for the review.

Regards,
Jason
