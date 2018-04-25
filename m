Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeDYKeX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:34:23 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:45579 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeDYKeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:34:11 -0400
X-Google-Smtp-Source: AIpwx48SiNTvJP+flFPY8rVRlNY/nGHnB1xfxbc7V5RDg7VjioLu1uhgT0yCYMNk2r1qG8n6qFwRUM9ndX0Xs3IBj3I=
MIME-Version: 1.0
In-Reply-To: <4355590.Ql03JAEh1C@jernej-laptop>
References: <20180424133425.24291-1-jagan@amarulasolutions.com> <4355590.Ql03JAEh1C@jernej-laptop>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 25 Apr 2018 16:04:09 +0530
Message-ID: <CAMty3ZCTtB__eWub2PbHK_DHSVQsf4V1eECX6bfwDq99pXaLJQ@mail.gmail.com>
Subject: Re: [RFC 00/13] arm64: allwinner: Add A64 DE2 pipeline support
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3PBYeKo023894

On Tue, Apr 24, 2018 at 9:02 PM, Jernej Škrabec <jernej.skrabec@siol.net> wrote:
> Hi,
>
> Dne torek, 24. april 2018 ob 15:34:12 CEST je Jagan Teki napisal(a):
>> Allwinner A64 has display engine pipeline like other Allwinner SOC's
>> A83T/H3/H5.
>>
>> A64 DE2 behaviour similar to Allwinner A83T where mixer0, connected to tcon0
>> with RGB, LVDS MIPI-DSI and mixer1, connected to tcon1 with HDMI.
>> This series merely concentrated on HDMI pipeline and rest will add
>> eventually.
>>
>> patch 1: dt-bindings for a64 DE2 CCU
>>
>> patch 2: a64 DE2 CCU node addition
>>
>> patch 3: dt-bindings for a64 DE2 pipeline
>>
>> patch 4 - 5: dt-bindings for a64 mixer0 and tcon-lcd
>>
>> patch 6: a64 DE2 pipeline node addition
>>
>> patch 7 - 8: dt-bindings for a64 HDMI and HDMI PHY
>>
>> patch 9: a64 HDMI nodes addition
>>
>> patch 10 - 11: dt-bindings for a64 mixer1 and tcon-tv
>>
>> patch 12: a64 HDMI pipeline
>>
>> patch 13: enable HDMI out on bananpi-m64
>>
>> Tested HDMI on bananapi-m64 (along with DE2 SRAM C changes from [1]
>> thread), able to detect the HDMI but, no penguins on screen.
>>
>> Request for any suggestions.
>
> You are mising sunxi-ng clock patches. PLL_VIDEO0 and PLL_VIDEO1 need fixes by
> setting minimum stable frequency. Please note that datasheet may have wrong
> information. That was obvious in H3 case and I had to check minimum stable
> PLL_VIDEO frequency in BSP driver.

Can you point me the clock patches? I've phadled only CLK_PLL_VIDEO0
on hdmi_phy So we need CLK_PLL_VIDEO1 as fourth clock?

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
