Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3881C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714862082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6WaKX95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714862082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeJCTYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:24:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37254 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJCTYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:24:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so5496821wmt.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bilsBF32UJf49Wo7eYBNsxtSGvXWT7lDnqlmAQ3nyPY=;
        b=I6WaKX95Q0AqkPSb7/170HcKWeIaEDYhXQl0s5hzGIn+cQomhbl+DVvNaGRCp4VhGF
         kuzAgvlI5IO+pANtv9X/oCxlOYLfKMajdDNMlVhv1/D+whuYIXtgxxKq3IGL7X/jowsc
         ECeXinJXTPY0dZa09cbyMd5q4DOATjGGFNK5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bilsBF32UJf49Wo7eYBNsxtSGvXWT7lDnqlmAQ3nyPY=;
        b=ZeHWBdBkWa6zp8d/HWpIu3PhJCeigPQ6L5ay+3zrsGu/FM83CL3M/omR3pBmQQFQdt
         36IYQZ53MZp0mQLSKcwfjjpcDf81vHanDOw3JH1IGBO9ECRRYIwXzaqy+c2158+d0CC0
         qqyq7mtG+dWFwPZDtB9l2lG+eT7qWHpooiefeSnmQ8azZbykndKUIlfMUUQAqwTisHmg
         DlbPlbuW1otxNZGr+rvaCd2HPW6fpigbnu6MEucVRTHx3WTdfvAh7IKkhiiPmI+ZkmGM
         GENe6IZiWNWIrZaeH/0SLNpzWMBJOPGZ92xzlqSf8v7aw6C9P9ppPG8h7VMjCS8De4RG
         wehw==
X-Gm-Message-State: ABuFfoiU6QIDtar2ZjFqhga0LQ4G36eHpR/8LwhpjyVYgvXg4p4XlIuW
        JFjkIQHfWZUvrlHhIueAbkWx/U0ZzWU=
X-Google-Smtp-Source: ACcGV62+4/9GFKJTkVsWMP3zkp/B861FE3ro2pbxb2/6DiQwMzhUaTkvbv98UUk8VkkZfxBeEYsOww==
X-Received: by 2002:a1c:2846:: with SMTP id o67-v6mr1339731wmo.60.1538570199790;
        Wed, 03 Oct 2018 05:36:39 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id e142-v6sm4454720wmf.20.2018.10.03.05.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 05:36:38 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
References: <1538566221-21369-1-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ccce4e75-e800-1d10-2350-463d4a72d481@linaro.org>
Date:   Wed, 3 Oct 2018 15:36:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538566221-21369-1-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 10/03/2018 02:30 PM, Vikash Garodia wrote:
> Exisiting code returns the max of the decoded size and buffer size.
> It turns out that buffer size is always greater due to hardware
> alignment requirement. As a result, payload size given to client
> is incorrect. This change ensures that the bytesused is assigned
> to actual payload size, when available.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 991e158..189ec97 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -888,8 +888,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>  		unsigned int opb_sz = venus_helper_get_opb_size(inst);
>  
>  		vb = &vbuf->vb2_buf;
> -		vb->planes[0].bytesused =
> -			max_t(unsigned int, opb_sz, bytesused);
> +		vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
>  		vb->planes[0].data_offset = data_offset;
>  		vb->timestamp = timestamp_us * NSEC_PER_USEC;
>  		vbuf->sequence = inst->sequence_cap++;
> 

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
