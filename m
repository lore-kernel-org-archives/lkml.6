Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeEHH0o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754492AbeEHH0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:26:42 -0400
X-Google-Smtp-Source: AB8JxZrdtJocHv4vqtd5I4poWvDtBitc5ue9AnLcIpZa58Vs2O5UPw0W2LIRg32GjYAZuHGuwVAMXxAA/xZQwxZYke0=
MIME-Version: 1.0
In-Reply-To: <20180507165814.GA4180@rob-hp-laptop>
References: <1525360112-9893-1-git-send-email-krzk@kernel.org> <20180507165814.GA4180@rob-hp-laptop>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 8 May 2018 09:26:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeJULLkWZsCH+oSBUdmeO1k3g4PsqaGOQApyzCC1orNww@mail.gmail.com>
Message-ID: <CAJKOXPeJULLkWZsCH+oSBUdmeO1k3g4PsqaGOQApyzCC1orNww@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: tegra: Add support for 256 MB Colibri-T20
 (plus such board on Iris)
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 6:58 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, May 03, 2018 at 05:08:32PM +0200, Krzysztof Kozlowski wrote:
>> Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
>> (with 1024 MB NAND) flavors.  Add support for the 256 MB version on Iris
>> evaluation board.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine because
>>    my bootloader uses mem= argument).
>> ---
>>  Documentation/devicetree/bindings/arm/tegra.txt    |   1 +
>>  arch/arm/boot/dts/Makefile                         |   1 +
>>  arch/arm/boot/dts/tegra20-colibri-256.dtsi         |  11 +
>>  arch/arm/boot/dts/tegra20-colibri-512.dtsi         | 531 +--------------------
>>  ...gra20-colibri-512.dtsi => tegra20-colibri.dtsi} |   4 -
>>  arch/arm/boot/dts/tegra20-iris-256.dts             |  10 +
>>  arch/arm/boot/dts/tegra20-iris-512.dts             |  98 +---
>>  ...gra20-iris-512.dts => tegra20-iris-common.dtsi} |  11 +-
>>  8 files changed, 31 insertions(+), 636 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/tegra20-colibri-256.dtsi
>>  copy arch/arm/boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi} (99%)
>>  create mode 100644 arch/arm/boot/dts/tegra20-iris-256.dts
>>  copy arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-iris-common.dtsi} (85%)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
>> index 32f62bb7006d..d304574ae441 100644
>> --- a/Documentation/devicetree/bindings/arm/tegra.txt
>> +++ b/Documentation/devicetree/bindings/arm/tegra.txt
>> @@ -49,6 +49,7 @@ board-specific compatible values:
>>    toradex,apalis_t30-eval
>>    toradex,apalis-tk1
>>    toradex,apalis-tk1-eval
>> +  toradex,colibri_t20-256
>
> NAK unless there are changes beyond the memory size. Otherwise, just use
> the existing string or deprecate the existing one for a new one without
> the memory size. I prefer the less churn of the former option.

I'll stick to original compatible. Thanks for feedback.

Best regards,
Krzysztof
