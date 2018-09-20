Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D42ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F8821525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcnH8Clu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F8821525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeITLgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:36:47 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51929 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731590AbeITLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:36:46 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so11638085itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 22:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/Apr84348/4hxOpdwFa3uPuvP2K8c4IC3kijsnoxMg=;
        b=HcnH8CluaSh9X5I6pTuB0HEo7rV9Z/omc6djryDpXHf59HJhy0clICsNGfFcZ3sri9
         OZsBO/9yoTDs1PTQSJ+G/dIYcRFa7gR/BA+ypbbBTkiUsQafX5/jrUKBFvRuv56WNTLS
         JtDqqUskuXoYhCikKgMLbJY9rNKp3DgRqE9OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/Apr84348/4hxOpdwFa3uPuvP2K8c4IC3kijsnoxMg=;
        b=saOfBBC2SCF0cG7tLoFe+a3mjqMAQCCi3uNGTk0Z43Iv/jtW071hnqPgfT++McDl0/
         UqjTc2bct0tAke257MZLY3nQHsOxK0n6o1Sir1eFdvXNP/oMgBGE46LZR/hh1nILGnHF
         GbltJwffqNIqc98NRXRjw507WdoG8G4YOu69MBKdRQ/pTdnLQOxpWY94oj3jI4Zdq3fp
         sl6jcdnvY68cyZUBdwPw0Hbz8Vur9OA8ZsAglP19HkvYnNrw0jeB0WBtoWuhHaLtC64p
         CagSZBdexo3AUeG3h9v5GI3FmVOZnHKPtZALNMN7o2TapXU4H8hxXfF1flcrAgFXqZn0
         f9cA==
X-Gm-Message-State: APzg51CXxTpUv7VLXHnNHJe4Cucze6VLXfOQmbNEEJUYhhvJZJTrvZZi
        Wq/l5yaVEIQmmcwaMpqr4id9JgNbT9c=
X-Google-Smtp-Source: ANB0VdaxOgRhzHe1t9UwGczIRqu4vj0Tyw8cj81sHQZGeZOUnQH04hDfCMQCkNtB8auI+GMTep/R8Q==
X-Received: by 2002:a24:1ad1:: with SMTP id 200-v6mr919662iti.4.1537422905359;
        Wed, 19 Sep 2018 22:55:05 -0700 (PDT)
Received: from [10.199.97.96] ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id f74-v6sm492479itf.20.2018.09.19.22.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 22:55:04 -0700 (PDT)
Subject: Re: [PATCH] media: qcom: remove duplicated include file
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537419595-29990-1-git-send-email-zhongjiang@huawei.com>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <43b41757-18ea-cbb3-1578-ba4068b13ab1@linaro.org>
Date:   Wed, 19 Sep 2018 22:55:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1537419595-29990-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for spotting that!

On 19.09.2018 21:59, zhong jiang wrote:
> device.h have duplicated include. hence just remove
> redundant include file.

I think it will be better to remove the second occurrence because
it will keep the alphabetical order of the includes.

Best regards,
Todor Tomov

> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/media/platform/qcom/camss/camss.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 418996d..0823a71 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -10,7 +10,6 @@
>  #ifndef QC_MSM_CAMSS_H
>  #define QC_MSM_CAMSS_H
>  
> -#include <linux/device.h>
>  #include <linux/types.h>
>  #include <media/v4l2-async.h>
>  #include <media/v4l2-device.h>
> 

