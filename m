Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B6BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51372075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPX9E+gG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51372075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGVWJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:09:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38200 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbeGVWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:09:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so5185084wmi.3;
        Sun, 22 Jul 2018 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CEFwu4H/FCnc1WnqFvV8XdVWTSgHLlkCKQ4JuYBQveg=;
        b=lPX9E+gGKHmXNDVoYQZggllfF0l+Liffdx4EHMeWJ8rED/k6gaK0A4n5pRFgmxruSV
         f5YqvN+5LV4/ZO+lQhGJc6Ys1XZgZIoDEkeqOl4NA0Dzb3MZygof+3t2eU1mvW0uQb2A
         i63xE8RiqY68O5kr+BskiLyj/Dqmfpf+g59bWocOw1RjUFk93QEgo/HhGJIR2rNPlrAI
         DINXGuzxhW7UVlSM0P104rqYvCprdu2iCEnLAmeP0ywfWAWo9oLHEYHXpVjazyGx/1m5
         IilC39t4AIOjESUOexrkKfA99Gr3JxSIS2SPnDesYIX88M8j4VnpTbrB3GUCAUYp1K2s
         y59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CEFwu4H/FCnc1WnqFvV8XdVWTSgHLlkCKQ4JuYBQveg=;
        b=kcm06FX1vB/tq6CT1RneEwIHLMlSduLkv98gOyNUA3rJVhl1HCuNfXpwJ3lwaMwWdi
         ocxrQ4O9v6tUdMQuoYVq/5INM3wSHcPKBDOpFVunesRg25d73cCTneazgDPMWQSrlFz0
         ko2bphy5izL/wj2BeKcyuYD6g2p8YN3r+oft4hQ1jDO/6/Fr5v7dIs5M7b7xLv1IA9ib
         soOt7wNh9uM+BwiyG42ruiKEvoBSuMb8xpNfagxzqX3VoXq3An4QNmhRpe7Ji88GVy4U
         VkUN2Yb01aMR1gT/vYrkk8UYX485hjCq++J83EoUosMrwpESiI5kw1fFyXINHOVv/jCd
         s+HA==
X-Gm-Message-State: AOUpUlFUKiBqQum5L1Yh+ifDENX4pjt3m6qNt298LoUICJsPE4c8Vqjl
        Po7+DrBAyFBE202xU7QPpMY=
X-Google-Smtp-Source: AAOMgpeqhDkkk8vooHwpn7/nH/AkIOpA9DCVC0ORxS6x25bIByC2sAwSHJsM/HIoy2lBHpES5Zopsw==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr2920051wmr.138.1532293886184;
        Sun, 22 Jul 2018 14:11:26 -0700 (PDT)
Received: from ziggy.stardust ([93.176.148.203])
        by smtp.gmail.com with ESMTPSA id l14-v6sm21526459wrw.65.2018.07.22.14.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 14:11:25 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Add basic support for Mediatek MT8183 SoC
To:     Erin Lo <erin.lo@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        mars.cheng@mediatek.com, linux-serial@vger.kernel.org,
        yingjoe.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
 <9ba45353-a6e1-9a6e-f05b-4b1679ae9e52@gmail.com>
 <1532074769.19148.2.camel@mtksdaap41>
 <2ca76468-198b-b764-c974-374e567e0c93@gmail.com>
 <1532158134.16009.10.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRT9gkSARAApxtQ4zUMC512
 kZ+gCiySFcIF/mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8K
 RP6Abo35YqBx3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIA
 LC9lAsv9oa+2L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8zn
 f//Z4BxtlTw3SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+
 nrNRDs7B35y/J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYA
 Eg2NJnqaKg3SCJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmO
 Ad/wxGLJ0xmAye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifq
 v6hernMQXGxs+lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeB
 lqhtMoZ0kDw2C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxy
 AtL+L+Lh1Sni7w3HBk1EJvUAEQEAAcLBXwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8Qnd
 EACuN16mvivnWwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2
 jmcg6QytgqVum6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB
 +Fw7CArNtUtLlc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR
 1rQNZWjNCpB2Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7v
 ZB0uo9CzCSm3I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu4
 8UjmUSsTwWC3HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX
 50OP+/11ArV0cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGf
 XM8DY1aFdU79pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp
 3mlIFZ6fsEKIAN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHc
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <1dc23f5f-50f5-e9da-f367-17cd84eace87@gmail.com>
Date:   Sun, 22 Jul 2018 23:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532158134.16009.10.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/18 09:28, Erin Lo wrote:
> On Fri, 2018-07-20 at 12:44 +0200, Matthias Brugger wrote:
>>
>> On 20/07/18 10:19, Erin Lo wrote:
>>> On Mon, 2018-07-16 at 11:28 +0200, Matthias Brugger wrote:
>>>> Hi Erin,
>>>>
>>>> On 17/05/18 08:22, Erin Lo wrote:
>>>>> MT8183 is a SoC based on 64bit ARMv8 architecture.
>>>>> It contains 4 CA53 and 4 CA73 cores.
>>>>> MT8183 share many HW IP with MT65xx series.
>>>>> This patchset was tested on MT8183 evaluation board, and boot to shell ok.
>>>>>
>>>>> This series contains document bindings, device tree including interrupt, uart.
>>>>>
>>>>> Change in v3:
>>>>> 1. Fill out GICC, GICH, GICV regions
>>>>> 2. Update Copyright to 2018
>>>>>
>>>>> Change in v2:
>>>>> 1. Split dt-bindings into different patches
>>>>> 2. Correct bindings for supported SoCs (mtk-uart.txt)
>>>>>
>>>>> Ben Ho (1):
>>>>>   arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
>>>>>     Makefile
>>>>>
>>>>> Erin Lo (3):
>>>>>   dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
>>>>>   dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
>>>>>   dt-bindings: serial: Add compatible for Mediatek MT8183
>>>>>
>>>>
>>>> I'm a bit reluctant to take this series, as it will only enable the EVB board to
>>>> boot into a serial console. Are you planning to add support for other devices of
>>>> this SoC?
>>>>
>>>> Apart please take into account that there is an issue with the dts file, as you
>>>> were told by the kbuild test robot.
>>>>
>>>> Regards,
>>>> Matthias
>>>>
>>>
>>> Hi, Matthias
>>> Sorry for missing this letter...since mail proxy server.
>>> We plan to add support all the devices of MT8183 in serious.
>>> We have implemented the clock and pinctrl driver for upstream and they
>>> are in internal review right now.
>>>
>>
>> Nice to hear that :)
>>
>>> About the dts issue... do you suggest me to send new patch right now or
>>> wait for clock and pinctrl driver ready then send them together?
>>>
>>
>> I would prefer that you send at least the clock controller together, so that we
>> don't have any dummy clocks in the basic device tree.
>>
>> Regards,
>> Matthias
>>
> 
> Got it! Next patch, we will send them with clock controller without
> dummy clocks in the basic device tree.
> By the way, the clock controller driver of MT8183 is a little bit
> different from former ICs, so we need more time to prepare them.
> We will send them to public as soon as possible.
> 

Thanks for the info.

Best regards,
Matthias
