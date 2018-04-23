Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeDWJ6N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:58:13 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:36121 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754130AbeDWJ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:58:10 -0400
Subject: Re: [PATCH v1] gpu: host1x: Fix dma_free_wc() argument in the error
 path
To: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20180423095456.16697-1-digetx@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <9bfd3550-b712-f838-cb96-5ca1255825d4@kapsi.fi>
Date: Mon, 23 Apr 2018 12:58:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180423095456.16697-1-digetx@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.209.167.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 23.04.2018 12:54, Dmitry Osipenko wrote:
> If IOVA allocation or IOMMU mapping fails, dma_free_wc() is invoked with
> size=0 because of a typo, that triggers "kernel BUG at mm/vmalloc.c:124!".
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/cdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index 93df28228721..0724122afeac 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c
> @@ -127,7 +127,7 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
>  iommu_free_iova:
>  	__free_iova(&host1x->iova, alloc);
>  iommu_free_mem:
> -	dma_free_wc(host1x->dev, pb->alloc_size, pb->mapped, pb->phys);
> +	dma_free_wc(host1x->dev, size, pb->mapped, pb->phys);
>
>  	return err;
>  }
>
