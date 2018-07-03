Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27445C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37E821939
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SRu3kYXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37E821939
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeGCHiW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:38:22 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26362 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbeGCHiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:38:19 -0400
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w637c4Mf023734
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 16:38:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w637c4Mf023734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530603485;
        bh=3QVz7g6qY4cyFuMUY4Ye6+dWScXOtH5lC2kR59WjMg4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=SRu3kYXYEqPUTLV/rVByIBh73aOejY0MHgxKt6hhlKMZD7Ws6PMfZJy/VrjAngOGU
         1PQ7XV1kDbG2TRz7bPff7W0OOAd11yiRwQO0AKs6RdHJZGjN2g8PxOxPmCq27nqmyn
         kxrnuCL2U4oOFJncqRfcFK/mw5hdIQaGzuFJHfn419isp0IZ5ryHmQg2hgPTVTNiP1
         O8/kfbjNq2kosiru4qDKZQI/chnRT+fdSdzFeq7mKJPnDJItpVl47bVT3JhNKyBIpX
         +BHMj68htN5nG03ABbm5+L1z+vMhSSh/Zz5UIFr9gOOkYS90N/Va1PFZ+QDrqBq8Tp
         cwSySjhGKwhkg==
X-Nifty-SrcIP: [209.85.213.42]
Received: by mail-vk0-f42.google.com with SMTP id b77-v6so537347vkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:38:04 -0700 (PDT)
X-Gm-Message-State: APt69E1ypK8HzSrAen2i46gSLNYVjvmsOP8UxgoTebw1JN946qOzQQem
        ikOeyUHpyVDkbCFL1eIwAb2c+b0+0E4Z1vCZWzY=
X-Google-Smtp-Source: AAOMgpeMJhVpTvO97Xx1/WSDxa7nBGZy/bb+5WBgRJ4FG/2aGG5ZzXLxe+6+W2nHlBz8gv4yi/nt/EbLMh7jCSZORmE=
X-Received: by 2002:a1f:9807:: with SMTP id a7-v6mr3566785vke.65.1530603483596;
 Tue, 03 Jul 2018 00:38:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 00:37:23 -0700 (PDT)
In-Reply-To: <20180703073533.GA6573@gmail.com>
References: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
 <2251685.NraJYuIFmt@blindfold> <20180703073533.GA6573@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 3 Jul 2018 16:37:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASx76Y4NqRX704Pud9+AN6xiKM9OshT=q55wGn6YZcBjg@mail.gmail.com>
Message-ID: <CAK7LNASx76Y4NqRX704Pud9+AN6xiKM9OshT=q55wGn6YZcBjg@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/build/vdso: a little more Makefile cleanups
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jeff Dike <jdike@addtoit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-03 16:35 GMT+09:00 Ingo Molnar <mingo@kernel.org>:
>
> * Richard Weinberger <richard@nod.at> wrote:
>
>> Masahiro,
>>
>> Am Dienstag, 3. Juli 2018, 03:50:12 CEST schrieb Masahiro Yamada:
>> >
>> > At first, I sent the first patch to UML ML,
>> > but they did not pick it up.
>> > Instead, I was able to get Acked-by from Richard,
>> > one of the UML maintainers.
>> >
>> > https://patchwork.kernel.org/patch/10399787/
>> >
>> > I am resending it to x86 ML.
>>
>> Uhh, I thought you want to carry this via your tree?
>> I don't mind picking up these patches.
>
> I already picked them up, as one of them affects the x86 tree.
>
> Is that OK?
>
> Thanks,
>
>         Ingo


No problem on my side.

Thank you!


-- 
Best Regards
Masahiro Yamada
