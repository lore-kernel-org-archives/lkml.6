Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A84CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009B820693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N2+p5Gt5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JeyKJ+Di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009B820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbeFRVwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:52:39 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33776 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754628AbeFRVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:52:36 -0400
Received: by mail-ua0-f193.google.com with SMTP id m21-v6so11736805uan.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lrfHbzA95E3YpTOn/UTx06hSFE1J53BemfNtE3Bqvsk=;
        b=N2+p5Gt54wSGio2C6D2eK06f1y2h8RoFcaWI/psL3+MdQiwVZIno/BGdWJiQB+Dsji
         KCxKxLOnqNQet3IVtF6Lt69Z6dykcEgR8niRCZvfrTYTj3w2v+JWkCwcuUFc7f9oM7GZ
         Iyzjruj3KOdw+/UGPAgoUJ6jnHirDMhCxt5i6Vq4AjEv5XuHrNDBR6UmjtVCJqs8+Xdd
         8FFjc6ilYCe6D7vxF/FVb5kguwbhmzLCpwJsT79TrnGEr/L2QAfuicPmotS38JdsifMl
         2qqrWEVxh7/thoufKb5AaxUtbrGzeKHmrTm2povcFxaFOHNtc6xd4R7yz1uATKE2bHQh
         PG/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lrfHbzA95E3YpTOn/UTx06hSFE1J53BemfNtE3Bqvsk=;
        b=JeyKJ+DiHyKrIBf/rP9vk7BxOVlt+tkDI5o/FcjlFabDVO91OxKIQH5sYoXnuozCYz
         TKJf+6G/RuG+nyu26sEfBWVE3irsze9FnVrw0pDVTxRW4MiUOGLx2S/V6hQU89doQNBa
         K8Qq2gua/dX190z3HKIUCskVEacbZcTrRe3cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lrfHbzA95E3YpTOn/UTx06hSFE1J53BemfNtE3Bqvsk=;
        b=kqQdIwS1j2e49QPeLAdJNI46FUnziljKUCaW+g1F2QQpYr5u8eqdQLtXI8+hqytRo6
         9jNf5mtlvUnyNppQHgMqcDvnXtVFiooKQ4P6pR5GlXRS5U2+/jpB6rhe733nS3DMz8e5
         9ML9/4bNBaeMuSkClqioEOt1EdI/MDnL4+p9FgaNXMqC0QFfa6odvHarvJNdBBjrZzEc
         lV/SV8zvf7PaV81UvNg/92+bHDEFLLLGFcIeXVnMvHNmPVj+pvma9Smls2njVPK9nM0j
         7vE4w4x77O46g9J3OAIe2Lc2hH5AZdU9Ul6ZrpRZyARFoVq6UEwBEssyDaYySGbsX3RQ
         UgaA==
X-Gm-Message-State: APt69E1w+vop1nDtMGebGjQm8tJEvSwWcsUMJnLOzfU59rm8pQj1EuO5
        r3aAFnqkAvo3SdXwFJlu9tt2pGWj6ZEw/ailkXpRuQ==
X-Google-Smtp-Source: ADUXVKLEuWQztZ+F8ONY5wUpd3N3SXhZY2kD7OVnLnfAF8sYjPrfBXY+dS3O6SfBUDB5UDb3xJJCJO4DNOozMYPKlMo=
X-Received: by 2002:ab0:5061:: with SMTP id z30-v6mr8873400uaz.82.1529358755508;
 Mon, 18 Jun 2018 14:52:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 14:52:34
 -0700 (PDT)
In-Reply-To: <20180618212414.GI21724@codeaurora.org>
References: <20180618205616.102750-1-dianders@chromium.org> <20180618212414.GI21724@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jun 2018 14:52:34 -0700
X-Google-Sender-Auth: PRpAZ8abRAPX8NXLAwPo86qSWiE
Message-ID: <CAD=FV=WNfBjOHU=LHP5o9DEeLzCv0JChnsbqWQAW6FW69d5P2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add rpmh-rsc node
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Raju P L S S S N <rplsssn@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 18, 2018 at 2:24 PM, Lina Iyer <ilina@codeaurora.org> wrote:
> On Mon, Jun 18 2018 at 14:56 -0600, Douglas Anderson wrote:
>>
>> This adds the rpmh-rsc node to sdm845 based on the examples in the
>> bindings.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index cd308b84bed7..19b006293d3b 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -7,6 +7,7 @@
>>
>> #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>
>> / {
>>         interrupt-parent = <&intc>;
>> @@ -984,6 +985,24 @@
>>                         #mbox-cells = <1>;
>>                 };
>>
>> +               apps_rsc: rsc@179c0000 {
>> +                       label = "apps_rsc";
>> +                       compatible = "qcom,rpmh-rsc";
>> +                       reg = <0x179c0000 0x10000>,
>> +                             <0x179d0000 0x10000>,
>> +                             <0x179e0000 0x10000>;
>> +                       reg-names = "drv-0", "drv-1", "drv-2";
>> +                       interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +                       qcom,tcs-offset = <0xd00>;
>> +                       qcom,drv-id = <2>;
>> +                       qcom,tcs-config = <SLEEP_TCS   3>,
>> +                                         <WAKE_TCS    3>,
>> +                                         <ACTIVE_TCS  2>,
>> +                                         <CONTROL_TCS 1>;
>
> Sorry, my example had this incorrect order and I just noticed this. We
> will need to fix the example as well.
>
> The first TCS should be ACTIVE_TCS, then followed by SLEEP_TCS and
> WAKE_TCS. This order is important and should match what is set in the
> firmware.
>
> qcom,tcs-config = <ACTIVE_TCS  2>,
>                   <SLEEP_TCS   3>,
>                    <WAKE_TCS    3>,
>                    <CONTROL_TCS 1>;
>
> While the above configuration would work for now, it would fail, when we
> enable system low power modes, which would use TCSes 2-7 for sleep and
> wake set transitions from the firmware.

Since I'm not expecting lots more feedback, I've gone ahead and sent
v2 with this fix.

-Doug
