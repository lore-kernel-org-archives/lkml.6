Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeENIUP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:20:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37323 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeENIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:20:13 -0400
X-Google-Smtp-Source: AB8JxZorLO2E2ah5MCMERnm87V+T+jIXBewbPpWsmiXvvU0sItdFfoUZmWWfQZvS+Sqcz6gmlEE+qeFSrCSET5UW1d8=
MIME-Version: 1.0
In-Reply-To: <CAGb2v66MKooAAroCzYdsXZDY0Oh66Dydpy59xj80QfiY+5mz_A@mail.gmail.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-4-jagan@amarulasolutions.com> <CAGb2v66MKooAAroCzYdsXZDY0Oh66Dydpy59xj80QfiY+5mz_A@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 14 May 2018 13:50:12 +0530
Message-ID: <CAMty3ZAOVg6EZoMi=LRuKEcrnDM_tzYfK1WnBN-_d-pmjNS6Nw@mail.gmail.com>
Subject: Re: [PATCH 03/21] clk: sunxi-ng: Enable DE2_CCU for Allwinner 64-bit SoCs
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:53 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Apr 30, 2018 at 7:40 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>> Allwinner 64-bit SoC like H5/A64 has DE2 CCU so enable them
>> as default.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  drivers/clk/sunxi-ng/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
>> index 79dfd296c3d1..1fffd3bf6ff3 100644
>> --- a/drivers/clk/sunxi-ng/Kconfig
>> +++ b/drivers/clk/sunxi-ng/Kconfig
>> @@ -58,6 +58,8 @@ config SUN8I_V3S_CCU
>>
>>  config SUN8I_DE2_CCU
>>         bool "Support for the Allwinner SoCs DE2 CCU"
>> +       default ARM64 && ARCH_SUNXI
>> +       depends on (DRM_SUN4I && (ARM64 && ARCH_SUNXI)) || COMPILE_TEST
>
> There is no reason to depend on DRM_SUN4I. There is no compile dependency.

Since this CCU is for DE2 I've make DRM_SUN4I for that matter, any problem?

>
> Also, this is needed on SUN8I as well, pretty much anything with DE 2.0.
> So you shouldn't limit it to ARM64. That pretty much breaks things for
> people with A83T's or H3's. In fact you should enable it by default for
> these as well.

True, I've skipped SUN8I since this series for A64.

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
