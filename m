Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B191DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE68208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fw1YuDvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE68208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbeHWRmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:42:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52335 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbeHWRmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:42:25 -0400
Received: by mail-it0-f66.google.com with SMTP id g18-v6so2433387itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eMDySztM5izmmLvYLP3Rg2VOoWkNHVUHpv4GzYZldEQ=;
        b=Fw1YuDvuvp869TmvQNT97eMRwZEAWeavzhML817mAlIM75vvrKwXxRosvk1xImqeZk
         eABLJaw4jMNfXRE8nuR9CopzNzIjx4/pbPR23n3RftUomaU28FbkPWlgz+18UiER5xNJ
         a2IBjmbjTbquSee3m2oyhbAU1iXsRQ6io9iHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eMDySztM5izmmLvYLP3Rg2VOoWkNHVUHpv4GzYZldEQ=;
        b=oT5HIo6eiewNfNup8U8qeprYpJS9zJT2cb3fdCsKpQhK5k5gXV8Kf74CFk+9IPCWQO
         Gc1mnkV/lyN81LFZiQHCS5HOiWhhM/IRpNel7qcQ04CIvrT0KiLmHUG4OqtgKdhGjBaJ
         OufcL+oPV4FuXm9whmNO16KhffwVcomEJX/0KqXbJnXY9Ge8sl4aR1lriBBFbZHz0TD2
         CfnrKkWXnF4Cdgdv0KzY6PMG3zwcowo8n/eyFt54b3b5PF+yIXqRral7IBWorQ5Cfbvn
         QKuNxu68V513SJIUjs9ZpHy53b5NS/cfzSXEgiPwBlkIAAfSjt/RCNsHrX37WOYJgVxr
         LeQQ==
X-Gm-Message-State: APzg51BJ3lnK/k0n18VDRShZjAARzNna5GiHx8EfjG65CPfaWx/ODbjm
        YtOAzFmvTqyqz13NAe8UqRfzeh+DHR0I9z4CG8+ZDW2/yBk=
X-Google-Smtp-Source: ANB0VdacTLB0zBc/gp5BDcP5jud4geaIwTTg4aVFEvksrXoAhP23R3OQ1MofYEx71C5Lz8dHnA/qg4/lR1RvhwxtdKo=
X-Received: by 2002:a24:33c1:: with SMTP id k184-v6mr6873118itk.76.1535033552976;
 Thu, 23 Aug 2018 07:12:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3541:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 07:12:32
 -0700 (PDT)
In-Reply-To: <CAL_Jsq+ppQP9icJVhpUYGj_JCyxudi0Z4=+mKiBueMKZftrQ7A@mail.gmail.com>
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com>
 <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
 <CAJe_ZhdZbUa2njAvSazGzv+7UgG+QHCTS+-Y-Ckqze+pMf9KQA@mail.gmail.com>
 <CAK7LNAT3MufLZhFB8HDnch09WUdEcLyDCU05dTYroOwWYcx=pQ@mail.gmail.com>
 <CAJe_ZheNp9t0DNQjmiQKMyZsbHBjMxqV87mE_3nQ1N_RS9znYQ@mail.gmail.com> <CAL_Jsq+ppQP9icJVhpUYGj_JCyxudi0Z4=+mKiBueMKZftrQ7A@mail.gmail.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Thu, 23 Aug 2018 19:42:32 +0530
Message-ID: <CAJe_Zhee-qQtAt7+k_LZ+CGabLBr3v3t2MYvbVYG9N1nHZcL=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vinod <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 18:51, Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Aug 23, 2018 at 12:38 AM Jassi Brar <jaswinder.singh@linaro.org> wrote:
>> On 23 August 2018 at 10:48, Masahiro Yamada

>> >
>> > If desired, I will export of_irq_count()
>> > and use it from my driver.
>> >
>> If you don't want to leave too much footprint, you could do
>>
>>   count = 0;
>>   while (of_irq_parse_one(dev, count, &irq) == 0) count++
>>
>> of_irq_parse_one() is already exported.
>
> Yes, but we really don't more users and drivers shouldn't be using it.
> Grepping DT functions and when the only users are pretty much powerpc,
> that's a good indication not to use the function.
>
> And you don't want to use of_irq_count either. platform_irq_count is
> what should be used here. It's already exported.
>
Thanks, platform_irq_count() is definitely better.

Yamada-san, for example, gpio-tegra.c infers the number of banks from
platform_irq_count() rather than the 'gpio-banks' property.
