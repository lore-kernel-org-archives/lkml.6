Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D374920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9WaMXnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D374920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJPXDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:03:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38493 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeJPXDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:03:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so23629723wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H/UhImBzyNgQ0iBa1+KDMfisyip+vMT+WtMgEOsYF/w=;
        b=S9WaMXnvlRWdz9dl54DXL6Uv3zAwzBnCn7nvmaKPHyXIYmr9fOgZC4B/R0kSQm3Qgg
         QIclaBe6huoAak/MPmMNnIA79KXDU1+ASY/yf7n2zZBtOpBSBjUna41n6UCDEjDehp+3
         h7FktXwKJThQwodYuPPnwz84p1u80mv4QjnFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H/UhImBzyNgQ0iBa1+KDMfisyip+vMT+WtMgEOsYF/w=;
        b=q/AU98F2nCA3ZYEOonPP+7JkobuBvnr8+aIvkiCviDugyQ22JMTTCLlYbLAq5U746q
         TSKB1gW0+USLfDaeCl8uvsYmOEVjEYgXErn3X25yVorrsWFK1xQoTQWg808tuctcffjg
         TAbdBYbG/28MWhTv3+2ZM0J6N/gAt7YVR82Kue5pBcqNuQs/rftHenMbAbByPWBFk0AO
         QH4GP0E8azytggYLk2jyRy5vMjX4Wdlw1SefabVuLQW4qqAEbmxdcp3+rvxYc7BZgVMF
         hLcE2XZwl3/7ftmf0RZdBiIwH9M+jvejkcfxpdsnHl9v/WrMkrPsyCVuUHZHGJYJjpVg
         qknA==
X-Gm-Message-State: ABuFfojNGO6hLdewGLOxpW6WpqBehfMDokkDPtMX8xHECSHlV8s9Z2uN
        IkxDLt58NHg0MuJ67sPpHxDOqw==
X-Google-Smtp-Source: ACcGV63cQKvtdLBh8TorCuHqE3GUgE2dzqkK414gJ29JDUrYn+RFufOlggDYmFrhP+UZlNJlyhSVIA==
X-Received: by 2002:a1c:3288:: with SMTP id y130-v6mr16917164wmy.11.1539702772461;
        Tue, 16 Oct 2018 08:12:52 -0700 (PDT)
Received: from [192.168.0.40] (221.56.88.92.rev.sfr.net. [92.88.56.221])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm16509318wrb.30.2018.10.16.08.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 08:12:51 -0700 (PDT)
Subject: Re: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
To:     Rob Herring <robh@kernel.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
 <20181015162835.GA20955@bogus>
 <d2cb2fa0-b579-205c-1777-308da075b3fd@linaro.org>
 <CAL_JsqJCJbOxP_ODJ_JTRCvrFpSCSxa-X1LCr+1-pY_ApTz_1Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <615bc0a7-161d-76de-e798-7ce779f49a75@linaro.org>
Date:   Tue, 16 Oct 2018 17:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJCJbOxP_ODJ_JTRCvrFpSCSxa-X1LCr+1-pY_ApTz_1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2018 16:44, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 1:01 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rob,
>>
>> thanks for the review.
>>
>> On 15/10/2018 18:28, Rob Herring wrote:
>>> On Tue, Sep 25, 2018 at 11:03:06AM +0200, Daniel Lezcano wrote:
>>>> Add the interrupt names for the sensors, so the code can rely on them
>>>> instead of dealing with index which are prone to error.
> 
> [...]
> 
>>>> +            interrupt-names = "tsensor_intr";
>>>
>>> That name seems pretty pointless.
>>>
>>>>              clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
>>>>              clock-names = "thermal_clk";
>>>>              #thermal-sensor-cells = <1>;
>>>> @@ -28,5 +30,6 @@ for Hi3660:
>>>>              compatible = "hisilicon,hi3660-tsensor";
>>>>              reg = <0x0 0xfff30000 0x0 0x1000>;
>>>>              interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            interrupt-names = "tsensor_a73";
>>>
>>> Just 'a73' is sufficient.
>>
>> This is the name defined in the board documentation to give a name to
>> the interrupt when requesting it. This one appears in /proc/interrupts.
>>
>> I can replace the 'tsensor_intr' by 'tsensor', but if 'tsensor_a73' is
>> replaced by 'a73' that may looks odd in /proc/interrupts to see an
>> interrupts line with the 'a73' name.
> 
> Sounds like a Linux problem, not DT...
> 
> The thing is that any *-names property is supposed to be a local to
> block name. For example, a UART may have a TX irq. It's local name is
> just "TX IRQ", but then upstream at the interrupt controller it may be
> "UART1 TX IRQ". If you have multiple instances, the local names are
> the same.
> 
> If we lose the node name from /proc/interrupts when interrupt-names is
> used, then we should fix that.

Ah, ok. It makes more sense for me now. Thanks for the explanation, .


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

