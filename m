Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeEQKEk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:04:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17670 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751858AbeEQKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:04:37 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] rtc: stm32: add stm32mp1 rtc support
Thread-Topic: [PATCH v2 3/3] rtc: stm32: add stm32mp1 rtc support
Thread-Index: AQHT56ze/8fjHTRwJkyhVQlr72s466QyuTAAgADimYA=
Date: Thu, 17 May 2018 10:03:41 +0000
Message-ID: <18a9abfc-a67c-509e-7f9b-af666ada52ae@st.com>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
 <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
 <20180516203240.GB24496@piout.net>
In-Reply-To: <20180516203240.GB24496@piout.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <41C4990E1A1C24408B13FA943DBE64D3@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HA4j5q032094

On 05/16/2018 10:32 PM, Alexandre Belloni wrote:
> On 09/05/2018 17:46:10+0200, Amelie Delaunay wrote:
>>   struct stm32_rtc_registers {
>> @@ -86,6 +98,9 @@ struct stm32_rtc_registers {
>>   	u8 prer;
>>   	u8 alrmar;
>>   	u8 wpr;
>> +	u8 sr;
>> +	u8 scr;
>> +	u16 verr;
> 
> All those offsets should probably be u16 or u32...
>

OK, those offsets will be all u16 in v3, the maximum STM32 RTC register 
offset value being 0x3FC.

>> +	if (regs.verr != UNDEF_REG) {
> 
> ...else, this is not working, as reported by kbuild
> 

Yes, in v3, UNDEF_REG will be the maximum u16 value (0xFFFF) instead of ~0.

>> +		u32 ver = readl_relaxed(rtc->base + regs.verr);
>> +
>> +		dev_info(&pdev->dev, "registered rev:%d.%d\n",
>> +			 (ver >> STM32_RTC_VERR_MAJREV_SHIFT) & 0xF,
>> +			 (ver >> STM32_RTC_VERR_MINREV_SHIFT) & 0xF);
>> +	}
>> +
> 

Thanks,
Amelie
