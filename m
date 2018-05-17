Date: Thu, 17 May 2018 09:07:24 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Felipe Balbi <balbi@kernel.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: linux-next: manual merge of the usb-gadget tree with the usb tree
Message-ID: <20180517070724.GD13919@kroah.com>
References: <20180517140318.5333cfee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517140318.5333cfee@canb.auug.org.au>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 02:03:18PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb-gadget tree got a conflict in:
> 
>   drivers/usb/mtu3/Kconfig
> 
> between commit:
> 
>   cd91a0e9d38f ("usb: Remove depends on HAS_DMA in case of platform dependency")
> 
> from the usb tree and commit:
> 
>   f39846824cd6 ("usb: mtu3: make USB_MTU3_DUAL_ROLE depend on EXTCON but not USB_MTU3")
> 
> from the usb-gadget tree.
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
> diff --cc drivers/usb/mtu3/Kconfig
> index c0c0eb88e5ea,8daf27768888..000000000000
> --- a/drivers/usb/mtu3/Kconfig
> +++ b/drivers/usb/mtu3/Kconfig
> @@@ -2,7 -2,7 +2,7 @@@
>   
>   config USB_MTU3
>   	tristate "MediaTek USB3 Dual Role controller"
> - 	depends on EXTCON && (USB || USB_GADGET)
>  -	depends on (USB || USB_GADGET) && HAS_DMA
> ++	depends on (USB || USB_GADGET)
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
>   	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
>   	help

Looks good to me, thanks!

greg k-h
