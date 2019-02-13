Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCE620842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f50/eK6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbfBMWGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:06:44 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37657 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfBMWGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:06:44 -0500
Received: by mail-yw1-f67.google.com with SMTP id k14so1538224ywe.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u6wAtHf633+1b21qJHTj2XIY7UMZA9Tc9wGB3tQtIL0=;
        b=f50/eK6ap/0A0DEKg9r4vUamHcuETcc4wdkTPpA/avW84GZ78cWqIaE06oTh4Pj5S7
         FyHveOfdXAwWoehd1KeJFm453WEQ4P/6VudysCZfZ772xRlETy8V8/pCVMlnzHGlluFP
         gXdf2CN6cIXh+Kv3fzlo0uIGAzrtVuVZBRqtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6wAtHf633+1b21qJHTj2XIY7UMZA9Tc9wGB3tQtIL0=;
        b=R0er3woxWRiedL6F+WbMdD+VrftDCyswMSI/7y3NOqt+hwyyYuDeO0dQXoBokzcY9B
         H4uq89WC7EiqghHHV0EAP/SzREksbxWM0RkwR8IgdTm1ojlUefE4HJ94MXAsMu5n7uiI
         YRk9Ad9xl026K7KEs+roubGkM1NrLJqdx9h3/l+Uam76lz3/3MUL038a/vo9oop6WeXa
         3fvAYZAn6o+PhPBUPu5yLZfVA8n16/gqK+XrRDaVM/AL0gKwveglZUJn+ME6GCpnr+bF
         8L1yX5MJXkXKRv0fNFWU5OYJiCpgvMvDTq95fbmH9Eg9JYuKQ5Q7xVL1JSrn9JYuoQqF
         wYUw==
X-Gm-Message-State: AHQUAuakPBaj/u0SewSToolCEKeKYiPvM6v6X2q2AFENTKlDw9KB7AIW
        DKmRXWtYbaGukdbh8kkA0MFDZw==
X-Google-Smtp-Source: AHgI3Ibp06o8aSa9CppmplGOGwJjf7IUwfBw4SrSNmuULA6zqp6WiNNZRJBOFpESEZQr+nK1nW+xnw==
X-Received: by 2002:a0d:f8c6:: with SMTP id i189mr348312ywf.286.1550095603260;
        Wed, 13 Feb 2019 14:06:43 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w2sm184144ywe.62.2019.02.13.14.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:06:42 -0800 (PST)
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts'
 optional
To:     Rob Herring <robh@kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com> <20190213211651.GA10705@bogus>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
Date:   Wed, 13 Feb 2019 14:06:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213211651.GA10705@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2/13/2019 1:16 PM, Rob Herring wrote:
> On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
>> In prep for the introduction of polling mode into the driver, update the
>> binding document to make the 'interrupts' property optional
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>> ---
>>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> index 81f982ccca31..d3a3620b1f06 100644
>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>> @@ -9,9 +9,6 @@ Required properties:
>>      Define the base and range of the I/O address space that contain the iProc
>>      I2C controller registers
>>  
>> -- interrupts:
>> -    Should contain the I2C interrupt
>> -
>>  - clock-frequency:
>>      This is the I2C bus clock. Need to be either 100000 or 400000
>>  
>> @@ -21,6 +18,13 @@ Required properties:
>>  - #size-cells:
>>      Always 0
>>  
>> +Optional properties:
>> +
>> +- interrupts:
>> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
>> +    polling mode
> 
> What determines when you want to use polling mode? I'm not sure DT 
> is the best way to control this unless it's really a property of 
> the h/w. Driver behavior is really outside the scope of the DT. u-boot 
> would use polling even if an interrupt is specified, for example.
> 
It's tied to the particular revision of the I2C controller, i.e., the
iProc NIC i2c controller does not have interrupt line wired. In this
case, the behavior is determined by the DT compatible string of the
iProc I2C device. I thought that it makes sense to now move the
'interrupts' property to be under "Optional" than "Required" which is
basically what this change is.

> Rob
> 
