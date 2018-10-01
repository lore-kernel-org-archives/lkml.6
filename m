Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EAAC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5B2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F5B2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeJASyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:54:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10287 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728979AbeJASyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:54:10 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w91CEFg7009912;
        Mon, 1 Oct 2018 14:16:03 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mu1hd3y9u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 14:16:03 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 102173A;
        Mon,  1 Oct 2018 12:16:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7473F2BDF;
        Mon,  1 Oct 2018 12:16:02 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.47) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Oct
 2018 14:16:02 +0200
Subject: Re: [PATCH V2 23/27] mmc: mmci: add variant property to request a
 reset
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-24-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqxBuQcafS2KFqPDwb4=V1Jwoovb4+VsJZjAA5CeKs2kw@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <a956549b-a84e-2582-1fce-3b15495f208c@st.com>
Date:   Mon, 1 Oct 2018 14:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqxBuQcafS2KFqPDwb4=V1Jwoovb4+VsJZjAA5CeKs2kw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

On 10/01/2018 11:30 AM, Ulf Hansson wrote:
> On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> Some variants could require a reset.
>> STM32 sdmmc variant needs to reset hardware block
>> during the power cycle procedure (for re-initialization)
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>>   drivers/mmc/host/mmci.c                        | 9 +++++++++
>>   drivers/mmc/host/mmci.h                        | 4 ++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
>> index 03796cf..e952707 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
>> @@ -11,6 +11,8 @@ Required properties:
>>   - compatible             : contains "arm,pl18x", "arm,primecell".
>>   - vmmc-supply            : phandle to the regulator device tree node, mentioned
>>                              as the VCC/VDD supply in the eMMC/SD specs.
>> +depend of variant:
>> +- resets                 : phandle to internal reset line.
>>
> 
> This looks like a thing depending on the SoC, rather than on the
> variant. Therefore, I suggest you move this to be an optional DT
> property.

could be replaced by:

Optional properties:
- resets                 : phandle to internal reset line.
			   Should be defined for sdmmc variant.

> 
> Also, please move the DT doc update into a separate patch.

OK

> 
>>   Optional properties:
>>   - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index b1d5bc5..6b3c33f 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -37,6 +37,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/types.h>
>>   #include <linux/pinctrl/consumer.h>
>> +#include <linux/reset.h>
>>
>>   #include <asm/div64.h>
>>   #include <asm/io.h>
>> @@ -1854,6 +1855,14 @@ static int mmci_probe(struct amba_device *dev,
>>
>>          dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
>>
>> +       if (variant->reset) {
>> +               host->rst = devm_reset_control_get_exclusive(&dev->dev, NULL);
> 
> As suggested, let's make this optional and not depending on the variant.

I done like that because is required for my variant (if no reset, no 
power cycle for sdmmc).

If you prefer, I could move to optional with 
"devm_reset_control_get_optional_exclusive"
And I add a comment in mmci dt binding to specify that not optional
for sdmmc. (see above)

> 
>> +               if (IS_ERR(host->rst)) {
>> +                       ret = PTR_ERR(host->rst);
>> +                       goto clk_disable;
>> +               }
>> +       }
>> +
>>          /* Get regulators and the supported OCR mask */
>>          ret = mmc_regulator_get_supply(mmc);
>>          if (ret)
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index e130689..f0fa185 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -247,6 +247,7 @@ struct mmci_host;
>>    * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
>>    *            register.
>>    * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>> + * @reset: true if variant has need reset signal.
>>    */
>>   struct variant_data {
>>          unsigned int            clkreg;
>> @@ -285,6 +286,7 @@ struct variant_data {
>>          bool                    qcom_dml;
>>          bool                    reversed_irq_handling;
>>          bool                    mmcimask1;
>> +       bool                    reset;
>>          unsigned int            irq_pio_mask;
>>          u32                     start_err;
>>          u32                     opendrain;
>> @@ -318,6 +320,8 @@ struct mmci_host {
>>          struct clk              *clk;
>>          bool                    singleirq;
>>
>> +       struct reset_control    *rst;
>> +
>>          spinlock_t              lock;
>>
>>          unsigned int            mclk;
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
