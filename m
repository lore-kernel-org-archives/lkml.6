Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 224B1C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41F02084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9hd4Hmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41F02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934763AbeFLXQJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:16:09 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43782 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934322AbeFLXQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:16:07 -0400
Received: by mail-vk0-f65.google.com with SMTP id d74-v6so406977vke.10;
        Tue, 12 Jun 2018 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K4sg31/j6WPgARkwoSjw8kZeg2YNHtVo4FHFBr2KFwc=;
        b=Z9hd4HmnfDqSA9m7SxeZXdmDUb7Ne+gIGfKiJaWU9HRUHJsxIj8kDzOLa9REm/lcMC
         1HGd5X5qVlHLjcQdoUHunxWVO9aOBmPuzKrVyq9/Qj+8f1rh++A4KCUUPLV3+htTACE/
         /X0XSRVZPchoF1WXwJePwdVlkXpqu3jAKWPT5JHAxTYg/tbWVNGTt9J3z8Zuq/mLGhWJ
         TH2eYVw0/8OrIg95B1t8dmmozQNtnp9Du5roZXi1xSU73pWLlEruEaDCn92H3PqXA2rr
         UJNw06KRlhcbW4kmsz5CF9S2Q2XzUr7Y8TGKHPTQ8CrkaTAGdhsQ+i2V6o9hgitGriwD
         c83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K4sg31/j6WPgARkwoSjw8kZeg2YNHtVo4FHFBr2KFwc=;
        b=HF5ZVeOO9kk5ReDaCjHLzmo9yqBCfR6lRY+rzjdYyz9Q7+9YYjiqvQu1+YLYgfWViL
         MtWb11G8+cwp7mR6Qg7Me4Dhl8vHNCgGeCCAShUSZcr9t1ySvmfjHtXHTOwMskoISuK1
         h0kIFCON7qhFhYmB+KIfuzRvAdgpSE8+KpBMO6K1y17mu0NPC3euJYy03VxL/MNBsi2E
         TW9rWNbX9GGGt5N7V86ZAn09h/z6RaX2P61n5B6iVLw5n5y9z2MQsXkmj1kJXr6Dnzvi
         EncqxMNEZJ0UyoWSqoXW2JGQYLTuLXSCUU1ljh4VkSeTXAYYPJzrbTWRQeXhmX5qgRac
         PdAA==
X-Gm-Message-State: APt69E2laFyA7NCrQ9LpoZBipeBsierWnqRAhXKaqzpo9HOZhXBiSr63
        +9V9rTkLk36T1dSC4c1WM7qN8usGJ5WC6Lx9acGvKpti
X-Google-Smtp-Source: ADUXVKKnl0xLVxVc6SUkuYjXE8z34o+hWunVQbdaYCaboAs221ajFgnvPLEE3tIhQJSNrCz9nQx77uPvRnGl/Nr537Q=
X-Received: by 2002:a1f:7283:: with SMTP id n125-v6mr1610981vkc.26.1528845367076;
 Tue, 12 Jun 2018 16:16:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 16:16:05
 -0700 (PDT)
In-Reply-To: <5d932502d9985cdfa6540480ea5ce6b0730502a1.camel@kernel.crashing.org>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
 <CAHp75VfJNrviiiam9p49+6_oSjW+YH8vwjcZ2hn5Ux5mHgDCQw@mail.gmail.com>
 <53ef03b26a17738dc1465ce85562c9611ad415f8.camel@kernel.crashing.org>
 <CAHp75Vcdaejn=eq740YNdscSv9zX9xj3RzYp=AFs8HFprw34_Q@mail.gmail.com> <5d932502d9985cdfa6540480ea5ce6b0730502a1.camel@kernel.crashing.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 02:16:05 +0300
Message-ID: <CAHp75VfV7actoXkMUbh9KwAXR1FKR_VZ5RAuaL-pKLSynFi-3g@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 1:58 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2018-06-12 at 19:53 +0300, Andy Shevchenko wrote:
>>
>> > > It feels like a wrong approach.
>> > > Can OF graph help here? Would it be better approach?
>> >
>> > I don't quite understand what your objection is nor what "OF graph"
>> > is...
>>
>> There is no objection per se, just a doubt that this is a right thing to do.
>> I might be wrong, of course.
>>
>> OF graph nodes is a special API that allows you to access like you
>> said "different node of device-tree".
>> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/graph.txt
>
> So I had a look and this is just an example on how to use phandles to
> link ports and endpoints... I fail to see how that relates to what this
> patch does.

Because your patch does nothing except another layring of the existing APIs.

> In the driver I'm doing for example, I do use a similar technique to
> "point" to the other node. In this case, this is a coprocessor in the
> SoC and I'm linking to the node that represent its interrupt controller
> (and its not a full fledged OS running there so we don't have a full
> interrupt tree for it).

Hmm... So, you are trying to solve problem with other methods which
might be not so suitable at all?

-- 
With Best Regards,
Andy Shevchenko
