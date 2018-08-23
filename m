Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121E2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71AF208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="loPqoOLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71AF208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeHWIqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:46:44 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31958 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeHWIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:46:44 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w7N5IgTZ015569;
        Thu, 23 Aug 2018 14:18:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w7N5IgTZ015569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535001523;
        bh=UJ7wuCUp8N+t6aD4NZES1oiF+tswbP+9Mts7n5Fqms4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=loPqoOLOQzbX1AomkXLfHcZyvo7vc22uUxF3L1fgH44KqviWrGNQuMJlWRMAHayFQ
         K9FMaHsay8VSTOqGVLfQoxaNYmPJzfevKlxf/qmEZWkzHTcSVW9CBcpXQdBH4cnrsC
         jmueXgcYaR/7eY3rvmftcXM0DDD0p76PauR7i5FwaO4eBn9bIt6yFNXlQ/bZA7KWcA
         Y4vh/tsnDbF9ZhN0KZ4ekcR3AH7bvI7JsbuG0prNd/7V6Uc12bF/PYoPe/svZY0qKd
         RpZFU5f6HQ7IHxf0MB+yvCMe3Z12z6Y8uoCpDh988MkAqPZW32S8O+jdTZo+8fuOIQ
         keqzjY9//3e8A==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id 101-v6so1677815uav.7;
        Wed, 22 Aug 2018 22:18:42 -0700 (PDT)
X-Gm-Message-State: APzg51Am6/Wq26mCxosVZcQihR95SCjipm52pXYosv4oHFRc1GtnsTyL
        xGLsRvbXd+oruigNbex4cnQzXwuXtFNn3jg5Rvc=
X-Google-Smtp-Source: AA+uWPyb6Wtwvt0fGS6iX+aicwZiZczD7XsI+GixhlKoujNNKvzsDF2P2u0Tr+S+0AWKmqmuSgjQRhHeOlKm1ILQZgw=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr8029612uah.135.1535001521662;
 Wed, 22 Aug 2018 22:18:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 22:18:01
 -0700 (PDT)
In-Reply-To: <CAJe_ZhdZbUa2njAvSazGzv+7UgG+QHCTS+-Y-Ckqze+pMf9KQA@mail.gmail.com>
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com>
 <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com> <CAJe_ZhdZbUa2njAvSazGzv+7UgG+QHCTS+-Y-Ckqze+pMf9KQA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 23 Aug 2018 14:18:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3MufLZhFB8HDnch09WUdEcLyDCU05dTYroOwWYcx=pQ@mail.gmail.com>
Message-ID: <CAK7LNAT3MufLZhFB8HDnch09WUdEcLyDCU05dTYroOwWYcx=pQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,


2018-08-21 19:44 GMT+09:00 Jassi Brar <jaswinder.singh@linaro.org>:
> On 21 August 2018 at 15:17, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> (+CC Rob, DT, LKML)
>>
>> I forgot to CC this to DT community...
>>
>>
>> 2018-08-21 18:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>> The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
>>> Pro4, and sLD8 SoCs.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 28 ++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>>> new file mode 100644
>>> index 0000000..a9e969e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>>> @@ -0,0 +1,28 @@
>>> +UniPhier Media IO DMA controller
>>> +
>>> +This works as an external DMA engine for SD/eMMC controllers etc.
>>> +found in UniPhier LD4, Pro4, sLD8 SoCs.
>>> +
>>> +Required properties:
>>> +- compatible: should be "socionext,uniphier-mio-dmac".
>>> +- reg: offset and length of the register set for the device.
>>> +- interrupts: a list of interrupt specifiers associated with the DMA channels.
>>> +- clocks: a single clock specifier
>>> +- #dma-cells: should be <1>. The single cell represents the channel number.
>>> +- dma-channels: specify the number of the DMA channels. This should match to
>>> +  the number of tuples in the interrupts property.
>>> +
> Can we not infer the number of channels from interrupt tuples? After
> all the driver assumes they are same.


It would be possible to count the number of tuples
in "interrupts".



I know of_irq_count(), but I do not see any driver
in drivers/dma/ that calls it.


I guess the reason is that of_irq_count() is not exported,
so tristate drivers like this cannot use it.


I checked Documentation/devicetree/bindings/dma/,
and some controllers specify _redundant_ dma-channels property.

fsl-mxs-dma.txt
renesas,rcar-dmac.txt
renesas,usb-dmac.txt



I also see counter-implementation.


bcm2835-dma.c hard-codes the number of channels in the driver.
tegra210-adma.c associates nr_channels with compatible string.



I will wait for comments from the maintainers.

If desired, I will export of_irq_count()
and use it from my driver.



Thanks.

-- 
Best Regards
Masahiro Yamada
