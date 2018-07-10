Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402CA20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PN6qIUZW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NohKIZln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402CA20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeGJMcf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:32:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932752AbeGJMcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:32:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A66F607EB; Tue, 10 Jul 2018 12:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531225952;
        bh=U3w+5TpBXyjh/ReduGdT6iSPhRY1f4QC+m3/HF79dPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PN6qIUZWxnVaIas/JfTg4i+YyYEPmGFBcYsYHF9qkyjl0lIXSU5a4+hF1K4Z0FE1H
         DrRQ05vuHjCpMbIcZs1rpxhl9Ka1CK8Y1CdOR3m9P0V/YWuK+3by5RbmgfYiEFsnlz
         mZgXZcYGN8fOoF+fX1Y7QUBnfg5NpOn8IySOkRMw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A7F5A60227;
        Tue, 10 Jul 2018 12:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531225951;
        bh=U3w+5TpBXyjh/ReduGdT6iSPhRY1f4QC+m3/HF79dPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NohKIZlnHeHc1hSN4mjyPUvPanqKCzJYwvo5xNF4oTQTBTMNgvnVb92Q4lS0pQKY7
         xb9Q3Yr3gu7BCMAn5BVwDtnY2/jpY2VCw7odXY+4e+0cctm3R9zTnkbIlo/swJN+1B
         M/dpBYX7/k6GfN9KY27vEzcjUtpVnIRrbSk3gOiQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Jul 2018 18:02:31 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
In-Reply-To: <20180705204250.GA30484@rob-hp-laptop>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-2-bgodavar@codeaurora.org>
 <20180705204250.GA30484@rob-hp-laptop>
Message-ID: <afafe6e8055477020376f65dd14cc346@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2018-07-06 02:12, Rob Herring wrote:
> On Thu, Jul 05, 2018 at 10:25:09PM +0530, Balakrishna Godavarthi wrote:
>> This patch enables regulators for the Qualcomm Bluetooth wcn3990
>> controller.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v9:
>>     * updated with latest reg handle and names.
>>     * updated max-speed definition.
>> 
>> Changes in v8:
>>     * Separated the optional entries between two chips
>> 
>> Changes in v7:
>>     * no change.
>> 
>> Changes in v6:
>> 
>>     * Changed the oper-speed to max-speed.
>> 
>> Changes in v5:
>> 
>>     * Added entry for oper-speed and init-speed.
>> 
>> ---
>>  .../bindings/net/qualcomm-bluetooth.txt       | 28 
>> +++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 0ea18a53cc29..ced58575e2b8 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -10,12 +10,22 @@ device the slave device is attached to.
>>  Required properties:
>>   - compatible: should contain one of the following:
>>     * "qcom,qca6174-bt"
>> +   * "qcom,wcn3990-bt"
>> +
>> +Optional properties for compatible string qcom,qca6174-bt:
>> 
>> -Optional properties:
>>   - enable-gpios: gpio specifier used to enable chip
>>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> 
>> -Example:
>> +Optional properties for compatible string qcom,wcn3990-bt:
>> +
>> + - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
>> + - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
>> + - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
>> + - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
>> + - max-speed: see 
>> Documentation/devicetree/bindings/serial/slave-device.txt
>> +
>> +Examples:
>> 
>>  serial@7570000 {
>>  	label = "BT-UART";
>> @@ -28,3 +38,17 @@ serial@7570000 {
>>  		clocks = <&divclk4>;
>>  	};
>>  };
>> +
>> +serial@898000 {
>> +	label = "BT-UART";
> 
> label is generally intended for when you need to identify the physical
> connector which wouldn't apply here.
> 
>> +	status = "okay";
> 
> Don't show status in examples.
> 
>> +
>> +	bluetooth {
>> +		compatible = "qcom,wcn3990-bt";
>> +		vddio-supply = <&vreg_s4a_1p8>;
>> +		vddxosupply = <&vreg_l7a_1p8>;
> 
> Typo.
> 
> With those fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
>> +		vddrf-supply = <&vreg_l17a_1p3>;
>> +		vddch0-supply = <&vreg_l25a_3p3>;
>> +		max-speed = <3200000>;
>> +	};
>> +};
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for reviewing patch. will update those.

-- 
Regards
Balakrishna.
