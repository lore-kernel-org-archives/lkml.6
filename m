Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48035C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1E4208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkrwmHX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1E4208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeGJKwj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:52:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42303 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeGJKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:52:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id g12-v6so16222773edi.9;
        Tue, 10 Jul 2018 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDFFlO9aUmN8heZV77r/CH4YWHlFOp2Vt8Tj2XJ7qLU=;
        b=kkrwmHX9ivUex9E32Ohn+0lSoI4Y+3rjbAzQUkESw4OIQ2ChglViJOU4bF0U6w5jEs
         4WrmFM17XehylXRFX7LUgGcQl7Cky4wIvztvDEdtcoKaVon5rY93gaQnq6d8KPPr8HEM
         0pLXOPZUAi+thiJvQqWBm9RVp06Y74nPSSlON+Gxgdm7WPqehDWQYJlApcFr/v/pLMaa
         aW2U7gqEAJt+qB9RQ3P5LFu2COtJ6G6wCudi2JhYs2yHLroGNSKODg8cXOvq95PcoO2F
         2IqoXQ/xJwI9hOW9f3gumJpCXnRqAHqxjvfAKOem8VzuQCEFB9YXXGX0HytnbDmy4Ev1
         ezLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hDFFlO9aUmN8heZV77r/CH4YWHlFOp2Vt8Tj2XJ7qLU=;
        b=YD7rRt8CVevGPtPL7hB2ZNZRwLio0rCBqCmhikILxp1wKE5JUETq4NxJOJg5tGeoP0
         zKvxooVqR+wU3X4ubP4AqFxKqYTiZn/WzrW4XexGkr5av63jkckUDOFDSKlUwlHIwwKO
         YvnAA54i9ZMnGdpmP+OMFm3A0L67zpHAZ9oTEWf45XQWOcrnfWwEHQDHrE08V6BkDbTr
         CXi1DeO/BQY3T+m2N8MUD/PsmZ4gNf2fX2nO0yLxJSeEIsWjsWaiSkduMcT7nPm3yuUD
         vXC4W4H7+wF1wCjjPBPob94O2vkFQdyI2jOMwA3/2h0NhMZmIEtMqJ0rivNHDKMtWpzc
         1ecw==
X-Gm-Message-State: APt69E1SOnAZUK9xQ0Efy4dUQrvVJfFWSjq8950QwLE/nGrDMM/5hIaQ
        i1o6gSScvLxPVp5SS3QT7s8=
X-Google-Smtp-Source: AAOMgpe/8ynOMHlqlUYbTylhctTErgdQ/GB7obtQOIuR88rqd5xrsjuZDM5uKJFc/rKue06fdE4Ygg==
X-Received: by 2002:a50:b7db:: with SMTP id i27-v6mr12528625ede.284.1531219955649;
        Tue, 10 Jul 2018 03:52:35 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id b22-v6sm8300982edn.0.2018.07.10.03.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 03:52:34 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
To:     Mars Cheng <mars.cheng@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
 <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
 <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
 <d439eb7d-6365-7a0a-2969-1ddecc51defc@arm.com>
 <1531177443.7777.18.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <7a3becb3-510b-5763-5b66-5e14ebf7c974@gmail.com>
Date:   Tue, 10 Jul 2018 12:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531177443.7777.18.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/18 01:04, Mars Cheng wrote:
> Hi Matthias/Marc
> 
> On Mon, 2018-07-09 at 17:43 +0100, Marc Zyngier wrote:
>> On 09/07/18 11:20, Matthias Brugger wrote:
>>>
>>>
>>> On 09/07/18 08:05, Mars Cheng wrote:
>>>> This adds basic chip support for MT6765 SoC.
>>>>
>>>> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
>>>> ---
>>>>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>>>>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
>>>>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  156 +++++++++++++++++++++++++++
>>>>  3 files changed, 190 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>>> index ac17f60..7506b0d 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>>> @@ -1,6 +1,7 @@
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>>
>>> As you can see, we have a long list of SoCs which are poorly supported.
>>> I'm not very keen to just add another SoC which supports booting into a ramdisk
>>> using the serial console. Do you have a roadmap adding mainline support for this
>>> SoC?
>>
>> Yes, that's a valid concern.
>>
>> mt6755 and mt6795 are in a similar state, the latter after three years.
>> I'm all for supporting new SoCs, but this feels looks a box-ticking
>> exercise ("hey, look, our SoC is supported in mainline") which doesn't
>> help anyone.
>>
>> My Ack still stands, but I'd definitely like to see some more complete
>> support before this patch goes in.
>>
>> Thanks,
>>
>> 	M.
> 
> Yes, we do arrange more resources to do upstream task for mt6765,
> clk/pinctrl drivers are almost ready to submit. systimer is under
> reviewing (v9).
> http://lists.infradead.org/pipermail/linux-mediatek/2018-July/013989.html
> 
> other drivers including
> pmic/pwrap/i2c/rtc/kpd/spi/wdt/cqdma/auxadc/pwm/cmdq/disp. We have
> dedicated owners to handle them and will cowork tightly with members to
> make sure things happen in the following weeks.
> 

Ok, so let's wait until pinctrl driver is submitted. I'd prefer if you could add
the clk driver to this series. This way we can get rid of the dummy clocks in
the device tree.

> For previous chips, we did have no enough support after shell. It is due
> to fast pace of smartphone SoC and other resource issues. We also know
> that is no excuse so that we already confirmed owners and their
> schedules for mt6765.
> 
> If there is any suggestion, please let us know.
> 

I know that smartphone SoC is a fast paced business. Never the less I'm
convinced that the basic building blocks won't change much from one version to
another. And that mainline support for the previous version of your SoC will
help you to get your new drivers faster upstream.

For me the best example is the mt7622 which got to a reasonable upstream support
quite fast, thanks to a good foundation of mt7623 in mainline. I'd love to see
that happen on the smartphone SoCs as well.

Not to mention that upstream support will help you internally when you have to
rebase your BSP code-base to a new kernel version.

That said I think it is good news that you have already defined owner for the
different devices and hope to see submissions for them in the near future :)
As a suggestion I would say that upstream submission takes time and effort and
it will help your engineers if they can allocate some time to do so. But that's
most probably a management decision and all engineers know that management bases
it's decision on some hard-to-understandable abbreviations like EBITDA etc. ;)

Best regards,
Matthias
