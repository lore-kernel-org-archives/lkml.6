Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3018D21531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bulgCsjQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bulgCsjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3018D21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeHBS2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:28:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeHBS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:28:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ECE3260397; Thu,  2 Aug 2018 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533227782;
        bh=ZSG0bzVfXn36wM5n5//TxVGTJTbOZZyHMsbacWWis+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bulgCsjQ0yITRbsrWhdq3u166ajXmVAYLZh7U+h8oh5UxPRLQjxNL6IAHpFU2580Z
         K2m/lH+TWGs26b95rmpe5tlhx8ETspdLo/vg9/FIryQ1sIds1Coi5e3IwiKQQ9lQB0
         G12SaMBqnFjWrmsbHXQ/w53O7djKGAjymGro3GYI=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7971F60397;
        Thu,  2 Aug 2018 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533227782;
        bh=ZSG0bzVfXn36wM5n5//TxVGTJTbOZZyHMsbacWWis+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bulgCsjQ0yITRbsrWhdq3u166ajXmVAYLZh7U+h8oh5UxPRLQjxNL6IAHpFU2580Z
         K2m/lH+TWGs26b95rmpe5tlhx8ETspdLo/vg9/FIryQ1sIds1Coi5e3IwiKQQ9lQB0
         G12SaMBqnFjWrmsbHXQ/w53O7djKGAjymGro3GYI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7971F60397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Thu, 2 Aug 2018 10:36:18 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     robdclark@gmail.com, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/gpu: fix parameters in function
 msm_gpu_crashstate_capture
Message-ID: <20180802163618.GC21283@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Anders Roxell <anders.roxell@linaro.org>,
        robdclark@gmail.com, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180731204532.4808-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180731204532.4808-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:45:32PM +0200, Anders Roxell wrote:
> When CONFIG_DEV_COREDUMP isn't defined msm_gpu_crashstate_capture
> doesn't pass the correct parameters.
> drivers/gpu/drm/msm/msm_gpu.c: In function ‘recover_worker’:
> drivers/gpu/drm/msm/msm_gpu.c:479:34: error: passing argument 2 of ‘msm_gpu_crashstate_capture’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
>                                   ^~~~~~
> drivers/gpu/drm/msm/msm_gpu.c:388:13: note: expected ‘char *’ but argument is of type ‘struct msm_gem_submit *’
>  static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/msm/msm_gpu.c:479:2: error: too many arguments to function ‘msm_gpu_crashstate_capture’
>   msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/msm/msm_gpu.c:388:13: note: declared here
>  static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
> 
> In current code the function msm_gpu_crashstate_capture parameters.
> 
> Fixes: cdb95931dea3 ("drm/msm/gpu: Add the buffer objects from the submit to the crash dump")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for doing this.

Reviewed-By: Jordan Crouse <jcrouse@codeaurora.org>

> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index f388944c93e2..713a92b516ba 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -385,8 +385,8 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
>  		msm_gpu_devcoredump_read, msm_gpu_devcoredump_free);
>  }
>  #else
> -static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
> -		char *cmd)
> +static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
> +		struct msm_gem_submit *submit, char *comm, char *cmd)
>  {
>  }
>  #endif

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
