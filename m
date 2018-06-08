Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +7V6F776GlspeQAAmS7hNA
	; Fri, 08 Jun 2018 21:53:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 173B86089E; Fri,  8 Jun 2018 21:53:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcNAN4dd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3BE58605A2;
	Fri,  8 Jun 2018 21:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BE58605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbeFHVxB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:53:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35708 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbeFHVxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:53:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id j15-v6so6150548wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 14:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y6142mVd0abv1jK06mUQOg9XsfcQixp6+m7adQfTtpc=;
        b=JcNAN4ddPnpZMbKTLBtPsAVsRHOOrvXZzqE5tFPrCrqT2YRxZhvQq6QrGy+J/OlMO+
         UVr7BiNMiTGsPxHCfO3r57chtAEZjI88DC1PcRGu2EA3WJ+Fb8Vz8O4U8OEuexBP5bJ5
         0Lh6sqJM+1e7T+FLv7tMUEbyoC0BJKi8NMwV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y6142mVd0abv1jK06mUQOg9XsfcQixp6+m7adQfTtpc=;
        b=OVgy7sCEitKlcXQEIiYDfM+gh7H0yde6PonHrzj9NuuO5nnGPLrTLneGm3NpfcwV57
         eCM7+egjpTI3/SQH4CFEYbZ4J5qO7IWGavcoxQgpAG24ey80tHQKOElO52NjydeoHDkC
         Q3XDLFn5gDybn7axFwVqd0u94uI9x8XJupIGDteq63qkLmDoolfZZ9FF+Feo06zdA74P
         574+uMCcQyFPt+I71LZE95hkQuGEK2vxawRpSzumBy0XMV4zq2whXla1IAygh6/QjuG1
         jr0afbye1imvpUbl6znBRQa0H/H6DlCDX51S/KZOLBx7jMx+GqNR31XT88k9iYpS0kXE
         8zXg==
X-Gm-Message-State: APt69E05j5n53WgwAI+TBrBbqn8d4Fkfje2/pUcPZVQzUe1UB+fzTehq
        RZURXqGl6P38YlyQseEqgXIg6yO2BEiqSsXC6QWZsg==
X-Google-Smtp-Source: ADUXVKJuLhlYRpyyzDqz1/3INtJ4ZuNnP0DA+Sj4fjqC8C2JPbbUWAxSmMHwQ3gHQrWto+OGpGx3uJA0viJqEe9Y7uo=
X-Received: by 2002:a50:ec19:: with SMTP id g25-v6mr8697530edr.242.1528494778697;
 Fri, 08 Jun 2018 14:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a48a:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 14:52:58 -0700 (PDT)
In-Reply-To: <20180608214946.GI30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-11-git-send-email-suzuki.poulose@arm.com> <20180608214946.GI30587@xps15>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 8 Jun 2018 15:52:58 -0600
Message-ID: <CANLsYkxNakRGCWT6O0JRKz+N1OTU3-XreC_FiB8Fiv+jEoPEbQ@mail.gmail.com>
Subject: Re: [PATCH 10/20] dts: juno: Update coresight bindings for hw port
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <matt.sealey@arm.com>,
        John Horley <john.horley@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 June 2018 at 15:49, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> On Tue, Jun 05, 2018 at 10:43:21PM +0100, Suzuki K Poulose wrote:
>> Switch to updated coresight bindings for hw ports.
>>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since V1:
>>   - Add support Juno for r1 & r2.
>> ---
>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Sudeep please hold on before applying this as there is more work to be
done on this set.

