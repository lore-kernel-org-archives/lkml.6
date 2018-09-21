Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1727B2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnbbxfRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1727B2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbeIUMn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:43:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39226 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUMn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:43:57 -0400
Received: by mail-it1-f193.google.com with SMTP id h1-v6so858866itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5QvWePBL7sSLhWmibPD6UStSwr7IpREzt2YDfpErdc=;
        b=gnbbxfRE62++1hTPy7bCXLOYJG/Ymp9KOTe2qCwcUcz+WHQsO7rrUTP26tnOUg2kke
         MCHUAw8n4S+iOuyldogz9s1ZG4IpwhIw94qimuXdIO9hr3qpPsaov+5w+drS/YdawHIt
         v0Y/MXWxLvdWyIWgnzyRvthbBBrMvkhg+fEI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5QvWePBL7sSLhWmibPD6UStSwr7IpREzt2YDfpErdc=;
        b=CgU2AvZdsUrg/nsYov/5r8yE42XdV6CtMiN0j4q5W19BBtz6NBhk1FOfolKq5UKw08
         02ADsSAU//jnsBmmtrX0qBejjc9pF3Cp3K/pgXnO2zF+twskfv2i7+4PBKdTZ1JoYMvi
         cG8fHWFQ++/BvzQA/j/EzPW4nQQNsa127LaXDhx80ErTQ9mG6vdn7I2Ms2ppGRDZ8Ebt
         BF9LWXQNUtCP/rZjCSb7B5SVB+6xV/tVqEKYsic9AJ62AYgp8x9adySYZWZi9KcvQah7
         A1J9cyqNWrdwtqw+HnpOcRT8jDsuIHYJOGOZ8Vw0/H0YhrKnRj6MNd7bT+6zxZtWT4bu
         PxUw==
X-Gm-Message-State: APzg51CW6nwixPAFYqxTrXNytyfKMa3+wpmoge3W2L86SuJ9am0KzI59
        hYhgh0gSa2cvVtqVNBXAB4FuOzButzc=
X-Google-Smtp-Source: ANB0VdY3ZH4/8GZxios8IYwr55GJrBRSeHV74BkzZpeFmolOK7SL+9R/X7bG3gVFBWHexLhJIN5JNw==
X-Received: by 2002:a24:3a88:: with SMTP id m130-v6mr4641054itm.151.1537512988510;
        Thu, 20 Sep 2018 23:56:28 -0700 (PDT)
Received: from [10.199.100.8] ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm8922850ioc.63.2018.09.20.23.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 23:56:27 -0700 (PDT)
Subject: Re: [PATCHv2] media: qcom: remove duplicated include file
To:     zhong jiang <zhongjiang@huawei.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537500620-21069-1-git-send-email-zhongjiang@huawei.com>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <3d4dda8b-7f9d-9f44-efdc-8fbd79673e9e@linaro.org>
Date:   Thu, 20 Sep 2018 23:56:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1537500620-21069-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Zhong.

On 20.09.2018 20:30, zhong jiang wrote:
> We include device.h twice in camss.h. It's unnecessary.
> hence just remove it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Acked-by: Todor Tomov <todor.tomov@linaro.org>

> ---
>  drivers/media/platform/qcom/camss/camss.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 418996d..f32289c 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -17,7 +17,6 @@
>  #include <media/v4l2-subdev.h>
>  #include <media/media-device.h>
>  #include <media/media-entity.h>
> -#include <linux/device.h>
>  
>  #include "camss-csid.h"
>  #include "camss-csiphy.h"
> 
