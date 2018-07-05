Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB4BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199CB23FF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="az2kIswr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fIPpsuMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199CB23FF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753855AbeGEPrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:47:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43620 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeGEPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:47:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C56960B28; Thu,  5 Jul 2018 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530805635;
        bh=PZBehTwsgU5zaT6W6NZSskTF1SYyUjzvuTJUCtZpQsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=az2kIswr0mg9IkRruanBgwj6UrxJx7B+/vbN7YrQr3cIV4pCZav/6a9INphvQEbbJ
         v6hepVgUuyjCkeJT3CQSjtxaUMxocvorf583AydRjdYIxq6xGD2dpuVi66uXR+dFm1
         2zlW4HN2tEIMyhCIWxxjIGejhHkppEWtVEYrMRAc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 816CE601CF;
        Thu,  5 Jul 2018 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530805634;
        bh=PZBehTwsgU5zaT6W6NZSskTF1SYyUjzvuTJUCtZpQsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fIPpsuMvWED0ZSJVECgZK4OGzne5L1VdQmRisJ0kHz1GUrwX2yUQzIE7paQwRQxvu
         PCLrEey6TuJNJRgrCp+XfAnWKN6PnrF7Gc8IvxYK+MV1GF9DvmXqnK1c59zEMEYx6a
         Bf57RQZWIJkiEZitBbHTTsB1BUGDMj3RkhIeHhMA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Jul 2018 21:17:14 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
In-Reply-To: <20180625145837.GA21153@rob-hp-laptop>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-2-bgodavar@codeaurora.org>
 <20180625145837.GA21153@rob-hp-laptop>
Message-ID: <0349ef8d37bbb8f45e6935d810ced897@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2018-06-25 20:28, Rob Herring wrote:
> On Mon, Jun 25, 2018 at 07:10:07PM +0530, Balakrishna Godavarthi wrote:
>> This patch enables regulators for the Qualcomm Bluetooth wcn3990
>> controller.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
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
>>  .../bindings/net/qualcomm-bluetooth.txt       | 30 
>> +++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt 
>> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> index 0ea18a53cc29..c2b09dd2bf31 100644
>> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> @@ -10,12 +10,23 @@ device the slave device is attached to.
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
>> + - vddio-supply: Bluetooth VDD IO regulator handle.
>> + - vddxtal-supply: Bluetooth VDD XTAL regulator handle.
>> + - vddpa-supply: Bluetooth VDD PA regulator handle.
>> + - vddldo-supply: Bluetooth VDD LDO regulator handle.
>> + - vddcore-supply: Bluetooth VDD CORE regulator handle.
>> + - max-speed: Maximum operating speed of the chip.
> 
> This shouldn't be per compatible really. The definition here is wrong
> too. You should know the max baud for the chip based on the compatible.
> This property is for when the max is less than the max of either the
> chip or host UART.
> 
> Rob

I have enabled max-speed in probe for compatible "qcom,wcn3990-bt", so 
it under the specific compatible string.
will update definition.

-- 
Regards
Balakrishna.
