Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1923CC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09E720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2tpfFs1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09E720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeILK3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:29:18 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:37861 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeILK3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:29:18 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w8C5QJe6003121;
        Wed, 12 Sep 2018 14:26:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w8C5QJe6003121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536729980;
        bh=vxwFZNLJCSXqK3vw/FgAkVmwXu0AACz8wEA5VL7EgLQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=2tpfFs1Y3kJ6ssdS9US57o5RA1AX5et/Hf/p5pRGEkNc/M2roiDzSkeeVvnNkngMT
         owJm69hkRK1+3jlemkR2SpNUmU5JVMWRVIF72I8BLpQ1jJjj7Yg4u/eBM3X1wKoi5T
         APtpzDVMIS8LbzoTlC/nRxlUXC4b38K7ZpDsBV/mangzZ6PtI0pDNEGRp5B7PNF6Zo
         IeFjHKbNgf6nXnCSMH77xSVEfzeSh9GhUu24vuUw+OezWyYG2IJptnbIf9t9TcYkXw
         MNvTyBM76zLg67QCb24Uz4TqQ3EvnL+9fi7aNmAkzwdxZmhiFDu4RIdzBaGrQfkSJ7
         t/pZ/MwPqPhyA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id m26-v6so670386uap.2;
        Tue, 11 Sep 2018 22:26:19 -0700 (PDT)
X-Gm-Message-State: APzg51Duw9lO3Sr/5VzyZ/9Gko77If7CQlgtiOMpNN8lEwozvgfArGj4
        qh+wfQs9PeoZqGrGOxwfNF/Pcm2FZacZa9LqQYk=
X-Google-Smtp-Source: ANB0VdYMKfGLdIsXixtCVHTnvaN4XOjAATdjpuuwq1aEPJ77cIViVTXrJSIFZJ4WFhYjml9y8762Z/uw9/BBy2W1UZ4=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr64735uah.135.1536729978695;
 Tue, 11 Sep 2018 22:26:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 22:25:38
 -0700 (PDT)
In-Reply-To: <20180912043530.GE2766@vkoul-mobl>
References: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
 <1535074873-15617-3-git-send-email-yamada.masahiro@socionext.com>
 <20180911070003.GI2634@vkoul-mobl> <CAK7LNASMhKfQT-Hqv48=HqOPRx3OVMtdNBEe=c7dE-B_5_Nuyw@mail.gmail.com>
 <20180912043530.GE2766@vkoul-mobl>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Sep 2018 14:25:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASFyxMTE_kVzja=bUvbDbT6Moz-nZn3=yBKdTWXEQdjXA@mail.gmail.com>
Message-ID: <CAK7LNASFyxMTE_kVzja=bUvbDbT6Moz-nZn3=yBKdTWXEQdjXA@mail.gmail.com>
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

2018-09-12 13:35 GMT+09:00 Vinod <vkoul@kernel.org>:
> On 12-09-18, 12:01, Masahiro Yamada wrote:
>> Hi Vinod,
>>
>>
>> 2018-09-11 16:00 GMT+09:00 Vinod <vkoul@kernel.org>:
>> > On 24-08-18, 10:41, Masahiro Yamada wrote:
>> >
>> >> +/* mc->vc.lock must be held by caller */
>> >> +static u32 __uniphier_mdmac_get_residue(struct uniphier_mdmac_desc *md)
>> >> +{
>> >> +     u32 residue = 0;
>> >> +     int i;
>> >> +
>> >> +     for (i = md->sg_cur; i < md->sg_len; i++)
>> >> +             residue += sg_dma_len(&md->sgl[i]);
>> >
>> > so if the descriptor is submitted to hardware, we return the descriptor
>> > length, which is not correct.
>> >
>> > Two cases are required to be handled:
>> > 1. Descriptor is in queue (IMO above logic is fine for that, but it can
>> > be calculated at descriptor submit and looked up here)
>>
>> Where do you want it to be calculated?
>
> where is it calculated now?


Please see __uniphier_mdmac_handle().


It gets the address and size by sg_dma_address(), sg_dma_len()
just before setting them to the hardware registers.


       sg = &md->sgl[md->sg_cur];

       if (md->dir == DMA_MEM_TO_DEV) {
               src_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_INC;
               src_addr = sg_dma_address(sg);
               dest_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED;
               dest_addr = 0;
       } else {
               src_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED;
               src_addr = 0;
               dest_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_INC;
               dest_addr = sg_dma_address(sg);
       }







>> This hardware provides only simple registers (address and size)
>> for one-shot transfer instead of descriptors.
>>
>> So, I used sgl as-is because I did not see a good reason
>> to transform sgl to another data structure.
>
>
>> > this seems missing stuff. Where do you do register calculation for the
>> > descriptor and where is slave_config here, how do you know where to
>> > send/receive data form/to (peripheral)
>>
>>
>> This dmac is really simple, and un-flexible.
>>
>> The peripheral address to send/receive data from/to is hard-weird.
>> cfg->{src_addr,dst_addr} is not configurable.
>>
>> Look at __uniphier_mdmac_handle().
>> 'dest_addr' and 'src_addr' must be set to 0 for the peripheral.
>
> Fair enough, what about other values like addr_width and maxburst?


None of them is configurable.



-- 
Best Regards
Masahiro Yamada
