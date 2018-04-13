Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754055AbeDMIzC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:55:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753136AbeDMIzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:55:00 -0400
Subject: Re: [PATCH v2] vfio: platform: Make printed error messages more
 consistent
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1523372051-23716-1-git-send-email-geert+renesas@glider.be>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e1468eeb-83a9-8537-5d72-f56c19b85858@redhat.com>
Date: Fri, 13 Apr 2018 10:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1523372051-23716-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,On 10/04/18 16:54, Geert Uytterhoeven wrote:
>   - Capitalize the first word of error messages,
>   - Unwrap statements that fit on a single line,
>   - Use "VFIO" instead of "vfio" as the error message prefix.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> v2:
>   - Add Reviewed-by.
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 4c27f4be3c3d0385..35469af87f88678e 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -630,8 +630,7 @@ static int vfio_platform_of_probe(struct vfio_platform_device *vdev,
>  	ret = device_property_read_string(dev, "compatible",
>  					  &vdev->compat);
>  	if (ret)
> -		pr_err("VFIO: cannot retrieve compat for %s\n",
> -			vdev->name);
> +		pr_err("VFIO: Cannot retrieve compat for %s\n", vdev->name);
>  
>  	return ret;
>  }
> @@ -673,7 +672,7 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  
>  	ret = vfio_platform_get_reset(vdev);
>  	if (ret && vdev->reset_required) {
> -		pr_err("vfio: no reset function found for device %s\n",
> +		pr_err("VFIO: No reset function found for device %s\n",
>  		       vdev->name);
>  		return ret;
>  	}
> 
