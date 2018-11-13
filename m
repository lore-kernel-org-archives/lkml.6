Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44E7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631C822507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ckM6nP7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631C822507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbeKMVJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:09:31 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:60962 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeKMVJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:09:30 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7DAEF24E0752;
        Tue, 13 Nov 2018 03:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542107513; bh=jwNjebw3qIYugPTS0DAXFGhhk4Ii29GbNu5jHGEADGs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=ckM6nP7A3YP3wFnfRSjgph8LVdOeZehmoZLk5DLCUq46TpYcK6w/Z5B1L9b6VRJ+Q
         jjonlXvwJsZfttSHHKa7mYag7/3NvQM1pSpivrSTOXZlD7QpV9bRCKiZjT0ZlTaB7c
         Voo7Bw5S45C8620gBYjbx7xRNdAdKJmNU1YEIz0pDUq/hPAGnEgdANmF+3ssxnz0J/
         XU8xkuys+Wya8obH5DYvSpbTy6DyhajCGFchxso4xQPU9wuRaGxLnrMr7yE7w1XKdX
         tOpl/8eWZFAowvjpcRcTtLYNqG3DT0TKvF8mBaqC6FIrzftpdR/WEY9DQ+OwUHvvf/
         TaQet2UEJG0eQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7C6185470;
        Tue, 13 Nov 2018 03:11:48 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 03:11:48 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 12:11:46 +0100
Received: from [10.0.2.15] (10.107.19.128) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 12:11:45 +0100
Subject: Re: [PATCH v3 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C
 master bindings
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Vitor soares <vitor.soares@synopsys.com>
CC:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <mshettel@codeaurora.org>, <swboyd@chromium.org>,
        <joao.pinto@synopsys.com>
References: <1541697251-20392-1-git-send-email-soares@synopsys.com>
 <1541697251-20392-3-git-send-email-soares@synopsys.com>
 <20181112101703.024ba1f3@bbrezillon>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <db819b2d-7426-4d40-fe8a-caf62cd2912f@synopsys.com>
Date:   Tue, 13 Nov 2018 11:11:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112101703.024ba1f3@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.128]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/11/18 09:17, Boris Brezillon wrote:
> On Thu,  8 Nov 2018 17:14:10 +0000
> Vitor soares <vitor.soares@synopsys.com> wrote:
>
>> Document Synopsys DesignWare I3C master module
>>
>> Signed-off-by: Vitor soares <soares@synopsys.com>
>> ---
>> Changes in v3:
>> - Remove dummy characters
>>
>> Changes in v2:
>> - Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
>> - Add controller version on compatible string
>>
>>   .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>> new file mode 100644
>> index 0000000..b930c09
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>> @@ -0,0 +1,42 @@
>> +Bindings for Synopsys DesignWare I3C master block
>> +=================================================
>> +
>> +Required properties:
>> +--------------------
>> +- compatible: shall be "snps,dw-i3c-master-1.00a"
>> +- clocks: shall reference the core_clk
> Are you sure this IP only requires only one clock? If you're unsure,
> you'd better have a clock-names prop.
Yes, the controller only has this clock dependency to configure the SCL.
>
>> +- interrupts: the interrupt line connected to this I3C master
>> +- reg: Offset and length of I3C master registers
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
>> +	i3c-master@2000 {
>> +		compatible = "snps,dw-i3c-master-1.00a";
>> +		#address-cells = <3>;
>> +		#size-cells = <0>;
>> +		reg = <0x02000 0x1000>;
>> +		interrupts = <0>;
>> +		clocks = <&i3cclk>;
>> +
>> +		eeprom@57{
>> +			compatible = "atmel,24c01";
>> +			reg = < 0x57 0x0 0x10>;
> 			       ^ remove this white space.
>
>> +			pagesize = <0x8>;
>> +		};
>> +	};
>> +

Best regards,

Vitor Soares

