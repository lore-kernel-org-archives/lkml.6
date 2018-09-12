Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13FFC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F85C2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ggieu4rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F85C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeILMfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:35:17 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:20643 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeILMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:35:17 -0400
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w8C7VuwU006592;
        Wed, 12 Sep 2018 16:31:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w8C7VuwU006592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536737517;
        bh=iuGTnHUZ1xccoynXqnPDL2mn4+ux9yWfkZ6d0sNek2g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ggieu4rxhw/5f77dvSZ0lt2hX1iwmFyxhwOrcw8NfXMcPHOYshJFT6rVf1mL3a8Aw
         x+rHvBzpZ0r09lDhsERc0Osj166x+tJa4lG/npiIdKtmt3DjNYIPaiuikXsT9O5sdf
         KbAgWZvTufcKzLc1xeuKJ8k7Y5wkBxMmm8AbMNd3sAR3VDAhkdqphWxIlPf1D+dJmn
         zrRjYmmjL3qxd77dcOPjRzMFMYb8q7joNpPhXpKwd75fR29wbFbsbNZFDbE3t731cV
         9egGfvHSegvqGqzwvhldhW8CIgjC9RtZJEvX/16IgJmrCDkTOTf2873//7eAzPo4u7
         ekxArx3lMlH8A==
X-Nifty-SrcIP: [209.85.213.54]
Received: by mail-vk0-f54.google.com with SMTP id s17-v6so118106vke.10;
        Wed, 12 Sep 2018 00:31:57 -0700 (PDT)
X-Gm-Message-State: APzg51BnTJroIJbwgj+wWIKVh92vVRyd2S/arUQ60/I7MQUgjtJD8JRT
        IZNZlrCNF5fRBZNCWcibV2KqPJrMifwOZ1BadXY=
X-Google-Smtp-Source: ANB0VdbXWvxRcQRwy+MOFrt3RVaMzQaiZ5Oz+1qH+H9uItY5LvRgy83R0xDjOgPTMyZK1X95sXcfJ5geDHw7Wcnc/x0=
X-Received: by 2002:a1f:5c08:: with SMTP id q8-v6mr192929vkb.34.1536737516272;
 Wed, 12 Sep 2018 00:31:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 00:31:15
 -0700 (PDT)
In-Reply-To: <20180912072657.GF2766@vkoul-mobl>
References: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
 <1535074873-15617-3-git-send-email-yamada.masahiro@socionext.com>
 <20180911070003.GI2634@vkoul-mobl> <CAK7LNASMhKfQT-Hqv48=HqOPRx3OVMtdNBEe=c7dE-B_5_Nuyw@mail.gmail.com>
 <20180912043530.GE2766@vkoul-mobl> <CAK7LNASFyxMTE_kVzja=bUvbDbT6Moz-nZn3=yBKdTWXEQdjXA@mail.gmail.com>
 <20180912072657.GF2766@vkoul-mobl>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Sep 2018 16:31:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNATSNQBbxQHkbo2zG1G44=urpC_cutu_D126QfDpMg5TNA@mail.gmail.com>
Message-ID: <CAK7LNATSNQBbxQHkbo2zG1G44=urpC_cutu_D126QfDpMg5TNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
To:     Vinod <vkoul@kernel.org>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 16:26 GMT+09:00 Vinod <vkoul@kernel.org>:
> On 12-09-18, 14:25, Masahiro Yamada wrote:
>> 2018-09-12 13:35 GMT+09:00 Vinod <vkoul@kernel.org>:
>> > On 12-09-18, 12:01, Masahiro Yamada wrote:
>> >> Hi Vinod,
>> >>
>> >>
>> >> 2018-09-11 16:00 GMT+09:00 Vinod <vkoul@kernel.org>:
>> >> > On 24-08-18, 10:41, Masahiro Yamada wrote:
>> >> >
>> >> >> +/* mc->vc.lock must be held by caller */
>> >> >> +static u32 __uniphier_mdmac_get_residue(struct uniphier_mdmac_desc *md)
>> >> >> +{
>> >> >> +     u32 residue = 0;
>> >> >> +     int i;
>> >> >> +
>> >> >> +     for (i = md->sg_cur; i < md->sg_len; i++)
>> >> >> +             residue += sg_dma_len(&md->sgl[i]);
>> >> >
>> >> > so if the descriptor is submitted to hardware, we return the descriptor
>> >> > length, which is not correct.
>> >> >
>> >> > Two cases are required to be handled:
>> >> > 1. Descriptor is in queue (IMO above logic is fine for that, but it can
>> >> > be calculated at descriptor submit and looked up here)
>> >>
>> >> Where do you want it to be calculated?
>> >
>> > where is it calculated now?
>>
>>
>> Please see __uniphier_mdmac_handle().
>>
>>
>> It gets the address and size by sg_dma_address(), sg_dma_len()
>> just before setting them to the hardware registers.
>>
>>
>>        sg = &md->sgl[md->sg_cur];
>>
>>        if (md->dir == DMA_MEM_TO_DEV) {
>>                src_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_INC;
>>                src_addr = sg_dma_address(sg);
>>                dest_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED;
>>                dest_addr = 0;
>>        } else {
>>                src_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED;
>>                src_addr = 0;
>>                dest_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_INC;
>>                dest_addr = sg_dma_address(sg);
>>        }
>>
>>
>>
>>
>>
>>
>>
>> >> This hardware provides only simple registers (address and size)
>> >> for one-shot transfer instead of descriptors.
>> >>
>> >> So, I used sgl as-is because I did not see a good reason
>> >> to transform sgl to another data structure.
>> >
>> >
>> >> > this seems missing stuff. Where do you do register calculation for the
>> >> > descriptor and where is slave_config here, how do you know where to
>> >> > send/receive data form/to (peripheral)
>> >>
>> >>
>> >> This dmac is really simple, and un-flexible.
>> >>
>> >> The peripheral address to send/receive data from/to is hard-weird.
>> >> cfg->{src_addr,dst_addr} is not configurable.
>> >>
>> >> Look at __uniphier_mdmac_handle().
>> >> 'dest_addr' and 'src_addr' must be set to 0 for the peripheral.
>> >
>> > Fair enough, what about other values like addr_width and maxburst?
>>
>>
>> None of them is configurable.
>
> what is configurable here :-)

The physical address of the memory, transfer size, direction
are configurable, of course.
But, they are out of scope of device_config hook.


> Who are the users of this DMA?

SD/eMMC controllers.



-- 
Best Regards
Masahiro Yamada
