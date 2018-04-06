Date: Fri, 6 Apr 2018 09:09:38 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [4.9, 137/145] spi: bcm-qspi: shut up warning about cfi header
 inclusion
Message-ID: <20180406070938.GE8416@kroah.com>
References: <20180223170742.426320243@linuxfoundation.org>
 <b9046b98-acb6-c828-661f-ab67696ff1b8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9046b98-acb6-c828-661f-ab67696ff1b8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 10:46:07AM -0700, Florian Fainelli wrote:
> On 02/23/2018 10:27 AM, gregkh@linuxfoundation.org wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When CONFIG_MTD_CFI is disabled, we get a warning for this spi driver:
> > 
> > include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
> > 
> > The problem here is a layering violation that was fixed in mainline kernels with
> > a larger rework in commit 054e532f8f90 ("spi: bcm-qspi: Remove hardcoded settings
> > and spi-nor.h dependency"). We can't really backport that to stable kernels, so
> > this just adds a Kconfig dependency to make it either build cleanly or force it
> > to be disabled.
> 
> Sorry for noticing so late, but this appears to be bogus, there is no
> MTD_NORFLASH symbol being defined in 4.9, in fact I can't find this
> Kconfig symbol in any kernel version, so this effectively results in the
> driver no longer being selectable, so this sure does silence the warning.
> 
> Arnd, should we just send reverts of this patch for the affected kernel
> or should we be defining MTD_NORFLASH somehow? Am I missing something here?

I'm going to revert this patch for now, thanks.

greg k-h
