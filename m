Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09161C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5A221928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z5RhiZHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437367AbfBNRgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:36:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39228 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404037AbfBNRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:36:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so3501836pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uhXbHxTxPGQ4MO7jdnSCR/lTxKKRk87s3AJY5Ha2z58=;
        b=Z5RhiZHnq+0pcf3YrfE347lsWCBkaC5gsJyhZZyikSHr8/Ge1eGecW9bWneheBnUa5
         CqhoCdeaLeoG/A4FWK2nbppRSW7qWSrIK74ewN+xUmzUF0fWTVrzaarVxMWf/96CKemi
         UurRAMJmPdX4CLvXyGD66uH3mYf9eLsn5ZJ0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhXbHxTxPGQ4MO7jdnSCR/lTxKKRk87s3AJY5Ha2z58=;
        b=l9o2jG3v4I3kz5s6aebh5H30Y/ew7jJQ+AR4ThqpnoZQdeAng6JUqjlyyDV4uUOUpi
         QIlhCPxBUJ4Z9YaxSaVBOJZz4+uitVsBYor2N3KSusguOUTVEz4DlGwzK1e1usd3X+DH
         VxhI6bf6AxOl8DwKMpqISTytXErm+unuqSVu7uNo1yw6iDQE3YyulnL/uSNMpq2Xq6ig
         rKB5s/jmClt9hE9lJlPvwol8w1KAaBfAfqZU0ycoalknNh28WmTaRV5df8HcmSo4tyZh
         BRKlEQpSjObbpTlJpFHMLsQrJY/ZALlDbct1YY1I2e+Nq3c9J3GkqTPqJ2jRd0XateDl
         E3Fg==
X-Gm-Message-State: AHQUAuYYlir8KQnO8d9pypt0bvPSYqBdvM2WU1KQPVv9AyxTVTPG3TON
        72+P3AWeYURfiUu/vJqrl9439Q==
X-Google-Smtp-Source: AHgI3Ib8Mvy87Kp9t/y1Yo/3tjQsBRSR2iy0NbGYlIFkvbpUusKJvbbBI1w7XarAIOyUuAMuf9WvrQ==
X-Received: by 2002:a17:902:7683:: with SMTP id m3mr5378816pll.191.1550165771118;
        Thu, 14 Feb 2019 09:36:11 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z185sm2492735pfb.17.2019.02.14.09.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:36:09 -0800 (PST)
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
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
 <20190204231554.87666-7-ray.jui@broadcom.com> <20190213211807.GA20560@bogus>
 <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
 <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <723faefb-d13d-caf0-3bbd-9e3e698436a4@broadcom.com>
Date:   Thu, 14 Feb 2019 09:36:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2019 6:02 AM, Rob Herring wrote:
> On Wed, Feb 13, 2019 at 4:09 PM Ray Jui <ray.jui@broadcom.com> wrote:
>>
>>
>>
>> On 2/13/2019 1:18 PM, Rob Herring wrote:
>>> On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
>>>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>>
>>>> Update iProc I2C binding document to add new compatible string
>>>> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
>>>> also added that allows configuration of the host view into the APE's
>>>> address for "brcm,iproc-nic-i2c"
>>>>
>>>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> index d3a3620b1f06..02e82d20239e 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
>>>>  Required properties:
>>>>
>>>>  - compatible:
>>>> -    Must be "brcm,iproc-i2c"
>>>> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
>>>>
>>>>  - reg:
>>>>      Define the base and range of the I/O address space that contain the iProc
>>>> @@ -24,6 +24,9 @@ Optional properties:
>>>>      Should contain the I2C interrupt. If unspecified, driver will fall back to
>>>>      polling mode
>>>>
>>>> +- brcm,ape-hsls-addr-mask:
>>>> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
>>>> +    'APE' co-processor
>>>
>>> What's the data type and size? What are valid values?
>>
>> It's an unsigned u32 mask value. An example of a valid value is for
>> example 0x03400000. Do you want any of these added to the paragraph above?
> 
> Yes. Bindings should define constraints.

Okay will do! Thanks.

> 
> Rob
> 