>
>>  arch/arm64/boot/dts/arm/juno-base.dtsi    | 82 ++++++++++++++++++++++---------
>>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 26 +++++++---
>>  arch/arm64/boot/dts/arm/juno.dts          |  5 +-
>>  3 files changed, 81 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> index eb749c5..33b41ba 100644
>> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> @@ -122,15 +122,18 @@
>>                       port@0 {
>>                               reg = <0>;
>>                               etf0_in_port: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&main_funnel_out_port>;
>> +                                     coresight,hwid = <0>;
>>                               };
>>                       };
>>
>>                       /* output port */
>>                       port@1 {
>> -                             reg = <0>;
>> +                             reg = <1>;
>>                               etf0_out_port: endpoint {
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <1>;
>>                               };
>>                       };
>>               };
>> @@ -145,8 +148,9 @@
>>               power-domains = <&scpi_devpd 0>;
>>               port {
>>                       tpiu_in_port: endpoint {
>> -                             slave-mode;
>> +                             direction = <0>;
>>                               remote-endpoint = <&replicator_out_port0>;
>> +                             coresight,hwid = <0>;
>>                       };
>>               };
>>       };
>> @@ -168,23 +172,27 @@
>>                               reg = <0>;
>>                               main_funnel_out_port: endpoint {
>>                                       remote-endpoint = <&etf0_in_port>;
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <1>;
>>                               };
>>                       };
>>
>>                       /* input ports */
>>                       port@1 {
>> -                             reg = <0>;
>> +                             reg = <1>;
>>                               main_funnel_in_port0: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&cluster0_funnel_out_port>;
>> +                                     coresight,hwid = <0>;
>>                               };
>>                       };
>>
>>                       port@2 {
>> -                             reg = <1>;
>> +                             reg = <2>;
>>                               main_funnel_in_port1: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&cluster1_funnel_out_port>;
>> +                                     coresight,hwid = <1>;
>>                               };
>>                       };
>>               };
>> @@ -200,8 +208,9 @@
>>               power-domains = <&scpi_devpd 0>;
>>               port {
>>                       etr_in_port: endpoint {
>> -                             slave-mode;
>> +                             direction = <0>;
>>                               remote-endpoint = <&replicator_out_port1>;
>> +                             coresight,hwid = <0>;
>>                       };
>>               };
>>       };
>> @@ -217,6 +226,8 @@
>>               power-domains = <&scpi_devpd 0>;
>>               port {
>>                       stm_out_port: endpoint {
>> +                             coresight,hwid = <0>;
>> +                             direction = <1>;
>>                       };
>>               };
>>       };
>> @@ -240,6 +251,8 @@
>>               port {
>>                       cluster0_etm0_out_port: endpoint {
>>                               remote-endpoint = <&cluster0_funnel_in_port0>;
>> +                             coresight,hwid = <0>;
>> +                             direction = <1>;
>>                       };
>>               };
>>       };
>> @@ -259,22 +272,26 @@
>>                               reg = <0>;
>>                               cluster0_funnel_out_port: endpoint {
>>                                       remote-endpoint = <&main_funnel_in_port0>;
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <1>;
>>                               };
>>                       };
>>
>>                       port@1 {
>> -                             reg = <0>;
>> +                             reg = <1>;
>>                               cluster0_funnel_in_port0: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&cluster0_etm0_out_port>;
>> +                                     coresight,hwid = <0>;
>>                               };
>>                       };
>>
>>                       port@2 {
>> -                             reg = <1>;
>> +                             reg = <2>;
>>                               cluster0_funnel_in_port1: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&cluster0_etm1_out_port>;
>> +                                     coresight,hwid = <1>;
>>                               };
>>                       };
>>               };
>> @@ -299,6 +316,8 @@
>>               port {
>>                       cluster0_etm1_out_port: endpoint {
>>                               remote-endpoint = <&cluster0_funnel_in_port1>;
>> +                             coresight,hwid = <0>;
>> +                             direction = <1>;
>>                       };
>>               };
>>       };
>> @@ -322,6 +341,8 @@
>>               port {
>>                       cluster1_etm0_out_port: endpoint {
>>                               remote-endpoint = <&cluster1_funnel_in_port0>;
>> +                             coresight,hwid = <0>;
>> +                             direction = <1>;
>>                       };
>>               };
>>       };
>> @@ -341,36 +362,42 @@
>>                               reg = <0>;
>>                               cluster1_funnel_out_port: endpoint {
>>                                       remote-endpoint = <&main_funnel_in_port1>;
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <1>;
>>                               };
>>                       };
>>
>>                       port@1 {
>> -                             reg = <0>;
>> +                             reg = <1>;
>>                               cluster1_funnel_in_port0: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&cluster1_etm0_out_port>;
>> +                                     coresight,hwid = <0>;
>>                               };
>>                       };
>>
>>                       port@2 {
>> -                             reg = <1>;
>> +                             reg = <2>;
>>                               cluster1_funnel_in_port1: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&cluster1_etm1_out_port>;
>> +                                     coresight,hwid = <1>;
>>                               };
>>                       };
>>                       port@3 {
>> -                             reg = <2>;
>> +                             reg = <3>;
>>                               cluster1_funnel_in_port2: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&cluster1_etm2_out_port>;
>> +                                     coresight,hwid = <2>;
>>                               };
>>                       };
>>                       port@4 {
>> -                             reg = <3>;
>> +                             reg = <4>;
>>                               cluster1_funnel_in_port3: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>>                                       remote-endpoint = <&cluster1_etm3_out_port>;
>> +                                     coresight,hwid = <3>;
>>                               };
>>                       };
>>               };
>> @@ -395,6 +422,8 @@
>>               port {
>>                       cluster1_etm1_out_port: endpoint {
>>                               remote-endpoint = <&cluster1_funnel_in_port1>;
>> +                             coresight,hwid = <0>;
>> +                             direction = <1>;
>>                       };
>>               };
>>       };
>> @@ -418,6 +447,8 @@
>>               port {
>>                       cluster1_etm2_out_port: endpoint {
>>                               remote-endpoint = <&cluster1_funnel_in_port2>;
>> +                             coresight,hwid = <0>;
>> +                             direction = <1>;
>>                       };
>>               };
>>       };
>> @@ -441,6 +472,8 @@
>>               port {
>>                       cluster1_etm3_out_port: endpoint {
>>                               remote-endpoint = <&cluster1_funnel_in_port3>;
>> +                             coresight,hwid = <0>;
>> +                             direction = <1>;
>>                       };
>>               };
>>       };
>> @@ -462,6 +495,8 @@
>>                               reg = <0>;
>>                               replicator_out_port0: endpoint {
>>                                       remote-endpoint = <&tpiu_in_port>;
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <1>;
>>                               };
>>                       };
>>
>> @@ -469,14 +504,17 @@
>>                               reg = <1>;
>>                               replicator_out_port1: endpoint {
>>                                       remote-endpoint = <&etr_in_port>;
>> +                                     coresight,hwid = <1>;
>> +                                     direction = <1>;
>>                               };
>>                       };
>>
>>                       /* replicator input port */
>>                       port@2 {
>> -                             reg = <0>;
>> +                             reg = <2>;
>>                               replicator_in_port0: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>> +                                     coresight,hwid = <0>;
>>                               };
>>                       };
>>               };
>> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>> index 0c43fb3..146a5d9 100644
>> --- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
>> @@ -15,15 +15,18 @@
>>                       port@0 {
>>                               reg = <0>;
>>                               csys1_funnel_out_port: endpoint {
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <1>;
>>                                       remote-endpoint = <&etf1_in_port>;
>>                               };
>>                       };
>>
>>                       /* input port */
>>                       port@1 {
>> -                             reg = <0>;
>> +                             reg = <1>;
>>                               csys1_funnel_in_port0: endpoint {
>> -                                     slave-mode;
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <0>;
>>                               };
>>                       };
>>
>> @@ -45,15 +48,18 @@
>>                       port@0 {
>>                               reg = <0>;
>>                               etf1_in_port: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>> +                                     coresight,hwid = <0>;
>>                                       remote-endpoint = <&csys1_funnel_out_port>;
>>                               };
>>                       };
>>
>>                       /* output port */
>>                       port@1 {
>> -                             reg = <0>;
>> +                             reg = <1>;
>>                               etf1_out_port: endpoint {
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <1>;
>>                                       remote-endpoint = <&csys2_funnel_in_port1>;
>>                               };
>>                       };
>> @@ -75,23 +81,27 @@
>>                       port@0 {
>>                               reg = <0>;
>>                               csys2_funnel_out_port: endpoint {
>> +                                     coresight,hwid = <0>;
>> +                                     direction = <1>;
>>                                       remote-endpoint = <&replicator_in_port0>;
>>                               };
>>                       };
>>
>>                       /* input ports */
>>                       port@1 {
>> -                             reg = <0>;
>> +                             reg = <1>;
>>                               csys2_funnel_in_port0: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>> +                                     coresight,hwid = <0>;
>>                                       remote-endpoint = <&etf0_out_port>;
>>                               };
>>                       };
>>
>>                       port@2 {
>> -                             reg = <1>;
>> +                             reg = <2>;
>>                               csys2_funnel_in_port1: endpoint {
>> -                                     slave-mode;
>> +                                     direction = <0>;
>> +                                     coresight,hwid = <1>;
>>                                       remote-endpoint = <&etf1_out_port>;
>>                               };
>>                       };
>> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
>> index c9236c4..27b8036 100644
>> --- a/arch/arm64/boot/dts/arm/juno.dts
>> +++ b/arch/arm64/boot/dts/arm/juno.dts
>> @@ -260,10 +260,11 @@
>>  &main_funnel {
>>       ports {
>>               port@3 {
>> -                     reg = <2>;
>> +                     reg = <3>;
>>                       main_funnel_in_port2: endpoint {
>> -                             slave-mode;
>> +                             direction = <0>;
>>                               remote-endpoint = <&stm_out_port>;
>> +                             coresight,hwid = <2>;
>>                       };
>>               };
>>       };
>> --
>> 2.7.4
>>
