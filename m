Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeETBut (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 21:50:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38904 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeETBur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 21:50:47 -0400
X-Google-Smtp-Source: AB8JxZrodOfCkP6Q+FOoqr5h6sU+0QVafvupKnxAa3uXV7NiCJ0IEkKz2KZM1LsGNKRjIw0WXvip723+hhWTTQsoy7M=
MIME-Version: 1.0
In-Reply-To: <20180519183127.2718-8-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net> <20180519183127.2718-8-jernej.skrabec@siol.net>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 20 May 2018 11:50:25 +1000
Message-ID: <CAGRGNgU+PaygxkVkfcxUqMeV1TijJrZRkPkff7b4cxdVY6NQLA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 07/15] dt-bindings: display: sun4i-drm: Add
 R40 HDMI pipeline
To: jernej.skrabec@siol.net
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Sun, May 20, 2018 at 4:31 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Missing compatibles and descriptions needed to implement R40 HDMI
> pipeline are added.
>
> For mixers only compatibles are added.
>
> TCON description is expanded with R40 TV TCON compatibles. If the SoC
> has TCON TOP unit, phandle to that unit has to be specified. Additional
> clock has to be specified if SoC has TCON TOP and TCON is TV TCON.
>
> New compatible is added for DWC HDMI PHY, which has additional clock
> specified.

There's a bunch of A64 related stuff mixed in here, is the R40
compatible with the A64's parts? If so, you should probably mention
that in the commit log.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt         | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index a099957ab62a..634276f713e8 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -111,8 +112,9 @@ Required properties:
>    - resets: phandle to the reset controller driving the PHY
>    - reset-names: must be "phy"
>
> -H3 HDMI PHY requires additional clock:
> +H3 and A64 HDMI PHY requires additional clocks:
>    - pll-0: parent of phy clock
> +  - pll-1: second possible phy clock parent (A64 only)

Maybe split this into two:

H3 HDMI PHY ...
   - pll-0: ...

A64 HDMI PHY ...
   - pll-0: ...
   - pll-1: ...

At the moment a quick reading implies that H3 needs pll-1.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
