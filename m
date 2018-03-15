Date: Thu, 15 Mar 2018 11:18:51 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@sifive.com>
Subject: Re: linux-next: manual merge of the tty tree with the asm-generic
 tree
Message-ID: <20180315101851.GB2802@kroah.com>
References: <20180315173604.5c858ed8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315173604.5c858ed8@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 05:36:04PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the tty tree got conflicts in:
> 
>   drivers/tty/hvc/Kconfig
>   drivers/tty/hvc/Makefile
> 
> between commit:
> 
>   c235c62f99e6 ("tty: remove bfin_jtag_comm and hvc_bfin_jtag drivers")
> 
> from the asm-generic tree and commit:
> 
>   afa6b1ccfad5 ("tty: New RISC-V SBI console driver")
> 
> from the tty tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/tty/hvc/Kconfig
> index 3bade5ad3d71,e7cc617d6e45..000000000000
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@@ -88,6 -88,25 +88,16 @@@ config HVC_DC
>   	 driver. This console is used through a JTAG only on ARM. If you don't have
>   	 a JTAG then you probably don't want this option.
>   
>  -config HVC_BFIN_JTAG
>  -	bool "Blackfin JTAG console"
>  -	depends on BLACKFIN
>  -	select HVC_DRIVER
>  -	help
>  -	 This console uses the Blackfin JTAG to create a console under the
>  -	 the HVC driver.  If you don't have JTAG, then you probably don't
>  -	 want this option.
>  -
> + config HVC_RISCV_SBI
> + 	bool "RISC-V SBI console support"
> + 	depends on RISCV
> + 	select HVC_DRIVER
> + 	help
> + 	  This enables support for console output via RISC-V SBI calls, which
> + 	  is normally used only during boot to output printk.
> + 
> + 	  If you don't know what do to here, say Y.
> + 
>   config HVCS
>   	tristate "IBM Hypervisor Virtual Console Server support"
>   	depends on PPC_PSERIES && HVC_CONSOLE
> diff --cc drivers/tty/hvc/Makefile
> index 7da1934d34e8,83079ae000ae..000000000000
> --- a/drivers/tty/hvc/Makefile
> +++ b/drivers/tty/hvc/Makefile
> @@@ -9,4 -10,6 +9,5 @@@ obj-$(CONFIG_HVC_IRQ)		+= hvc_irq.
>   obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
>   obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
>   obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
>  -obj-$(CONFIG_HVC_BFIN_JTAG)	+= hvc_bfin_jtag.o
> + obj-$(CONFIG_HVC_RISCV_SBI)	+= hvc_riscv_sbi.o
>   obj-$(CONFIG_HVCS)		+= hvcs.o



Merge looks correct, thanks!

greg k-h
