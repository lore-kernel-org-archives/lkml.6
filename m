Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08591217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfBZJOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:14:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17443 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbfBZJOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:14:14 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q9BJNm018319;
        Tue, 26 Feb 2019 10:14:03 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6cq62r-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Feb 2019 10:14:03 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D622E3F;
        Tue, 26 Feb 2019 09:14:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F1812967;
        Tue, 26 Feb 2019 09:14:01 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Feb
 2019 10:14:00 +0100
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add STM32 factory-programmed
 romem
To:     Rob Herring <robh@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lionel.debieve@st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
 <20190225165307.GA26260@bogus>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <d2473029-76a7-de2c-8ff5-9d065577f0b1@st.com>
Date:   Tue, 26 Feb 2019 10:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225165307.GA26260@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 5:53 PM, Rob Herring wrote:
> On Wed, Jan 30, 2019 at 05:38:53PM +0100, Fabrice Gasnier wrote:
>> Add documentation for STMicroelectronics STM32 Factory-programmed
>> read only memory area.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>> new file mode 100644
>> index 0000000..fbff52e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>> @@ -0,0 +1,31 @@
>> +STMicroelectronics STM32 Factory-programmed data device tree bindings
>> +
>> +This represents STM32 Factory-programmed read only non-volatile area: locked
>> +flash, OTP, read-only HW regs... This contains various information such as:
> 
> Several distinct types here. Does s/w need to know the difference 
> rather than just one generic-ish compatible? Access size restrictions 
> maybe? Ability to unlock and program?

Hi Rob,

The reading part is represented here as "st,stm32-romem" compatible, to
simply handle read only access. I agree this could be a generic-ish.

BUT the specifics are regarding the ability to unlock/lock and program.
Access size can vary from one part to another (e.g. on stm32f4,
reference manual sates: OTP area is divided into 16 OTP data blocks of
32 bytes. on stm32f7, OTP area is divided into 16 OTP data blocks of 64
bytes.)

In STM32MP15, both the read & write access through the BSEC are
specific, represented by dedicated compatible.

Do you wish I update the compatible to something like:
"st,stm32f4-otp"
"st,stm32mp15-bsec"
?

Thanks for reviewing,
Best regards,
Fabrice

> 
> If not, then why even make this stm32 specific?
> 
>> +analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
>> +internal vref (VREFIN_CAL), unique device ID...
>> +
>> +Required properties:
>> +- compatible:		Should be one of:
>> +			"st,stm32-romem"
>> +			"st,stm32mp15-bsec"
>> +- reg:			Offset and length of factory-programmed area.
>> +- #address-cells:	Should be '<1>'.
>> +- #size-cells:		Should be '<1>'.
>> +
>> +Optional Data cells:
>> +- Must be child nodes as described in nvmem.txt.
>> +
>> +Example on stm32f4:
>> +	romem: nvmem@1fff7800 {
>> +		compatible = "st,stm32-romem";
>> +		reg = <0x1fff7800 0x400>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		/* Data cells: ts_cal1 at 0x1fff7a2c */
>> +		ts_cal1: calib@22c {
>> +			reg = <0x22c 0x2>;
>> +		};
>> +		...
>> +	};
>> -- 
>> 1.9.1
>>
