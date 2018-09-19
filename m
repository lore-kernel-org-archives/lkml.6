Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAD8ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F672146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GOjQt/b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F672146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeISHKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:10:51 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57393 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISHKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:10:51 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ac3a7128;
        Wed, 19 Sep 2018 01:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=qxSYIB8kvk/svqK+vY4LbZJN/qQ=; b=GOjQt/
        b6fdhhjD0g4l6PFihsIzVWP8F2DuYebmlm5Sw1NS6y833pWTbQq7h9nXp4dCiCs1
        Y5W57kc19IfiwuP0I1LZsoqgQ76WXSv+QpDe6n78N6TG50t8hJkguI0HJxQ7cRo2
        TRFGiIWMorwhgleDkLcaYbndYUE1oRGO3ev3ocAO7jqDkyVHotF0oT21etvnhIuB
        bLGdIi8VeBG0P4l6G1hM1r1w9Hsj0nexjqbTUT+bnd452rrFQD6RSeWxOeRsrH/w
        n/yvZUbj206i4YyFecKey8eXAH5VDDJ8IceiXEjvwAaW9qsZdC0i8q8wM+AnxBRT
        FDAFgWUeEKXGmLbg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6118351e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 01:17:50 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id i10-v6so4105103oth.0;
        Tue, 18 Sep 2018 18:35:27 -0700 (PDT)
X-Gm-Message-State: APzg51Bx/XvDFjVBpH4KIASubuzQdhLWJi09OdBtX1LhSyK9RzlpsrW4
        FZhfLmwaJbM2Xse3iqXZScP26Plwg0gU8juwI9s=
X-Google-Smtp-Source: ANB0VdZbIfyFRNzYjgSju9+ufzgPmKRK/XmLHj4jsh/e/oNTAinvKHOy4wbyvg0dfacqWp8MRjC3rQPW+xd2/el0Ybo=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr16431518oth.250.1537320926773;
 Tue, 18 Sep 2018 18:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-8-Jason@zx2c4.com>
 <20180919005054.GC74746@gmail.com>
In-Reply-To: <20180919005054.GC74746@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 03:35:15 +0200
X-Gmail-Original-Message-ID: <CAHmME9oL98adRp6xXqaXxA0E4Oa4ecPW+JHChCS3hTgH7RLPjA@mail.gmail.com>
Message-ID: <CAHmME9oL98adRp6xXqaXxA0E4Oa4ecPW+JHChCS3hTgH7RLPjA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/20] zinc: Poly1305 generic C
 implementations and selftest
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 2:50 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Hardcoding the 'input' array to 600 bytes forces the full amount of space to be
> reserved in the kernel image for every test vector.  Also, if anyone adds a
> longer test vector they will need to remember to increase the value.
>
> It should be a const pointer instead, like the test vectors in crypto/testmgr.h.

I know. The agony. This has been really annoying me. I originally did
it the right way, but removed it last week, when I noticed that gcc
failed to put it in the initconst section:

https://git.zx2c4.com/WireGuard/commit/?id=f4698d20f13946afc6ce99e98685ba3f9adc4474

Even changing the (u8[]){ ... } into a (const u8[]){ ... } or even
into a const string literal does not do the trick. It makes it into
the constant data section with const, but it does not make it into the
initconst section. What a bummer.

I went asking about this on the gcc mailing list, to see if there was
just some aspect of C that I had overlooked:
https://gcc.gnu.org/ml/gcc/2018-09/msg00043.html So far, it looks like
we're SOL. I could probably make some macros to do this in a .S file
but... that's pretty unacceptably gross. Or I could define lots and
lots of variables in __initconst, and then connect them all together
at the end, but that's pretty gross too. Or I could have all this data
in one variable and record offsets into it, but that's even more
atrocious.

So I think it comes down to these two non-ugly options:
- We use fixed sized buffers, waste a lot of space, and be happy that
it's cleared from memory immediately after init/insertion anyway, so
it's not actually wasting ram.
- We use const string literals / constant compound literals, save
space on disk, but not benefit from having it cleared from memory
after init/insertion.

Of these, which would you prefer? I can see the argument both ways,
but in the end opted for the first. Or perhaps you have a better third
option?

Jason
