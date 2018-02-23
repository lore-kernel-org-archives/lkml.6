Date: Fri, 23 Feb 2018 10:49:15 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bogdan Purcareata <bogdan.purcareata@nxp.com>
Subject: Re: linux-next: manual merge of the staging tree with Linus' tree
Message-ID: <20180223094915.GA2643@kroah.com>
References: <20180223132836.6c7afdff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223132836.6c7afdff@canb.auug.org.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 01:28:36PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/fsl-mc/bus/Kconfig
> 
> between commit:
> 
>   02b7b2844c2f ("staging: fsl-mc: fix build testing on x86")
> 
> from Linus' tree and commit:
> 
>   6bd067c48efe ("staging: fsl-mc: Move core bus out of staging")
> 
> from the staging tree.
> 
> I fixed it up (I used the latter version of that file and applied the
> followinf merge fix patch) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 23 Feb 2018 13:25:34 +1100
> Subject: [PATCH] staging: fsl-mc: merge fix for CONFIG_FSL_MC_BUS moving
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/bus/fsl-mc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
> index bcca64486fd3..c23c77c9b705 100644
> --- a/drivers/bus/fsl-mc/Kconfig
> +++ b/drivers/bus/fsl-mc/Kconfig
> @@ -7,7 +7,7 @@
>  
>  config FSL_MC_BUS
>  	bool "QorIQ DPAA2 fsl-mc bus driver"
> -	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86 || PPC)))
> +	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86_LOCAL_APIC || PPC)))
>  	select GENERIC_MSI_IRQ_DOMAIN
>  	help
>  	  Driver to enable the bus infrastructure for the QorIQ DPAA2
> -- 
> 2.16.1

Thanks for this, I'll fix it up after 4.16-rc3 is out.

greg k-h
