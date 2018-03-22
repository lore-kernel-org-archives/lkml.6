Date: Thu, 22 Mar 2018 09:20:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180322082058.GD30498@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180320075012.GB10034@kroah.com>
 <20180321131843.GA27151@kroah.com>
 <20180321174043.GB6008@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321174043.GB6008@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:40:43AM -0700, Guenter Roeck wrote:
> On Wed, Mar 21, 2018 at 02:18:43PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 20, 2018 at 08:50:12AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.4.123 release.
> > > > There are 134 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > > > and the diffstat can be found below.
> > > 
> > > -rc2 is out to fix a build error that was in -rc1:
> > >  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc2.gz
> > 
> > And now -rc3 is out to hopefully resolve the last of the reported
> > problems:
> > 
> >   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc3.gz
> > 
> 
> Almost. For 4.4.122-132-g78a7af7:
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 127 pass: 125 fail: 2
> Failed tests: 
> 	powerpc:mpc8544ds:mpc85xx_defconfig 
> 	powerpc:mpc8544ds:mpc85xx_smp_defconfig
> 
> Error log:
> drivers/mtd/nand/fsl_ifc_nand.c: In function 'fsl_ifc_chip_init':
> drivers/mtd/nand/fsl_ifc_nand.c:995:23: error: 'FSL_IFC_VERSION_2_0_0' undeclared
> 
> Most likely commit 2a39eeb6949c ("mtd: nand: ifc: update bufnum mask for ver >=
> 2.0.0") doesn't really apply to v4.4 and older kernels.

Yeah, good catch, now dropping this one.

Odd that the Qemu test fails, but the build doesn't?

thanks again for the testing and help here.

greg k-h
