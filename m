Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968B21A37
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CecvTzrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2968B21A37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeHHTUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:20:09 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:48014 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:20:09 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A162710C02C5;
        Wed,  8 Aug 2018 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533747575; bh=n5gQ39V0XTXwTQw5tpnzprJJqj77ym38+PsWFodYbV8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=CecvTzrl1R4VePkEcR/LlcGrLr9hilskA5J5oUx5U80TVWwWEwY/7ENN77h28e617
         Pi7oY5p0CETE8lgzIaxNITPDFmxA5eXtkWv/pLML/9eTejrw2SYX6gbBSRYHcGGJG6
         RCHpO7rZoCgYs6aGN08gJg6+DwXotUn8Mg6IKLKpWcjlTa/FWHdAlpiElwmMkuDSU4
         J9qCUGyz8JWJ2pmm1vtJGewbq8iB0mZBuX6PsluOv+mpY/mX1J6TLuyugp9uMy8icS
         ZYRaagR97PeH8pp+ETdSWAF/MfoC6AQFDhQA7bMjCn8xx4IHYiAGQfdS1KPkp9C0Jj
         t5b7HZ+RdBtow==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id C71633907;
        Wed,  8 Aug 2018 09:59:30 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 8 Aug 2018 09:59:30 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 8 Aug 2018 18:59:27 +0200
Received: from [10.0.2.15] (10.107.25.93) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 8 Aug
 2018 18:59:26 +0200
Subject: Re: [PATCH 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C
 master bindings
To:     Rob Herring <robh@kernel.org>,
        Vitor soares <Vitor.Soares@synopsys.com>
CC:     <boris.brezillon@bootlin.com>, <wsa@the-dreams.de>,
        <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <Joao.Pinto@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <1532120272-17157-3-git-send-email-soares@synopsys.com>
 <20180725195733.GA14450@rob-hp-laptop>
From:   vitor <Vitor.Soares@synopsys.com>
Message-ID: <c00cb815-ae82-312a-213b-145537a294bd@synopsys.com>
Date:   Wed, 8 Aug 2018 17:59:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725195733.GA14450@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.93]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 25-07-2018 20:57, Rob Herring wrote:
> On Fri, Jul 20, 2018 at 09:57:51PM +0100, Vitor soares wrote:
>> This patch document Synopsys DesignWare I3C master DT bindings.
>>
>> Signed-off-by: Vitor soares <soares@synopsys.com>
>> ---
>>   .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 43 ++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>> new file mode 100644
>> index 0000000..7f5c8b0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>> @@ -0,0 +1,43 @@
>> +Bindings for Synopsys DesignWare I3C master block
>> +=================================================
>> +
>> +Required properties:
>> +--------------------
>> +- compatible: shall be "snps,dw-i3c-master"
> Only one version and no version number?
>
> ... and an SoC specific compatible string.

I'm not understanding. Can you explain?

>
>> +- clocks: shall reference the core_clk
>> +- clock-names: shall contain "core_clk"
> "_clk" is redundant and *-names with a single entry is kind of
> pointless.

I will fix it for next version.

>
>> +- interrupts: the interrupt line connected to this I3C master
>> +- reg:  Offset and length of I3C master registers
>> +
>> +Mandatory properties defined by the generic binding (see
>> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
>> +
>> +- #address-cells: shall be set to 3
>> +- #size-cells: shall be set to 0
>> +
>> +Optional properties defined by the generic binding (see
>> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
>> +
>> +- i2c-scl-hz
>> +- i3c-scl-hz
>> +
>> +I3C device connected on the bus follow the generic description (see
>> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
>> +
>> +Example:
>> +
>> +	i3c-master@0x2000 {
> Drop the '0x'
>
>> +		compatible = "snps,dw-i3c-master";
>> +		#address-cells = <3>;
>> +		#size-cells = <0>;
>> +		reg = <0x02000 0x1000>;
>> +		interrupts = <0>;
>> +		clocks = <&i3cclk>;
>> +		clock-names = "core_clk";
>> +
>> +		eeprom@0x57{
>> +			compatible = "atmel,24c01";
>> +			reg = < 0x57 0x80000010 0x0>;
>> +			pagesize = <0x8>;
>> +		};
>> +	};
>> -- 
>> 2.7.4
>>
>>

Thanks for your feedback.

Best regards,
Vitor Soares
