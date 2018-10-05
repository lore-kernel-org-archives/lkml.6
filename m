Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAFD2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="j0Z5EuuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAFD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeJEUpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:45:31 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39163 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbeJEUpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:45:31 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3b32fa45;
        Fri, 5 Oct 2018 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=EJG4bZbHY5tmk6y+1vXrhzNJV9g=; b=j0Z5Eu
        uNQXnHRgLZXw32k687lzPytM9qx/hIOWCP0aJx7ETZIfgaGP8A6oDnNaIkgSqtEc
        zW6PYq12py90FwL/wo5xI59y4JnlILdxQW1d3UezZTW5cW8WG4D/qwfrd9SRrFLE
        VMX8oxmtUvTaX2bPDzBbDA6KdD0EEo1Yf2bpZYUWwPg5oEYxSp4cOs5RZFhz0Zaz
        BsJc21fIR5uEw9tfBa0FlptSHFGoyRZdovbjn6K4y0FAxMhJT+KtatS2T8WNa8OR
        mo3hkJqQQQ2gLY5c0QdP2XFkcprboqHVoQjBrYZwWEpkihmrPQxnDMgwj30mTDJ1
        uv715omsASam2SeA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7c5ae6f3 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 5 Oct 2018 13:46:16 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id e17-v6so10424863oib.4;
        Fri, 05 Oct 2018 06:46:42 -0700 (PDT)
X-Gm-Message-State: ABuFfog93l2oV0FIv8crgKp78SvJqP6MUmXPCH8mMWbKMqgudputumL+
        +1vqGtizl7FQuL2a47azEbibaBrDQt3IfIrIhz8=
X-Google-Smtp-Source: ACcGV62bsWcWzmWikIwh8gLks64D2QpSlBRwQmTJsvfb55IvaD0mAinh+8GGVj7v4gfGvT0FftsCjMuQYoZOs0BWPY0=
X-Received: by 2002:aca:b256:: with SMTP id b83-v6mr5615550oif.235.1538747201002;
 Fri, 05 Oct 2018 06:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
 <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au> <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
 <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
 <CAHmME9r6-DHLwePQGBGcnPUZuZgZ2GtSUX9arsWzLqhKxd=uDA@mail.gmail.com>
 <20181003064951.GC745@sol.localdomain> <CAHmME9ogY=v2Le85+_=-m++RwAzwiUmKyNzx6N2y9Ht-J7xBcQ@mail.gmail.com>
 <CAFLxGvw154vyOziRKuFf5-XTa1NcQm5ZVmgUy3=F79k=Rw2dvA@mail.gmail.com>
In-Reply-To: <CAFLxGvw154vyOziRKuFf5-XTa1NcQm5ZVmgUy3=F79k=Rw2dvA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 5 Oct 2018 15:46:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9rdkAG6mvkUMy9J5+8U9BQkrym7WmmtmK6o3nudykWLoA@mail.gmail.com>
Message-ID: <CAHmME9rdkAG6mvkUMy9J5+8U9BQkrym7WmmtmK6o3nudykWLoA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 3:38 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> So we will have two competing crypo stacks in the kernel?
> Having a lightweight crypto API is a good thing but I really don't like the idea
> of having zinc parallel to the existing crypto stack.

No, as you've seen in this patchset, the dynamic dispatch crypto API
can trivially be done on top of Zinc. So each time we introduce a new
primitive to Zinc that's also in the dynamic dispatch API, we
reimplement the current crypto API in terms of Zinc. Check out the two
patches in this series that do this; it's quite clean and sleek.

> And I strongly vote that Herbert Xu shall remain the maintainer of the whole
> crypto system (including zinc!) in the kernel.

No, sorry, we intend to maintain the code we've written. But I am
amenable to taking a tree-route into upstream based on whatever makes
most sense with merge conflicts and such.
