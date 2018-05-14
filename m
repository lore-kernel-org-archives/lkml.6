Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZpwkox5UK2anSCeZO2fiG7KBwPqa8ee/fuQ7vMClIOne6q8hsjMhReMGkyPrvNH+zXD0lWG
ARC-Seal: i=1; a=rsa-sha256; t=1526302080; cv=none;
        d=google.com; s=arc-20160816;
        b=CD7/aL+wfCzq0vaihTr2RyKMbbLEgxRlkEX2tIxvuwxkbto9SpXXjbHhWoU6b98VIa
         Vi1TkwQNw8PmS8VYQmy9dGdF3e6omW7o0nJBaPjs+Ok8Kop7hLSko/zWPe0zFWn+i2k7
         xlXBWiNRRSPsLEDJTdqNyrhrikO3fb0ETUhZDoWduiaH/zOz8h7W82JzKgvd7OpET7ci
         xAf74TpV2Et5206Vl9sWYncuHtD8C6TQ2GVE7rS+NeO1VvMGfVuAPQUj4nGhRWwkhxs8
         BnwiIUdwAtYppokUUfu/D8bzMTi5oZNLuHmZxh8cTQUlK4hDdMygKoU18I+ET7bu0vKT
         kEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=s9ri+ksBrPBOZK0Ofx49u11feRxT2lZIFCBI28IDRmY=;
        b=Cv0R7JFsQE5zesAsIHlh55JQT/uhXhkyFiyTksTQ06QStSHpBmX9fzxoa/B1rKZ/eb
         M4VpXbtJYGcwsaIGTE0XuDtX0Ln5Xz4RPfP+yHzU1AOFmRZyXriGiiMCbVdWrTR0yLsc
         veeaYC/0bme1pq5avue0CO7OZvsMjrkAGL8XKLnlDJOm29Akb1IOlzbRfqUfP9gKBCUa
         ewKQT3N2OPWxtpt8DEGyQzs6gLHUBTd2tslan7XKyRSz9qOC5Za1ENW179OERhDJck11
         L/XyDVzhynyCzPVcfrWXIWCsn+TWYHZZN3Yis0/8XwfHHLJjFNhZCSTNLiXn8343c8nl
         CtIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nS2ZzVB7;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nS2ZzVB7;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Mon, 14 May 2018 07:47:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
	robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
	gregkh@linuxfoundation.org, hch@lst.de, joro@8bytes.org,
	m.szyprowski@samsung.com, shawnguo@kernel.org,
	frowand.list@gmail.com, bhelgaas@google.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Message-ID: <20180514124757.GA253589@bhelgaas-glaptop.roam.corp.google.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894785673525346?=
X-GMAIL-MSGID: =?utf-8?q?1600443730463072453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When you add the changleog, please also fix the subject typo:

- bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
               ^^^^^^^
+ bus: fsl-mc: support dma configure for devices on fsl-mc bus

On Mon, Apr 30, 2018 at 11:57:20AM +0530, Nipun Gupta wrote:
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 5d8266c..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +static int fsl_mc_dma_configure(struct device *dev)
> +{
> +	struct device *dma_dev = dev;
> +
> +	while (dev_is_fsl_mc(dma_dev))
> +		dma_dev = dma_dev->parent;
> +
> +	return of_dma_configure(dev, dma_dev->of_node, 0);
> +}
> +
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
>  	.name = "fsl-mc",
>  	.match = fsl_mc_bus_match,
>  	.uevent = fsl_mc_bus_uevent,
> +	.dma_configure  = fsl_mc_dma_configure,
>  	.dev_groups = fsl_mc_dev_groups,
>  };
>  EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  		mc_dev->icid = parent_mc_dev->icid;
>  		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
>  		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
>  		dev_set_msi_domain(&mc_dev->dev,
>  				   dev_get_msi_domain(&parent_mc_dev->dev));
>  	}
> @@ -633,10 +645,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  			goto error_cleanup_dev;
>  	}
>  
> -	/* Objects are coherent, unless 'no shareability' flag set. */
> -	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> -
>  	/*
>  	 * The device-specific probe callback will get invoked by device_add()
>  	 */
> -- 
> 1.9.1
> 
