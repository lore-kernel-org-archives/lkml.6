Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523305666; cv=none;
        d=google.com; s=arc-20160816;
        b=Wn7/8phFh4ODMjFq3T9FJHqTii3I/DPSME7ZEKlO54rfNIEtRdUsdKWOIRQViuGoRO
         HxYne/OUEMuyHn1umKWdpUduTzEkY0UFXCsxO6C6aW5U/lz4/lBdDykRgzJoZ8rF72un
         f7bVDWX0qD+ufjidinFvaduscsyGm6DfFacj8g39GsIzBIAVy0vMW5Yi9EIT9ckyrMIL
         6oX8e00tuxaEBn6ZnrkPMusA7P0JOU25VAMPZeRexrWWBAujSat+hqtCfE56GlK9FbCw
         WdzWiZzf5X+pyXMjUMdlmk9B16Hy1148yunjb9/WDR6Jhh+fNvGAMLbvMRNR2pQkXnvO
         P0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uDzs1tY1dgWX70nALpMmM5SV42XsMaLZ3hgDkdc+h0A=;
        b=VwosEodcxtaFnCCFvrJHbM1kKzxb9pysQIbR7AsPPiAn99yvOZMNYJY+jJGn6NVwSU
         GcJbjPNJfhy9yCcV57qZfaWWWOhpWmPLnWMA7FXrgLArJmd9IYRCWaHcYSvanPVTnfLo
         FjHT4FYtFzmqoWcFrmc5d8fEHjUWjBtT+CUyfy91sNcaMj6yiXcgssPz1k0pPQDdFWYS
         +3L10AyD0sIPmeYCm5mC7KDVF8W9oAmCY/Dcx8Ny4DHsE0Ik+rxPyRJXbdrdYDfOTSQ3
         NJ0kP3sIZpVcQG7Q51c+BUVLlDmQ75I4Ph+BD+PQ+fj/tCV8jMMODBeFbNLgOeUGFGQK
         qFEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+j8tkqIOxA31sdaIhyTbbq3NzdTj6lMhILg1aizky1yK5VG/ucgjdrUIvxYym3kA4W35D6UA==
Date: Mon, 9 Apr 2018 15:27:45 -0500
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
Subject: Re: [PATCH v3 2/2] drivers: remove force dma flag from buses
Message-ID: <20180409202745.p6hxkyy4n7fin3bd@rob-hp-laptop>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1522396485-10248-1-git-send-email-nipun.gupta@nxp.com>
 <1522396485-10248-2-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522396485-10248-2-git-send-email-nipun.gupta@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1597301762868192534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 01:24:45PM +0530, Nipun Gupta wrote:
> With each bus implementing its own DMA configuration callback,
> there is no need for bus to explicitly have force_dma in its
> global structure. This patch modifies of_dma_configure API to
> accept an input parameter which specifies if implicit DMA
> configuration is required even when it is not described by the
> firmware.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
> Changes in v2:
>   - This is a new change suggested by Robin and Christoph
>     and is added to the series.
> 
> Changes in v3:
>   - Rebase and changes corresponding to the changes in patch 1/2
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
