Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E383AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D4421479
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="FY5Esor8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D4421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLCJAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:00:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43670 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLCJAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:00:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so8475129lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X6gR6oTiKV1eZi/PIL0iVx3uz2eaIcricEaPUfGvikw=;
        b=FY5Esor8O+Tn6mvOzZpBXSBJEXq4SeC6kblc4CicZnWHq8gWEePxp8BNz6KRJnuwFo
         HIhqpOXhrH3UFqrHCHsd524DlJYJ1WBcaVOk5gTKShK2JErG2R+OOSPYhocxXzAwCdnC
         ajQtuWy1Tc8FLDdF7TMYMRbbz3/u1eqbUMAQ8bKRtby26ucjRXvNDuu9DMh40BE7Fv7o
         pG2rJqGN/IElt7ZuYec21p2yVYakkyGjGnqpH2gajq/pRCxqoCvjeYexyS4e/jhIhzD/
         Xy47W1Mc6oomHMZXtsYt3pT0jw8AqtBW+S/dL4uPWKdSFj6sdtBPJ4hEkIEE6g25vZ95
         bbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X6gR6oTiKV1eZi/PIL0iVx3uz2eaIcricEaPUfGvikw=;
        b=I616wCLmbQLMqMduMnbRt03QQcl7uWeMnqQkCUvKdiVIldMILYZwoX2wLb4Z084kVM
         4zjvy02A/zUkWjhWGnI1u5IXoM3ClzH6LmtqGAbm4/ZWto/BVEK0K4QExZnUUa51f7t6
         TMZKnHYnhhTigUuMA48/oyTcEuavQtqt1KdPYglPfkoHgOM7yHva2tpnYFuwdrGg8vs3
         gZBz5i1sZ/LU0ABrA//sHvMHxs1OhR9ukh7aQXRIXomXaStBbJk+L3/tQNFK7+cE4DIO
         7lwayN4saTtr6czIblT+qYenQymnzrGwMAp3itJ83NlYA8Sq6HgcnhO9p8DJbIStpB4D
         XUEQ==
X-Gm-Message-State: AA+aEWbdQDB8tVmJND9iiNthrCs3VnEqjp3RiEfvsXwkjqru9Ds2LoPy
        sJ6YPuqs+dVYnAZNHnicu3dVbg==
X-Google-Smtp-Source: AFSGD/WJIWqnIy26NSKRRjE0EnbWnuQbpFcSPL8r+HKNqT6zkLpU3O+COAK0yx9u1sb5qdyjBNQmKA==
X-Received: by 2002:a19:d007:: with SMTP id h7mr8495076lfg.52.1543827614477;
        Mon, 03 Dec 2018 01:00:14 -0800 (PST)
Received: from [192.168.0.200] ([31.173.84.149])
        by smtp.gmail.com with ESMTPSA id n8-v6sm2558966lji.90.2018.12.03.01.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 01:00:13 -0800 (PST)
Subject: Re: [PATCH v1 01/12] dt-bindings: usb: add support for dwc3
 controller on HiSilicon SoCs
To:     Chen Yu <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wangbinghui@hisilicon.com, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-2-chenyu56@huawei.com>
 <fde4d37b-0c4d-055b-a0ba-4e9fe87717ad@cogentembedded.com>
 <33cda716-d09c-28e7-d4b4-26f246786f5e@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <680c5b9f-e2c7-926d-7d10-4ce2cd091282@cogentembedded.com>
Date:   Mon, 3 Dec 2018 11:59:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <33cda716-d09c-28e7-d4b4-26f246786f5e@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.2018 11:51, Chen Yu wrote:

>>> This patch adds binding descriptions to support the dwc3 controller
>>> on HiSilicon SoCs and boards like the HiKey960.
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: John Stultz <john.stultz@linaro.org>
>>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>>> ---
>>>    .../devicetree/bindings/usb/dwc3-hisi.txt          | 67 ++++++++++++++++++++++
>>>    1 file changed, 67 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3-hisi.txt b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>> new file mode 100644
>>> index 000000000000..d32d2299a0a1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>> @@ -0,0 +1,67 @@
>>> +HiSilicon DWC3 USB SoC controller
>>> +
>>> +This file documents the parameters for the dwc3-hisi driver.
>>> +
>>> +Required properties:
>>> +- compatible:    should be "hisilicon,hi3660-dwc3"
>>> +- clocks:    A list of phandle + clock-specifier pairs for the
>>> +        clocks listed in clock-names
>>> +- clock-names:    Specify clock names
>>> +- resets:    list of phandle and reset specifier pairs.
>>> +
>>> +Sub-nodes:
>>> +The dwc3 core should be added as subnode to HiSilicon DWC3 as shown in the
>>> +example below. The DT binding details of dwc3 can be found in:
>>> +Documentation/devicetree/bindings/usb/dwc3.txt
>>> +
>>> +Example:
>>> +    usb3: hisi_dwc3 {
>>> +        compatible = "hisilicon,hi3660-dwc3";
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +        ranges;
>>> +
>>> +        clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
>>> +             <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>>> +        clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
>>> +        assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>>> +        assigned-clock-rates = <229000000>;
>>> +        resets = <&crg_rst 0x90 8>,
>>> +             <&crg_rst 0x90 7>,
>>> +             <&crg_rst 0x90 6>,
>>> +             <&crg_rst 0x90 5>;
>>> +
>>> +        dwc3: dwc3@ff100000 {
>>
>>      According to the DT spec, the node names should be generic, not chip specific, i.e. usb@ff100000 in this case.
>>
> 
> Do you mean it should be usb@ff100000: dwc3@ff100000 ?

	dwc3: usb@ff100000

    "dwc3:" is a label, not name.

> Thanks!
> 
>> [...]

MBR, Sergei
