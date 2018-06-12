Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40F4DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DEA2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f8gRuVED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DEA2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934896AbeFLBDj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:03:39 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45338 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934864AbeFLBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:03:37 -0400
Received: by mail-qt0-f196.google.com with SMTP id i18-v6so22213489qtp.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 18:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KhcKphqSSxJuZIcrzu6V5Tj36vrgJpuM8g/Qzk85E7s=;
        b=f8gRuVED3rKNLAoBlhEWtsYxDwJvu3CSnr4N6VL0DtsEPi4xFKDuD3DNopdPhbiHGM
         ISW795M6tq58feIoHt7VTc6Q9L/mZIgknAI2uDpLSUBq0/Pr+m6IAGWeMymA+/0xA6pM
         CPBVxqf94b05p/8dGY9+MFhTdbSlPvtSq7gfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhcKphqSSxJuZIcrzu6V5Tj36vrgJpuM8g/Qzk85E7s=;
        b=I9t40N9fgn5oLK9y0GMuTs7YQWBsXHF0vgjIWv4y7DqQrLEy0I1HIKELQoJX0qaWae
         kOh0+2nk/Ao7qhNmj0CIcyr7uywOGG5xOborbNfasI8h/uK3eue0tZcxvSQqHrq9dF5P
         KU6lKe8+gg2vkdykMFD4DcwZ6oSphQaOxFtitGEuCacnK+S0nycR+3Jjt3N0YzFj19EA
         xYbSB/E8kXetqXzXYfo62rBFtjHjtF/+U2qoPjwsY4aOzAXa2tQb4qLI79EMCZlKjx2p
         UzifC618f/UQDXrxqJAa6w5aGEIavnnq1u018Y8WgFQ9GDD2Yyr0jWCAVxdfgvTaGc1n
         wPXw==
X-Gm-Message-State: APt69E2K9/vz+TO5ZHGyrfdtJ7bpu6Xs5HyD26HUHrTeQNESkw7Suf9C
        7irBfM4zmNl6/cfsCLDLmzMwhQ==
X-Google-Smtp-Source: ADUXVKIpcv/8IndO+ybxzNllBjKqkEmOnP/T/lG7+pNKegoiLTq3rQCapau+A1HJ7hsRHWZ5Hb1rcw==
X-Received: by 2002:aed:238d:: with SMTP id j13-v6mr1451965qtc.384.1528765416832;
        Mon, 11 Jun 2018 18:03:36 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b38-v6sm4549448qta.96.2018.06.11.18.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 18:03:35 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
 <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com>
 <522816f9-c33f-ee58-619e-84ee86dba418@broadcom.com>
 <D95617BA-7C31-4737-9514-BA3F7B09DCE2@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <f4451a5c-ab0c-358a-60e8-ec03a5daa298@broadcom.com>
Date:   Mon, 11 Jun 2018 18:03:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <D95617BA-7C31-4737-9514-BA3F7B09DCE2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/2018 5:55 PM, Florian Fainelli wrote:
> On June 11, 2018 5:27:20 PM PDT, Ray Jui <ray.jui@broadcom.com> wrote:
>>
>>
>> On 6/11/2018 3:36 PM, Florian Fainelli wrote:
>>> On 05/29/2018 02:58 PM, Ray Jui wrote:
>>>> Change the PCIe INTx mapping to model the 4 INTx interrupts in the
>>>> IRQ domain of the iProc PCIe controller itself
>>>>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> ---
>>>>    arch/arm/boot/dts/bcm-cygnus.dtsi | 18 ++++++++++++++----
>>>>    1 file changed, 14 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> b/arch/arm/boot/dts/bcm-cygnus.dtsi
>>>> index 699fdf9..6de21ef 100644
>>>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>>>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>>>> @@ -254,9 +254,14 @@
>>>>    			compatible = "brcm,iproc-pcie";
>>>>    			reg = <0x18012000 0x1000>;
>>>>    
>>>> +			interrupt-controller;
>>>>    			#interrupt-cells = <1>;
>>>> -			interrupt-map-mask = <0 0 0 0>;
>>>> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>>>> +			interrupt-map-mask = <0 0 0 7>;
>>>> +			interrupt-map = <0 0 0 1 &pcie0 1>,
>>>> +					<0 0 0 2 &pcie0 2>,
>>>> +					<0 0 0 3 &pcie0 3>,
>>>> +					<0 0 0 4 &pcie0 4>;
>>>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
>>>
>>> You would want to fix those IRQ_TYPE_NONE values as well because
>> since
>>> commit 83a86fbb5b56b5eed8a476cc3fe214077d7c4f49 ("irqchip/gic: Loudly
>>> complain about the use of IRQ_TYPE_NONE") this is going to create
>> some
>>> nice warnings on boot.
>>>
>>> I am about to send fixes for NSP and HR2 since that's what I have
>> access
>>> to at the moment, but it would be good if you could send updates to
>> the
>>> Cygnus and NS2 DTS files?
>>>
>>> Thanks
>>>
>>
>> Okay. Thanks for letting me know. How do you want this to be done for
>> Cygnus and NS2?
>>
>> I guess I should have the fix patches to DTS done and sent out first,
>> and then rebase this INTx patch series against the patches with the
>> fix.
>>
>> Does that make sense to you?
> 
> Yes it does. As soon as v4.18-rc1 is tagged I will send the Device Tree fixes pull request, if I can have yours for Cygnus and NS2 in the next few days I could lump those together. Then we can either base your changes off v4.18-rc2 or a later tag that already has the DTS fixes.
> 

Okay that sounds good. I'll try to get those fixes out for you within 
the next few days.

Thanks!

Ray
