Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeEQHkT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbeEQHkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:40:17 -0400
X-Google-Smtp-Source: AB8JxZoXwEaU5PgMZk1TWbYu6ygAQLJQKu3OO7ggOkq9O98tPzQpLr0OOanZ0d008eEtaMMjw3wF9/j4dnrC8h2OBrw=
MIME-Version: 1.0
In-Reply-To: <fce1d8c51fc3fd74fe61933fe9b59654@agner.ch>
References: <1526395285-19006-1-git-send-email-krzk@kernel.org>
 <1526395285-19006-4-git-send-email-krzk@kernel.org> <fce1d8c51fc3fd74fe61933fe9b59654@agner.ch>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 17 May 2018 09:40:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcBpOUkVay7u=gHRuw3=gZkR2Jk0k3QycHZorxWz7x2jg@mail.gmail.com>
Message-ID: <CAJKOXPcBpOUkVay7u=gHRuw3=gZkR2Jk0k3QycHZorxWz7x2jg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: tegra: Work safely with 256 MB
 Colibri-T20 modules
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

On Tue, May 15, 2018 at 11:20 PM, Stefan Agner <stefan@agner.ch> wrote:
> On 15.05.2018 16:41, Krzysztof Kozlowski wrote:
>> Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
>> (with 1024 MB NAND) flavors.  Both of them will use the same DTSI
>> expecting the bootloader to do the fixup of /memory node.  However in
>> case it does not happen, let's stay on safe side by limiting the memory
>> to 256 MB for both versions of Colibri-T20.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> RFT:
>> Not tested on 512 MB module as I have only the 256 MB one.
>>
>> Changes since v3:
>> 1. Reduce the memory in existing DTSI instead of creating a new one
>>    (suggested by Marcel).
>>
>> Changes since v2:
>> 1. Do not add new compatible but use everywhere existing
>>    "toradex,colibri_t20-512" (suggested by Rob).
>>
>> Changes since v1:
>> 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine because
>>    my bootloader uses mem= argument).
>> ---
>>  arch/arm/boot/dts/tegra20-colibri-512.dtsi | 9 +++++++--
>>  arch/arm/boot/dts/tegra20-iris-512.dts     | 2 +-
>
> I don't like this variant too much.
>
> Can we not just drop the 512? And while at it, I would prefer to see the
> usual $soc-$module-$carrier schema, as we use with all the other modules
> of the Colibri and Apalis family.
>
> e.g.
> tegra20-colibri-512.dtsi -> tegra20-colibri.dtsi
> tegra20-iris-512.dts -> tegra20-colibri-iris.dts

Sure, let me resend it.

BR,
Krzysztof
