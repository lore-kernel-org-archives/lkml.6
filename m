Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A280C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052A921530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGzxmT5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052A921530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeIZXJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:09:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45593 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbeIZXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:09:00 -0400
Received: by mail-io1-f65.google.com with SMTP id e12-v6so23801959iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXd1QzH0K2rVvZr9uVGOOi3qH9xV0eECvZDFRLRN5vM=;
        b=XGzxmT5wiSoDQfWsO6rgBYqayADwaQ1gGmVjjWErj5LLFN74FKuF5MQkbUYmsPeT3q
         kIMCoT1BBeOXlsi1fW4FA6Yr7D7FRLOnb8cgywPXVEf3HS/437j4scdFfsUUJ0EKXav3
         D05Q9ZjwG7XucxhwW4PY24dezIO1dWlJLsRqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXd1QzH0K2rVvZr9uVGOOi3qH9xV0eECvZDFRLRN5vM=;
        b=fiH5oanV6FrjYO6Hb1XGbaC4fW/0uMQNqSqh1EYztdpXFIVWDPAdL2vSfocbp1xduL
         MuGh8JrV/NuS+nS31Z7XVYVRLHsu5PFoKIJ8plYUNMQTCqeToIYcbjnb65NHFVZshEm/
         xif5p8HU8KPK170++EhnDGjI8kkARY72X0k64QJBAyMvtIZYG9Nz92TCgfOQTqKzyIso
         6cbrjM6UP44XThzkuayBSKXIzCKgs8nB9XYaglXULZ+RZQoQGuzarLYnVXr1MoA0o8ba
         w6WLqVh5AKAJOlf+IKVWbc0+5hx+7S3ykkXozA5uKmhxW4UNEqoMM3r0V2zocga0E2Fv
         TvGA==
X-Gm-Message-State: ABuFfojaNYxaZGbrrDdNlgh9ueRDDXeUDZnsdYMPF6wDquFDwKxE1W50
        mzbp0/+M8jTIwwSyEDTZ7nyI+rC62VRaCd0JMcggGA==
X-Google-Smtp-Source: ACcGV62+12GVsukWYkiZtkJZeCtgN6zd1ymSutlSAIE+JSTC0ojKjGj6EagSGS0PtXaar16jVqXpT+vFJvCWbpSTzrY=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr5679564iob.170.1537980909696;
 Wed, 26 Sep 2018 09:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com> <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com>
In-Reply-To: <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Sep 2018 18:54:56 +0200
Message-ID: <CAKv+Gu9hOW0pOjDjrvg1q-v85aiwSZRnjivnvRTCwxMdph4j7g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 at 17:41, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Sep 26, 2018 at 4:02 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > I don't think it makes sense to keep
> > it simple now and add the complexity later (and the same concern
> > applies to async support btw).
>
> Ugh, no. I don't want to add needless complexity, period. Zinc is
> synchronous, not asynchronous. It provides software implementations.
> That's what it does. While many of your reviews have been useful, many
> of your comments indicate some desire to change and mold the purpose
> and focus of Zinc away from Zinc's intents. Stop that. It's not going
> to become a bloated mess of "things Ard wanted and quipped about on
> LKML." Things like these only serve to filibuster the patchset
> indefinitely. But maybe that's what you'd like all along? Hard to
> tell, honestly. So, no, sorry, Zinc isn't gaining an async interface
> right now.

Framing it as /needless/ complexity does not help at all. The changes
you are proposing are very useful, but nobody wants two crypto
subsystems with two different maintainers in the kernel, so I would
like to understand where this is going in the future. I am not saying
it should block these patches though.

Also, I have spent a *lot* of time looking at your code, and trying to
make it better, especially for use cases that weren't on your radar to
begin with (e.g., 'pet projects' [your words] like the Cortex-A7 which
will be in almost every new 32-bit Android phone). So characterizing
my feedback as some kind of sabotage is not very productive either.

Contrary to what you seem to think, I am not deeply invested in the
crypto API. What I do care about is that the ARM crypto pieces in the
kernel are maintained, supported and improved by someone who
understands the use cases Linaro's members care about, and is willing
to make an effort to gain such understanding if he doesn't. I have no
doubt that your involvement in the kernel's crypto subsystem will have
a significant positive impact when it comes to code quality,
robustness and usability. I'd just like to see a bit more
consideration for other aspects of kernel programming, e.g.,
preemption under -rt, stack size constraints, coding style, importing
code from other projects etc. - please try to be less dismissive of
feedback first time around, but try to understand why people are
raising these issues; I'm sure you will appreciate it when future
contributors to zinc will do the same.
