Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeENKbT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:31:19 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:44580 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeENKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:31:17 -0400
X-Google-Smtp-Source: AB8JxZpPXCMmZRtTu7Y+ReQ2kr9Fiahn556xW6HMg91Afolz0AqOvl/N1JYL30JOv39eTcfyH11B/oGDYayEO7TBp/A=
MIME-Version: 1.0
In-Reply-To: <20180514084050.ix5corfuvx33gsyn@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-10-jagan@amarulasolutions.com> <20180502113413.vv2r3ubfoh7gm3ms@flea>
 <CAMty3ZBheurXewQ8R53G_0gNLgv1jQkZbjAbaN30JQ6_ZVn7Eg@mail.gmail.com> <20180514084050.ix5corfuvx33gsyn@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 14 May 2018 16:01:15 +0530
Message-ID: <CAMty3ZDCubM2sLBfNVar-kA9djZ8PJDQJOS0Jwi6wWNVeK9mCg@mail.gmail.com>
Subject: Re: [PATCH 09/21] arm64: dts: allwinner: a64: Add HDMI support
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
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

On Mon, May 14, 2018 at 2:10 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, May 14, 2018 at 02:03:36PM +0530, Jagan Teki wrote:
>> On Wed, May 2, 2018 at 5:04 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>> > Hi,
>> >
>> > On Mon, Apr 30, 2018 at 05:10:46PM +0530, Jagan Teki wrote:
>> >> +             hdmi_phy: hdmi-phy@1ef0000 {
>> >> +                     compatible = "allwinner,sun50i-a64-hdmi-phy",
>> >> +                                  "allwinner,sun8i-h3-hdmi-phy";
>> >> +                     reg = <0x01ef0000 0x10000>;
>> >> +                     clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
>> >> +                              <&ccu CLK_PLL_VIDEO1>;
>> >
>> > You were discussing that the PLL0 could also be used to clock the PHY,
>> > has that been figured out?
>>
>> This is what I understand from Fig: 3-3. Module Clock Diagram, both
>> tcon0 and tcon1 are using HDMI. I'm thinking based on the tcon
>> configuration we need use proper PLL or some logic to get common PLL
>> don't know yet. Since this series adding tcon1 I've attached PLL1.
>
> You're not describing the TCON node here though, but the HDMI one, and
> the HDMI block is listed in both the PLL video 0 and 1.

So how can we attach particular PLL with particular HDMI(PLL0 to HDMI0
and so-on) or do we need to attached both the PLL's any suggestion?
