Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A54C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17EB245A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="YdrauYee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17EB245A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeGBT4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:56:32 -0400
Received: from vern.gendns.com ([206.190.152.46]:47767 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752930AbeGBT4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UxFD5uDBUO+RLSJc4ZYxXVFdNqbDgN51gjP304mQLcw=; b=YdrauYeeQq4vzQMTCAw3+MOWYR
        cFl5vlhQKkJNePXjB7sG94Vjiq67LNNGfmS21g0jRC4N5jExSVLSIBI4UZkBYE7nPTpc1Wjmkgos2
        bv9IZ3hzVhvy//qKbhqyv0JPCrkyzOaRVEmIahQfiSlklEHhTNjd/s5L3Rr/jUtYpndT7xcrQoS2t
        KfMjzZvdXCh0Cch67vrM4BNia/RPM5QHrjZ8O2srTQ5/iEkmB4xOVzV7cYNye+PGpAyttwTMPOfcM
        QAm6jaaq/bztW1Woj0dmMXCcMB6OWAWCzhfWmk8AIT5SvrmVjNN5gfYA5erV/475v5dps4t6lGYfT
        y5eYETlw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36786 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fa4w0-00DxWx-3w; Mon, 02 Jul 2018 15:56:28 -0400
Subject: Re: [v7,07/10] dt-bindings: counter: Document stm32 quadrature
 encoder
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
References: <c1cc3d567d0a5799c3afe6e24ca9ec3b1547224e.1529607879.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <cf8231e3-0255-a4da-145c-69ccfe7288b2@lechnology.com>
Date:   Mon, 2 Jul 2018 14:56:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c1cc3d567d0a5799c3afe6e24ca9ec3b1547224e.1529607879.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 04:08 PM, William Breathitt Gray wrote:
> From: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Add bindings for STM32 Timer quadrature encoder.
> It is a sub-node of STM32 Timer which implement the
> quadratic encoder part of the hardware.

quadradic? or quadrature?

> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>   .../bindings/counter/stm32-timer-cnt.txt      | 31 +++++++++++++++++++
>   .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
>   2 files changed, 38 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> 
> diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> new file mode 100644
> index 000000000000..c52fcdd4bf6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
> @@ -0,0 +1,31 @@
> +STMicroelectronics STM32 Timer quadrature encoder
> +
> +STM32 Timer provides quadrature encoder to detect
> +angular position and direction of rotary elements,
> +from IN1 and IN2 input signals.
> +
> +Must be a sub-node of an STM32 Timer device tree node.
> +See ../mfd/stm32-timers.txt for details about the parent node.
> +
> +Required properties:
> +- compatible:		Must be "st,stm32-timer-counter".
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
> +			to set CH1/CH2 pins in mode of operation for STM32
> +			Timer input on external pin.
> +
> +Example:
> +	timers@40010000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "st,stm32-timers";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "int";
> +
> +		counter {
> +			compatible = "st,stm32-timer-counter";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&tim1_in_pins>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> index 1db6e0057a63..ff9c14ada30b 100644
> --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> @@ -23,6 +23,7 @@ Optional parameters:
>   Optional subnodes:
>   - pwm:			See ../pwm/pwm-stm32.txt
>   - timer:		See ../iio/timer/stm32-timer-trigger.txt
> +- counter:		See ../counter/stm32-timer-cnt.txt
>   
>   Example:
>   	timers@40010000 {
> @@ -43,4 +44,10 @@ Example:
>   			compatible = "st,stm32-timer-trigger";
>   			reg = <0>;
>   		};
> +
> +		counter {
> +			compatible = "st,stm32-timer-counter";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&tim1_in_pins>;
> +		};
>   	};
> 

