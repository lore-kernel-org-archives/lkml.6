Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C9FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEE920844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoiEWR1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfBFOLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:11:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41554 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfBFOLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:11:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so7687210wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H26IpZSzsFoVzmoVGy0X//B3f2ZHBvcrKe8exAQCCD8=;
        b=GoiEWR1sTb71CGcrJprAe+8hBJIgWK8wlQrbrL2C+PHrhgKniMtWqD2QGrCpbWcssA
         JevcQEsf3bRe+Va4Jpm1nNsxy9VrGXnrLMcmn+EjDNSu/D5F4p6otMnepH1lNhVBoOwM
         igYPLD//L0+42Rl5tG05/6En5fS/Qb6ZR04VAAqLD6H0nJFCCFSxXs52HcfyIYvidEHP
         g+xnqtUU/hvxsdAr/lb29fmxkuV05aZ+5cfDOZLpUlm04kHH9fMZS479eGlQ9vymkPrK
         Ag2/RlfPRAOFDECCAZ5InmTL6NgRPsnPChaVdXEGW0VzHlvwz46LPLotCsl+0inx99MR
         zdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H26IpZSzsFoVzmoVGy0X//B3f2ZHBvcrKe8exAQCCD8=;
        b=qO0K/2Cgs1moqLE4CvlVnLM6KMEbgAB7r+4S8WWLh2xMcWAliAYzSZVBbTugBIvOMC
         zSpfAHO6aEVkBbh1Fdn8BrK9M+gZQ2VYndlacLyik6bnV10J1FFK3c73wlnmMCOLxbSx
         rpYarlS9AadXs45cf7aLlwm6HVcjLBRSUVRYsARLMWiyKepWHsEnohKo+4x+b+dbUjMe
         pwtTfMJNB/IsJYDoZkEQIuqnpMnyTldjuXoZK9HVgz/DI9LIkOc4uVFkPGKUDQTLb4/m
         oCNpctooBE6Dh6+rFX3eCHrAz4qzCwjCUulpfVD5HPDmvZvM6FaRSmQkpVPJRtwSLU9B
         H6PA==
X-Gm-Message-State: AHQUAuZGkHzkjmnZRd5EQp3Wfrdp0GI0o4SKacevCrPaaOQ6PPT566+U
        XZ05Y9q/YUT/8ITyB9qDpdLnD/iWeNQ=
X-Google-Smtp-Source: AHgI3IYufiPs/ge9lrZxAIrYRe0x5mGhgYAEl0EGEO8NfdO2TEpcQcfQ/3CIkMGCq1GakqKqJL1iRQ==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr8404986wrv.330.1549462309941;
        Wed, 06 Feb 2019 06:11:49 -0800 (PST)
Received: from [192.168.1.2] (119.red-83-34-190.dynamicip.rima-tde.net. [83.34.190.119])
        by smtp.gmail.com with ESMTPSA id w125sm40664556wmb.45.2019.02.06.06.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 06:11:49 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org,
        shawn.guo@linaro.org, vkoul@kernel.org, bjorn.andersson@linaro.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190130200218.GB5908@bogus>
 <f6823a9e-f2d0-ca5b-a2f8-eb362221ab81@linaro.org>
Message-ID: <63959c4f-211e-bc2e-12a4-c4ef61c818a9@linaro.org>
Date:   Wed, 6 Feb 2019 15:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f6823a9e-f2d0-ca5b-a2f8-eb362221ab81@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 12:02, Jorge Ramirez wrote:
> On 1/30/19 21:02, Rob Herring wrote:
>> On Tue, Jan 29, 2019 at 12:35:14PM +0100, Jorge Ramirez-Ortiz wrote:
>>> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
>>> controller embedded in QCS404.
>>>
>>> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
>>> definitions.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> ---
>>>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
>>>  1 file changed, 73 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>> new file mode 100644
>>> index 0000000..8ef6e39
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>> @@ -0,0 +1,73 @@
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
>> This is in no way specific enough.
> 
> ok. will remove the old unused bindings and reuse qcom,dwc3-ss-usb-phy
> 
>>
>>> +
>>> +- reg:
>>> +    Value type: <prop-encoded-array>
>>> +    Definition: USB PHY base address and length of the register map.
>>> +
>>> +- #phy-cells:
>>> +    Value type: <u32>
>>> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
>>> +
>>> +- clocks:
>>> +    Value type: <prop-encoded-array>
>>> +    Definition: See clock-bindings.txt section "consumers". List of
>>> +		 three clock specifiers for reference, phy core and
>>> +		 pipe clocks.
>>> +
>>> +- clock-names:
>>> +    Value type: <string>
>>> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
>>> +		 property. Must contain "ref", "phy" and "pipe".
>>> +
>>> +- vdd-supply:
>>> +    Value type: <phandle>
>>> +    Definition: phandle to the regulator VDD supply node.
>>> +
>>> +- vdda1p8-supply:
>>> +    Value type: <phandle>
>>> +    Definition: phandle to the regulator 1.8V supply node.
>>> +
>>> +
>>> +Optional child nodes:
>>> +
>>> +- vbus-supply:
>>> +    Value type: <phandle>
>>> +    Definition: phandle to the VBUS supply node.
>>
>> Does the phy actually get supplied by Vbus? If not, then Vbus supply 
>> should be defined in a USB connector node.
> 
> yes per the documentation vbus can optionally be routed to the phy to
> drive a signal to the controller.


funny enough when vbus is optionally routed to the phy is not to be
controlled like we do when the vbus-supply property is present.

So to all effects no, you are right, the phy does not get supplied by VBUS.

would defining the connector like this be enough?

usb3_phy: usb3-phy@78000 {
	compatible = "qcom,snps-usb-ssphy";
	[...]
	usb3_c_connector: usb3-c-connector {
		compatible = "usb-c-connector";
		label = "USB-C";
		type = "micro";
		vbus-supply = <&usb3_vbus_reg>;
	};
};


> 
> 
>>
>>> +
>>> +- resets:
>>> +    Value type: <prop-encoded-array>
>>> +    Definition: See reset.txt section "consumers". PHY reset specifiers
>>> +		 for phy core and COR resets.
>>
>> COR or COM?
> 
> com
>>
>> Looks to me the order is reversed.
> 
> yes
> 
>>
>>> +
>>> +- reset-names:
>>> +    Value type: <string>
>>> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
>>> +		 property. Must contain "com" and "phy".
>>> +
>>> +Example:
>>> +
>>> +usb3_phy: phy@78000 {
>>
>> usb3-phy@...
> 
> ok
> 
>>
>>> +	compatible = "qcom,usb-ssphy";
>>> +	reg = <0x78000 0x400>;
>>> +	#phy-cells = <0>;
>>> +	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
>>> +		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>>> +		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
>>> +	clock-names = "ref", "phy", "pipe";
>>> +	resets = <&gcc GCC_USB3_PHY_BCR>,
>>> +		 <&gcc GCC_USB3PHY_PHY_BCR>;
>>> +	reset-names = "com", "phy";
>>> +	vdd-supply = <&vreg_l3_1p05>;
>>> +	vdda1p8-supply = <&vreg_l5_1p8>;
>>> +	vbus-supply = <&usb3_vbus_reg>;
>>> +};
>>> -- 
>>> 2.7.4
>>>
>>
> 

