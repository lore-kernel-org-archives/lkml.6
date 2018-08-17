Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE29C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7ED218DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hUfxehP7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L5Yxf7lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7ED218DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeHQMJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:09:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49556 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:09:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D576B627D8; Fri, 17 Aug 2018 09:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534496785;
        bh=eHCwWFH3AOFmKSG55rmqDfrcJ5R+noWmjWYZXP4oF80=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hUfxehP7p1Yz9SDO8tlAmU69ssKX2FGMM3DKwi1BzNOlNgChOj0zifgFV6WxxpCTi
         C5rHBh3v1ioy3FkVnZZLgJBDExa7167l4jD/x3evD9FSPjsnhu1oFjs6z/7PdOZ3XM
         in+mCrXRwniJ04xblFoPgk0N+ZN2aa1oG2l9PxsE=
Received: from [192.168.1.101] (unknown [157.49.113.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4D36627D8;
        Fri, 17 Aug 2018 09:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534496784;
        bh=eHCwWFH3AOFmKSG55rmqDfrcJ5R+noWmjWYZXP4oF80=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L5Yxf7lLLunF1jlHru4q9fXUqQjjS9s8vYihctqom9ByX7t+AeHYXADDXcF+8afTz
         s285kV8WFLOUzDAad486bvwJ2lCeS/WXZK21wMovF/8NzlEOQ46szjYIgg3xAKYwap
         SJdI1KXGTcSKyp7i9ahIHWmBxp12gzGa3Pm0sGu8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4D36627D8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] drm/msm/disp/dpu: Use proper define for
 drm_encoder_init() 'encoder_type'
To:     Stephen Boyd <swboyd@chromium.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
References: <20180816233616.148248-1-swboyd@chromium.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <f4a9238f-8806-d82a-f260-b7c13d0bc4e5@codeaurora.org>
Date:   Fri, 17 Aug 2018 14:36:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816233616.148248-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/2018 5:06 AM, Stephen Boyd wrote:
> We got a bug report that this function oopses when trying to do a kasprintf().
> 
> PC is at string+0x2c/0x60
> LR is at vsnprintf+0x28c/0x4ec
> pc : [<ffffff80088d35d8>] lr : [<ffffff80088d5fc4>] pstate: a0c00049
> sp : ffffff80095fb540
> x29: ffffff80095fb540 x28: ffffff8008ad42bc
> x27: 00000000ffffffd8 x26: 0000000000000000
> x25: ffffff8008c216c8 x24: 0000000000000000
> x23: 0000000000000000 x22: ffffff80095fb720
> x21: 0000000000000000 x20: ffffff80095fb720
> x19: ffffff80095fb6f0 x18: 000000000000000a
> x17: 00000000b42ba473 x16: ffffff800805bbe8
> x15: 00000000000a157d x14: 000000000000000c
> x13: 0000000000000000 x12: 0000ffff0000000f
> x11: 0000000000000003 x10: 0000000000000001
> x9 : 0000000000000040 x8 : 000000000000001c
> x7 : ffffffffffffffff x6 : 0000000000000000
> x5 : 0000000000000228 x4 : 0000000000000000
> x3 : ffff0a00ffffff04 x2 : 0000000000007961
> x1 : 0000000000000000 x0 : 0000000000000000
> Process kworker/3:1 (pid: 61, stack limit = 0xffffff80095f8000)
> Call trace:
> Exception stack(0xffffff80095fb400 to 0xffffff80095fb540)
> b400: 0000000000000000 0000000000000000 0000000000007961 ffff0a00ffffff04
> b420: 0000000000000000 0000000000000228 0000000000000000 ffffffffffffffff
> b440: 000000000000001c 0000000000000040 0000000000000001 0000000000000003
> b460: 0000ffff0000000f 0000000000000000 000000000000000c 00000000000a157d
> b480: ffffff800805bbe8 00000000b42ba473 000000000000000a ffffff80095fb6f0
> b4a0: ffffff80095fb720 0000000000000000 ffffff80095fb720 0000000000000000
> b4c0: 0000000000000000 ffffff8008c216c8 0000000000000000 00000000ffffffd8
> b4e0: ffffff8008ad42bc ffffff80095fb540 ffffff80088d5fc4 ffffff80095fb540
> b500: ffffff80088d35d8 00000000a0c00049 ffffff80095fb550 ffffff80080d06a4
> b520: ffffffffffffffff ffffff80088d5e0c ffffff80095fb540 ffffff80088d35d8
> [<ffffff80088d35d8>] string+0x2c/0x60
> [<ffffff80088d5fc4>] vsnprintf+0x28c/0x4ec
> [<ffffff80083973b8>] kvasprintf+0x68/0x100
> [<ffffff800839755c>] kasprintf+0x60/0x80
> [<ffffff800849cc24>] drm_encoder_init+0x134/0x164
> [<ffffff80084d9a7c>] dpu_encoder_init+0x60/0x94
> [<ffffff80084eced0>] _dpu_kms_drm_obj_init+0xa0/0x424
> [<ffffff80084ed870>] dpu_kms_hw_init+0x61c/0x6bc
> [<ffffff80084f7614>] msm_drm_bind+0x380/0x67c
> [<ffffff80085114e4>] try_to_bring_up_master+0x228/0x264
> [<ffffff80085116e8>] component_master_add_with_match+0x90/0xc0
> [<ffffff80084f722c>] msm_pdev_probe+0x260/0x2c8
> [<ffffff800851a910>] platform_drv_probe+0x58/0xa8
> [<ffffff80085185c8>] driver_probe_device+0x2d8/0x40c
> [<ffffff8008518928>] __device_attach_driver+0xd4/0x10c
> [<ffffff800851644c>] bus_for_each_drv+0xb4/0xd0
> [<ffffff8008518230>] __device_attach+0xd0/0x160
> [<ffffff8008518984>] device_initial_probe+0x24/0x30
> [<ffffff800851744c>] bus_probe_device+0x38/0x98
> [<ffffff8008517aac>] deferred_probe_work_func+0x144/0x148
> [<ffffff80080c8654>] process_one_work+0x218/0x3bc
> [<ffffff80080c883c>] process_scheduled_works+0x44/0x48
> [<ffffff80080c95bc>] worker_thread+0x288/0x32c
> [<ffffff80080cea30>] kthread+0x134/0x13c
> [<ffffff8008084750>] ret_from_fork+0x10/0x18
> Code: 910003fd 2a0403e6 eb0400ff 54000060 (38646845)
> 
> Looking at the code I see that drm_encoder_init() is called from the DPU
> code with 'DRM_MODE_CONNECTOR_DSI' passed in as the 'encoder_type'
> argument (follow from _dpu_kms_initialize_dsi()). That corresponds to
> the integer 16. That is then indexed into drm_encoder_enum_list in
> drm_encoder_init() to look up the name of the encoder. If you're still
> following along, that's an encoder not a connector! We really want to
> use DRM_MODE_ENCODER_DSI (integer 6) instead of DRM_MODE_CONNECTOR_DSI
> here, or we'll go out of bounds of the encoder array. Pass the right
> thing and everything is fine.
> 
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 7dd6bd2d6d37..74cc204b07e8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -450,7 +450,7 @@ static void _dpu_kms_initialize_dsi(struct drm_device *dev,
>   	int i, rc;
>   
>   	/*TODO: Support two independent DSI connectors */
> -	encoder = dpu_encoder_init(dev, DRM_MODE_CONNECTOR_DSI);
> +	encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DSI);
>   	if (IS_ERR_OR_NULL(encoder)) {
>   		DPU_ERROR("encoder init failed for dsi display\n");
>   		return;
> 

I have tested this on sdm845 mtp and it does fix the issue.
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
