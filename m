Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeEDKDo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbeEDKDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:03:39 -0400
X-Google-Smtp-Source: AB8JxZogyuvWRc+vtZs4S+sFkHcvvht8HlgwNxtYwTDXwo2wMExMGEI8a1BzIPR6xjnepEJ95hkWPlqYncnHQ5g/ZrE=
MIME-Version: 1.0
In-Reply-To: <c47c07b2c112219093b668c0b4d46ac8@agner.ch>
References: <1525360112-9893-1-git-send-email-krzk@kernel.org> <c47c07b2c112219093b668c0b4d46ac8@agner.ch>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 4 May 2018 12:03:36 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeb+DmKVQ1uXkBOjaGMpxtPVFp54SBWm6h=+o30z9K3aQ@mail.gmail.com>
Message-ID: <CAJKOXPeb+DmKVQ1uXkBOjaGMpxtPVFp54SBWm6h=+o30z9K3aQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: tegra: Add support for 256 MB Colibri-T20
 (plus such board on Iris)
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

On Fri, May 4, 2018 at 11:19 AM, Stefan Agner <stefan@agner.ch> wrote:
> On 03.05.2018 17:08, Krzysztof Kozlowski wrote:
>> Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
>> (with 1024 MB NAND) flavors.  Add support for the 256 MB version on Iris
>> evaluation board.
>
> To we really need to specify memory size these days? I think all common
> boot loaders fill the memory node anyway.
>
> arch/arm/boot/dts/imx6qdl-apalis.dtsi:
>         /* Will be filled by the bootloader */
>         memory@10000000 {
>                 reg = <0x10000000 0>;
>         };
>
>
> I think we should just rename tegra20-colibri-512.dtsi =>
> tegra20-colibri.dtsi and tegra20-iris-512.dts => tegra20-iris.dts to
> avoid confusion and add such an empty node.

Having memory node is requirement of DeviceTree specification (at
least one cpu and memory node). Of course if bootloader fills it, then
we could assume that specification is satisfied... but what if some
bootloader skips it? This creates quite specific dependency between
kernel's DTS and bootloader.

One safe solution would be to specify 256 MB memory node for both
boards and assume that bootloader will bump it to 512 MB for specific
module.

>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine because
>>    my bootloader uses mem= argument).
>
> What boot loader are you using? You even can omit mem= if your boot
> loader fills the memory node properly.

I use the one provided by vendor - Toradex. By default it passes both
mem= and few other mem-like arguments (for FB and video processor) to
command line. I believe it does not adjust the DTB itself because
Toradex prepared this bootloader for... 3.1 kernel without DTB. 7
years old kernel. :)

Best regards,
Krzysztof
