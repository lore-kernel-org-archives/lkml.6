Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC764C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8642720879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzB76D3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeL1MjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:39:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40359 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeL1MjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:39:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so20818862wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lnIw1MthrHSvj7a6sLajCEOJ1/8XjiJnC0Qx+cGIMDg=;
        b=VzB76D3B6pRHwfVdcwjETtuQ8bFlx+m/IYF9ZeAPbeItEf5AK8MzhqZpmn0v3/27ok
         Dkwjud72VKjNUvDsxeISu6e5oTAM9z44JkG7mZAhcWVlsb6NcImkspUks4nV25SNBsx/
         kY6QO17Y734ZyOk1lUBJu82MRT9SmEDgaT3Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lnIw1MthrHSvj7a6sLajCEOJ1/8XjiJnC0Qx+cGIMDg=;
        b=szxCsHi0yX4YN3q+ShBgaA5x8W9UJoqtrkfivg31D8BKHQ0P+8Y8HHlIWXrbfZQYkG
         IXUHvp3RRJNefJ1p1xV0LXKNkwwyXhtmZG/2+LaAvq2uILYN2achGLClDJunOaTQEGRY
         N8NaCV+UxnXUBmjS2VbJQuYTSN3Ktlp+zEBhmftOE/OhYiS1ZxjJIEg2AQhKJJ/4JPaG
         Ku/3HT7x55TsQ+a8r4ayrBmndD+CInHSEwGImvYiCRHZxEz4bJ2JF48q9HFC1FjZxhAx
         fEhtJMXszkmiAQ9MI9TLmB5GbxyBLKaoK6HaZnDxEy5Nq4Hg+rAudqTjUcE2njFtqJGa
         3qig==
X-Gm-Message-State: AJcUukdyFFpwCq/7iigXFZEfduk3fm+ddejxZWc4frly8TYSoE0JWJOs
        iPFcMQRmV97DSpA0VHydvoO7NA==
X-Google-Smtp-Source: ALg8bN4Vu2KHUbfxm1Rrqn5iLQmq+n2Mi4o6G20Vf6Nk8XbEw1EMZgTV08RnSiAMmFB8UKhX7ppWrA==
X-Received: by 2002:a5d:50c5:: with SMTP id f5mr24189136wrt.37.1546000741273;
        Fri, 28 Dec 2018 04:39:01 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.92])
        by smtp.gmail.com with ESMTPSA id a17sm26705144wrs.58.2018.12.28.04.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 04:39:00 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
To:     Jack Pham <jackp@codeaurora.org>, Rob Herring <robh@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, kishon@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.guo@linaro.org, vkoul@kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20181220170531.GA19862@bogus>
 <20181220173633.GA19912@jackp-linux.qualcomm.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <2a007a91-e709-c9f1-f634-ddcf707e954d@linaro.org>
Date:   Fri, 28 Dec 2018 13:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220173633.GA19912@jackp-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 18:37, Jack Pham wrote:
> Hi Rob, Jorge,
> 
> On Thu, Dec 20, 2018 at 11:05:31AM -0600, Rob Herring wrote:
>> On Fri, Dec 07, 2018 at 10:55:57AM +0100, Jorge Ramirez-Ortiz wrote:
>>> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
>>> controller embedded in QCS404.
>>>
>>> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
>>> definitions.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> Reviewed-by: Vinod Koul <vkoul@kernel.org>
>>> ---
>>>   .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 78 ++++++++++++++++++++++
>>>   1 file changed, 78 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>> new file mode 100644
>>> index 0000000..fcf4e01
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>> @@ -0,0 +1,78 @@
>>> +Qualcomm Synopsys 1.0.0 SS phy controller
>>> +===========================================
>>> +
>>> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
>>> +chipsets
>>> +
>>> +Required properties:
>>> +
>>> +- compatible:
>>> +    Value type: <string>
>>> +    Definition: Should contain "qcom,usb-ssphy".
>>
>> What is "qcom,dwc3-ss-usb-phy" which already exists then?
> 
> Uh, apparently only the bindings doc is there but the driver never
> landed. I guess it fell through the cracks nearly 4 years ago.
> 
> https://lore.kernel.org/patchwork/patch/499502/
> 
> Jorge, does Andy's version of this driver at all resemble what can be
> used for QCS404?

on close inspection I cant see any similitudes between the drivers. 
Unfortunately I don't have access to documentation yet but the control 
register offsets and the control bits in the drivers do not match.

because of the above I'd like to go ahead with our separate drivers 
-already tested and validated- for HS (Shawn's) and SS (mine).

if that is acceptable, should we reuse the upstream bindings for  our 
implementation? or perhaps Shawn Guo will do for his HS version of the 
driver and I go ahead and create a new one? what would you suggest?





> 
> Jack
> 

