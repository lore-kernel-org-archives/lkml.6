Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1287DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67EA2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FljUnDeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbeLaWQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:16:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39754 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbeLaWQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 17:16:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so13015973pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 14:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3BvVN5hSR1x6mM5UHkIXAVqeyD/R+jv4Qox7LTusL8=;
        b=FljUnDeD7xCVTfQ2Somk4F4ztpoQU6igNBFNEWTesRVhp+PQepOJsmA9bF+hHhBVh5
         K3U2p7fRt6OHWWV+yBqh5fLtF476FhVZZosos1480aTJkaDyHIJff2WFppB3p29biJM4
         ops9CasTI0VLFnn9yTE5Kh61iLZUFrxHIAhAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s3BvVN5hSR1x6mM5UHkIXAVqeyD/R+jv4Qox7LTusL8=;
        b=e+M12nahiOOvDVvodTeWs56rMGWZWBzUTnBERLWaGilKeL3V/6ATjwyraYi5rdHB62
         SRhBzq5YZeK7Tl44pQaLfjy1uqbYKDV520Qquy5IN3MxZS7xV09m70FpT4d5khNhqLTX
         aO6LECI32gB68a/LTjBHs74kSUe3xrVoDr+VepDpOPeiXXQWYG/Ad+PmFNzjGbHOxqYT
         trvsa/7f7Loq+vQrfkcN9PoNs+lSorHyWKQY0JgJp5hMrb5hv+6XJSu+vtJBT+8uHnAw
         Tmtx4tYOP8AyPRi51ndLQq3HqnDuRopK/q0t5qfz5scYIybFiKN8ho9aBcy1U1G0q5Ax
         +o4Q==
X-Gm-Message-State: AJcUukc558fDzrPWtN9N+NBob2UGEy3fLcDxgOVIrqdoVEgW5Z8WYj0S
        aMBGEMbA4iHh83M0FrH83TTB8Q==
X-Google-Smtp-Source: ALg8bN6tJJemwLq0Tkcj+WjMir/pkrVRMapQS1W23rFgI2SnBsnLyRg9NlCJPhEMXMQIiM/ByCbMMQ==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr38856582plo.210.1546294559274;
        Mon, 31 Dec 2018 14:15:59 -0800 (PST)
Received: from [10.10.115.153] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id g15sm222377398pfj.131.2018.12.31.14.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 14:15:58 -0800 (PST)
Subject: Re: [PATCH v5 0/3] Stingray thermal driver support
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
 <b6e02875-784f-4908-a985-5ee7e3df3ac6@gmail.com>
 <CABe79T4mpnbkaTCerYegmc1+uY4idOVOxCVDqHramk3fYipiCA@mail.gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Openpgp: preference=signencrypt
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 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
 w0j9Sw==
Message-ID: <3c05a1f1-5041-ebb7-27e5-0a2321314b0a@broadcom.com>
Date:   Mon, 31 Dec 2018 14:15:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABe79T4mpnbkaTCerYegmc1+uY4idOVOxCVDqHramk3fYipiCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2018 19:17, Srinath Mannam wrote:
> Hi,
> 
> Could you please provide your feedback to this patch series?

Rui or Eduardo can we get either one of you to review the thermal driver
parts of this patch series? Why do we constantly have to chase people to
respond in this specific subsystem?

> 
> Regards,
> Srinath.
> On Thu, Nov 8, 2018 at 3:45 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 10/16/2018 8:11 AM, Srinath Mannam wrote:
>>> These patches adds the stingray thermal driver and its
>>> corresponding DT nodes with documentation.
>>
>> Can we get feedback from the thermal maintains whether this is
>> acceptable or not?
>>
>>>
>>> Changes from v4
>>>   - Addressed Rob Herring comments on DT parameters and
>>>     thermal driver architecture.
>>>   - Removed brcm,max-crit-temp DT parameter
>>>   - Changed driver to thermal sensor registration model.
>>>   - Added trip DT properties.
>>>
>>> Changes from v3
>>>   - Addressed Daniel lezcano comments.
>>>   - Elaborated commit description of thermal driver patch.
>>>   - Added brcm,max-crit-temp DT parameter.
>>>
>>> Changes from v2:
>>>   - All stingray TMON DT nodes are combine together into single.
>>>     Temperature registers are combined into one mem resource.
>>>     brcm,tmon-mask parameter has available TMONs mask value.
>>>   - All available TMONs are initialized together in single
>>>     instance of driver probe call.
>>>
>>> Changes from v1:
>>>   - Fixed auto build sparce warning.
>>>
>>> Pramod Kumar (3):
>>>   dt-bindings: thermal: Add binding document for SR thermal
>>>   thermal: broadcom: Add Stingray thermal driver
>>>   arm64: dts: stingray: Add Stingray Thermal DT support.
>>>
>>>  .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++
>>>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++
>>>  drivers/thermal/Kconfig                            |   3 +-
>>>  drivers/thermal/broadcom/Kconfig                   |   9 ++
>>>  drivers/thermal/broadcom/Makefile                  |   1 +
>>>  drivers/thermal/broadcom/sr-thermal.c              | 138 +++++++++++++++++++++
>>>  6 files changed, 344 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
>>>
>>
>> --
>> Florian

-- 
Florian
