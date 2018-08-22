Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FD7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DCB20936
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FB+sJMgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DCB20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeHVXlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:41:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50551 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeHVXlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:41:22 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so4548560ite.0;
        Wed, 22 Aug 2018 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80hEiIm5FFXWZyLkSgSMVxDMC8q3as/sO/JTbOfd4So=;
        b=FB+sJMgXz6w1/a/r5Yw1Fwr3FB+pdMRl3ALT/Ds1ILvWNdcUEsBFcHEgrF69xJL5Vk
         O7L9WhJJ1C615u5eqEKBfkCAbWIvAj/o/aFFTe/ZcSsP+WuCxL03BCwa5ox3T5lvjtwi
         +0lcbqqEFs6ilZJdgAXGHjhRfiNvBgEPzmGnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80hEiIm5FFXWZyLkSgSMVxDMC8q3as/sO/JTbOfd4So=;
        b=ePJaZWibk4qyJq3MyUl6YHYv3gw3oXi26zYd5JKOcXjSgJyrOev4OzeljXY7radfSK
         TDEdBrHEUK9XhkP4d1RZYdESNzGHwgZbWs5GxT0LtRkC4cHF4vZrkPk24s1aXOiHtGNq
         CS3Mu6hpm1V4V8Uebv2JK46fBY88TvUpp3k7Ef1M//qYUYocMMSlFDqYRkxU78FTCWQw
         sg7x13ecCNGu7LE5qfasFs/urB22TmG2T0QeQ7o6a+uz8ZFK6LT4HNK4B3xtO/pca8r3
         JimTx2ASGLvAsqCdQfqsdDg/1+FpGoRU1bGYtH/w11dQAVuB/GyegYivtINq4pX1MFV4
         T3lw==
X-Gm-Message-State: APzg51A0Y2NS9P9e17f8tXqMd6IpboPTjxsxTAdd++LDi4wAARsgMEeE
        1x3k4T2q3FLmfpzCppHGCIZnaRkdRu9XVyEvNON0eg==
X-Google-Smtp-Source: ANB0VdY32BnkY8ZZ2CCxOU+myZIOsG+zATFDwAargrb9Zo64m3t/ruySxZVObQjAg5Q8yOMXSTn0Ve7u1cfqDq0iYCQ=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr4814130itq.9.1534968903233;
 Wed, 22 Aug 2018 13:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180822085522.GA14354@veci.piliscsaba.redhat.com>
 <CA+55aFzd53LwrBfvdtKx7e_bQPhzsKEvCME1rGbrrY4pG94d=Q@mail.gmail.com> <CAJfpegsZUxZXQSHZoy0=9iqB6jRL0ZOtFGnSqT4FrzT8K2mcbQ@mail.gmail.com>
In-Reply-To: <CAJfpegsZUxZXQSHZoy0=9iqB6jRL0ZOtFGnSqT4FrzT8K2mcbQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 13:14:51 -0700
Message-ID: <CA+55aFzMv5rkRJs2Xu4L3aAQM6UWSAFhHJhXECyquaW4+BXwBQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: set I_CREATING on inode being created
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:58 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > So I'd like some clarification on this point before applying it. It's
> > possible that the spinlock is required, I just want to understand why.
>
> I added the spinlock, because it's cheap (new_inode() already pulls it
> into L1 cache) and because it's much harder to prove that lockless one
> is correct than just adding that locking.

Ok, thanks, looks good to me. And looking around, I think it matches
most of the other cases of us setting those I_NEW and I_CREATING
flags, so I guess it's good from a consistency standpoint too.

I just wanted that clarified, but I'll just apply the patch directly.

Thanks,

             Linus
