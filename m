Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C96C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4CA21927
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ32SUUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfBHM3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:29:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39613 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfBHM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:29:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so3364988wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I/GDz/IsdMmcCDZRowSDR4Fv2Qfj1zy1OtxkQuRkPWc=;
        b=bQ32SUUn9vi65MSFCaMG8romDjcU3AD7T9O5DcsJOafYp2HhL+4nYYKtw1jU6vgPeZ
         PPlvriLyOUy6OAFv0SbTzA+CrjXB9b8Eyeydjah33j1Ry1CLPN6metL11jy4Rr8v3iNp
         5r9GbpUeXue5X+YAxOTIqHmRkchgOvkOcUaBwqTQBt8ocWmt+0r9Cn3AwQeZ1wJFNA5N
         eTDzCbNW9mySBBuYh0nTojE0IM8smXXxGOosQoEQHlmQDIXNHRkEr3u1AMD/IjN5bhWl
         9g4sNByRFMUzocTeQ8Z+I2B5JV7DOrRuCDicf33pAjMMBfUG5NtGn0qges7iX5+66ncn
         Y2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/GDz/IsdMmcCDZRowSDR4Fv2Qfj1zy1OtxkQuRkPWc=;
        b=n50EPNEa97zTfNvVFVIc8iJqekJSh2QVBRA43v7p8Yh4Iqkys3NSxco75JHWhbiGdZ
         zaqzd174HXU9sCLWom6+7/wAGsNf5vxzfzI0lxMCyzT+AyK0KVSOXJNRUFS4UrMM/yOY
         +jsZetF69Lej/ZNEZ4fpSJ+3oP+gK0w7N0raaHPrXLUkvl4Pimc+bzySWOUv6Sp+sgbL
         rCChsPRyzTEoM88PE4eVYaMlDWLOBDmAz4ykP+L5CT6dtJxsbpIV5wEqZRlGeKwb79ZJ
         WrY77IUru/zZOHYNB6dDti92XwITfkf3RQ+vQwLXhG8qrtzv8tkRpwqmLqNTRK3dfT4Q
         3Bow==
X-Gm-Message-State: AHQUAub9HVLBu4rpKfLr1GvzL9Z4MRL0c03qXzaFYnvumQV7V/Mg+BjP
        4evdldv4Nv88hnb6CX5oBZz6K7jmsYs=
X-Google-Smtp-Source: AHgI3IZIGFdLK0E05Vb//wPGIifqL10j36kHJDaCuc4fjJYcY8HpsDbjkn/5Cf3hNFQ3T42fnhUG9g==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr16737894wru.28.1549628944975;
        Fri, 08 Feb 2019 04:29:04 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y20sm4236525wra.51.2019.02.08.04.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:29:03 -0800 (PST)
Subject: Re: [PATCH v5 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
 <20190201130925.27066-2-srinivas.kandagatla@linaro.org>
 <20190208122113.GG23483@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6d3b6d2f-8ba1-fe87-ffbe-7a82c4a680db@linaro.org>
Date:   Fri, 8 Feb 2019 12:28:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208122113.GG23483@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2019 12:21, Greg KH wrote:
> On Fri, Feb 01, 2019 at 01:09:21PM +0000, Srinivas Kandagatla wrote:
>> The FastRPC driver implements an IPC (Inter-Processor Communication)
>> mechanism that allows for clients to transparently make remote method
>> invocations across DSP and APPS boundaries. This enables developers
>> to offload tasks to the DSP and free up the application processor for
>> other tasks.
>>
>> Co-developed-by: Thierry Escande<thierry.escande@linaro.org>
>> Signed-off-by: Thierry Escande<thierry.escande@linaro.org>
>> Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> Reviewed-by: Rob Herring<robh@kernel.org>
>> ---
>>   .../devicetree/bindings/misc/qcom,fastrpc.txt | 78 +++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> What changed from v4?  v2?  v3?
> 
I have done that in cover letter w.r.t previous versions,

Changes since v4(https://patchwork.kernel.org/cover/10779341/) :
- collected acks for DT from Rob.
- Removed unnecessary list safe iteration spotted by Greg KH.
- Removed unnecessary syslog spams.
- Added more checks to input validity.


> That needs to be somewhere in here, below the --- line or in the 00
> email at the least to give us some idea of what is different.
> 
> v6 please?
Sure, I can send v6 with full change log from RFC in cover letter along 
with some minor fixes.


thanks,
srini
