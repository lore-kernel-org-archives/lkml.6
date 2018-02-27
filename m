Date: Tue, 27 Feb 2018 14:14:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Dan Murphy <dmurphy@ti.com>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
Message-ID: <20180227131436.GJ32493@kroah.com>
References: <20180226202144.375869933@linuxfoundation.org>
 <81b4e3e9-b631-6fbc-f45c-6fa740e33494@ti.com>
 <20180226211917.GA2211@roeck-us.net>
 <20180226214519.GF16043@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226214519.GF16043@atomide.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 01:45:19PM -0800, Tony Lindgren wrote:
> * Guenter Roeck <linux@roeck-us.net> [180226 21:20]:
> > On Mon, Feb 26, 2018 at 02:58:24PM -0600, Dan Murphy wrote:
> > > Tony L/Greg
> > > 
> > > On 02/26/2018 02:21 PM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.14.23 release.
> > > > There are 54 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > We have a build issue on 4.14.22 and can be re-created with this rc as well.
> > > 
> > > arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
> > > omap-secure.c:(.text+0xe4): undefined reference to `save_secure_ram_context'
> > > make: *** [vmlinux] Error 1
> > > 
> > > The issue was introduced with the back port of
> > > 
> > > b59a1da647f163d0bf035f823a908b45c357643a ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context
> > > 
> > Looks like you may have CONFIG_PM disabled, is that correct ?
> > Is there a default configuration that we can use to reproduce
> > the problem ?
> 
> It should be fixed with this commit in mainline kernel:
> 
> 863204cfdae9 ("ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds")

Thanks, I'll queue this up in the next round.

greg k-h
