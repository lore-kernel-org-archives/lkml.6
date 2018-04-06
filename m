Date: Fri, 6 Apr 2018 09:26:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 51/97] mfd: palmas: Reset the POWERHOLD mux during
 power off
Message-ID: <20180406072613.GB15735@kroah.com>
References: <20180323094157.535925724@linuxfoundation.org>
 <20180323094200.471499547@linuxfoundation.org>
 <1522788554.2654.127.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522788554.2654.127.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 09:49:14PM +0100, Ben Hutchings wrote:
> On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Keerthy <j-keerthy@ti.com>
> > 
> > 
> > [ Upstream commit 85fdaf8eb9bbec1f0f8a52fd5d85659d60738816 ]
> > 
> > POWERHOLD signal has higher priority  over the DEV_ON bit.
> > So power off will not happen if the POWERHOLD is held high.
> > Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
> > and the DEV_ON bit to take effect to power off the PMIC.
> > 
> > PMIC Power off happens in dire situations like thermal shutdown
> > so irrespective of the POWERHOLD setting go ahead and turn off
> > the powerhold.  Currently poweroff is broken on boards that have
> > powerhold enabled. This fixes poweroff on those boards.
> [...]
> 
> This is not very useful by itself; I think you should pick these too:
> 
> [3.18]
> 0ea66f76ba17 Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
> 7c62de5f3fc9 ARM: dts: dra7: Add power hold and power controller properties to palmas
> 
> [4.4]
> 0ea66f76ba17 Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
> 1f166499ce00 ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
> - apply the changes in am57xx-beagle-x15.dts
> 7c62de5f3fc9 ARM: dts: dra7: Add power hold and power controller properties to palmas
> 
> [4.9]
> 0ea66f76ba17 Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
> 1f166499ce00 ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
> 8804755bfb1f ARM: dts: am57xx-idk-common: Add overide powerhold
> property
> 7c62de5f3fc9 ARM: dts: dra7: Add power hold and power controller properties to palmas
> 
> None of the above are needed for 4.14 and 4.15, but they do have one
> more board that needed this property, so please pick this:
> 
> aac4619d028e ARM: dts: DRA76-EVM: Set powerhold property for tps65917

Many thanks for this, all now queued up.

greg k-h
