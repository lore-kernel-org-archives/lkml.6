Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB4AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D5621571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h951CBQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D5621571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeI0ViX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:38:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:53713 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbeI0ViX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:38:23 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c4a546ee;
        Thu, 27 Sep 2018 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=iLnXO5fKnraQ
        ngk0pcl0LLQQ7Dw=; b=h951CBQgdTG1Qz1B1v05Kw8da0/imuUTbCtTjmuQsvpL
        Fer3u31q8/iJ6MLTdlCNefFvMaRPgr8ydW4ikyBblmub8StDLRQoTOCbqdS5gZs1
        4ZEpBy5Y3fSv9GuFvBBUueMUBua7hP2sAeTAvDeinvUWJE61WiMvlc5njROaq2VS
        ek6QsLxcpMwRB0j3I4I6GJ+ppGOyIUaULGOmDuEfNQ63qsrYNtLSuphUyGNAUq5o
        9NU6nUS0AVNVYMWNQ0yMwMoaET07l6MDD71YnIc1zgACpUNGINLbIEz7Tr4i+7W9
        KHjrPsUYlHKUuftQhCrr1CiI0XszUJplr5BO0opRBw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 964dab80 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 27 Sep 2018 15:00:52 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id h26-v6so2900838otl.9;
        Thu, 27 Sep 2018 08:19:33 -0700 (PDT)
X-Gm-Message-State: ABuFfohnBOYWeQcLX2jc5O0Z5+F+URxUDGe0PLBSuAYeI+9zXlfAv+Bv
        BvhjANfaSk8piJ2dWJEJZEXQJheoxY+sEQ54p8U=
X-Google-Smtp-Source: ACcGV60NFHi4hnOAy0ejGJPdEr5llf3SakWSwNYVyGmstRzJBqsu5Hmin78iwZ1ywUmVF7NXK35DNpNxvgh1LZQYDF4=
X-Received: by 2002:a9d:309d:: with SMTP id s29-v6mr7603737otc.144.1538061572188;
 Thu, 27 Sep 2018 08:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
 <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
 <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com>
 <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com>
 <CAHmME9qNn5aRgtbV3bAsz3xW1A49a7RMMkOzGruBUPzLVUxVNg@mail.gmail.com> <CAHmME9rN3-7Mj5JQqt2EFPauG9vjkN5pQn3tPiJY4fPiwksaDA@mail.gmail.com>
In-Reply-To: <CAHmME9rN3-7Mj5JQqt2EFPauG9vjkN5pQn3tPiJY4fPiwksaDA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 27 Sep 2018 17:19:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9pBRu4hC5=Ef62R_nWOi3jTegxvxNrR8qDM+VfO=2t8Tg@mail.gmail.com>
Message-ID: <CAHmME9pBRu4hC5=Ef62R_nWOi3jTegxvxNrR8qDM+VfO=2t8Tg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again Thomas,

On Thu, Sep 27, 2018 at 3:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Thomas,
>
> I'm trying to optimize this for crypto performance while still taking
> into account preemption concerns. I'm having a bit of trouble figuring
> out a way to determine numerically what the upper bounds for this
> stuff looks like. I'm sure I could pick a pretty sane number that's
> arguably okay -- and way under the limit -- but I still am interested
> in determining what that limit actually is. I was hoping there'd be a
> debugging option called, "warn if preemption is disabled for too
> long", or something, but I couldn't find anything like that. I'm also
> not quite sure what the latency limits are, to just compute this with
> a formula. Essentially what I'm trying to determine is:
>
> preempt_disable();
> asm volatile(".fill N, 1, 0x90;");
> preempt_enable();
>
> What is the maximum value of N for which the above is okay? What
> technique would you generally use in measuring this?
>
> Thanks,
> Jason

From talking to Peter (now CC'd) on IRC, it sounds like what you're
mostly interested in is clocktime latency on reasonable hardware, with
a goal of around ~20=C2=B5s as a maximum upper bound? I don't expect to get
anywhere near this value at all, but if you can confirm that's a
decent ballpark, it would make for some interesting calculations.

Regards,
Jason
