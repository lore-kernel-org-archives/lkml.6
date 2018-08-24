Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32736C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A7E21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AGXBdd0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A7E21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeHXFIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:08:10 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:49459 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHXFIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:08:09 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7O1ZU4M023765;
        Fri, 24 Aug 2018 10:35:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7O1ZU4M023765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535074531;
        bh=LsisJ6PKCjwyiOQOsB1LLBGBfli/YK7/4ZNDSoCIPTs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=AGXBdd0eXWQ+HswCPENZeTRadzRsLA7nH5bgOYceaAnLWVl1pUp8yiiJDs9CsisC2
         HROBN+8w0UcLuq1RcXEailUQrZR2RN6F2eXyKzuQetkhhgFmaoLiBJyVu4DicT8fc+
         e2fFwdZz2/5OFNa6NJFzYvTef9wuRO03ehKQK6ZTcsNQZLZu11LXUDGj7vWtVhsBkG
         Q+j9MDB0Ah6pdOjmLRTHa1k4dS+gv/quN094LP7I26vGzLc1PjQwhXhAQ7KQ4jt+SI
         QyK5W60QBM4Gaow/diE64HI7k/byJZIm3hNPCw5cZw76yTGCsfbvAuDbXlWDwwkon7
         ZA45w0JU3b8dA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id i4-v6so4446455uak.0;
        Thu, 23 Aug 2018 18:35:31 -0700 (PDT)
X-Gm-Message-State: AOUpUlHkxsDzL509ak/iEOx7/vBUnyLqREf3OyeqP4tyAy7zMTusGn8i
        MBwm0ADVGJCjDejJZxfSXMt7bA84Q1oS3I1zT4E=
X-Google-Smtp-Source: AA+uWPxXNDIXJ+HIrB7/UvigP4KPgW2E2qqktR5rcLx4a/wsfb9gDXILiI5snlUMx4s/X6+R7Q/CRIbxDDW6qpozAyM=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr41290037uag.16.1535074529990;
 Thu, 23 Aug 2018 18:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 18:34:49
 -0700 (PDT)
In-Reply-To: <CAJe_Zhee-qQtAt7+k_LZ+CGabLBr3v3t2MYvbVYG9N1nHZcL=g@mail.gmail.com>
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com>
 <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
 <CAJe_ZhdZbUa2njAvSazGzv+7UgG+QHCTS+-Y-Ckqze+pMf9KQA@mail.gmail.com>
 <CAK7LNAT3MufLZhFB8HDnch09WUdEcLyDCU05dTYroOwWYcx=pQ@mail.gmail.com>
 <CAJe_ZheNp9t0DNQjmiQKMyZsbHBjMxqV87mE_3nQ1N_RS9znYQ@mail.gmail.com>
 <CAL_Jsq+ppQP9icJVhpUYGj_JCyxudi0Z4=+mKiBueMKZftrQ7A@mail.gmail.com> <CAJe_Zhee-qQtAt7+k_LZ+CGabLBr3v3t2MYvbVYG9N1nHZcL=g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 24 Aug 2018 10:34:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDULBeDdydetMLQXauvV7KBe8a5QXUXy=-GKkTyWkfbQ@mail.gmail.com>
Message-ID: <CAK7LNASDULBeDdydetMLQXauvV7KBe8a5QXUXy=-GKkTyWkfbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vinod <vkoul@kernel.org>,
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

Hi Rob, Jassi,


2018-08-23 23:12 GMT+09:00 Jassi Brar <jaswinder.singh@linaro.org>:
> On 23 August 2018 at 18:51, Rob Herring <robh+dt@kernel.org> wrote:
>> On Thu, Aug 23, 2018 at 12:38 AM Jassi Brar <jaswinder.singh@linaro.org> wrote:
>>> On 23 August 2018 at 10:48, Masahiro Yamada
>
>>> >
>>> > If desired, I will export of_irq_count()
>>> > and use it from my driver.
>>> >
>>> If you don't want to leave too much footprint, you could do
>>>
>>>   count = 0;
>>>   while (of_irq_parse_one(dev, count, &irq) == 0) count++
>>>
>>> of_irq_parse_one() is already exported.
>>
>> Yes, but we really don't more users and drivers shouldn't be using it.
>> Grepping DT functions and when the only users are pretty much powerpc,
>> that's a good indication not to use the function.
>>
>> And you don't want to use of_irq_count either. platform_irq_count is
>> what should be used here. It's already exported.
>>
> Thanks, platform_irq_count() is definitely better.
>
> Yamada-san, for example, gpio-tegra.c infers the number of banks from
> platform_irq_count() rather than the 'gpio-banks' property.


I did not platform_irq_count().  I will send v2 with it.

Thanks.


-- 
Best Regards
Masahiro Yamada
