Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B52CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD2A208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C28Ik4Ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD2A208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeHWJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 05:06:42 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36774 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbeHWJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 05:06:42 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so6123467itp.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XKLKPXGS/Q0pqM9yiqWwDtqddSXypAyX3tCxVBhVIHI=;
        b=C28Ik4Ni/MwLdXm5zVI83CeztA0qgmhxHnErFtJ1g0Uohvsf4wcQJbwInO6/ejQ6KS
         Afo3uJmkAzqswVZe54PuTEzNU4PKpYOFBqkhBYGEqVtYK2ZkXci/wL+WGgCNHv+qctar
         EA/KcbCcBNJGmn3+KdkW6I6xjOs9ix4ytChdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XKLKPXGS/Q0pqM9yiqWwDtqddSXypAyX3tCxVBhVIHI=;
        b=CzNIyqvWUtIuxUYzYxGMWH0g6kR2U9ihS93bZBC+R//PZ589g+BuuLFTRuXsvGnmSL
         kx0OGLT7B2zEq/hGlcxBfVST5zPTi14rSnmgwnXxIEKTkE/DnSaw2V+dI43nM9toJ+7c
         XhQkYEYlTrqNVahEwU5td2bky05rBkKzHq/2ifC8scaY7CwsPPTll+LS4HQCssxZTwOr
         P/nleYudc2to5JlOZRG8ZXp+Bo4WjV6JlJsRpeLtouWQYlOvGTMqFjpY1lqqAzTCFbEG
         Asb9caJJ11ZMGzxCvtDwOfCfw/iGm3HBYVMmljWfbV3l+ye0R6ls7NGsY+vXhKcXIwZQ
         l94w==
X-Gm-Message-State: APzg51DkEFoNqThw8wTzjNByclAtOsobXvA0W2tgdRMa2gR9QqD0N5fl
        YE9We2nEJ2b999wEvVFrcZw2xAwanHwlqVh53KN3Dg==
X-Google-Smtp-Source: ANB0VdYpRk4sUQrscUl1FL25CVlq9AHy8FtLBS+RGz8U/gVVQKnRUIVW6YqCYHzVybkWNBwT8w08UUbHGcyIgRL9Sn8=
X-Received: by 2002:a02:5f44:: with SMTP id r65-v6mr4844262jab.34.1535002724791;
 Wed, 22 Aug 2018 22:38:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3541:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 22:38:44
 -0700 (PDT)
In-Reply-To: <CAK7LNAT3MufLZhFB8HDnch09WUdEcLyDCU05dTYroOwWYcx=pQ@mail.gmail.com>
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com>
 <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
 <CAJe_ZhdZbUa2njAvSazGzv+7UgG+QHCTS+-Y-Ckqze+pMf9KQA@mail.gmail.com> <CAK7LNAT3MufLZhFB8HDnch09WUdEcLyDCU05dTYroOwWYcx=pQ@mail.gmail.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Thu, 23 Aug 2018 11:08:44 +0530
Message-ID: <CAJe_ZheNp9t0DNQjmiQKMyZsbHBjMxqV87mE_3nQ1N_RS9znYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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

On 23 August 2018 at 10:48, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Jassi,
>
>
> 2018-08-21 19:44 GMT+09:00 Jassi Brar <jaswinder.singh@linaro.org>:
>> On 21 August 2018 at 15:17, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> (+CC Rob, DT, LKML)
>>>
>>> I forgot to CC this to DT community...
>>>
>>>
>>> 2018-08-21 18:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>>> The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
>>>> Pro4, and sLD8 SoCs.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 28 ++++++++++++++++++++++
>>>>  1 file changed, 28 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>>>> new file mode 100644
>>>> index 0000000..a9e969e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>>>> @@ -0,0 +1,28 @@
>>>> +UniPhier Media IO DMA controller
>>>> +
>>>> +This works as an external DMA engine for SD/eMMC controllers etc.
>>>> +found in UniPhier LD4, Pro4, sLD8 SoCs.
>>>> +
>>>> +Required properties:
>>>> +- compatible: should be "socionext,uniphier-mio-dmac".
>>>> +- reg: offset and length of the register set for the device.
>>>> +- interrupts: a list of interrupt specifiers associated with the DMA channels.
>>>> +- clocks: a single clock specifier
>>>> +- #dma-cells: should be <1>. The single cell represents the channel number.
>>>> +- dma-channels: specify the number of the DMA channels. This should match to
>>>> +  the number of tuples in the interrupts property.
>>>> +
>> Can we not infer the number of channels from interrupt tuples? After
>> all the driver assumes they are same.
>
>
> It would be possible to count the number of tuples
> in "interrupts".
>
>
>
> I know of_irq_count(), but I do not see any driver
> in drivers/dma/ that calls it.
>
>
> I guess the reason is that of_irq_count() is not exported,
> so tristate drivers like this cannot use it.
>
>
> I checked Documentation/devicetree/bindings/dma/,
> and some controllers specify _redundant_ dma-channels property.
>
> fsl-mxs-dma.txt
> renesas,rcar-dmac.txt
> renesas,usb-dmac.txt
>
:) I am not sure "because others are doing it" is a good reason to
introduce redundancy.


> I also see counter-implementation.
>
>
> bcm2835-dma.c hard-codes the number of channels in the driver.
> tegra210-adma.c associates nr_channels with compatible string.
>
>
>
> I will wait for comments from the maintainers.
>
> If desired, I will export of_irq_count()
> and use it from my driver.
>
If you don't want to leave too much footprint, you could do

  count = 0;
  while (of_irq_parse_one(dev, count, &irq) == 0) count++

of_irq_parse_one() is already exported.

A good side-effect is you wouldn't have to hardcode the count in the
driver (like bcm and tegra examples you quote).

Having said that, I wouldn't lose sleep over it. So ....

Cheers!
