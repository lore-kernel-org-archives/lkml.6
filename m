Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DD7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2432243B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8vZEJDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2432243B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeKLVoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:44:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39356 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbeKLVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:44:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id b13so8972535wrx.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 03:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rHtabUXDENQZmvVaPd87M9fjQtwGmPBo8F2MdS91W+4=;
        b=L8vZEJDVb4trY3MFB7wM/9cfXYtpHSog9oWSSKHQ+yJeyUq0k2JE9hzzHk7FSrtguM
         CrHZlw7Rm06B94fmZd9VORY9epyw+0VFu829v2KAaOQogyak606W6Pljp9Jp1T7knwPL
         YWIy/WEFaUYKoKwhz1rSfj3ro9dMfMt4Zuxz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rHtabUXDENQZmvVaPd87M9fjQtwGmPBo8F2MdS91W+4=;
        b=ZXypwcGvkiqTN32XduRyEoYFY8cz4QuDIxfPtmVfL/ZIkRZjqHtwBpen8fmTVIjaFf
         V6xu91S4j51txnRCthmfvVPb6w98xBM5pfP1b/RvU3/ahn/L0URo/acK0tf3lCpKl1Wj
         Wkz0G0rJOzxqGIGPhLrrSt4SQLkNpd8TBfz9YhsPdp7YPhw37zhw0YG6jT9ThI0kq6KH
         447IuDkudCXUnmqClmtn/iMzKpGW80wr/RWgNmO65EZ6dP+b2KhWiOQUf9jQTpvU+1rk
         v6EzIrlFYd2LATTrQl4uBVbbMAQW4SZGHffG9hoiKbKXXJdpeHb5xV/qpPro/SucVgbe
         QpHQ==
X-Gm-Message-State: AGRZ1gLiamDyIFAz8QbfT3PzQy+xtKT1F11WBs+EjirOENM/XT1AwEod
        YH8eYvVKAZ3kzLhvg+E1eFulKw==
X-Google-Smtp-Source: AJdET5fWOnf3RQMCFhjFDiHPeWeVPUbjDlbUTZX7Gk634h8aoT38lG40AluZ5HdxwdnqJyHnXVLlmw==
X-Received: by 2002:adf:9403:: with SMTP id 3-v6mr695678wrq.54.1542023475422;
        Mon, 12 Nov 2018 03:51:15 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id x16-v6sm11230600wro.28.2018.11.12.03.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 03:51:14 -0800 (PST)
Subject: Re: [PATCH] media: venus: change the default value of GOP size
To:     Malathi Gottam <mgottam@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1542013562-18968-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <fe5d4fc2-94bb-2224-fea2-91490e28aed0@linaro.org>
Date:   Mon, 12 Nov 2018 13:51:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542013562-18968-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

Thanks for the patch!

On 11/12/18 11:06 AM, Malathi Gottam wrote:
> When the client doesn't explicitly set any GOP size, current
> default value is low and overshoots bitrate beyond  tolerance.
> Hence default value is modified so as to have intra period of 1sec.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Sounds reasonable :

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 45910172..e6a43e9 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -295,7 +295,7 @@ int venc_ctrl_init(struct venus_inst *inst)
>  		0, INTRA_REFRESH_MBS_MAX, 1, 0);
>  
>  	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> -		V4L2_CID_MPEG_VIDEO_GOP_SIZE, 0, (1 << 16) - 1, 1, 12);
> +		V4L2_CID_MPEG_VIDEO_GOP_SIZE, 0, (1 << 16) - 1, 1, 30);
>  
>  	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>  		V4L2_CID_MPEG_VIDEO_VPX_MIN_QP, 1, 128, 1, 1);
> 

-- 
regards,
Stan
