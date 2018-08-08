Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D53121A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SwMqbRtj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ktO13o11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D53121A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbeHHWWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:22:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbeHHWWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:22:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E57B860B74; Wed,  8 Aug 2018 20:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533758463;
        bh=cnzjzz2uhhDk+Bna3PkLNRO3P+nKNCO1tN0rMvtP4os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwMqbRtjUnsSUeJU60NZS5AWapZ7f/Z2bAmlKINaU8Dwj409HtNi1RvKHo8ZUhp23
         Xa6+65W5YOK5HXqfIukoTgKjpJ54wlOaOpazQVCu+jYNekFQU1tE8t/s8pHSVIo8eA
         YBKbEg+yQ0IOL4qTUi1ajOZmE0WlDActitKEvwQ4=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02902601D2;
        Wed,  8 Aug 2018 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533758462;
        bh=cnzjzz2uhhDk+Bna3PkLNRO3P+nKNCO1tN0rMvtP4os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktO13o11w0HfCy8x7j8IlKhqYRUx+rhbNl9K7k9Qa3lbQT1GjSxW3jsoPpzZ4U7t7
         5FmMzZGFLcBoZzx5nsLMs3xCNTi2Ec8YnCNuuu0KGpqINa+K96GVlVrLxSIrA7BqhH
         MbKFSpFtgeUGIl+xqqGtfrnOxeXiHNW5jXtDiAzs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02902601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 8 Aug 2018 14:01:01 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     marc.zyngier@arm.com, Stephen Boyd <sboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, swboyd@chromium.org
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: add wake up interrupts for
 GPIOs
Message-ID: <20180808200101.GD27850@codeaurora.org>
References: <20180731224421.29062-1-ilina@codeaurora.org>
 <20180731224421.29062-5-ilina@codeaurora.org>
 <CAE=gft5SRSnXN4Cs8JdTNgFKAFk1YH4bxL91=jvhRZe7Zznxdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft5SRSnXN4Cs8JdTNgFKAFk1YH4bxL91=jvhRZe7Zznxdg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07 2018 at 13:57 -0600, Evan Green wrote:
>On Tue, Jul 31, 2018 at 3:44 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> GPIOs that are wakeup capable have interrupt lines that are routed to
>> the always-on interrupt controller (PDC) in parallel to the pinctrl. The
>> interrupts listed here are the wake up lines corresponding to GPIOs.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 69 ++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 8ccce42885c1..96ef18ced85b 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -720,6 +720,75 @@
>>                         #gpio-cells = <2>;
>>                         interrupt-controller;
>>                         #interrupt-cells = <2>;
>> +                       interrupts-extended = <&pdc 30 IRQ_TYPE_LEVEL_HIGH>,
>
>In order to get any GPIO interrupts on my board, I needed to add the
>summary IRQ first in this list. My reading of platform_get_irq is that
>"interrupts-extended" is queried before "interrupts", so we
>accidentally wire the summary IRQ to PDC 30. Given this, you can
>probably remove the regular "interrupts" property.
>
Sure. Will fix that.

-- Lina

>> +                                             <&pdc 31 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 32 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 33 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 34 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 35 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 36 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 37 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 38 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 39 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 41 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 42 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 43 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 44 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 45 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 46 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 47 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 49 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 50 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 51 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 52 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 54 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 55 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 56 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 57 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 58 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 59 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 60 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 61 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 62 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 63 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 64 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 65 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 66 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 67 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 68 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 69 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 70 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 71 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 72 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 73 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 74 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 75 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 77 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 79 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 80 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 81 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 82 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 83 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 84 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 85 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 86 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 90 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 91 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 92 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 95 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 96 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 97 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 98 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 99 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 100 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 102 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 103 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 104 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 105 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 106 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 107 IRQ_TYPE_LEVEL_HIGH>,
>> +                                             <&pdc 108 IRQ_TYPE_LEVEL_HIGH>;
>>
>>                         qup_i2c0_default: qup-i2c0-default {
>>                                 pinmux {
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
