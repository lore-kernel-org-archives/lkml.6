Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F28CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A2C20C10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxqSoiek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A2C20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933458AbeGDKzD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:55:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54557 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932548AbeGDKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:55:01 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so7243957itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=idZcDPcHbrIcruHjRrabKpauhW7c6DimOqrdu2e4TBY=;
        b=FxqSoiekacTbzjV2W3i8bDwQylZVAc7qudbHkxakPb3BZCeaLAfB/M1MZHm93LIxOG
         sfinRSwlfgvN+NmHi+khR2R6bhlkmlX+nHPlkKqY0EUmz/CpSQT6ZRSjm0CMJnGgINAi
         0VF6viaTImp9QNkD4mKBRuDBKlHQph6tbOruo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=idZcDPcHbrIcruHjRrabKpauhW7c6DimOqrdu2e4TBY=;
        b=PmSRJffFp4vFk6IsbjWrK1coqHAXh0mmg7CTnQVuWBroRJ3Frm1R6F4ZsH5zw8E3sl
         VPL7pyyPNnFu84/YmjRY/yIMkJw/IlzOIW87rCIK/x0bQiIaAW9+oFJFFeIH143M3zsl
         f+Evv9DEAZz4PuOFXVT2Xo1O2NEuX35/6e50RadLDqm9w0qHjzvTS/IcGolkX2vatsJt
         GC7qr1Bga9/oUdqCyaURuIzQAVRw57Jo6w06M6kZ24POvYZEy4vgFnCiRhdx3DzrIlyC
         ciXK2HdJTujPwxlONLYDCDqr4yna2N6n2UOBxIiCdawC2DHicC3mwyofnhxJtm9XTxe5
         /dYA==
X-Gm-Message-State: APt69E1Qt3w1uGVxD1XLsYLJL73o2egHjRWKGoluIyqusHSR9e+/1Nw1
        6yVQU17YF0NLMK/tMwjmuGMN9x56y2rLKk1OJ8Y2OQ==
X-Google-Smtp-Source: AAOMgpcLVr4Ld4npRbyR6RN41XkHsNg3JEKRGllG8DHtOjrMxT8/tyWbu4Vm6b4MA3B/6j0SWQnmFFZfV+aIF08023Y=
X-Received: by 2002:a24:1c09:: with SMTP id c9-v6mr1416034itc.38.1530701701066;
 Wed, 04 Jul 2018 03:55:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:55:00 -0700 (PDT)
In-Reply-To: <61a16c6b-9158-17ea-51f9-2ee5b85ccb78@nxp.com>
References: <20180628084509.19646-1-laurentiu.tudor@nxp.com>
 <CAPDyKFoNmcg+7JbWq1eeb2Dx7GKSh=FWpZcEeB8RORaBbrr=qA@mail.gmail.com> <61a16c6b-9158-17ea-51f9-2ee5b85ccb78@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jul 2018 12:55:00 +0200
Message-ID: <CAPDyKFrabODyn4qgprFS4+Pfg0Xvy1tBzqDofJOwWuM7HK=0ZQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 13:15, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
> Hi Uffe,
>
> On 02.07.2018 17:37, Ulf Hansson wrote:
>> On 28 June 2018 at 10:45, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>>> SDHCI controller in ls1043a and ls1046a generate 40-bit wide addresses
>>> when doing DMA. Make sure that the corresponding dma mask is correctly
>>> configured.
>>>
>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Thanks, applied for next!
>
> Thanks for picking this up!
> I just realized that maybe I should have provided some context around
> this patch. I'm working on enabling smmu on these chips and encountered
> the following problem: the smmu input address size is 48 bits so the dma
> mappings for sdhci end up 48-bit wide. However, on these chips sdhci
> only use 40-bits of that address size when doing dma.
> So you end up with a 48-bit address translation in smmu but the device
> generates transactions with clipped 40-bit addresses, thus smmu context
> faults are triggered. Setting up the correct dma mask fixes this situation.

That's perfect data for the changelog. Care to send a v2, then I
re-place the one I have just applied!

Kind regards
Uffe

>
> ---
> Best Regards, Laurentiu
>
>>
>>> ---
>>>   drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
>>> index 4ffa6b173a21..8332f56e6c0d 100644
>>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>>> @@ -22,6 +22,7 @@
>>>   #include <linux/sys_soc.h>
>>>   #include <linux/clk.h>
>>>   #include <linux/ktime.h>
>>> +#include <linux/dma-mapping.h>
>>>   #include <linux/mmc/host.h>
>>>   #include "sdhci-pltfm.h"
>>>   #include "sdhci-esdhc.h"
>>> @@ -427,6 +428,11 @@ static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
>>>   static int esdhc_of_enable_dma(struct sdhci_host *host)
>>>   {
>>>          u32 value;
>>> +       struct device *dev = mmc_dev(host->mmc);
>>> +
>>> +       if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
>>> +           of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
>>> +               dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
>>>
>>>          value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
>>>          value |= ESDHC_DMA_SNOOP;
>>> --
>>> 2.17.1
>>>
