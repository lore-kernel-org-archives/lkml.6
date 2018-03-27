Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeC0F00 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:26:26 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:59350 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeC0F0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:26:23 -0400
Subject: Re: [PATCH v4 0/8] ARM: davinci: complete the conversion to using the
 reset framework
To: Suman Anna <s-anna@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
CC: David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        devicetree <devicetree@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180323130455.11470-1-brgl@bgdev.pl>
 <152182378792.178046.3747112581117251857@swboyd.mtv.corp.google.com>
 <CAMRc=MfEebDk4D=t-ybRgbn+HaY7RUfOFCDAf9H8F3cZRchJmA@mail.gmail.com>
 <152182490783.178046.1191965992600877708@swboyd.mtv.corp.google.com>
 <CAMRc=MdmTAwPAAnL1+n+OXSycnyjuQ1hKmts158mPcgat1NUYQ@mail.gmail.com>
 <c78817f9-02fd-0ded-609e-5014efdd4a77@ti.com>
 <0683b11c-fefa-5fc7-793e-1a662a5f0480@ti.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <44218403-5e7f-dd12-6d01-a52987fc4cc8@ti.com>
Date: Tue, 27 Mar 2018 10:54:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0683b11c-fefa-5fc7-793e-1a662a5f0480@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

On Tuesday 27 March 2018 06:12 AM, Suman Anna wrote:
> I tried booting your tree [3] on the OMAPL138-LCDK board. I am using
> NFS, and I am unable to get to the console. I don't have any issues
> booting latest -next branch (next-20180326) which only has the reset and
> clock driver related changes.
> 
> Here's the log towards the end of the boot..
> ---
> pinctrl-single 1c14120.pinmux: 160 pins, size 80
> Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
> console [ttyS2] disabled
> 1d0d000.serial: ttyS2 at MMIO 0x1d0d000 (irq = 61, base_baud = 8250000)
> is a TI DA8xx/66AK2x
> console [ttyS2] enabled
> brd: module loaded
> libphy: Fixed MDIO Bus: probed
> davinci_mdio 1e24000.mdio: davinci mdio revision 1.5, bus freq 2200000
> davinci_mdio 1e24000.mdio: no live phy, scanning all
> davinci_mdio: probe of 1e24000.mdio failed with error -5
> i2c /dev entries driver
> <nothing after this>

This is because of a bug in bootloader PLL configuration which got
uncovered only with CCF conversion. The bootloader that comes
pre-flashed with the board or the latest U-Boot master should work fine.

Here is the log with latest U-Boot master:
https://pastebin.ubuntu.com/p/HkwY9g4YDc/

Thanks,
Sekhar
