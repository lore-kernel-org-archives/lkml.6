Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbeDMMSa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:18:30 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:40141 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754494AbeDMMS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:18:28 -0400
X-Google-Smtp-Source: AIpwx4/BkUr15tDaw3ZuOjjla4BoUpG/ks/t+/lhNBcRDSh/vDCS4+k55Pj+Oe4Vl1SQM0rXeLqHIKQdOyc/7QCfwS4=
MIME-Version: 1.0
In-Reply-To: <20180413120958.vo4y34q36q2rjyej@flea>
References: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
 <20180411124325.youvfpws27l2wesf@flea> <CAD6G_RRQrj9m=MPdjovEcwJV_fivCMAERSa49Mt0cKGFTicsxA@mail.gmail.com>
 <20180413120958.vo4y34q36q2rjyej@flea>
From: Jagan Teki <jagannadh.teki@gmail.com>
Date: Fri, 13 Apr 2018 17:48:26 +0530
Message-ID: <CAD6G_RQrgw2Oopr8uxxev+XN=PERCoR37G7TUur=b=Pvy=6AnA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] drm/sun4i: Allwinner MIPI-DSI support
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 5:39 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Fri, Apr 13, 2018 at 05:30:04PM +0530, Jagan Teki wrote:
>> On Wed, Apr 11, 2018 at 6:13 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > On Wed, Apr 04, 2018 at 11:57:08AM +0200, Maxime Ripard wrote:
>> >> Hi,
>> >>
>> >> Here is an preliminary version of the MIPI-DSI support for the Allwinner
>> >> SoCs.
>> >>
>> >> This controller can be found on a number of recent SoCs, such as the
>> >> A31, A33 or the A64.
>> >>
>> >> Given the sparse documentation, there's a number of obscure areas, but
>> >> the current implementation has been tested with a 4-lanes DSI panel on
>> >> an A33.
>> >>
>> >> The support is a bit rough around the edges at the time, and some artifacts
>> >> are still shown on the screen for some reasons. Wider testing with
>> >> different display will hopefully nail those down.
>> >>
>> >> This needs the regmap_mmio_attach_clk, on its way to Linus in 4.17.
>> >>
>> >> Let me know what you think,
>> >> Maxime
>> >>
>> >> Changes from v3:
>> >>   - Rebased on top of current drm-misc-next
>> >>   - Switched to SPDX license header
>> >>   - Made the ECC array const
>> >>   - Split the big DSI patch into two, one to add the DSI driver and one to
>> >>     add the TCON bits.
>> >>   - Removed the dithering code
>> >>   - Changed the DT labels to remove the indices
>> >>   - Used sleeps instead of delays in the panel driver
>> >>   - Used the backlight_enable / _disable functions
>> >>   - Added Chen-Yu's Reviewed-by
>> >>
>> >> Changes from v2:
>> >>   - Added a ports node under the DSI node
>> >>   - Changed the huarui panel driver to an ili9881c driver
>> >>   - Changed the panel vendor to bananapi
>> >>   - Made the init table static in the panel driver
>> >>   - Dropped the huarui vendor patch for the DT doc.
>> >>
>> >> Changes from v1:
>> >>   - Rebased on 4.16-rc1
>> >>   - Constified a few function arguments and structures
>> >>   - Reworked the DT binding example a bit
>> >>   - Reworked the panel driver to check for DSI return codes, and use DCS
>> >>     helpers when possible
>> >>
>> >> Maxime Ripard (8):
>> >>   drm/sun4i: tcon: Add TRI finish interrupt for vblank
>> >>   dt-bindings: display: Add Allwinner MIPI-DSI bindings
>> >>   drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
>> >>   drm/sun4i: Tie the DSI controller in the TCON
>> >>   dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
>> >>   drm/panel: Add Ilitek ILI9881c panel driver
>> >>   ARM: dts: sun8i: a33: Add the DSI-related nodes
>> >>   [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display
>>
>> I have reviewed most of the patches and reused for A64 all look fine
>> to me (except the panel driver). May be my issue is not relevant to
>> this thread, but I'm looking for help If I miss anything for A64 [1]
>> and [2] are changes made for A64, the issue is kernel hang while
>> loading sun6i_dsi.
>
> My guess would be that you're not claiming the DE2 SRAM. See:
> https://lkml.org/lkml/2018/3/16/1096

Thanks Maxime, will try.
