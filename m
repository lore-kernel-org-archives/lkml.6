Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A86C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ECC20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ECC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeFTNfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:35:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48746 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754017AbeFTNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:35:43 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5KDXsKN002473;
        Wed, 20 Jun 2018 15:35:04 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jpma38w8c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Jun 2018 15:35:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3769C3D;
        Wed, 20 Jun 2018 13:35:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B9512BD9;
        Wed, 20 Jun 2018 13:35:04 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 15:35:02 +0200
Subject: Re: [PATCH V2 1/3] watchdog: stm32: add pclk feature for stm32mp1
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1529481238-15277-1-git-send-email-ludovic.Barre@st.com>
 <1529481238-15277-2-git-send-email-ludovic.Barre@st.com>
 <6162d701-2afd-5a22-d38f-7fb9e726cff7@roeck-us.net>
 <e9babb86-7588-5de6-93ab-4cdd8982e773@st.com>
 <d1d5e5f8-2e0f-7a73-ec43-6bb1f3d5f19c@roeck-us.net>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <9e3edcdb-5bf5-2731-fb05-4baf0ab5822c@st.com>
Date:   Wed, 20 Jun 2018 15:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d1d5e5f8-2e0f-7a73-ec43-6bb1f3d5f19c@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 03:29 PM, Guenter Roeck wrote:
> On 06/20/2018 06:24 AM, Ludovic BARRE wrote:
>>
>>
>> On 06/20/2018 11:19 AM, Guenter Roeck wrote:
>>> On 06/20/2018 12:53 AM, Ludovic Barre wrote:
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> This patch adds config data to manage specific properties by
>>>> compatible. Adds stm32mp1 config which requires pclk clock.
>>>>
>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>> ---
>>>>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  21 +++-
>>>>   drivers/watchdog/stm32_iwdg.c                      | 132 
>>>> ++++++++++++++-------
>>>>   2 files changed, 104 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt 
>>>> b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>>>> index cc13b10a..f07f6d89 100644
>>>> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>>>> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>>>> @@ -2,18 +2,31 @@ STM32 Independent WatchDoG (IWDG)
>>>>   ---------------------------------
>>>>   Required properties:
>>>> -- compatible: "st,stm32-iwdg"
>>>> -- reg: physical base address and length of the registers set for 
>>>> the device
>>>> -- clocks: must contain a single entry describing the clock input
>>>> +- compatible: Should be either "st,stm32-iwdg" or "st,stm32mp1-iwdg"
>>>> +- reg: Physical base address and length of the registers set for 
>>>> the device
>>>> +- clocks: Reference to the clock entry lsi. Additional pclk clock 
>>>> entry
>>>> +  is required only for st,stm32mp1-iwdg.
>>>> +- clock-names: Name of the clocks used.
>>>> +  "lsi" for st,stm32-iwdg
>>>> +  "pclk", "lsi" for st,stm32mp1-iwdg
>>>>   Optional Properties:
>>>>   - timeout-sec: Watchdog timeout value in seconds.
>>>> -Example:
>>>> +Examples:
>>>>   iwdg: watchdog@40003000 {
>>>>       compatible = "st,stm32-iwdg";
>>>>       reg = <0x40003000 0x400>;
>>>>       clocks = <&clk_lsi>;
>>>> +    clock-names = "lsi";
>>>> +    timeout-sec = <32>;
>>>> +};
>>>> +
>>>> +iwdg: iwdg@5a002000 {
>>>> +    compatible = "st,stm32mp1-iwdg";
>>>> +    reg = <0x5a002000 0x400>;
>>>> +    clocks = <&rcc IWDG2>, <&clk_lsi>;
>>>> +    clock-names = "pclk", "lsi";
>>>>       timeout-sec = <32>;
>>>>   };
>>>> diff --git a/drivers/watchdog/stm32_iwdg.c 
>>>> b/drivers/watchdog/stm32_iwdg.c
>>>> index c97ad56..fc96670 100644
>>>> --- a/drivers/watchdog/stm32_iwdg.c
>>>> +++ b/drivers/watchdog/stm32_iwdg.c
>>>> @@ -11,12 +11,13 @@
>>>>   #include <linux/clk.h>
>>>>   #include <linux/delay.h>
>>>> -#include <linux/kernel.h>
>>>> -#include <linux/module.h>
>>>>   #include <linux/interrupt.h>
>>>>   #include <linux/io.h>
>>>>   #include <linux/iopoll.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>>   #include <linux/of.h>
>>>> +#include <linux/of_device.h>
>>>>   #include <linux/platform_device.h>
>>>>   #include <linux/watchdog.h>
>>>> @@ -54,11 +55,17 @@
>>>>   #define TIMEOUT_US    100000
>>>>   #define SLEEP_US    1000
>>>> +struct stm32_iwdg_config {
>>>> +    bool has_pclk;
>>>> +};
>>>> +
>>>
>>> This data structure is unnecessary. Just assign the boolean directly 
>>> to .data
>>> and ...
>>>
>>
>> Ok, I send a v3, with boolean directly to .data
>> like:
>>
>> #define NO_PCLK        false
>> #define HAS_PCLK    true
>> ...
> 
> Just use true/false directly. There is no need for those defines.
> 
> If you want the reader to understand what is defined, I would be ok with
> 
> #define HAS_PCLK    true
> 
> static const struct of_device_id stm32_iwdg_of_match[] = {
>       { .compatible = "st,stm32-iwdg", .data = (void *) !HAS_PCLK },
>       { .compatible = "st,stm32mp1-iwdg", .data = (void *) HAS_PCLK },
>       { /* end node */ }
> 
> Guenter

Ok, thanks

> 
>> static const struct of_device_id stm32_iwdg_of_match[] = {
>>      { .compatible = "st,stm32-iwdg", .data = (void *) NO_PCLK },
>>      { .compatible = "st,stm32mp1-iwdg", .data = (void *) HAS_PCLK },
>>      { /* end node */ }
>> };
>>
>> Note:
>> V3, because I sent my original version with V2
>> (it's mistake)
>>
>>>>   struct stm32_iwdg {
>>>> -    struct watchdog_device    wdd;
>>>> -    void __iomem        *regs;
>>>> -    struct clk        *clk;
>>>> -    unsigned int        rate;
>>>> +    struct watchdog_device        wdd;
>>>> +    void __iomem            *regs;
>>>> +    struct stm32_iwdg_config    *config;
>>>
>>> declare bool has_pclk here.
>>>
>>>> +    struct clk            *clk_lsi;
>>>> +    struct clk            *clk_pclk;
>>>> +    unsigned int            rate;
>>>>   };
>>>>   static inline u32 reg_read(void __iomem *base, u32 reg)
>>>> @@ -133,6 +140,44 @@ static int stm32_iwdg_set_timeout(struct 
>>>> watchdog_device *wdd,
>>>>       return 0;
>>>>   }
>>>> +static int stm32_iwdg_clk_init(struct platform_device *pdev,
>>>> +                   struct stm32_iwdg *wdt)
>>>> +{
>>>> +    u32 ret;
>>>> +
>>>> +    wdt->clk_lsi = devm_clk_get(&pdev->dev, "lsi");
>>>> +    if (IS_ERR(wdt->clk_lsi)) {
>>>> +        dev_err(&pdev->dev, "Unable to get lsi clock\n");
>>>> +        return PTR_ERR(wdt->clk_lsi);
>>>> +    }
>>>> +
>>>> +    /* optional peripheral clock */
>>>> +    if (wdt->config->has_pclk) {
>>>> +        wdt->clk_pclk = devm_clk_get(&pdev->dev, "pclk");
>>>> +        if (IS_ERR(wdt->clk_pclk)) {
>>>> +            dev_err(&pdev->dev, "Unable to get pclk clock\n");
>>>> +            return PTR_ERR(wdt->clk_pclk);
>>>> +        }
>>>> +
>>>> +        ret = clk_prepare_enable(wdt->clk_pclk);
>>>> +        if (ret) {
>>>> +            dev_err(&pdev->dev, "Unable to prepare pclk clock\n");
>>>> +            return ret;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    ret = clk_prepare_enable(wdt->clk_lsi);
>>>> +    if (ret) {
>>>> +        dev_err(&pdev->dev, "Unable to prepare lsi clock\n");
>>>> +        clk_disable_unprepare(wdt->clk_pclk);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    wdt->rate = clk_get_rate(wdt->clk_lsi);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static const struct watchdog_info stm32_iwdg_info = {
>>>>       .options    = WDIOF_SETTIMEOUT |
>>>>                 WDIOF_MAGICCLOSE |
>>>> @@ -147,49 +192,50 @@ static const struct watchdog_ops 
>>>> stm32_iwdg_ops = {
>>>>       .set_timeout    = stm32_iwdg_set_timeout,
>>>>   };
>>>> +static const struct stm32_iwdg_config stm32_iwdg_cfg = {
>>>> +    .has_pclk = false,
>>>> +};
>>>> +
>>>> +static const struct stm32_iwdg_config stm32mp1_iwdg_cfg = {
>>>> +    .has_pclk = true,
>>>> +};
>>>> +
>>>> +static const struct of_device_id stm32_iwdg_of_match[] = {
>>>> +    { .compatible = "st,stm32-iwdg", .data = &stm32_iwdg_cfg },
>>>> +    { .compatible = "st,stm32mp1-iwdg", .data = &stm32mp1_iwdg_cfg },
>>>> +    { /* end node */ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
>>>> +
>>>>   static int stm32_iwdg_probe(struct platform_device *pdev)
>>>>   {
>>>>       struct watchdog_device *wdd;
>>>> +    const struct of_device_id *match;
>>>>       struct stm32_iwdg *wdt;
>>>>       struct resource *res;
>>>> -    void __iomem *regs;
>>>> -    struct clk *clk;
>>>>       int ret;
>>>> +    match = of_match_device(stm32_iwdg_of_match, &pdev->dev);
>>>> +    if (!match || !match->data)
>>>> +        return -ENODEV;
>>>> +
>>>> +    wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>>>> +    if (!wdt)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    wdt->config = (struct stm32_iwdg_config *)match->data;
>>>> +
>>>>       /* This is the timer base. */
>>>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> -    regs = devm_ioremap_resource(&pdev->dev, res);
>>>> -    if (IS_ERR(regs)) {
>>>> +    wdt->regs = devm_ioremap_resource(&pdev->dev, res);
>>>> +    if (IS_ERR(wdt->regs)) {
>>>>           dev_err(&pdev->dev, "Could not get resource\n");
>>>> -        return PTR_ERR(regs);
>>>> +        return PTR_ERR(wdt->regs);
>>>>       }
>>>> -    clk = devm_clk_get(&pdev->dev, NULL);
>>>> -    if (IS_ERR(clk)) {
>>>> -        dev_err(&pdev->dev, "Unable to get clock\n");
>>>> -        return PTR_ERR(clk);
>>>> -    }
>>>> -
>>>> -    ret = clk_prepare_enable(clk);
>>>> -    if (ret) {
>>>> -        dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
>>>> +    ret = stm32_iwdg_clk_init(pdev, wdt);
>>>> +    if (ret)
>>>>           return ret;
>>>> -    }
>>>> -
>>>> -    /*
>>>> -     * Allocate our watchdog driver data, which has the
>>>> -     * struct watchdog_device nested within it.
>>>> -     */
>>>> -    wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>>>> -    if (!wdt) {
>>>> -        ret = -ENOMEM;
>>>> -        goto err;
>>>> -    }
>>>> -
>>>> -    /* Initialize struct stm32_iwdg. */
>>>> -    wdt->regs = regs;
>>>> -    wdt->clk = clk;
>>>> -    wdt->rate = clk_get_rate(clk);
>>>>       /* Initialize struct watchdog_device. */
>>>>       wdd = &wdt->wdd;
>>>> @@ -217,7 +263,8 @@ static int stm32_iwdg_probe(struct 
>>>> platform_device *pdev)
>>>>       return 0;
>>>>   err:
>>>> -    clk_disable_unprepare(clk);
>>>> +    clk_disable_unprepare(wdt->clk_lsi);
>>>> +    clk_disable_unprepare(wdt->clk_pclk);
>>>>       return ret;
>>>>   }
>>>> @@ -227,23 +274,18 @@ static int stm32_iwdg_remove(struct 
>>>> platform_device *pdev)
>>>>       struct stm32_iwdg *wdt = platform_get_drvdata(pdev);
>>>>       watchdog_unregister_device(&wdt->wdd);
>>>> -    clk_disable_unprepare(wdt->clk);
>>>> +    clk_disable_unprepare(wdt->clk_lsi);
>>>> +    clk_disable_unprepare(wdt->clk_pclk);
>>>>       return 0;
>>>>   }
>>>> -static const struct of_device_id stm32_iwdg_of_match[] = {
>>>> -    { .compatible = "st,stm32-iwdg" },
>>>> -    { /* end node */ }
>>>> -};
>>>> -MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
>>>> -
>>>>   static struct platform_driver stm32_iwdg_driver = {
>>>>       .probe        = stm32_iwdg_probe,
>>>>       .remove        = stm32_iwdg_remove,
>>>>       .driver = {
>>>>           .name    = "iwdg",
>>>> -        .of_match_table = stm32_iwdg_of_match,
>>>> +        .of_match_table = of_match_ptr(stm32_iwdg_of_match),
>>>>       },
>>>>   };
>>>>   module_platform_driver(stm32_iwdg_driver);
>>>>
>>>
>>
> 
