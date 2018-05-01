Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525178090; cv=none;
        d=google.com; s=arc-20160816;
        b=KfYLNtNqdlkJTInDI7jDv58D09TY5iUA5HZ4bqTlTyHG176rgyEumxLTJHjA0xZ/Y4
         jFftn9Wyc1fqVM3nT4po7GltHFsVTVEdMfuZrsLs+XdUqLWUvefd9RkyP4JUAGnyGknP
         cVvwvKCG3c1e0PFh3u2aobZCJESGfr9IKEFzJi+MPiK5CK7bX8MyzUw3Wahy9Fzv7m++
         0asKe2vevarKR1XS3HbDQL9qV3nBxptnJ6FDGb8DS0a5JNXvy8OBb6lqEbrzOPAi7+3r
         pX9VLr//ppJmAV0akyoZwHWLcRirVHh8H6Y99QYtbnbFDnzsMMJ3DJrMTj5nXDlckx0Y
         xhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=8Itd33omx9B00SYSPYsGPBWJ/btkaVWnVdFJTkg82yI=;
        b=W8VlubsnNdcna5o8nykuPwEQw+XILgjM5hr0Pyla4cspceK2jxiTtb7Yt8TFYIBuMF
         HEdCEkQFM3MKHh3Jj4DpmcNzhgBGGWSLH7wZOTyjkg0EeDCM2dBk9h3BR+PY/oegLgAu
         E9VLMr5wfOcwxLKbZam9gFsza7Xw8zE6ycCPS4D6ZRJKjp3VlTng1nTUevg9xKgrAaaX
         tFiWz57/1ZC8/9Paxm+iVudellxxQ9TV3v5DwKqq5rnh3oTL2pUM8DUgxBvYl4dQAnaG
         /eG1bNOtmMAcX+qVprd52RcUtnBfZJ+JHwu5KFa+0RBn+Ph9paw7TWtWKFA3obD7/8lY
         Ij/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZoDEBB1oFZdxSDIx/Ism1TLlsnBu8FHnRV83S3l3oD/BOWZWzlujHxphO59RunTITAZ+WY8Fw==
Date: Tue, 1 May 2018 07:34:48 -0500
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, hch@lst.de, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
	bhelgaas@google.com, zajec5@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, dan.j.williams@intel.com,
	vinod.koul@intel.com, thierry.reding@gmail.com,
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
Message-ID: <20180501123448.GA23861@rob-hp-laptop>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-2-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524883919-29484-2-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1599265141132764377?=
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
>  drivers/gpu/host1x/bus.c      | 5 ++---
>  drivers/of/device.c           | 6 ++++--
>  drivers/of/of_reserved_mem.c  | 2 +-
>  drivers/pci/pci-driver.c      | 3 +--
>  include/linux/device.h        | 4 ----
>  include/linux/of_device.h     | 8 ++++++--
>  10 files changed, 17 insertions(+), 19 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
