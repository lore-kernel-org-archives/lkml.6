Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93DAC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B6321915
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdsmURBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfAYIcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:32:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54479 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:32:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so5870516wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jo/yKNc+FHcu1ZPWzAgglGyjX2mEGEzJhVOfioU4LWA=;
        b=kdsmURBnwCi2J3yPzg1+JmgDGRuYs3K8a7YE9IkOOEm9jkoVS6YNVRl7myUfK7TWN3
         r73RoAEYOWqRL8itKmO0lcwSFtqp7wHgiN7sOqeObfhIFwTe0Z/6FxOGnrFrAFr9z0Nc
         bMwU5fwFbdMqYErYcfePgvFc36Fo0Bj0Sln2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jo/yKNc+FHcu1ZPWzAgglGyjX2mEGEzJhVOfioU4LWA=;
        b=mxLs0syDR4aN3+PHmq64ThAbxeFCMBcnT7RjZClAEUeFijn8Klpy6qSB/I/TqfB7ph
         QkIecO/erlJ+Ibpsu13dmxwaJETz/vyVzy81CbmF+mizJpMpBhW6lbBA+waaxAWs1AKb
         PNEcxfi6slbpER/scV3jasN5pI2xYXSpcaKxkJ4uBFtsB2kdEwxUqnhbMIxMaT0MbG4n
         jSpncaNwljV8NinFCCp4SBwrDp0afb80hrJ9rkM163fqDzf4eUAG3LTjv3IXuLWrgYmD
         hfwvtRCerOBZIq0Ssboxoz99vRYxd4yMhn22AtfAfa0vf2E8i8NSFOIqB01FBU6APf2Y
         ZayA==
X-Gm-Message-State: AJcUukfjA5cHp3KDmfYgnEbJPtnWzO2p04i/9qSTmRdmaP+7W0w/l8mC
        RdPdCYbWpmcP5yi1vxdoGyG+tw==
X-Google-Smtp-Source: ALg8bN4E5oDD7cJoQcSx2sKOW+uG1V3qVzQTsN1tUApqOiIpIZ6ofedNIdY1EZYdgwzYO2oYT21ZLA==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr5846986wmk.139.1548405148982;
        Fri, 25 Jan 2019 00:32:28 -0800 (PST)
Received: from [192.168.28.94] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id a132sm77592114wmh.5.2019.01.25.00.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 00:32:28 -0800 (PST)
Subject: Re: [PATCH v3] arm64: dts: sdm845: add video nodes
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Malathi Gottam <mgottam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <1545292023-5489-1-git-send-email-mgottam@codeaurora.org>
 <0ee6676f-f169-1ea1-506e-16e4097d1c04@linaro.org>
 <CAPBb6MWedPvoFW2jrqhZhNP-41PrEC+G4xnXs=cex1ywnVdm-w@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <323bca85-6dc3-4d28-ec02-69ce57bc6506@linaro.org>
Date:   Fri, 25 Jan 2019 10:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MWedPvoFW2jrqhZhNP-41PrEC+G4xnXs=cex1ywnVdm-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 1/25/19 9:46 AM, Alexandre Courbot wrote:
> On Thu, Jan 17, 2019 at 8:58 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi Malathi,
>>
>> On 12/20/18 9:47 AM, Malathi Gottam wrote:
>>> This adds video nodes to sdm845 based on the examples
>>> in the bindings.
>>>
>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>
>> Looks good to me:
>>
>> Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index b72bdb0..ccd2b10 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -87,6 +87,11 @@
>>>                       reg = <0 0x86200000 0 0x2d00000>;
>>>                       no-map;
>>>               };
>>> +
>>> +             venus_region: memory@95800000 {
>>> +                     reg = <0x0 0x95800000 0x0 0x500000>;
>>> +                     no-map;
>>> +             };
>>>       };
>>>
>>>       cpus {
>>> @@ -1403,5 +1408,35 @@
>>>                               status = "disabled";
>>>                       };
>>>               };
>>> +
>>> +             video-codec@aa00000 {
>>> +                     compatible = "qcom,sdm845-venus";
>>> +                     reg = <0x0aa00000 0xff000>;
>>> +                     interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>>> +                     power-domains = <&videocc VENUS_GDSC>;
>>> +                     clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
>>> +                              <&videocc VIDEO_CC_VENUS_AHB_CLK>,
>>> +                              <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
>>> +                     clock-names = "core", "iface", "bus";
>>> +                     iommus = <&apps_smmu 0x10a0 0x8>,
>>> +                              <&apps_smmu 0x10b0 0x0>;
>>> +                     memory-region = <&venus_region>;
>>> +
>>> +                     video-core0 {
>>> +                             compatible = "venus-decoder";
>>> +                             clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
>>> +                                      <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
>>> +                             clock-names = "core", "bus";
>>> +                             power-domains = <&videocc VCODEC0_GDSC>;
>>> +                     };
>>> +
>>> +                     video-core1 {
>>> +                             compatible = "venus-encoder";
>>> +                             clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
>>> +                                      <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
>>> +                             clock-names = "core", "bus";
>>> +                             power-domains = <&videocc VCODEC1_GDSC>;
>>> +                     };
>>> +             };
> 
> This patch lacks the video-firmware node, it should at the very least
> be added before this gets merged.

The firmware node should be added in board dts file, the for example
sdm845-mtp will not populate firmware node because it uses TZ for
firmware loading.


-- 
regards,
Stan
