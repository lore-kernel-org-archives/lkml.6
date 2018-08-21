Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B2DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBEC21581
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBEC21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeHUL4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:56:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46348 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeHUL4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:56:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63D427A9;
        Tue, 21 Aug 2018 01:37:06 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C4883F739;
        Tue, 21 Aug 2018 01:37:04 -0700 (PDT)
Subject: Re: [PATCH RESEND v1 1/5] dt-bindings: pinctrl: add wakeup capable
 GPIOs for SDM845
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>
Cc:     sboyd@kernel.org, evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-2-ilina@codeaurora.org>
 <20180820231901.GA5603@tuxbook-pro>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <9606d47c-78b4-c8c6-97c8-11b606a61496@arm.com>
Date:   Tue, 21 Aug 2018 09:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820231901.GA5603@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/18 00:19, Bjorn Andersson wrote:
> On Fri 17 Aug 12:10 PDT 2018, Lina Iyer wrote:
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> [..]
>> @@ -155,11 +166,52 @@ Example:
>>  	tlmm: pinctrl@3400000 {
>>  		compatible = "qcom,sdm845-pinctrl";
>>  		reg = <0x03400000 0xc00000>;
>> -		interrupts = <GIC_SPI 208 0>;
>>  		gpio-controller;
>>  		#gpio-cells = <2>;
>>  		interrupt-controller;
>>  		#interrupt-cells = <2>;
>> +		interrupts-extended = <&intc GIC_SPI 208 0>,
>> +			<&pdc 510 0>, <&pdc 511 0>, <&pdc 512 0>, <&pdc 513 0>,
>> +			<&pdc 514 0>, <&pdc 515 0>, <&pdc 516 0>, <&pdc 517 0>,
>> +			<&pdc 518 0>, <&pdc 519 0>, <&pdc 632 0>, <&pdc 639 0>,
>> +			<&pdc 521 0>, <&pdc 522 0>, <&pdc 523 0>, <&pdc 524 0>,
>> +			<&pdc 525 0>, <&pdc 526 0>, <&pdc 527 0>, <&pdc 630 0>,
>> +			<&pdc 637 0>, <&pdc 529 0>, <&pdc 530 0>, <&pdc 531 0>,
>> +			<&pdc 532 0>, <&pdc 633 0>, <&pdc 640 0>, <&pdc 534 0>,
>> +			<&pdc 535 0>, <&pdc 536 0>, <&pdc 537 0>, <&pdc 538 0>,
>> +			<&pdc 539 0>, <&pdc 540 0>, <&pdc 541 0>, <&pdc 542 0>,
>> +			<&pdc 543 0>, <&pdc 544 0>, <&pdc 545 0>, <&pdc 546 0>,
>> +			<&pdc 547 0>, <&pdc 548 0>, <&pdc 549 0>, <&pdc 550 0>,
>> +			<&pdc 551 0>, <&pdc 552 0>, <&pdc 553 0>, <&pdc 554 0>,
>> +			<&pdc 555 0>, <&pdc 556 0>, <&pdc 557 0>, <&pdc 631 0>,
>> +			<&pdc 638 0>, <&pdc 559 0>, <&pdc 560 0>, <&pdc 561 0>,
>> +			<&pdc 562 0>, <&pdc 563 0>, <&pdc 564 0>, <&pdc 565 0>,
>> +			<&pdc 566 0>, <&pdc 570 0>, <&pdc 571 0>, <&pdc 572 0>,
>> +			<&pdc 573 0>, <&pdc 609 0>, <&pdc 610 0>, <&pdc 611 0>,
>> +			<&pdc 612 0>, <&pdc 613 0>, <&pdc 614 0>, <&pdc 615 0>,
>> +			<&pdc 617 0>, <&pdc 618 0>, <&pdc 619 0>, <&pdc 620 0>,
>> +			<&pdc 621 0>, <&pdc 622 0>, <&pdc 623 0>;
> 
> I would expect that there are about 80 WARN_ON() hit in the irq code
> when you boot mainline with this. Have you tried that?

Dunno about the ones pointing to the PDC, but the one pointing to the
GIC is definitely a howler.

Another reason for this code to be developed and tested with mainline.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
