Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBEECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF982075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+seIFOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF982075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGRPQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:16:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39911 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbeGRPQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:16:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so4931338wre.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pXv0CfQkEqOIcCPtFbyw9ZmnTtcYZsXptCyHB2MrQY4=;
        b=O+seIFOWuxlIX9KE6Qglnce3IwWjjezGJixV+9b6wLj7ZgedCtsH7lAvxas/jkTgKu
         wi1GKxLEAS608cGDUZ3yQQNlObr+lus+YpTuTPyQWjGSTLBJmD3GsOXinyiRCY5s21JG
         Rk3S9rqrty/0TGSRkW3jCblE8qazDpZcHVa6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pXv0CfQkEqOIcCPtFbyw9ZmnTtcYZsXptCyHB2MrQY4=;
        b=m5vnbYA3LTi1FJwYKVkyrEmuR8w5+qmn/0Bg0MzUEeG8bEYhhQAXqUXvMcz1HJpV0w
         ua5AhL1gxUnGb/mWqWi5tmHo+ry6SU147BfjH+J0wbBx1sfKWCdnMINLom34VmuMbk/D
         +bbm5SK6U8hm3O98JidtMfnDRdPRPDiZQocwWeTY7e2c5YOtLPyQXlZiuDiiTvZGGG2L
         jHCNb8253xAvfH7spuOMZTGxqGxEIqqxmQO5KolUbaxW3CHaJ7jQAPo6vcslxn55jcyB
         jjZu7Pt+XWzS2OHYTQGIwtcqg+cx4zMiwrnCC1IKpYk4jNaYq2niRGtqRHLVxNrPb9RX
         iF2A==
X-Gm-Message-State: AOUpUlGsoGVkU/Vesg0djjseS+GM9QtTYpfNDa0fPmC5Q9gNwd+9TbYS
        zWVNB8SJUYbaF1znjMhlSYx97l5AIns=
X-Google-Smtp-Source: AAOMgpcF3SZM4/2hnLCfIfHG44dmSlukoz4CBuyx/2iwzlN2p7iJGsXAKtU7SJRgcNxi1y4mKHS3uw==
X-Received: by 2002:adf:8806:: with SMTP id d6-v6mr4530060wrd.41.1531924679672;
        Wed, 18 Jul 2018 07:37:59 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id i4-v6sm1882840wmf.4.2018.07.18.07.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 07:37:58 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Vikash Garodia <vgarodia@codeaurora.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, acourbot@chromium.org
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
 <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org>
 <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <92f6f79a-02ae-d23e-1b97-fc41fd921c89@linaro.org>
Date:   Wed, 18 Jul 2018 17:37:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/18/2018 04:26 PM, Nicolas Dufresne wrote:
> Le mercredi 18 juillet 2018 à 14:31 +0300, Stanimir Varbanov a écrit :
>> Hi Vikash,
>>
>> On 07/02/2018 10:44 AM, Vikash Garodia wrote:
>>> Exisiting code returns the max of the decoded
>>> size and buffer size. It turns out that buffer
>>> size is always greater due to hardware alignment
>>> requirement. As a result, payload size given to
>>> client is incorrect. This change ensures that
>>> the bytesused is assigned to actual payload size.
>>>
>>> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
>>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>>> ---
>>>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c
>>> b/drivers/media/platform/qcom/venus/vdec.c
>>> index d079aeb..ada1d2f 100644
>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst
>>> *inst, unsigned int buf_type,
>>>  
>>>  		vb = &vbuf->vb2_buf;
>>>  		vb->planes[0].bytesused =
>>> -			max_t(unsigned int, opb_sz, bytesused);
>>> +			min_t(unsigned int, opb_sz, bytesused);
>>
>> Most probably my intension was to avoid bytesused == 0, but that is
>> allowed from v4l2 driver -> userspace direction
> 
> It remains bad practice since it was used by decoders to indicate the
> last buffer. Some userspace (some GStreamer versions) will stop working
> if you start returning 0.

I think it is legal v4l2 driver to return bytesused = 0 when userspace
issues streamoff on both queues before EOS, no? Simply because the
capture buffers are empty.

-- 
regards,
Stan
