Date: Fri, 16 Mar 2018 13:32:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Ford <aford173@gmail.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 13/36] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
Message-ID: <20180316123221.GD25079@kroah.com>
References: <20180310001807.213987241@linuxfoundation.org>
 <20180310001807.970379538@linuxfoundation.org>
 <1520897374.23626.82.camel@codethink.co.uk>
 <CAHCN7xL3N0RnmhnPRqgTNSiehwLcVm6OFLyFNvPPcqnuh5O5oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xL3N0RnmhnPRqgTNSiehwLcVm6OFLyFNvPPcqnuh5O5oA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:31:05PM -0500, Adam Ford wrote:
> On Mon, Mar 12, 2018 at 6:29 PM, Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
> > On Fri, 2018-03-09 at 16:18 -0800, Greg Kroah-Hartman wrote:
> >> 4.4-stable review patch.  If anyone has any objections, please let me know.
> >>
> >> ------------------
> >>
> >> From: Adam Ford <aford173@gmail.com>
> >>
> >> commit 74402055a2d3ec998a1ded599e86185a27d9bbf4 upstream.
> >>
> >> The pinmuxing was missing for I2C1 which was causing intermittent issues
> >> with the PMIC which is connected to I2C1.  The bootloader did not quite
> >> configure the I2C1 either, so when running at 2.6MHz, it was generating
> >> errors at time.
> >>
> >> This correctly sets the I2C1 pinmuxing so it can operate at 2.6MHz
> >>
> >> Fixes: 687c27676151 ("ARM: dts: Add minimal support for LogicPD Torpedo
> >> DM3730 devkit")
> >>
> >> Signed-off-by: Adam Ford <aford173@gmail.com>
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>
> >> ---
> >>  arch/arm/boot/dts/logicpd-torpedo-som.dtsi |    8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> >> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> >> @@ -90,6 +90,8 @@
> >>  };
> >>
> >>  &i2c1 {
> >> +     pinctrl-names = "default";
> >> +     pinctrl-0 = <&i2c1_pins>;
> >>       clock-frequency = <2600000>;
> >>
> >>       twl: twl@48 {
> >> @@ -146,6 +148,12 @@
> >>                       OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_ctl.sdmmc3_cmd */
> >>               >;
> >>       };
> >> +     i2c1_pins: pinmux_i2c1_pins {
> >> +             pinctrl-single,pins = <
> >> +                     OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
> >> +                     OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
> >> +             >;
> >> +     };
> >
> > This is being added under &omap3_pmx_core2, but upstream it was added
> > under &omap3_pmx_core.  Does that matter?
> 
> I would agree with you that it should be under the omap3_pmx_core
> 
> I have been trying to get time to run tests on this, but due to a hard
> drive corruption, I haven't been able to do much for the past several
> days.
> 
> Greg - If I find it doesn't doesn't work as-is, do you want me to
> submit a patch to you directly, or go through alternative means?

Ugh, how about I revert this one, as the current code is wrong, and you
just provide a correct backport when you get a chance to create/test it?

thanks,

greg k-h
