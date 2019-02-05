Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE93EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67652083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgXrTfZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfBELCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:02:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36333 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfBELCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:02:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so3132893wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 03:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHCRNsN/DXOVQgOjKjbrzcLFvgqEVSD2eE2iN0OqNho=;
        b=vgXrTfZQgycBb0HIz8O+OoGKxucePKyhMLJY6eGuUddq6d5gFowky9MLYVYHppVPKb
         +ge7c7fGa+92VTTD4X5Ph3fCW5KeK7y4+JC1nHVIz3D0hL7jDCD32Xmgt6xivG43Ph8/
         sAL0Lz7tHlNVzRbOytJmxpd3Juox07j0/8v9DzilxcfWCsTk73V9soGBCZVuafHQN0Pa
         1BECcmEgM/vj2LBuCf2abQbKL+zK7v4+XLWt9txh4Kg1BpYA7YS11MdEY52HSkDc/TRF
         Kmm9y68OIpxTJMtECoobW23Job27hUCRdAirNS/r5iQ0kWviQJY+NYAE48Q9tbhz1F6s
         e1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHCRNsN/DXOVQgOjKjbrzcLFvgqEVSD2eE2iN0OqNho=;
        b=Fa98vJjiq0W0G53UArKFvnLX4zMRNBKtptRiknpKKujX6RcWtJd8ZPuI2UbO/RJebk
         HOSeS40JUnmGiZv3I+2FAx7FLlEQRl4MQnFIiLs9p2VfTlUwEjntBYi2CehjkN0jSJQ1
         RjMBhJ8/gf0u4hmSKRiaTXwwRHH5bgAudmNSq6OtWnsjH9LF6nL5QSohpaih5H306qrD
         gZc0fF0Ar9bkFCtJJMorFvr+Bzx05DjqtJ37+UOLYUDlBZcQX8sP5KFO9cors+MRtOFZ
         fau2rm/w96aWpiFSeRP/DvjMjQofdp19zmG/aUqAzaf3R5RPs2MPf58GiMUWcrERd6Cp
         iv5Q==
X-Gm-Message-State: AHQUAubBUgK7Z8v4Rf1Hx9TA5ZgdU8eoCp1aUKaLbMXectVqaV2SOS6R
        7gkNYwoJdwHXIyHY0wPfB4WOwRWegQo=
X-Google-Smtp-Source: AHgI3Ib+rdCZnDCe6jYriM9DqrUUqwck14LS/t0G23s5MJSChKFOgnKAZGPIEeB0fLOQr91yHWgE+Q==
X-Received: by 2002:a1c:cbcb:: with SMTP id b194mr3017944wmg.64.1549364525872;
        Tue, 05 Feb 2019 03:02:05 -0800 (PST)
Received: from [192.168.1.2] (119.red-83-34-190.dynamicip.rima-tde.net. [83.34.190.119])
        by smtp.gmail.com with ESMTPSA id c9sm7193314wrs.84.2019.02.05.03.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 03:02:05 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
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
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <f6823a9e-f2d0-ca5b-a2f8-eb362221ab81@linaro.org>
Date:   Tue, 5 Feb 2019 12:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190130200218.GB5908@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 21:02, Rob Herring wrote:
> On Tue, Jan 29, 2019 at 12:35:14PM +0100, Jorge Ramirez-Ortiz wrote:
>> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
>> controller embedded in QCS404.
>>
>> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
>> definitions.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>> new file mode 100644
>> index 0000000..8ef6e39
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>> @@ -0,0 +1,73 @@
>> +Qualcomm Synopsys 1.0.0 SS phy controller
>> +===========================================
>> +
>> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
>> +chipsets
>> +
>> +Required properties:
>> +
>> +- compatible:
>> +    Value type: <string>
>> +    Definition: Should contain "qcom,usb-ssphy".
> 
> This is in no way specific enough.

ok. will remove the old unused bindings and reuse qcom,dwc3-ss-usb-phy

> 
>> +
>> +- reg:
>> +    Value type: <prop-encoded-array>
>> +    Definition: USB PHY base address and length of the register map.
>> +
>> +- #phy-cells:
>> +    Value type: <u32>
>> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
>> +
>> +- clocks:
>> +    Value type: <prop-encoded-array>
>> +    Definition: See clock-bindings.txt section "consumers". List of
>> +		 three clock specifiers for reference, phy core and
>> +		 pipe clocks.
>> +
>> +- clock-names:
>> +    Value type: <string>
>> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
>> +		 property. Must contain "ref", "phy" and "pipe".
>> +
>> +- vdd-supply:
>> +    Value type: <phandle>
>> +    Definition: phandle to the regulator VDD supply node.
>> +
>> +- vdda1p8-supply:
>> +    Value type: <phandle>
>> +    Definition: phandle to the regulator 1.8V supply node.
>> +
>> +
>> +Optional child nodes:
>> +
>> +- vbus-supply:
>> +    Value type: <phandle>
>> +    Definition: phandle to the VBUS supply node.
> 
> Does the phy actually get supplied by Vbus? If not, then Vbus supply 
> should be defined in a USB connector node.

yes per the documentation vbus can optionally be routed to the phy to
drive a signal to the controller.


> 
>> +
>> +- resets:
>> +    Value type: <prop-encoded-array>
>> +    Definition: See reset.txt section "consumers". PHY reset specifiers
>> +		 for phy core and COR resets.
> 
> COR or COM?

com
> 
> Looks to me the order is reversed.

yes

> 
>> +
>> +- reset-names:
>> +    Value type: <string>
>> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
>> +		 property. Must contain "com" and "phy".
>> +
>> +Example:
>> +
>> +usb3_phy: phy@78000 {
> 
> usb3-phy@...

ok

> 
>> +	compatible = "qcom,usb-ssphy";
>> +	reg = <0x78000 0x400>;
>> +	#phy-cells = <0>;
>> +	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
>> +		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>> +		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
>> +	clock-names = "ref", "phy", "pipe";
>> +	resets = <&gcc GCC_USB3_PHY_BCR>,
>> +		 <&gcc GCC_USB3PHY_PHY_BCR>;
>> +	reset-names = "com", "phy";
>> +	vdd-supply = <&vreg_l3_1p05>;
>> +	vdda1p8-supply = <&vreg_l5_1p8>;
>> +	vbus-supply = <&usb3_vbus_reg>;
>> +};
>> -- 
>> 2.7.4
>>
> 

