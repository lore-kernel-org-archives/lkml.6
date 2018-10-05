Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD071C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750842087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750842087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeJEUwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:52:00 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58654 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJEUwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:52:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A8BEC60A3578;
        Fri,  5 Oct 2018 15:53:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wMTqvY68N0wF; Fri,  5 Oct 2018 15:53:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 674C160A357F;
        Fri,  5 Oct 2018 15:53:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RstBbJB_xAbx; Fri,  5 Oct 2018 15:53:08 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EE2A360A3578;
        Fri,  5 Oct 2018 15:53:07 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
Date:   Fri, 05 Oct 2018 15:53:07 +0200
Message-ID: <7854782.OKhPC64esT@blindfold>
In-Reply-To: <CAHmME9rdkAG6mvkUMy9J5+8U9BQkrym7WmmtmK6o3nudykWLoA@mail.gmail.com>
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com> <CAFLxGvw154vyOziRKuFf5-XTa1NcQm5ZVmgUy3=F79k=Rw2dvA@mail.gmail.com> <CAHmME9rdkAG6mvkUMy9J5+8U9BQkrym7WmmtmK6o3nudykWLoA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. Oktober 2018, 15:46:29 CEST schrieb Jason A. Donenfeld:
> On Fri, Oct 5, 2018 at 3:38 PM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> > So we will have two competing crypo stacks in the kernel?
> > Having a lightweight crypto API is a good thing but I really don't like the idea
> > of having zinc parallel to the existing crypto stack.
> 
> No, as you've seen in this patchset, the dynamic dispatch crypto API
> can trivially be done on top of Zinc. So each time we introduce a new
> primitive to Zinc that's also in the dynamic dispatch API, we
> reimplement the current crypto API in terms of Zinc. Check out the two
> patches in this series that do this; it's quite clean and sleek.

This is why I was asking. Your statement and the code didn't match for me.
 
> > And I strongly vote that Herbert Xu shall remain the maintainer of the whole
> > crypto system (including zinc!) in the kernel.
> 
> No, sorry, we intend to maintain the code we've written. But I am
> amenable to taking a tree-route into upstream based on whatever makes
> most sense with merge conflicts and such.
 
So, you will be a sub-maintainer below Herbert's crypto, that's fine.
What you wrote sounded like a parallel world...

Thanks,
//richard


