Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5476BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C64220657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Su9YOYYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C64220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeKAVXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:23:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35307 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbeKAVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:23:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id q12-v6so1182344wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lji5OxB3m1oEwXs/Y9yrmQyvxmjSrhthjs27reVFMYs=;
        b=Su9YOYYSabZqLbDqhU9l9fgDJ2BbZ89Q5ZAODX1zKICYZCAxz19rIjmxnlHIYZ+zl8
         D1dRpG8GUhjP5bbeXxUUBYgikWewFZB5v49cJW4qx8J3YEMK2LNQkqcSY60tTJjIc6MT
         tEcHTlBogFypzrmpncogQOWFqf9jBF7xwhtHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lji5OxB3m1oEwXs/Y9yrmQyvxmjSrhthjs27reVFMYs=;
        b=gtOQtrUo33Pc7Wk8k8BL+ElX9t0GP/f0qRFcHNzdPuoxnX9KXSFGKXK9DVepH2BFwg
         4q31P05xemEaaTBT6pXA5xHIASlqgdPhfK1spoMsZVNGpbey2h5uuwheo1rz1YLVvC46
         7nbA5R9mz7+Dzq+5Owf0DphXiVQcNkKZyxu771smCULu6yox622xGrrZlApDqChIG3GM
         dz1dQR4sL7pKChE9nm4N/CYcgHz/vq4JRXlYb4ySnPIuvs+H1z+JFO+y91uHx/F2UPOK
         mVZYOttSeIAu7h3aw78rsF08JVL8Hspq+Crr/hz/aUQaIPLHJCqbA8HVo782rRJFALzz
         QvIw==
X-Gm-Message-State: AGRZ1gJp23CFxjvyzr8zdKAIm+Fj4JbclkbUVDuX5OZNrQqKRYF8tDtA
        bhlLbghNQzQ9tbmWI2KlCziAiQ==
X-Google-Smtp-Source: AJdET5fJy3KyTe+735gs2t8NcelCDniF6B1bHBzbyncqzuQzIlzzl4gbq4y9qsf9wwYV7Smp9lUaOA==
X-Received: by 2002:a1c:5d01:: with SMTP id r1-v6mr5098220wmb.25.1541074865380;
        Thu, 01 Nov 2018 05:21:05 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id o15-v6sm5105214wrw.47.2018.11.01.05.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:21:04 -0700 (PDT)
Subject: Re: [PATCH v2] media: venus: handle peak bitrate set property
To:     Malathi Gottam <mgottam@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1540209912-24834-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <5e7de7d5-cd5b-7a88-6015-df28d45b122e@linaro.org>
Date:   Thu, 1 Nov 2018 14:21:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540209912-24834-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Malathi, thanks for the patch!

On 10/22/18 3:05 PM, Malathi Gottam wrote:
> Max bitrate property is not supported for venus version 4xx.
> Return unsupported from packetization layer. Handle it in 
> hfi_venus layer to exit gracefully to venc layer.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c  | 2 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index e8389d8..87a4414 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -1215,7 +1215,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
>  	}
>  	case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
>  		/* not implemented on Venus 4xx */
> -		break;
> +		return -ENOTSUPP;
>  	default:
>  		return pkt_session_set_property_3xx(pkt, cookie, ptype, pdata);
>  	}
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 1240855..9d086b9 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1355,6 +1355,8 @@ static int venus_session_set_property(struct venus_inst *inst, u32 ptype,
>  	pkt = (struct hfi_session_set_property_pkt *)packet;
>  
>  	ret = pkt_session_set_property(pkt, inst, ptype, pdata);
> +	if (ret == -ENOTSUPP)
> +		return 0;
>  	if (ret)
>  		return ret;
>  

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
