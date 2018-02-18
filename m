Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeBRJsR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 04:48:17 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46518 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeBRJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 04:48:16 -0500
Date: Sun, 18 Feb 2018 10:41:35 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: tim@krieglstein.org, jarkko.nikula@linux.intel.com,
        preid@electromag.com.au, wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: i2c-designware: sound and s2ram broken on Broadwell-U system
 since commit ca382f5b38f367b6 (add i2c gpio recovery option)
Message-ID: <20180218094135.GA2459@light.dominikbrodowski.net>
References: <20180217132543.GA21571@light.dominikbrodowski.net>
 <1518879773.22495.378.camel@linux.intel.com>
 <1518880180.22495.379.camel@linux.intel.com>
 <20180217165815.GA1854@light.dominikbrodowski.net>
 <1518901021.22495.383.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518901021.22495.383.camel@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 10:57:01PM +0200, Andy Shevchenko wrote:
> On Sat, 2018-02-17 at 17:58 +0100, Dominik Brodowski wrote:
> > On Sat, Feb 17, 2018 at 05:09:40PM +0200, Andy Shevchenko wrote:
> 
> > This patch fixes the issue, thanks.
> 
> I will send it soon out.
> 
> >  Do you still need the DEBUG_GPIO output?
> 
> It would be nice to have, though if it makes difficulties to you, then
> don't bother.

Note that I have to enable CONFIG_GPIOLIB before I can enable DEBUG_GPIO;
CONFIG_PINCTRL was off as well. Maybe some "SELECT" is missing for
CONFIG_I2C_DESIGNWARE_BAYTRAIL ?

The following output is with your patch applied. Do you need it without
your fixup patch as well?

$ dmesg | egrep -i "(gpio|pinctrl|i2c|broadw)"
[    0.591578] calling  dw_i2c_init_driver+0x0/0x13 @ 1
[    0.625040] i2c_designware INT3432:00: GPIO lookup for consumer scl
[    0.625073] i2c_designware INT3432:00: using ACPI for GPIO lookup
[    0.625102] acpi INT3432:00: GPIO: looking up scl-gpios
[    0.625129] acpi INT3432:00: GPIO: looking up scl-gpio
[    0.625154] i2c_designware INT3432:00: using lookup tables for GPIO lookup
[    0.625202] i2c_designware INT3432:00: lookup for GPIO scl failed
[    0.678297] i2c_designware INT3433:00: GPIO lookup for consumer scl
[    0.678326] i2c_designware INT3433:00: using ACPI for GPIO lookup
[    0.678353] acpi INT3433:00: GPIO: looking up scl-gpios
[    0.678376] acpi INT3433:00: GPIO: looking up scl-gpio
[    0.678398] i2c_designware INT3433:00: using lookup tables for GPIO lookup
[    0.678427] i2c_designware INT3433:00: lookup for GPIO scl failed
[    0.701403] initcall dw_i2c_init_driver+0x0/0x13 returned 0 after 107421 usecs
[    1.711543] calling  gpio_clk_driver_init+0x0/0x13 @ 1
[    1.712419] initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 44 usecs
[    1.933569] calling  synaptics_i2c_driver_init+0x0/0x13 @ 1
[    1.933602] initcall synaptics_i2c_driver_init+0x0/0x13 returned 0 after 30 usecs
[    1.933996] calling  rmi_i2c_driver_init+0x0/0x13 @ 1
[    1.934060] initcall rmi_i2c_driver_init+0x0/0x13 returned 0 after 59 usecs
[    1.935852] calling  i2c_i801_init+0x0/0xc9 @ 1
[    1.957452] initcall i2c_i801_init+0x0/0xc9 returned 0 after 21089 usecs
[    1.977716] calling  i2c_hid_driver_init+0x0/0x13 @ 1
[    2.025330] input: DLL0665:01 06CB:76AD Touchpad as /devices/pci0000:00/INT3433:00/i2c-1/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input9
[    2.025853] hid-multitouch 0018:06CB:76AD.0001: input: I2C HID v1.00 Mouse [DLL0665:01 06CB:76AD] on i2c-DLL0665:01
[    2.026376] initcall i2c_hid_driver_init+0x0/0x13 returned 0 after 47514 usecs
[    2.065027] calling  max98090_i2c_driver_init+0x0/0x13 @ 1
[    2.065075] initcall max98090_i2c_driver_init+0x0/0x13 returned 0 after 44 usecs
[    2.065077] calling  rt286_i2c_driver_init+0x0/0x13 @ 1
[    2.118805] initcall rt286_i2c_driver_init+0x0/0x13 returned 0 after 52461 usecs
[    2.118809] calling  rt5640_i2c_driver_init+0x0/0x13 @ 1
[    2.118853] initcall rt5640_i2c_driver_init+0x0/0x13 returned 0 after 38 usecs
[    2.118856] calling  rt5651_i2c_driver_init+0x0/0x13 @ 1
[    2.118894] initcall rt5651_i2c_driver_init+0x0/0x13 returned 0 after 34 usecs
[    2.165208] calling  broadwell_audio_init+0x0/0x13 @ 1
[    2.167941] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
[    2.168171] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
[    2.168377] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
[    2.168575] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
[    2.170833] broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
[    2.179624] input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input15
[    2.180363] initcall broadwell_audio_init+0x0/0x13 returned 0 after 14793 usecs

Thanks,
	Dominik
