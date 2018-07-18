Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1562075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgidKwAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1562075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeGRMIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:08:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37702 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeGRMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:08:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id a19-v6so2498402wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MX5g16XKofHSlXrsXIl3prxm5Y6ASxP2sUInxHB4+Eg=;
        b=KgidKwAyEnkcwRyVRdhwR8QDn3Xqysu3q6+wxtkoZWNAEpLyfN8iP6GqtSfciZUeQw
         HznG9e3VdROOaUY74UWJHP38g+lTg/Vzk3ARFLbmTfrxRfNsaugvHXZR70eKb/UiMUdq
         7dBlhadvLBZsl8CXhvAcplENigcaxWg9xYbL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MX5g16XKofHSlXrsXIl3prxm5Y6ASxP2sUInxHB4+Eg=;
        b=a7cKsxulK38+dDi1AS+XdWrPd1BHzXWX0wZK2WVVvrvIXOcjUjDQHrG9bQTyzbKMuW
         Oo5sytlPeUHermiBGHu+tLKGX7x10RgJd76a6R2dWVxb6UAUqQaYi3DxyhPBX2GK6N0R
         UYVjE9t+xEYcxH1o2unP81Na/wiJ5Cw+ktGcJvQNCQSgs6OJ4jbsO8/sST22FjD9uVtB
         0bGQl1qYRVcoDFUWJQERwJCpQzs24WwXUEX8Esh8SmT1ybyd2lP02G8RL2hlXZt1RUNR
         k10lTrsp9XEh5Ttt74+AjtnAmyiZKKfrlu2vEdA2YhiiZo1U7Wc1uNYgSEdBSYN9FLhW
         ntyg==
X-Gm-Message-State: AOUpUlEd4mt+M/unFp0jUzmQ/jrDTcRs1He+VR5feE5qtaXm/AoAubBD
        T1CIeH2+b0cQUIR+py1pfvL9DQ==
X-Google-Smtp-Source: AAOMgpcIbvUjatrd9cV8YwQUaFwEMDcYdRxys6phPgyHLeH+AbN6y7aCQrNEPQGohUoxF1IZozGuJA==
X-Received: by 2002:a1c:2352:: with SMTP id j79-v6mr1385009wmj.124.1531913472254;
        Wed, 18 Jul 2018 04:31:12 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id w9-v6sm4703225wrr.77.2018.07.18.04.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 04:31:11 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Vikash Garodia <vgarodia@codeaurora.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, acourbot@chromium.org
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org>
Date:   Wed, 18 Jul 2018 14:31:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 07/02/2018 10:44 AM, Vikash Garodia wrote:
> Exisiting code returns the max of the decoded
> size and buffer size. It turns out that buffer
> size is always greater due to hardware alignment
> requirement. As a result, payload size given to
> client is incorrect. This change ensures that
> the bytesused is assigned to actual payload size.
> 
> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index d079aeb..ada1d2f 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>  
>  		vb = &vbuf->vb2_buf;
>  		vb->planes[0].bytesused =
> -			max_t(unsigned int, opb_sz, bytesused);
> +			min_t(unsigned int, opb_sz, bytesused);

Most probably my intension was to avoid bytesused == 0, but that is
allowed from v4l2 driver -> userspace direction

Could you drop min/max_t macros at all and use bytesused directly i.e.

vb2_set_plane_payload(vb, 0, bytesused)

-- 
regards,
Stan
