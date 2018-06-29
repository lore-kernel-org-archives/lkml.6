Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC6FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D27528036
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="okJ6+OpN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="okJ6+OpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D27528036
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936676AbeF2VUx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:20:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933987AbeF2VUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:20:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D658260AFF; Fri, 29 Jun 2018 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530307250;
        bh=6v7KonVOkD4GAIjp4WiYiyhL9f8yIcu7Aw9UGbPtLSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okJ6+OpNEIMPRnJz3OllyqL4FI2uZCfeFXHKur7wF018jdzEAhpUfuKYHdIXrovKP
         kRiUoUHm1jWO3/jeaiAaUUfS40sRuuB3UPmV+iEwPbw70mHDIVXzIj6H5Qq9nWMAhO
         Kk4M6NZBPlCXoo0k8Ec09GTUoRHYZKuig47sGQpE=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3B3F606FC;
        Fri, 29 Jun 2018 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530307250;
        bh=6v7KonVOkD4GAIjp4WiYiyhL9f8yIcu7Aw9UGbPtLSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okJ6+OpNEIMPRnJz3OllyqL4FI2uZCfeFXHKur7wF018jdzEAhpUfuKYHdIXrovKP
         kRiUoUHm1jWO3/jeaiAaUUfS40sRuuB3UPmV+iEwPbw70mHDIVXzIj6H5Qq9nWMAhO
         Kk4M6NZBPlCXoo0k8Ec09GTUoRHYZKuig47sGQpE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3B3F606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 29 Jun 2018 15:20:47 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: Remove VLA usage
Message-ID: <20180629212047.GH24526@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180629184818.GA37439@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629184818.GA37439@beast>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:48:18AM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a kasprintf()ed buffer. Return paths are updated
> to free the allocation.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Thanks for doing this.

Acked-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  7 +++++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 28 +++++++++++++++++--------
>  2 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index d39400e5bc42..f5f76f8151f9 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -11,6 +11,7 @@
>   *
>   */
>  
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
>  #include <linux/qcom_scm.h>
> @@ -19,6 +20,7 @@
>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <linux/pm_opp.h>
>  #include <linux/nvmem-consumer.h>
> +#include <linux/slab.h>
>  #include "msm_gem.h"
>  #include "msm_mmu.h"
>  #include "a5xx_gpu.h"
> @@ -91,12 +93,13 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname)
>  		ret = qcom_mdt_load(dev, fw, fwname, GPU_PAS_ID,
>  				mem_region, mem_phys, mem_size, NULL);
>  	} else {
> -		char newname[strlen("qcom/") + strlen(fwname) + 1];
> +		char *newname;
>  
> -		sprintf(newname, "qcom/%s", fwname);
> +		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
>  
>  		ret = qcom_mdt_load(dev, fw, newname, GPU_PAS_ID,
>  				mem_region, mem_phys, mem_size, NULL);
> +		kfree(newname);
>  	}
>  	if (ret)
>  		goto out;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index bcbf9f2a29f9..bfaafdfc7eb2 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -17,7 +17,9 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/kernel.h>
>  #include <linux/pm_opp.h>
> +#include <linux/slab.h>
>  #include "adreno_gpu.h"
>  #include "msm_gem.h"
>  #include "msm_mmu.h"
> @@ -70,10 +72,12 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
>  {
>  	struct drm_device *drm = adreno_gpu->base.dev;
>  	const struct firmware *fw = NULL;
> -	char newname[strlen("qcom/") + strlen(fwname) + 1];
> +	char *newname;
>  	int ret;
>  
> -	sprintf(newname, "qcom/%s", fwname);
> +	newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
> +	if (!newname)
> +		return ERR_PTR(-ENOMEM);
>  
>  	/*
>  	 * Try first to load from qcom/$fwfile using a direct load (to avoid
> @@ -87,11 +91,12 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
>  			dev_info(drm->dev, "loaded %s from new location\n",
>  				newname);
>  			adreno_gpu->fwloc = FW_LOCATION_NEW;
> -			return fw;
> +			goto out;
>  		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
>  			dev_err(drm->dev, "failed to load %s: %d\n",
>  				newname, ret);
> -			return ERR_PTR(ret);
> +			fw = ERR_PTR(ret);
> +			goto out;
>  		}
>  	}
>  
> @@ -106,11 +111,12 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
>  			dev_info(drm->dev, "loaded %s from legacy location\n",
>  				newname);
>  			adreno_gpu->fwloc = FW_LOCATION_LEGACY;
> -			return fw;
> +			goto out;
>  		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
>  			dev_err(drm->dev, "failed to load %s: %d\n",
>  				fwname, ret);
> -			return ERR_PTR(ret);
> +			fw = ERR_PTR(ret);
> +			goto out;
>  		}
>  	}
>  
> @@ -126,16 +132,20 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
>  			dev_info(drm->dev, "loaded %s with helper\n",
>  				newname);
>  			adreno_gpu->fwloc = FW_LOCATION_HELPER;
> -			return fw;
> +			goto out;
>  		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
>  			dev_err(drm->dev, "failed to load %s: %d\n",
>  				newname, ret);
> -			return ERR_PTR(ret);
> +			fw = ERR_PTR(ret);
> +			goto out;
>  		}
>  	}
>  
>  	dev_err(drm->dev, "failed to load %s\n", fwname);
> -	return ERR_PTR(-ENOENT);
> +	fw = ERR_PTR(-ENOENT);
> +out:
> +	kfree(newname);
> +	return fw;
>  }
>  
>  static int adreno_load_fw(struct adreno_gpu *adreno_gpu)
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
