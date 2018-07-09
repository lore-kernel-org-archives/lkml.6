Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F3BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5854020877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLTKaKuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5854020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934056AbeGIP7Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932845AbeGIP7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:59:20 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CDB2087F;
        Mon,  9 Jul 2018 15:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531151960;
        bh=o2WhOivJYPXlbRt8S4TZbt4VPo8pddOl3uhdgqrahxE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bLTKaKuDexoBlpa1/4cnXnW/yMn8hxKeQDkM0ejOt1BgCihZJulNafVhOj7aH99nu
         /NTr2uyXpS89IekOFmRAr4QdlY1TUQkSvq+GRCMSCk5huYpgq7wesH6bBry2D5eSaM
         WR9jeXVVAmduWNKJb5Ud6wv3fP1x78j2HKD0djpE=
Received: by mail-wr1-f53.google.com with SMTP id p1-v6so11535231wrs.9;
        Mon, 09 Jul 2018 08:59:19 -0700 (PDT)
X-Gm-Message-State: APt69E1Wd9Gs9gbZqCR8TLpMA2+NXwKYq6S6Lkw09WiLakme8XgeBUhs
        sbMrjnyfFUBN8tsyOjdP95S6MysZgiNAyzTIi04=
X-Google-Smtp-Source: AAOMgpdInMwd7lXxtoeyaS9OHH133iquMJP9jWTjQhogVc5nMkK9SCGuS9ET+CXK87wGuiS41/dBvozkMz7NRJahsd8=
X-Received: by 2002:adf:f485:: with SMTP id l5-v6mr16175170wro.259.1531151958237;
 Mon, 09 Jul 2018 08:59:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 08:59:17 -0700 (PDT)
In-Reply-To: <20180709152758.GD18353@ulmo>
References: <1527144833-24285-1-git-send-email-krzk@kernel.org> <20180709152758.GD18353@ulmo>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 9 Jul 2018 17:59:17 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeQVXWwE=aeZ32WMkJ4BCMs8rTM2RTbfJnNdkJ14z089Q@mail.gmail.com>
Message-ID: <CAJKOXPeQVXWwE=aeZ32WMkJ4BCMs8rTM2RTbfJnNdkJ14z089Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] ARM: dts: tegra: Remove usage of deprecated skeleton.dtsi
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 July 2018 at 17:27, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, May 24, 2018 at 08:53:50AM +0200, Krzysztof Kozlowski wrote:
>> Remove the usage of skeleton.dtsi because it was deprecated since commit
>> 9c0da3cc61f1 ("ARM: dts: explicitly mark skeleton.dtsi as deprecated").
>> It also allows later to fix DTC warnings for missing unit name in
>> /memory nodes.
>>
>> The /chosen and /aliases nodes are added only when dependent DTSes do
>> not define them.  Compiled DTB is the same as before this commit.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Reviewed-by: Stefan Agner <stefan@agner.ch>
>>
>> ---
>>
>> Changes since v6:
>> 1. Add Stefan's reviewed-by tag.
>>
>> Changes since v5:
>> 1. New patch, split with skeleton.dtsi removal (suggested by Stefan).
>> ---
>>  arch/arm/boot/dts/tegra114.dtsi       |  8 ++++++--
>>  arch/arm/boot/dts/tegra124.dtsi       |  6 ++++--
>>  arch/arm/boot/dts/tegra20.dtsi        | 11 +++++++++--
>>  arch/arm/boot/dts/tegra30-apalis.dtsi |  4 ++++
>>  arch/arm/boot/dts/tegra30.dtsi        | 11 +++++++++--
>>  5 files changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
>> index 0e4a13295d8a..27ef515e5640 100644
>> --- a/arch/arm/boot/dts/tegra114.dtsi
>> +++ b/arch/arm/boot/dts/tegra114.dtsi
>> @@ -5,11 +5,15 @@
>>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>
>> -#include "skeleton.dtsi"
>> -
>>  / {
>>       compatible = "nvidia,tegra114";
>>       interrupt-parent = <&lic>;
>> +     #address-cells = <1>;
>> +     #size-cells = <1>;
>> +
>> +     memory {
>> +             device_type = "memory";
>> +     };
>>
>>       host1x@50000000 {
>>               compatible = "nvidia,tegra114-host1x", "simple-bus";
>> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
>> index 174092bfac90..951feea784af 100644
>> --- a/arch/arm/boot/dts/tegra124.dtsi
>> +++ b/arch/arm/boot/dts/tegra124.dtsi
>> @@ -7,14 +7,16 @@
>>  #include <dt-bindings/reset/tegra124-car.h>
>>  #include <dt-bindings/thermal/tegra124-soctherm.h>
>>
>> -#include "skeleton.dtsi"
>> -
>>  / {
>>       compatible = "nvidia,tegra124";
>>       interrupt-parent = <&lic>;
>>       #address-cells = <2>;
>>       #size-cells = <2>;
>>
>> +     memory {
>> +             device_type = "memory";
>> +     };
>> +
>>       pcie@1003000 {
>>               compatible = "nvidia,tegra124-pcie";
>>               device_type = "pci";
>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
>> index 0a7136462a1a..88dd1afb5877 100644
>> --- a/arch/arm/boot/dts/tegra20.dtsi
>> +++ b/arch/arm/boot/dts/tegra20.dtsi
>> @@ -4,11 +4,18 @@
>>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>
>> -#include "skeleton.dtsi"
>> -
>>  / {
>>       compatible = "nvidia,tegra20";
>>       interrupt-parent = <&lic>;
>> +     #address-cells = <1>;
>> +     #size-cells = <1>;
>> +
>> +     chosen { };
>> +     aliases { };
>> +
>> +     memory {
>> +             device_type = "memory";
>> +     };
>>
>>       iram@40000000 {
>>               compatible = "mmio-sram";
> Any idea why Tegra20 here and Tegra30 below get empty chosen and aliases
> nodes while Tegra114 and Tegra124 don't?

I double checked... and it is my mistake. Previously I thought that
the board DTS do not define them therefore removal of skeleton.dtsi
would affect them. However now I see that it is not aliases and chosen
are everywhere.

I'll send v8.

Best regards,
Krzysztof
