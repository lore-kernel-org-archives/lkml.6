Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1887C21872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Je4IbZJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404069AbfBMWJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:09:16 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46398 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbfBMWJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:09:15 -0500
Received: by mail-yb1-f196.google.com with SMTP id 7so1562839ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JlYCdnYOOJpfvtxmzKtdiYFZ9RgWQA+eh2iRMCxSzs=;
        b=Je4IbZJUQJ+mNOfRfiNgk8jH4mTjSSVPcjYWFxcjYwcbXXpg5AiOiOxWGIjga1IE4X
         +0N3njHWH7OEmDMmNJoTbiogb6R2e+sX4klFibeysE4GRzCBPTfTWlo1XMCb14ZKpY3x
         50KisZbxJz3juvnLLqSsmR5y5eMJNzsnyyt6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JlYCdnYOOJpfvtxmzKtdiYFZ9RgWQA+eh2iRMCxSzs=;
        b=GYPQgYqVqdm5QQx26JGjxw52kblMfHVtSW5C8hwAMk4+hVmeU8uFj86hutWJSORNxJ
         TXaAKDmNQEnS6kQeQroW79LvyPcdIXs//XhEc+9Fps6Ee/QZsKkmWx13/+NbfQZsgdcf
         GYfnOc0Ywx8iv1MmwMero5xdOhOKpsfk+JIqcyy4eTdWcagd3LdWVX3R7nnoKtFiMdm9
         e/MAfoTivTG5j9pDCzvuMGGhF7mQTRni4+v3nSpR49D5weQ61nuc4fkBR8R7/yqUZ6xW
         hCumAxbzx8uUTtBaj3JyDJkD+/Oey2/EtXg3Rivkq6ymphW499mjhmkY88YmJkOsI2S7
         sBJA==
X-Gm-Message-State: AHQUAubthcoQVkTIME3oL6uhX3DhVZYmklDz3ZHBnRKdp1yasJjjC9aa
        2RubG587Pmo6IDxeG86XO4LyfA==
X-Google-Smtp-Source: AHgI3IYUntGkhv7heIF1fcfP2jdZiurEGy+tZwvTtpG5EtKZv81+JI7+azU8i2o1UENf2NswKumkDQ==
X-Received: by 2002:a25:da05:: with SMTP id n5mr351869ybf.63.1550095754764;
        Wed, 13 Feb 2019 14:09:14 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o124sm166394ywe.75.2019.02.13.14.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:09:13 -0800 (PST)
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
To:     Rob Herring <robh@kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-7-ray.jui@broadcom.com> <20190213211807.GA20560@bogus>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
Date:   Wed, 13 Feb 2019 14:09:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213211807.GA20560@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2019 1:18 PM, Rob Herring wrote:
> On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>
>> Update iProc I2C binding document to add new compatible string
>> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
>> also added that allows configuration of the host view into the APE's
>> address for "brcm,iproc-nic-i2c"
>>
>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> index d3a3620b1f06..02e82d20239e 100644
>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
>>  Required properties:
>>  
>>  - compatible:
>> -    Must be "brcm,iproc-i2c"
>> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
>>  
>>  - reg:
>>      Define the base and range of the I/O address space that contain the iProc
>> @@ -24,6 +24,9 @@ Optional properties:
>>      Should contain the I2C interrupt. If unspecified, driver will fall back to
>>      polling mode
>>  
>> +- brcm,ape-hsls-addr-mask:
>> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
>> +    'APE' co-processor
> 
> What's the data type and size? What are valid values?

It's an unsigned u32 mask value. An example of a valid value is for
example 0x03400000. Do you want any of these added to the paragraph above?

> 
>>  
>>  Example:
>>  	i2c0: i2c@18008000 {
>> -- 
>> 2.17.1
>>
