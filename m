Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754424AbeEWL1e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754024AbeEWL1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:27:30 -0400
X-Google-Smtp-Source: AB8JxZrjXbgtHS/JZ8FgaPPtOSzE1qj/W0YhfTvdxjAnMPl2gNscpEU5jiRwfQSZ8ndrVzGIuE83RElSyjoZL503Ezo=
MIME-Version: 1.0
In-Reply-To: <870361d2b9451af2e21cc570c8fca2c2@agner.ch>
References: <1527069406-6359-1-git-send-email-krzk@kernel.org>
 <1527069406-6359-2-git-send-email-krzk@kernel.org> <870361d2b9451af2e21cc570c8fca2c2@agner.ch>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 23 May 2018 13:27:27 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdnjXdUviryXhMKwhKFLM=JJ4tMNa+08t3Bct+NNU6Caw@mail.gmail.com>
Message-ID: <CAJKOXPdnjXdUviryXhMKwhKFLM=JJ4tMNa+08t3Bct+NNU6Caw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] ARM: dts: tegra: Fix unit_address_vs_reg DTC
 warnings for /memory
To: Stefan Agner <stefan@agner.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lucas Stach <dev@lynxeye.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 1:00 PM, Stefan Agner <stefan@agner.ch> wrote:
> On 23.05.2018 11:56, Krzysztof Kozlowski wrote:
>> Add a generic /memory node in each Tegra DTSI (with empty reg property,
>> to be overidden by each DTS) and set proper unit address for /memory
>> nodes to fix the DTC warnings:
>>
>>     arch/arm/boot/dts/tegra20-harmony.dtb: Warning (unit_address_vs_reg):
>>         /memory: node has a reg or ranges property, but no unit name
>>
>> The DTB after the change is the same as before except adding
>> unit-address to /memory node.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Changes since v5:
>> 1. Split with skeleton.dtsi removal (suggested by Stefan).
>>
>> Changes since v4:
>> 1. None
>> ---
>>  arch/arm/boot/dts/tegra114-dalmore.dts      | 2 +-
>>  arch/arm/boot/dts/tegra114-roth.dts         | 2 +-
>>  arch/arm/boot/dts/tegra114-tn7.dts          | 2 +-
>>  arch/arm/boot/dts/tegra114.dtsi             | 3 ++-
>>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
>>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
>>  arch/arm/boot/dts/tegra124-jetson-tk1.dts   | 2 +-
>>  arch/arm/boot/dts/tegra124-nyan.dtsi        | 2 +-
>>  arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
>>  arch/arm/boot/dts/tegra124.dtsi             | 3 ++-
>>  arch/arm/boot/dts/tegra20-colibri-512.dtsi  | 2 +-
>>  arch/arm/boot/dts/tegra20-harmony.dts       | 2 +-
>>  arch/arm/boot/dts/tegra20-paz00.dts         | 2 +-
>>  arch/arm/boot/dts/tegra20-seaboard.dts      | 2 +-
>>  arch/arm/boot/dts/tegra20-tamonten.dtsi     | 2 +-
>>  arch/arm/boot/dts/tegra20-trimslice.dts     | 2 +-
>>  arch/arm/boot/dts/tegra20-ventana.dts       | 2 +-
>>  arch/arm/boot/dts/tegra20.dtsi              | 3 ++-
>>  arch/arm/boot/dts/tegra30-apalis.dtsi       | 4 ++--
>>  arch/arm/boot/dts/tegra30-beaver.dts        | 2 +-
>>  arch/arm/boot/dts/tegra30-cardhu.dtsi       | 2 +-
>>  arch/arm/boot/dts/tegra30-colibri.dtsi      | 2 +-
>>  arch/arm/boot/dts/tegra30.dtsi              | 3 ++-
>>  23 files changed, 28 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts
>> b/arch/arm/boot/dts/tegra114-dalmore.dts
>> index eafff16765b4..1788556b4977 100644
>> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
>> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
>> @@ -23,7 +23,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@80000000 {
>>               reg = <0x80000000 0x40000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra114-roth.dts
>> b/arch/arm/boot/dts/tegra114-roth.dts
>> index 7ed7370ee67a..3d3835591cd2 100644
>> --- a/arch/arm/boot/dts/tegra114-roth.dts
>> +++ b/arch/arm/boot/dts/tegra114-roth.dts
>> @@ -28,7 +28,7 @@
>>               };
>>       };
>>
>> -     memory {
>> +     memory@80000000 {
>>               /* memory >= 0x79600000 is reserved for firmware usage */
>>               reg = <0x80000000 0x79600000>;
>>       };
>> diff --git a/arch/arm/boot/dts/tegra114-tn7.dts
>> b/arch/arm/boot/dts/tegra114-tn7.dts
>> index 7fc4a8b31e45..bfdd1bf61816 100644
>> --- a/arch/arm/boot/dts/tegra114-tn7.dts
>> +++ b/arch/arm/boot/dts/tegra114-tn7.dts
>> @@ -28,7 +28,7 @@
>>               };
>>       };
>>
>> -     memory {
>> +     memory@80000000 {
>>               /* memory >= 0x37e00000 is reserved for firmware usage */
>>               reg = <0x80000000 0x37e00000>;
>>       };
>> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
>> index 27ef515e5640..aff4b8e115bc 100644
>> --- a/arch/arm/boot/dts/tegra114.dtsi
>> +++ b/arch/arm/boot/dts/tegra114.dtsi
>> @@ -11,8 +11,9 @@
>>       #address-cells = <1>;
>>       #size-cells = <1>;
>>
>> -     memory {
>> +     memory@80000000 {
>>               device_type = "memory";
>> +             reg = <0x80000000 0>;
>
> Nit: I'd rather prefer
>
> reg = <0x80000000 0x0>;

Sure.


>>       };
>>
>>       host1x@50000000 {
>> diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
>> b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
>> index bb67edb016c5..6a7f45651d38 100644
>> --- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
>> +++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
>> @@ -15,7 +15,7 @@
>>       compatible = "toradex,apalis-tk1-v1.2", "toradex,apalis-tk1",
>>                    "nvidia,tegra124";
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x0 0x80000000 0x0 0x80000000>;
>>       };
>
> Unit address combines all address cells, so this should be 80000000
> here. See also the device tree spec (v0.2) which has an example in
> chapter 3.4 /memory node.
>
> So this should be:
>
> memory@80000000 {
> ...
>
> Same with all the board files below.

Ah, yes.

>>
>> diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi
>> b/arch/arm/boot/dts/tegra124-apalis.dtsi
>> index 65a2161b9b8e..e4625abd0a8a 100644
>> --- a/arch/arm/boot/dts/tegra124-apalis.dtsi
>> +++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
>> @@ -50,7 +50,7 @@
>>       model = "Toradex Apalis TK1";
>>       compatible = "toradex,apalis-tk1", "nvidia,tegra124";
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x0 0x80000000 0x0 0x80000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> index 6dbcf84dafbc..e23b1159e8fd 100644
>> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> @@ -24,7 +24,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x0 0x80000000 0x0 0x80000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi
>> b/arch/arm/boot/dts/tegra124-nyan.dtsi
>> index 3609367037a6..f45ac668d88c 100644
>> --- a/arch/arm/boot/dts/tegra124-nyan.dtsi
>> +++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
>> @@ -13,7 +13,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x0 0x80000000 0x0 0x80000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts
>> b/arch/arm/boot/dts/tegra124-venice2.dts
>> index 89bcc178994d..44492b48e165 100644
>> --- a/arch/arm/boot/dts/tegra124-venice2.dts
>> +++ b/arch/arm/boot/dts/tegra124-venice2.dts
>> @@ -18,7 +18,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x0 0x80000000 0x0 0x80000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
>> index 951feea784af..ad9c9cd6fa8a 100644
>> --- a/arch/arm/boot/dts/tegra124.dtsi
>> +++ b/arch/arm/boot/dts/tegra124.dtsi
>> @@ -13,8 +13,9 @@
>>       #address-cells = <2>;
>>       #size-cells = <2>;
>>
>> -     memory {
>> +     memory@0 {
>>               device_type = "memory";
>> +             reg = <0 0>;
>>       };
>
> This should have two address and two size cells I guess. And DDR for all
> TK1 start at 0x0 0x80000000...
>
> So here with a default length of 0:
>
>         memory@80000000 {
>                 reg = <0x0 0x80000000 0x0 0x0>;
>         };

Yes, right.

>>
>>       pcie@1003000 {
>> diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
>> b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
>> index 5c202b3e3bb1..5623ff8d128c 100644
>> --- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
>> +++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
>> @@ -10,7 +10,7 @@
>>               rtc1 = "/rtc@7000e000";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x00000000 0x20000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra20-harmony.dts
>> b/arch/arm/boot/dts/tegra20-harmony.dts
>> index 628a55a9318b..1d96d92b72a7 100644
>> --- a/arch/arm/boot/dts/tegra20-harmony.dts
>> +++ b/arch/arm/boot/dts/tegra20-harmony.dts
>> @@ -18,7 +18,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x00000000 0x40000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
>> b/arch/arm/boot/dts/tegra20-paz00.dts
>> index 30436969adc0..ef245291924f 100644
>> --- a/arch/arm/boot/dts/tegra20-paz00.dts
>> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
>> @@ -19,7 +19,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x00000000 0x20000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts
>> b/arch/arm/boot/dts/tegra20-seaboard.dts
>> index 284aae351ff2..f91441683aad 100644
>> --- a/arch/arm/boot/dts/tegra20-seaboard.dts
>> +++ b/arch/arm/boot/dts/tegra20-seaboard.dts
>> @@ -18,7 +18,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x00000000 0x40000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi
>> b/arch/arm/boot/dts/tegra20-tamonten.dtsi
>> index 872046d48709..20137fc578b1 100644
>> --- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
>> +++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
>> @@ -15,7 +15,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x00000000 0x20000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts
>> b/arch/arm/boot/dts/tegra20-trimslice.dts
>> index d55c6b240a30..9eb26dc15f6b 100644
>> --- a/arch/arm/boot/dts/tegra20-trimslice.dts
>> +++ b/arch/arm/boot/dts/tegra20-trimslice.dts
>> @@ -18,7 +18,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x00000000 0x40000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra20-ventana.dts
>> b/arch/arm/boot/dts/tegra20-ventana.dts
>> index ee3fbf941e79..f44551e2d9d0 100644
>> --- a/arch/arm/boot/dts/tegra20-ventana.dts
>> +++ b/arch/arm/boot/dts/tegra20-ventana.dts
>> @@ -18,7 +18,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@0 {
>>               reg = <0x00000000 0x40000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
>> index 88dd1afb5877..55581c0e5105 100644
>> --- a/arch/arm/boot/dts/tegra20.dtsi
>> +++ b/arch/arm/boot/dts/tegra20.dtsi
>> @@ -13,8 +13,9 @@
>>       chosen { };
>>       aliases { };
>>
>> -     memory {
>> +     memory@0 {
>>               device_type = "memory";
>> +             reg = <0 0>;
>>       };
>>
>>       iram@40000000 {
>> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi
>> b/arch/arm/boot/dts/tegra30-apalis.dtsi
>> index 6f29cbad6e8a..9465fc592b7b 100644
>> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
>> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
>> @@ -10,8 +10,8 @@
>>       model = "Toradex Apalis T30";
>>       compatible = "toradex,apalis_t30", "nvidia,tegra30";
>>
>> -     memory {
>> -             reg = <0 0>;
>> +     memory@80000000 {
>> +             reg = <0x80000000 0x40000000>;
>>       };
>>
>>       pcie@3000 {
>> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts
>> b/arch/arm/boot/dts/tegra30-beaver.dts
>> index ae52a5039506..1434d50438f9 100644
>> --- a/arch/arm/boot/dts/tegra30-beaver.dts
>> +++ b/arch/arm/boot/dts/tegra30-beaver.dts
>> @@ -17,7 +17,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@80000000 {
>>               reg = <0x80000000 0x7ff00000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi
>> b/arch/arm/boot/dts/tegra30-cardhu.dtsi
>> index 92a9740c533f..33b73dca16a3 100644
>> --- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
>> +++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
>> @@ -40,7 +40,7 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> -     memory {
>> +     memory@80000000 {
>>               reg = <0x80000000 0x40000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi
>> b/arch/arm/boot/dts/tegra30-colibri.dtsi
>> index c44d8c40c410..9bf3327665d3 100644
>> --- a/arch/arm/boot/dts/tegra30-colibri.dtsi
>> +++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
>> @@ -10,7 +10,7 @@
>>       model = "Toradex Colibri T30";
>>       compatible = "toradex,colibri_t30", "nvidia,tegra30";
>>
>> -     memory {
>> +     memory@80000000 {
>>               reg = <0x80000000 0x40000000>;
>>       };
>>
>> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
>> index 19237c08c166..2b6243b0c6d6 100644
>> --- a/arch/arm/boot/dts/tegra30.dtsi
>> +++ b/arch/arm/boot/dts/tegra30.dtsi
>> @@ -14,8 +14,9 @@
>>       chosen { };
>>       aliases { };
>>
>> -     memory {
>> +     memory@80000000 {
>>               device_type = "memory";
>> +             reg = <0x80000000 0>;
>
> Nit: for consistency sake, 0x0 :-)


Sure, thanks for review!

Best regards,
Krzysztof
