Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5446CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24787222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g4M8cFGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437411AbfBNRgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:36:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44976 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbfBNRgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:36:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so5668438edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryRC4W/SA5dnQCgYQdvbKL45VGQoqpZT+NFh8c9Rb0I=;
        b=g4M8cFGjJsYULIePc+YAzDxv9Q1Jn5NGPBH5cGIhkbSuMsp6t9AqUmRl7+BwbYC8eX
         EqmuilLKK0NZ6TL40QjzDZaY6LM5cVcy6iR38Dq4hXT729L3grO6WYQcevkD0wCYmrQz
         SbiCmaWrLy5QPVwclGbOiHj9Vju3I+Aos64g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryRC4W/SA5dnQCgYQdvbKL45VGQoqpZT+NFh8c9Rb0I=;
        b=i+T4mk9vXIZUFIIQvQBSZgcVWM7vtHO1Cv6KxYvlvR/aCquxvWaLpqrr5ZNVhocFO2
         U56nBBV1/hpB1X0ISDsasvQ+pHPq4S7G/7qFmZIlQw2n73PTaSxdWk8VYNLrMp6+T3bD
         E9ILcgeJrk0U+Nc4POH2R0v9qC8pQtshOItnGSBDTBN4CcGS8j6zxj5AK66VKe8rKecZ
         OxEwoPXkpxD0QXtISryqeaQg8PUKsBaFWFyGLtGD0qkFYBgauhnZMbZNjq5zhZVmghqI
         qEcRpgu7spE852F89EBUgy/slN4/4yxrLwk9CnN8IlbmcB3Y37vtRF0WQ4K11dLmAFFF
         1Ogw==
X-Gm-Message-State: AHQUAubaxPcPAxNxyuuZ11VSAYGAS9xwLRXEp4MyDA6g14ZmZVqAOwFo
        LfvBDsm7oLsI15CMDSw/RlRAwQ==
X-Google-Smtp-Source: AHgI3Ib7bHgeOFreWspwUxtqqjRsnvGYB8RrCKmzKT4Vlh/VjJ0HZd6XAb8PTnbT/eOeMZC+5hOzlQ==
X-Received: by 2002:a17:906:a456:: with SMTP id cb22mr3633823ejb.80.1550165806455;
        Thu, 14 Feb 2019 09:36:46 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j4sm646599ejx.75.2019.02.14.09.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:36:45 -0800 (PST)
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts'
 optional
To:     Rob Herring <robh@kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com> <20190213211651.GA10705@bogus>
 <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
 <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <e17b1cd0-8ffb-d014-bcce-57a3ca227506@broadcom.com>
Date:   Thu, 14 Feb 2019 09:36:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2019 6:16 AM, Rob Herring wrote:
> On Wed, Feb 13, 2019 at 4:06 PM Ray Jui <ray.jui@broadcom.com> wrote:
>>
>> Hi Rob,
>>
>> On 2/13/2019 1:16 PM, Rob Herring wrote:
>>> On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
>>>> In prep for the introduction of polling mode into the driver, update the
>>>> binding document to make the 'interrupts' property optional
>>>>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>> ---
>>>>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> index 81f982ccca31..d3a3620b1f06 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> @@ -9,9 +9,6 @@ Required properties:
>>>>      Define the base and range of the I/O address space that contain the iProc
>>>>      I2C controller registers
>>>>
>>>> -- interrupts:
>>>> -    Should contain the I2C interrupt
>>>> -
>>>>  - clock-frequency:
>>>>      This is the I2C bus clock. Need to be either 100000 or 400000
>>>>
>>>> @@ -21,6 +18,13 @@ Required properties:
>>>>  - #size-cells:
>>>>      Always 0
>>>>
>>>> +Optional properties:
>>>> +
>>>> +- interrupts:
>>>> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
>>>> +    polling mode
>>>
>>> What determines when you want to use polling mode? I'm not sure DT
>>> is the best way to control this unless it's really a property of
>>> the h/w. Driver behavior is really outside the scope of the DT. u-boot
>>> would use polling even if an interrupt is specified, for example.
>>>
>> It's tied to the particular revision of the I2C controller, i.e., the
>> iProc NIC i2c controller does not have interrupt line wired. In this
>> case, the behavior is determined by the DT compatible string of the
>> iProc I2C device. I thought that it makes sense to now move the
>> 'interrupts' property to be under "Optional" than "Required" which is
>> basically what this change is.
> 
> Okay, please put this detail into the commit msg.

Will do! Thanks.

> 
> Rob
> 
