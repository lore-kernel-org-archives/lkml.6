Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AD7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4209B22443
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWidSFSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4209B22443
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeKLWVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:21:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54222 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbeKLWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:21:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id f10-v6so8288790wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 04:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JQXN4uT/zOm4FKa7x9tk0m7XnRHRwKm5gqDaXQ67OcY=;
        b=ZWidSFSfZyIPG0Ywf8hJdO/QbGaGovSWwZIc68Lmr98flxopyrFHsWq9NwA52F1UwC
         nuNRpjDw+0yRmB42RV6ZuEEUQgkED6X3LMchUjogpb5lE8xioqk5NC/krx18m4ztIGQi
         5Q/BFoyFt2dgoGrnQGiM2TVhB0tdZzSNCpcD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JQXN4uT/zOm4FKa7x9tk0m7XnRHRwKm5gqDaXQ67OcY=;
        b=jWf2nZgcPfVSyxD87ejhMOU5jYVcnrLl5/XqC/R9COPcRfpFZUyO/vIcA1NAgFgxwg
         +QlmZdxr8L/0fN9jbPVsfv/cIN8hEKJaT4boi2CioIfIl5P8Yx2TxA/xo4B2Hs2ok0bL
         VQMRGqgh9Y3z+I1wO4FGacLaIKT1EVNhWyrHn84OmBkFZmxAf1VgIi3rQuQuWmWCq93t
         zmtKpJeBn5McNxvQ0knJirw6aGQo7PeCb0sIgsiFm3XWefI2DqlyQx8I91XYixoV6ZF/
         40ofyieWk4yWw81C2W8STUJRznXkoD8G0tVeaRtCR2uYztXI+vmZbsFCKyfK/fI1FVdO
         TG1g==
X-Gm-Message-State: AGRZ1gKKu3d/ZZD0xbpSDyIxEs3jRj8bEAAV+FiXlCBM+14miHiDTxYg
        7uMutFk6sEQSDwRMpV475X5cH8daZ/U=
X-Google-Smtp-Source: AJdET5eW5rgY26vUjmTs0Qxt18gXtyMfLx5r2wY1QbUICDcZ7XJ91TKbR05yQNHUIDWvW3Ow1dc+JQ==
X-Received: by 2002:a1c:8604:: with SMTP id i4-v6mr7839777wmd.23.1542025704916;
        Mon, 12 Nov 2018 04:28:24 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 197-v6sm9757129wmh.44.2018.11.12.04.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 04:28:24 -0800 (PST)
Subject: Re: [PATCH] media: venus: amend buffer size for bitstream plane
To:     Malathi Gottam <mgottam@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <48f90d4d-8ae3-65ae-2096-eebf047c1c0c@linaro.org>
Date:   Mon, 12 Nov 2018 14:28:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

Thanks for the patch!

On 10/9/18 10:52 AM, Malathi Gottam wrote:
> For lower resolutions, incase of encoder, the compressed
> frame size is more than half of the corresponding input
> YUV. Keep the size as same as YUV considering worst case.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 2679adb..05c5423 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
>  	}
>  
>  	if (compressed) {
> -		sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
> +		sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;

Could you drop this division by 2 only for lower resolutions and also
only for the encoder session? I do not want to waste memory if it is not
absolutely needed.

-- 
regards,
Stan
