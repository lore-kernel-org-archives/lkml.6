Date: Thu, 8 Mar 2018 09:14:09 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Ofir Drang <ofir.drang@arm.com>, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ccree: remove ccree staging copy
Message-ID: <20180308171409.GA21632@kroah.com>
References: <1520498678-32175-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520498678-32175-1-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 08:44:38AM +0000, Gilad Ben-Yossef wrote:
> Now when the ccree driver has been accepted into the cryptodev tree
> we can remove the staging tree copy.

Yeah!  Nice job.

> 
> Please note that this commit may cause a merge conflict with the
> cryptodev tree since we needed to disable the staging copy in order
> to get the new copy to compile but the resolution is trivial.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  drivers/staging/Kconfig                  |    2 -
>  drivers/staging/Makefile                 |    1 -
>  drivers/staging/ccree/Kconfig            |   27 -
>  drivers/staging/ccree/Makefile           |    7 -
>  drivers/staging/ccree/TODO               |   10 -
>  drivers/staging/ccree/cc_aead.c          | 2704 ------------------------------
>  drivers/staging/ccree/cc_aead.h          |  109 --
>  drivers/staging/ccree/cc_buffer_mgr.c    | 1651 ------------------
>  drivers/staging/ccree/cc_buffer_mgr.h    |   74 -
>  drivers/staging/ccree/cc_cipher.c        | 1165 -------------
>  drivers/staging/ccree/cc_cipher.h        |   74 -
>  drivers/staging/ccree/cc_crypto_ctx.h    |  170 --
>  drivers/staging/ccree/cc_debugfs.c       |  101 --
>  drivers/staging/ccree/cc_debugfs.h       |   32 -
>  drivers/staging/ccree/cc_driver.c        |  474 ------
>  drivers/staging/ccree/cc_driver.h        |  194 ---
>  drivers/staging/ccree/cc_fips.c          |  111 --
>  drivers/staging/ccree/cc_fips.h          |   37 -
>  drivers/staging/ccree/cc_hash.c          | 2296 -------------------------
>  drivers/staging/ccree/cc_hash.h          |  114 --
>  drivers/staging/ccree/cc_host_regs.h     |  142 --
>  drivers/staging/ccree/cc_hw_queue_defs.h |  590 -------
>  drivers/staging/ccree/cc_ivgen.c         |  280 ----
>  drivers/staging/ccree/cc_ivgen.h         |   55 -
>  drivers/staging/ccree/cc_kernel_regs.h   |  167 --
>  drivers/staging/ccree/cc_lli_defs.h      |   59 -
>  drivers/staging/ccree/cc_pm.c            |  122 --
>  drivers/staging/ccree/cc_pm.h            |   57 -
>  drivers/staging/ccree/cc_request_mgr.c   |  713 --------
>  drivers/staging/ccree/cc_request_mgr.h   |   51 -
>  drivers/staging/ccree/cc_sram_mgr.c      |  107 --
>  drivers/staging/ccree/cc_sram_mgr.h      |   65 -
>  32 files changed, 11761 deletions(-)
>  delete mode 100644 drivers/staging/ccree/Kconfig
>  delete mode 100644 drivers/staging/ccree/Makefile
>  delete mode 100644 drivers/staging/ccree/TODO
>  delete mode 100644 drivers/staging/ccree/cc_aead.c
>  delete mode 100644 drivers/staging/ccree/cc_aead.h
>  delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.c
>  delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.h
>  delete mode 100644 drivers/staging/ccree/cc_cipher.c
>  delete mode 100644 drivers/staging/ccree/cc_cipher.h
>  delete mode 100644 drivers/staging/ccree/cc_crypto_ctx.h
>  delete mode 100644 drivers/staging/ccree/cc_debugfs.c
>  delete mode 100644 drivers/staging/ccree/cc_debugfs.h
>  delete mode 100644 drivers/staging/ccree/cc_driver.c
>  delete mode 100644 drivers/staging/ccree/cc_driver.h
>  delete mode 100644 drivers/staging/ccree/cc_fips.c
>  delete mode 100644 drivers/staging/ccree/cc_fips.h
>  delete mode 100644 drivers/staging/ccree/cc_hash.c
>  delete mode 100644 drivers/staging/ccree/cc_hash.h
>  delete mode 100644 drivers/staging/ccree/cc_host_regs.h
>  delete mode 100644 drivers/staging/ccree/cc_hw_queue_defs.h
>  delete mode 100644 drivers/staging/ccree/cc_ivgen.c
>  delete mode 100644 drivers/staging/ccree/cc_ivgen.h
>  delete mode 100644 drivers/staging/ccree/cc_kernel_regs.h
>  delete mode 100644 drivers/staging/ccree/cc_lli_defs.h
>  delete mode 100644 drivers/staging/ccree/cc_pm.c
>  delete mode 100644 drivers/staging/ccree/cc_pm.h
>  delete mode 100644 drivers/staging/ccree/cc_request_mgr.c
>  delete mode 100644 drivers/staging/ccree/cc_request_mgr.h
>  delete mode 100644 drivers/staging/ccree/cc_sram_mgr.c
>  delete mode 100644 drivers/staging/ccree/cc_sram_mgr.h
> 
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index e95ab68..7802c26 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -114,8 +114,6 @@ source "drivers/staging/greybus/Kconfig"
>  
>  source "drivers/staging/vc04_services/Kconfig"
>  
> -source "drivers/staging/ccree/Kconfig"
> -
>  source "drivers/staging/typec/Kconfig"
>  
>  source "drivers/staging/vboxvideo/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index af8cd6a..56afa21 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -49,6 +49,5 @@ obj-$(CONFIG_MOST)		+= most/
>  obj-$(CONFIG_KS7010)		+= ks7010/
>  obj-$(CONFIG_GREYBUS)		+= greybus/
>  obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
> -obj-$(CONFIG_CRYPTO_DEV_CCREE)	+= ccree/
>  obj-$(CONFIG_DRM_VBOXVIDEO)	+= vboxvideo/
>  obj-$(CONFIG_PI433)		+= pi433/
> diff --git a/drivers/staging/ccree/Kconfig b/drivers/staging/ccree/Kconfig
> deleted file mode 100644
> index c94dfe8..0000000

This patch doesn't apply at all.  Does it work for you when using 'git
am' to import it?

Should I just do this "by hand" instead?

thanks,

greg k-h
