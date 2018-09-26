Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445A12150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="z0USmq6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445A12150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeIZX0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:26:31 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34193 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbeIZX0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:26:30 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4bfb2d7c;
        Wed, 26 Sep 2018 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=hTUiKdFMVh/amkT/1sXgdSl9sGw=; b=z0USmq
        6u8QsQdRjz6x+oJb6f9nPk9SC2XRKU84HZFI/aREwIxvMRhb/wJowm5PyPniBsQM
        CwFrReMZjd+6hsbL3/M2H3isnCclqcNVhRnDGkH+Q/ab7Tho3eu8Vz7lyqwOmy8Y
        huWR9Vj4UewqSYXMX/7ku1AHlcopxahMQHXMBAHLud2mPoUfwCNWpmtOcqIAT1xt
        uGvsqwU37XH/Gju+jv0ZKn0yyO6kFZcdAVR/NV3eFKstZ3ex4z9Z0pk6dhq8W+Ht
        dRg8mdeuwVnWb3166InWUP8GW+cE78oc9cxGWUEmTIKZPHCKvV55/RgvhKoaYLg+
        HLZp71PcqNUp7Lrg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 526f4d69 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 16:53:59 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id e18-v6so28914541oti.8;
        Wed, 26 Sep 2018 10:12:32 -0700 (PDT)
X-Gm-Message-State: ABuFfoiZ0y99hTbt+1tegT3T/0FzswsZ0iqb8oTESY65M4/trBENlw8d
        9LAPnYtWhyaksR2xj+2IXJNhjslqW2Lu2eZs7mk=
X-Google-Smtp-Source: ACcGV62YTE/BFwxSzb/9n3OKXwQuc7hGVj+aGW7w+6e97exgDMMknSKWneCz2nsusFE/tn348KbWiwwVNloXJ7wGhHk=
X-Received: by 2002:a9d:48a8:: with SMTP id d37-v6mr5094459otf.384.1537981651283;
 Wed, 26 Sep 2018 10:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com> <CAKv+Gu9hOW0pOjDjrvg1q-v85aiwSZRnjivnvRTCwxMdph4j7g@mail.gmail.com>
In-Reply-To: <CAKv+Gu9hOW0pOjDjrvg1q-v85aiwSZRnjivnvRTCwxMdph4j7g@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 19:07:19 +0200
X-Gmail-Original-Message-ID: <CAHmME9o4usa8TDPA0=mHY-8ijQNVc-jH4UMU-EZuSK2wqaieKQ@mail.gmail.com>
Message-ID: <CAHmME9o4usa8TDPA0=mHY-8ijQNVc-jH4UMU-EZuSK2wqaieKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 6:55 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Framing it as /needless/ complexity does not help at all. The changes
> you are proposing are very useful, but nobody wants two crypto
> subsystems with two different maintainers in the kernel, so I would
> like to understand where this is going in the future. I am not saying
> it should block these patches though.

Thanks for clarifying. I understood you to be intending to block the
patches until they were converted to an async interface, which is not
what Zinc's about. Seeing as you're just curious about future
directions, that seems much more tenable.

> Also, I have spent a *lot* of time looking at your code, and trying to
> make it better, especially for use cases that weren't on your radar to
> begin with

I am extremely grateful for a good portion of your reviews indeed. As
I mentioned earlier, much is very useful. But in other places, I fear
you're steering this in a direction I really am hesitant to go.

> (e.g., 'pet projects' [your words]

Taken out of context.

> consideration for other aspects of kernel programming, e.g.,
> preemption under -rt, stack size constraints, coding style, importing
> code from other projects etc.

And indeed all of these concerns I've been pretty amenable to, and
continue to do so. What I'm commenting on are things outside of these.


> - please try to be less dismissive of
> feedback first time around, but try to understand why people are
> raising these issues

Apologies, and duly noted. I'll give you the benefit of the doubt.

Jason
