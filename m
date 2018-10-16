Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F32C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14182089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0x5PSgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14182089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJPVvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:51:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32916 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPVvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:51:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id l14-v6so12453615edq.0;
        Tue, 16 Oct 2018 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Os08TZtRIQQk5XJNkJ906/VCHb2GgmVLiq2u3CX0KWI=;
        b=m0x5PSgMo3ZtDTCYDv5a+w7eJk/eGouug4g4ycVrGru97ZAbp5bIdLvcCGYcBK5sHN
         tttptxcmF870jaTTgCtYXnsVJudiy2voP41R82Zaey7vjcmcw8smICBeykYp4pO4v8cC
         NxO1hu1LkmXbZ0wfYzOKKmujSsaaX1vNvpkkO4327AIlFVrTFSIejhmags09kN74nG/u
         0C/pnxSNj+YxAWB/oE1YBIdkyXEbHVI5zV5zVqgO2MYtKtQuof6zCtR+aJbOjaMgKiG4
         O9JTt3bzQVZuTpsd694Keur1vfP8gqdOehEody3zStcNYMADiwKO7+rH2OzofLkAUY1S
         NMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Os08TZtRIQQk5XJNkJ906/VCHb2GgmVLiq2u3CX0KWI=;
        b=qo/+E+AoFw0Xey1X1iQbR7Z27yv4NlchUtEB9p1fpNpGyEkKYQWzLAdCE7e5A2zgdw
         lkoBNvkwQOaXLGvppAuPoUDfPL35TcmwC6cGGZgBFW0TrRL20AvYKh6PJB9uYat5aTuk
         mZn4HwlHWq0v5K3mrmYrUXtQoq7hYtxPMjgJebBRnM29WX35R6xHu7qcOnVMY11Q4Xyc
         BY50E6yEh1/YotlwEyUyVwLDN0WyghQx8DHa9wPhxZHk3mX1RN5c8+HQ7KnPcAMjf2DH
         llfEI6wpbQuqEpl3WqLsSlbO4az9s3BWdrwysBmHBjJJ7IOyUsS7Ojb736/MRteroB1N
         SVQw==
X-Gm-Message-State: ABuFfogATwUP85bWWCkGJjlu/7CS/FzVo/HjGkYxt7QzVeIxxlzi1jgH
        7o55b6kBY4L0vODz1IjbWWw=
X-Google-Smtp-Source: ACcGV62cuxolFyFEFkxl86XJPH+h6bFNn0P6O7jKMfAoIwqGVlKO+j2kZVQ0NXmPusiuapQH7AKw3Q==
X-Received: by 2002:a50:b2a6:: with SMTP id p35-v6mr30555649edd.261.1539698453513;
        Tue, 16 Oct 2018 07:00:53 -0700 (PDT)
Received: from ziggy.stardust ([93.176.144.101])
        by smtp.gmail.com with ESMTPSA id i6-v6sm2858946eja.63.2018.10.16.07.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 07:00:52 -0700 (PDT)
Subject: Re: [PATCH 5/5] pinctrl: mediatek: Add initial pinctrl driver for
 MT6797 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Mars Cheng <mars.cheng@mediatek.com>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-6-manivannan.sadhasivam@linaro.org>
 <c8d65395-c60c-5d06-92ad-c389642c22ba@gmail.com>
 <20181011164429.GA18174@Mani-XPS-13-9360>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <e7abee72-23a3-4716-baf0-484514bbb019@gmail.com>
Date:   Tue, 16 Oct 2018 15:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011164429.GA18174@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2018 18:44, Manivannan Sadhasivam wrote:
> On Thu, Oct 11, 2018 at 05:50:19PM +0200, Matthias Brugger wrote:
>>
>>
>> On 08/10/2018 21:14, Manivannan Sadhasivam wrote:
>>> Add initial pinctrl driver for Mediatek MT6797 SoC supporting only
>>> GPIO and pinmux configurations.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  drivers/pinctrl/mediatek/Kconfig              |    7 +
>>>  drivers/pinctrl/mediatek/Makefile             |    1 +
>>>  drivers/pinctrl/mediatek/pinctrl-mt6797.c     |   82 +
>>>  drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h | 2430 +++++++++++++++++
>>>  4 files changed, 2520 insertions(+)
>>>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
>>>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
>>>
>> [...]
>>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
>>> new file mode 100644
>>> index 000000000000..8949d2a15c39
>>> --- /dev/null
>>> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
>>> @@ -0,0 +1,2430 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Based on pinctrl-mtk-mt6765.h
>>> + *
>>> + * Copyright (C) 2018 MediaTek Inc.
>>> + *
>>> + * Author: ZH Chen <zh.chen@mediatek.com>
>>> + *
>>> + * Copyright (c) 2018 Manivannan Sadhasivam
>>> + */
>>> +
>>> +#ifndef __PINCTRL_MTK_MT6797_H
>>> +#define __PINCTRL_MTK_MT6797_H
>>> +
>>> +#include "pinctrl-paris.h"
>>> +
>>> +static const struct mtk_pin_desc mtk_pins_mt6797[] = {
>>> +	MTK_PIN(
>>> +		0, "GPIO0",
>>> +		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
>>> +		DRV_GRP3,
>>
>> As far as I have seen, you put all pins in driving group 3, but from the public
>> available "Functional Specification" (page 51-81) I can see that there exist
>> several driving groups:
>> 2/4/6/8 mA (DRV_GRP3)
>> 4/8/12/16 mA (not sure which group this is)
>> 2/4/6/8/10/12/14/16 mA (DRV_GRP4).
>>
> 
> Not sure about that. But I derived the configuration from DRV_CFGx
> registers available in "Application Software Register Table - Part 1"
> from page no: 906.
> 
> This register supports 2/4/6/8mA and this belongs to DRV_GRP2/DRV_GRP3
> [1].

I can see other driving groups as defined in the "Functional Specification" [1]
which gets also reflected in the "Application Software Register Table - Part 1"
[2], see for example page 852.

CCing Mars, maybe he can help to clarify.

Regards,
Matthias

[1]
https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Functional_Specification_V1_0.pdf
[2]
https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_1.pdf

> 
> Still I'm not fully confident of my choice here. Maybe Sean can throw
> some inputs!
> 
> Thanks,
> Mani
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c#n40
> 
>> Regards,
>> Matthias
>>
