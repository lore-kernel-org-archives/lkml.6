Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64FECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0C82152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ut+Vb3sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0C82152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeI0Pgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:36:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40165 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeI0Pgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:36:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id r83-v6so1684367ljr.7;
        Thu, 27 Sep 2018 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xJGCjJMIfwBpV42q3bpu9VNqJfpjVTpG8AQJNcE39hE=;
        b=ut+Vb3sK4NEihCk+PhFBqT3DoE2X68HeAAaHmx7Yji+SQZXYmXltnqyEwBi56ouHMR
         BhCP2g4pngYPYAMLre78YVjHwHh9QVk4GI+3Grbq1B4G+4kD6SFFD2g1pGFuQvkuSp/0
         vAjCTviaUc5pAl8i5+YgEvf2HpkeXy50BqAO+eZbQvC33JfADi/XWM4NxvX7J5tBnaK3
         80vKmAQl3Q92vK4CUtKt9zN4NWfc9OZFPMbN+Vgfj2lovfMRBBpUjWDN7F3kmv71lZRc
         dZHLxUH1VOHPaTLtpsUvxt6Af7aD4VpMwk7QEAdxMSTosK8Qz7QC5a+El0eBV1m+qltv
         w0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xJGCjJMIfwBpV42q3bpu9VNqJfpjVTpG8AQJNcE39hE=;
        b=MfTBMDkH49cy1raIszulTOPdhl1QEj28y38MLMkKcHJrre4WuFVQ/5fEf6LR4129cW
         1DygnduYPtbgpuOsurzpdDKUo+qhA0HgkgIWAGEP9xf4Jq4kKM99W8pPozhULINxGKxm
         au0vH85/4wMMDuGgdBOuI4i7TlbKJeHhOAfwpCauuWRCFgZ5zG5/HgUN+1/aBINBG1Dg
         UGCQnksejoGEyGjqq9sJxSOiPnggSRHt6+iad55iNrtEPoXAe6ACvG5oBt7iKUjHDJPp
         QL1ob2JixYXJBgK4qUtaJ2/f+MFqswrmNvk//v2Ho7xgO0o2LopJ6ECUD621iBloyrKp
         B9NQ==
X-Gm-Message-State: ABuFfoh999BnRRz8dyCkGqaCFS0vt36WWcX4Tcjju61eWzBOG2DTx6Z0
        51Az4kUV+s+B+/QFRTfhN8zHfZYCGkx1Xd5NIGQ=
X-Google-Smtp-Source: ACcGV61FApaIjthQS2OA+LeNRP1u3Nu+9RAo6qWCno7YSMAZ3m6tbNDzassDmINsNJhVaBW5AyP2PuJm3UrnBo8dtD8=
X-Received: by 2002:a2e:3a0c:: with SMTP id h12-v6mr7088688lja.67.1538039970767;
 Thu, 27 Sep 2018 02:19:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:619:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 02:18:50 -0700 (PDT)
In-Reply-To: <ccc61e1b-768c-2a6d-3ff5-95b72bc58a6f@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-5-suzuki.poulose@arm.com> <ccc61e1b-768c-2a6d-3ff5-95b72bc58a6f@arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 27 Sep 2018 17:18:50 +0800
Message-ID: <CAAfSe-swWPgCWN6cZbQxLL6fwaJ1qLXnC_X7A0zeYuHDaZ_A1Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] arm64: dts: sc9836/sc9860: Update coresight
 bindings for hardware ports
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "arm@kernel.org" <arm@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        Leo Yan <leo.yan@linaro.org>, Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 27 September 2018 at 16:51, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> +To: Chunyan Zhang
>
> Chunyan Zhang,
>
> On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
>>
>> Switch to the new coresight bindings for hw ports
>>
>
> How can we push this patch ? Do you generally send the spreadtrum
> specific changes to ARM soc folks ? Or would you like me to post
> this directly to ARM soc folks ?

