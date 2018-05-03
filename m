Return-Path: <vinod.koul@intel.com>
X-Google-Smtp-Source: AB8JxZrFdgs3EwpgBuVrm0yrp6acX8L215PAWnTwoQ6HGkh1OllnFkNYAA1IY5KF8jmuamlXLVlN
ARC-Seal: i=1; a=rsa-sha256; t=1525365101; cv=none;
        d=google.com; s=arc-20160816;
        b=CdjelxuUpn9U+iwjvl8ycHJKCqIPGbzeNGj8gr46LSUGoXoAQ3r84jetwN/szuO5NR
         7Z5s5LlYWhmeCfqWIwbyJoU/fb1pblU0j21FmS+vf1dcySOMSzzMFxCrtXN8rLJzLOMl
         1bR0BgDIL504SbRLo2Eonr5X6VHT1qkh81PQhii4f3gXCCqHZvlWu27311R2yZVJ4toL
         /p1OOr8SKrwBXa15onkmVxwB0oFeU6VMzHUCls7cTyqhdhwQ4+TUBAfxvEjQiWxlmu83
         2M/78giNMbBz7L4ZGFgLDrMmzeTGKFzui344zlVm+ZODhFD9rEe1noXElFN30xHcUqCg
         JnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=qRVz2lDWdtc5m4RNkU/czTNj28z/1jVYJzjdco2HX3Q=;
        b=xASL8oegNIh9FTx0e1K4iF9ojHnYo9VJ/XQcFCpxFJdaWDgr5w5DRuLq75u3OXUM4G
         xTNSoBFdkmD35NkiQNpWSgCO3ubfwDku72YaxD2jzjZSYUhozbgwVBXYCp4q/J99oydn
         rJzLsacXh1kCPJ4pIg6MJzjl6UfJ3L6VJcbX2Wc7o+nXLH8nwN7XBj2+yuVqHpZuy4zx
         QUkBCxa7YHPwJrjrdQYeFdycnDgGCYwhQSIUJQ7KL72zbRWIEaYSM2xEY4NKjffTTEp3
         vv4fMa5JhCfNzyA9jTEWMfbhRABOP4OT+LmjffmGQJeH0FNDcDhvWTGUjLwXCHBX5PYB
         bg6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="52147504"
Date: Thu, 3 May 2018 22:06:22 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, hch@lst.de, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
	bhelgaas@google.com, zajec5@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, dan.j.williams@intel.com,
	thierry.reding@gmail.com, robh+dt@kernel.org,
	frowand.list@gmail.com, jarkko.sakkinen@linux.intel.com,
	rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com,
	johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, bharat.bhushan@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH v4 2/2] drivers: remove force dma flag from buses
Message-ID: <20180503163622.GA6014@localhost>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-2-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524883919-29484-2-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1599461236315599053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 08:21:59AM +0530, Nipun Gupta wrote:
> With each bus implementing its own DMA configuration callback,
> there is no need for bus to explicitly have force_dma in its
> global structure. This patch modifies of_dma_configure API to
> accept an input parameter which specifies if implicit DMA
> configuration is required even when it is not described by the
> firmware.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # PCI parts
> ---
> Changes in v2:
>   - This is a new change suggested by Robin and Christoph
>     and is added to the series.
> 
> Changes in v3:
>   - Rebase and changes corresponding to the changes in patch 1/2
> 
> Changes in v4:
>   - Rebased on top of 4.17-rc2
> 
>  drivers/amba/bus.c            | 1 -
>  drivers/base/platform.c       | 3 +--
>  drivers/bcma/main.c           | 2 +-
>  drivers/dma/qcom/hidma_mgmt.c | 2 +-

This one:
Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
