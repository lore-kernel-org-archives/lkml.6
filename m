Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3660C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F122086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HkmV46y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfALS2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:28:19 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34049 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfALS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:28:18 -0500
Received: by mail-lj1-f182.google.com with SMTP id u89-v6so15681413lje.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLzhC0GOqv48+Y/0NICGksHP7CCBLPmIWy0Y4y29K20=;
        b=HkmV46y30xcApCMEfyyiM+DqCbxi6mGwBITj52TcNUuRJedUPTOz27bZ17eGgAa4bO
         r6XFroFjcU7i7L3qUmx9jFu0k0IFjtl7wV0675KrvsrUaZxV54sacZNtzylu3Jaybl3Y
         bLHsyavLfgH8LREVgkc5KSjrWessEDJNmHTe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLzhC0GOqv48+Y/0NICGksHP7CCBLPmIWy0Y4y29K20=;
        b=g5gjVbABHnZW7H1nyL4B5asSazVoWU1YVK9xULrCwC/B7oZNrlcMEsY53WuORzeRmM
         6/vU6jXVTvpsCbkZFh+Mnn/DGSEmP9kc21m3FzTuqK55aAUUhUzcx06lfS9gW0/s3HUP
         P7f0p2Yi/EWPnNgSqpN0rx4uUE4vEpnQfnWfEzSzpO7XJT089fE/TOwpocb6dLXmV7QY
         ssMkhfqert9iTQsh5k5TtZ8D+IUZrV2u3PorPWv4hH1ogix6BWA4zVuVluNIrYNTB6fZ
         FpeUphRTgWR0sErHtwAj+d9XmNdo1X0xNOp6MCpVpUhCaOzqquQl47OlMGKmNzulzdds
         hLdA==
X-Gm-Message-State: AJcUukeohe6tFTGblw44UyUzongXTfA5HlvBCppfhuX+TDJ7Z0YCd810
        XtS6luqPWQf72sV6ZDm5gftHaJuiGdM=
X-Google-Smtp-Source: ALg8bN5Dt8xP7uDEi8MqzO2g8NYFUWTuAc+yFuw48XvNm3jaIe3lH7T27Yz9TGfSyeMhZIUgvHS2fg==
X-Received: by 2002:a2e:6f11:: with SMTP id k17-v6mr10742948ljc.94.1547317696234;
        Sat, 12 Jan 2019 10:28:16 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id e97-v6sm16595425lji.51.2019.01.12.10.28.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 10:28:15 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id s5-v6so15621491ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:28:15 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr12012194ljk.80.1547317694876;
 Sat, 12 Jan 2019 10:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20190112181355.GA31454@infradead.org>
In-Reply-To: <20190112181355.GA31454@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Jan 2019 10:27:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
Message-ID: <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
Subject: Re: [GIT PULL] remove dma_zalloc_coherent
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 10:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Lets see if this works better as a pull request than the
> plain patches:

So I'm still debating this myself, which is why I haven't reacted.

The reason I'm not entirely sure this makes sense is that not every
user actually mmaps things into user space.

And now if somebody for some reason doesn't want the overhead, there
is really *no* way to say that.

Maybe nobody cares. But from what I can tell, the mmap case is
actually really quite rare (well, at least the regular
"dma_mmap_attrs/coherent()" kind).

I'd be happier if there at least was an interface to specify "yes, I
want zeroing". But there isn't. You did not, for example, just make
__GFP_ZERO work. No. You just said "GFP_ZERO hasn't worked reliably,
so we had that other interface, and now we're doing it
unconditionally, so we can remove the other interface".

This all *despite* the fact that as far as I can tell, 95% of the
users don't actually need or care about zeroing and don't really want
it.

So explain that.

              Linus