Yeah, at present sprd dts files generally got merged through arm-soc
(I've added arm@kernel.org).

Thanks,
Chunyan

>
> Suzuki
>
>
>> Cc: orsonzhai@gmail.com
>> Cc: zhang.lyra@gmail.com
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/boot/dts/sprd/sc9836.dtsi |  82 +++++-----
>>   arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++-------------
>>   2 files changed, 153 insertions(+), 144 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> b/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> index 63894c456969..4bcdbb709c01 100644
>> --- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> +++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> @@ -50,10 +50,11 @@
>>                 reg = <0 0x10003000 0 0x1000>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etf_in: endpoint {
>> -                               slave-mode;
>> -                               remote-endpoint = <&funnel_out_port0>;
>> +               in-ports {
>> +                       port {
>> +                               etf_in: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_out_port0>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -63,55 +64,50 @@
>>                 reg = <0 0x10001000 0 0x1000>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               ports {
>> +
>> +               out-ports {
>> +                       port {
>> +                               funnel_out_port0: endpoint {
>> +                                       remote-endpoint = <&etf_in>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               in-ports {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>   -                     /* funnel output port */
>>                         port@0 {
>> -                               reg = <0>;
>> -                               funnel_out_port0: endpoint {
>> -                                       remote-endpoint = <&etf_in>;
>> -                               };
>> -                       };
>> -
>> -                       /* funnel input port 0-4 */
>> -                       port@1 {
>>                                 reg = <0>;
>>                                 funnel_in_port0: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&etm0_out>;
>>                                 };
>>                         };
>>   -                     port@2 {
>> +                       port@1 {
>>                                 reg = <1>;
>>                                 funnel_in_port1: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&etm1_out>;
>>                                 };
>>                         };
>>   -                     port@3 {
>> +                       port@2 {
>>                                 reg = <2>;
>>                                 funnel_in_port2: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&etm2_out>;
>>                                 };
>>                         };
>>   -                     port@4 {
>> +                       port@3 {
>>                                 reg = <3>;
>>                                 funnel_in_port3: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&etm3_out>;
>>                                 };
>>                         };
>>   -                     port@5 {
>> +                       port@4 {
>>                                 reg = <4>;
>>                                 funnel_in_port4: endpoint {
>> -                                       slave-mode;
>>                                         remote-endpoint = <&stm_out>;
>>                                 };
>>                         };
>> @@ -126,9 +122,11 @@
>>                 cpu = <&cpu0>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etm0_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port0>;
>> +               out-ports {
>> +                       port {
>> +                               etm0_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port0>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -140,9 +138,11 @@
>>                 cpu = <&cpu1>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etm1_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port1>;
>> +               out-ports {
>> +                       port {
>> +                               etm1_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port1>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -154,9 +154,11 @@
>>                 cpu = <&cpu2>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etm2_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port2>;
>> +               out-ports {
>> +                       port {
>> +                               etm2_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port2>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -168,9 +170,11 @@
>>                 cpu = <&cpu3>;
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       etm3_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port3>;
>> +               out-ports {
>> +                       port {
>> +                               etm3_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port3>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -182,9 +186,11 @@
>>                 reg-names = "stm-base", "stm-stimulus-base";
>>                 clocks = <&clk26mhz>;
>>                 clock-names = "apb_pclk";
>> -               port {
>> -                       stm_out: endpoint {
>> -                               remote-endpoint = <&funnel_in_port4>;
>> +               out-ports {
>> +                       port {
>> +                               stm_out: endpoint {
>> +                                       remote-endpoint =
>> <&funnel_in_port4>;
>> +                               };
>>                         };
>>                 };
>>         };
>> diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> b/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> index 48f5928ed45c..5f57bf055cde 100644
>> --- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> +++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> @@ -304,30 +304,29 @@
>>                         reg = <0 0x10001000 0 0x1000>;
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port@0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         soc_funnel_out_port: endpoint {
>>                                                 remote-endpoint =
>> <&etb_in>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port@1 {
>> +                       in-ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>>                                         reg = <0>;
>>                                         soc_funnel_in_port0: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>                                                 <&main_funnel_out_port>;
>>                                         };
>>                                 };
>>   -                             port@2 {
>> +                               port@4 {
>>                                         reg = <4>;
>>                                         soc_funnel_in_port1: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>                                                         <&stm_out_port>;
>>                                         };
>> @@ -340,11 +339,12 @@
>>                         reg = <0 0x10003000 0 0x1000>;
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       port {
>> -                               etb_in: endpoint {
>> -                                       slave-mode;
>> -                                       remote-endpoint =
>> -                                               <&soc_funnel_out_port>;
>> +                       out-ports {
>> +                               port {
>> +                                       etb_in: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&soc_funnel_out_port>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -356,10 +356,12 @@
>>                         reg-names = "stm-base", "stm-stimulus-base";
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       port {
>> -                               stm_out_port: endpoint {
>> -                                       remote-endpoint =
>> -                                               <&soc_funnel_in_port1>;
>> +                       out-ports {
>> +                               port {
>> +                                       stm_out_port: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&soc_funnel_in_port1>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -369,38 +371,36 @@
>>                         reg = <0 0x11001000 0 0x1000>;
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port@0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         cluster0_funnel_out_port: endpoint
>> {
>>                                                 remote-endpoint =
>>
>> <&cluster0_etf_in>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port@1 {
>> +                       in-ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>>                                         reg = <0>;
>>                                         cluster0_funnel_in_port0: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm0_out>;
>>                                         };
>>                                 };
>>   -                             port@2 {
>> +                               port@1 {
>>                                         reg = <1>;
>>                                         cluster0_funnel_in_port1: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm1_out>;
>>                                         };
>>                                 };
>>   -                             port@3 {
>> +                               port@2 {
>>                                         reg = <2>;
>>                                         cluster0_funnel_in_port2: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm2_out>;
>>                                         };
>>                                 };
>> @@ -408,7 +408,6 @@
>>                                 port@4 {
>>                                         reg = <4>;
>>                                         cluster0_funnel_in_port3: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm3_out>;
>>                                         };
>>                                 };
>> @@ -420,46 +419,43 @@
>>                         reg = <0 0x11002000 0 0x1000>;
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>> -                       ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port@0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         cluster1_funnel_out_port: endpoint
>> {
>>                                                 remote-endpoint =
>>
>> <&cluster1_etf_in>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port@1 {
>> +                       in-ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>>                                         reg = <0>;
>>                                         cluster1_funnel_in_port0: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm4_out>;
>>                                         };
>>                                 };
>>   -                             port@2 {
>> +                               port@1 {
>>                                         reg = <1>;
>>                                         cluster1_funnel_in_port1: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm5_out>;
>>                                         };
>>                                 };
>>   -                             port@3 {
>> +                               port@2 {
>>                                         reg = <2>;
>>                                         cluster1_funnel_in_port2: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm6_out>;
>>                                         };
>>                                 };
>>   -                             port@4 {
>> +                               port@3 {
>>                                         reg = <3>;
>>                                         cluster1_funnel_in_port3: endpoint
>> {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>> <&etm7_out>;
>>                                         };
>>                                 };
>> @@ -472,22 +468,18 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port@0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         cluster0_etf_out: endpoint {
>>                                                 remote-endpoint =
>>                                                 <&main_funnel_in_port0>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port@1 {
>> -                                       reg = <0>;
>> +                       in-ports {
>> +                               port {
>>                                         cluster0_etf_in: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>
>> <&cluster0_funnel_out_port>;
>>                                         };
>> @@ -501,22 +493,18 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port@0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         cluster1_etf_out: endpoint {
>>                                                 remote-endpoint =
>>                                                 <&main_funnel_in_port1>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port@1 {
>> -                                       reg = <0>;
>> +                       in-ports {
>> +                               port {
>>                                         cluster1_etf_in: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>
>> <&cluster1_funnel_out_port>;
>>                                         };
>> @@ -530,31 +518,30 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port@0 {
>> -                                       reg = <0>;
>> +                       out-ports {
>> +                               port {
>>                                         main_funnel_out_port: endpoint {
>>                                                 remote-endpoint =
>>
>> <&soc_funnel_in_port0>;
>>                                         };
>>                                 };
>> +                       };
>>   -                             port@1 {
>> +                       in-ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>>                                         reg = <0>;
>>                                         main_funnel_in_port0: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>
>> <&cluster0_etf_out>;
>>                                         };
>>                                 };
>>   -                             port@2 {
>> +                               port@1 {
>>                                         reg = <1>;
>>                                         main_funnel_in_port1: endpoint {
>> -                                               slave-mode;
>>                                                 remote-endpoint =
>>
>> <&cluster1_etf_out>;
>>                                         };
>> @@ -569,10 +556,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm0_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster0_funnel_in_port0>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm0_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster0_funnel_in_port0>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -584,10 +573,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm1_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster0_funnel_in_port1>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm1_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster0_funnel_in_port1>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -599,10 +590,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm2_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster0_funnel_in_port2>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm2_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster0_funnel_in_port2>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -614,10 +607,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm3_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster0_funnel_in_port3>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm3_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster0_funnel_in_port3>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -629,10 +624,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm4_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster1_funnel_in_port0>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm4_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster1_funnel_in_port0>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -644,10 +641,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm5_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster1_funnel_in_port1>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm5_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster1_funnel_in_port1>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -659,10 +658,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm6_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster1_funnel_in_port2>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm6_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster1_funnel_in_port2>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>> @@ -674,10 +675,12 @@
>>                         clocks = <&ext_26m>;
>>                         clock-names = "apb_pclk";
>>   -                     port {
>> -                               etm7_out: endpoint {
>> -                                       remote-endpoint =
>> -
>> <&cluster1_funnel_in_port3>;
>> +                       out-ports {
>> +                               port {
>> +                                       etm7_out: endpoint {
>> +                                               remote-endpoint =
>> +
>> <&cluster1_funnel_in_port3>;
>> +                                       };
>>                                 };
>>                         };
>>                 };
>>
>
