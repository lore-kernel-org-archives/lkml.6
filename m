Date: Fri, 16 Feb 2018 20:54:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/88] 4.9.82-stable review
Message-ID: <20180216195456.GB6984@kroah.com>
References: <20180215151222.437136975@linuxfoundation.org>
 <cb0f5a5e-05ac-c52d-9334-40bbfc87a245@roeck-us.net>
 <20180216192117.GB11682@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216192117.GB11682@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 08:21:17PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 16, 2018 at 06:19:46AM -0800, Guenter Roeck wrote:
> > On 02/15/2018 07:16 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.82 release.
> > > There are 88 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Feb 17 15:11:46 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 145 pass: 137 fail: 8
> > Failed builds:
> > 	arm:allmodconfig
> > 	powerpc:defconfig
> > 	powerpc:allmodconfig
> > 	powerpc:ppc64e_defconfig
> > 	powerpc:cell_defconfig
> > 	powerpc:maple_defconfig
> > 	powerpc:ppc6xx_defconfig
> > 	powerpc:mpc83xx_defconfig
> > Qemu test results:
> > 	total: 126 pass: 119 fail: 7
> > Failed tests:
> > 	powerpc:mpc8544ds:mpc85xx_defconfig
> > 	powerpc:mpc8544ds:mpc85xx_smp_defconfig
> > 	powerpc:mac99:ppc64_book3s_defconfig:nosmp
> > 	powerpc:mac99:ppc64_book3s_defconfig:smp4
> > 	powerpc:pseries:pseries_defconfig
> > 	powerpc:mpc8544ds:ppc64_e5500_defconfig:nosmp
> > 	powerpc:mpc8544ds:ppc64_e5500_defconfig:smp
> 
> Yeah, powerpc is b0rked :(
> 
> > Build failures:
> > 
> > Building arm:allmodconfig ... failed
> > --------------
> > Error log:
> > 
> > drivers/clocksource/timer-stm32.c: In function 'stm32_clockevent_init':
> > drivers/clocksource/timer-stm32.c:191:2: error: implicit declaration of function 'kfree'
> 
> Let me go track this one down.

Found this one, should be fixed, might be a while before I can push out
an updated tree, I'm on a train right now...

thanks,

greg k-h
