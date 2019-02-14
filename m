Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B65421904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBNAnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:43:08 -0500
Received: from mx.socionext.com ([202.248.49.38]:27884 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfBNAnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:43:07 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 14 Feb 2019 09:43:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3E117180101;
        Thu, 14 Feb 2019 09:43:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 14 Feb 2019 09:43:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A38BE1A04E0;
        Thu, 14 Feb 2019 09:43:04 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 81FD3121B6C;
        Thu, 14 Feb 2019 09:43:04 +0900 (JST)
Subject: Re: [PATCH v2 07/15] ndings: clock: milbeaut: add Milbeaut clock
 description
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
References: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
 <155008053444.115909.15767350529461671558@swboyd.mtv.corp.google.com>
 <155008127539.115909.8938099989804942@swboyd.mtv.corp.google.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <38afb1e0-2af9-0eb1-9d1b-4ff7273e25ab@socionext.com>
Date:   Thu, 14 Feb 2019 09:43:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <155008127539.115909.8938099989804942@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/14 3:07, Stephen Boyd wrote:
> Quoting Stephen Boyd (2019-02-13 09:55:34)
>> The subject seems to have been cut off? "ndings"?
>>
>> Quoting Sugaya Taichi (2019-02-08 04:27:03)
>>> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
>>> new file mode 100644
>>> index 0000000..bcfc5df
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
>>> @@ -0,0 +1,49 @@
>>> +Milbeaut SoCs Clock Controller Binding
>>> +----------------------------------------
>>> +Milbeaut SoCs Clock controller is an integrated clock controller, which
>>> +generates and supplies to all modules.
>>> +
>>> +This binding uses common clock bindings
>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> +
>>> +Required properties:
>>> +- compatible: should be one of the following:
>>> +    "socionext,milbeaut-m10v-ccu" - for M10V SoC
>>> +- reg: shall contain base address and length of clock registers
>>> +- #clock-cells: shall be 1
>>> +- clocks: shall be an external clock
>>> +
>>> +Example: Clock controller node:
>>> +
>>> +       clk: m10v-clk-ctrl@1d021000 {
>>> +               compatible = "socionext,milbeaut-m10v-clk-ccu";
>>
>> I thought there was some length limit on compatible string names. 32
>> bytes? Just barely under!
>>
> 
> Ah I'm wrong. Compatible is 128. Good.
> 
> Seems I was thinking of DT property names.
> 

Sorry confusing you.
I accidently deleted "dt-bi" from subject when committing.
I repair the string in the next version.

Thanks,
Sugaya Taichi

