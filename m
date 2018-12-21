Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3108BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA16218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLmQE0zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbeLUHkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:40:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35659 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbeLUHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:40:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so4177245wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U3hF2lzG0nCdgTLxyEE6CaVxamDCtOZv9Y7nedTds7w=;
        b=DLmQE0zgKdiFuG+ryKJijs62w9eV0DTeIiLIAgH1fqekbztxihECkwl6qKxVFdVNYv
         tCKZ2a6uU7WZ+B1u1oc9KE6ErVYLyujm4PGQsV9BLdbF9CPHf7lfmpH4NMhcXdUU+Kp/
         CF4LnHSPnX938RJMDbyV6kFhOGJD9bHGh2Tdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U3hF2lzG0nCdgTLxyEE6CaVxamDCtOZv9Y7nedTds7w=;
        b=p8/vJu2Xs0sM0vM9hn9gWxodDQdC5LXWGsaE+ditVinc5UYKGC1037nDTLZc4BwljD
         ARuWQVfpnqbAHzr9PP65qXN3HdkCYNxaNTo3i6/hgPuyyJo/kN2YcUrFRFsOn+W4bsy1
         nkvqpqRhtlFIr2c4B54i3aa2OfDjIXoWEW/oBiZkOrrdEt+ZNy2s6b47tGizO3JJksrs
         l3x+GcoHDhq2UBpE5KmlQp5iwiKivuUA8FgSmFX1+CBm0vq2HgwXBtnZ6kg2eZQNruFi
         l6TzeoY1SI37qx06H6xwZEuKZiAe3Bk/fOuQXJq9eRuxVapV2j68/GLqRiFE+mnKbKtW
         7Lcg==
X-Gm-Message-State: AJcUukcCIP0+ZUeA6unm+93VR0hU9qioxC/AhcnXHVfLLZkuyx4gk8TX
        92PFRfM8jEnh4PPycCs/4tNySw==
X-Google-Smtp-Source: ALg8bN7JqZNyaB4RHZ5tAzCYZ/QTzHWrRCThn662CeNSGiMY1jnc1p5HsvQJQLQIzM/Tn1Eb6l7IIA==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr1300185wrg.237.1545378031878;
        Thu, 20 Dec 2018 23:40:31 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.119])
        by smtp.gmail.com with ESMTPSA id c9sm13726882wmh.27.2018.12.20.23.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 23:40:31 -0800 (PST)
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
Message-ID: <3107e7b1-7d5f-8a67-34ec-e2d6f31cb28f@linaro.org>
Date:   Fri, 21 Dec 2018 08:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220173633.GA19912@jackp-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
>> What is "qcom,dwc3-ss-usb-phy" which already exists then?
> Uh, apparently only the bindings doc is there but the driver never
> landed. I guess it fell through the cracks nearly 4 years ago.
>
> https://lore.kernel.org/patchwork/patch/499502/
>
> Jorge, does Andy's version of this driver at all resemble what can be
> used for QCS404?

the drivers seem quite different but I'll give it a go as well and 
compare (it is my understanding that the controller is the same - I will 
have access to the hardware documentation soon to compare)

but I'll come back to you on this.

>
> Jack

