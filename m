Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25523C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48C4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmfbVoF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48C4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbeK1C6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:58:33 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34059 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbeK1C6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:58:33 -0500
Received: by mail-wr1-f50.google.com with SMTP id j2so23266555wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WTXIdCbjdGM8VNo5aan412GRCqRkpI0TBB9+gxr3xmE=;
        b=gmfbVoF+UyE0laPj6kVvneas0BuhJ01n2kN6Km9ZNhilqOFpZc+5dMYv0BK9M3evDG
         QYqeUCVP9GI8CBASeIqy4DlbWpKVcH4yL8hnpC4TvTaST3YW60qRjaUQtP+jq1y9/n4Y
         Wt3dfl1X43iEtakc1H4xvpt2L6GvBLcSAFTYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTXIdCbjdGM8VNo5aan412GRCqRkpI0TBB9+gxr3xmE=;
        b=B18UzftRf+bCN/tRnhK0Ugsqg2+2X2z2EgYHTNtuwjglxBjxwX7wz0r9XdSv3rkUsl
         RRbRpsVcYP/Q3hind2VNkphMgLRnjATwnM8/OEVls/JUIU8bX6UVDvF7XLQeJ0cGEr/j
         DHao/OlI2nCdU5qrcpjy/1kLHISYbk0fq2HyP6G00PQoKpK5MsfB0t+rSwBYzwc1AchL
         FxGIE66JgNj9Ms79E+WThi/rQAJhCP8uZSsx5mjRH5yGPsWnYNFnMBteQf85+JRi9zOO
         ZmoGmoYTp8ncymgkXaWG6h58vsZA2r5OX8Dyxrl04PNBfq3ksxSrMin4svV59QJOrPWu
         fuww==
X-Gm-Message-State: AA+aEWZxcN0S8F7q2ZlKgfl/Yi2HRwqXMA9zuJyJNW9Mc2uS+3DINiBR
        HVNm2FkgF0LsdUMPl3KW3UfqepeSZRA=
X-Google-Smtp-Source: AFSGD/VwDlCrsg1R98q7s5oZUPPisj3o+5U0I5oLq6ahBC3Xlh1QGnQRufB/2KZSS8osXZDAv0OWzg==
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr20705736wrg.52.1543334410662;
        Tue, 27 Nov 2018 08:00:10 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n62sm3107453wmd.25.2018.11.27.08.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:00:09 -0800 (PST)
Subject: Re: [PATCH] slimbus: ngd: fix spelling mistake "exeeds" -> "exceeds"
To:     Colin King <colin.king@canonical.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181127143451.27580-1-colin.king@canonical.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f4b18827-25dc-14b0-2aef-04167b88456b@linaro.org>
Date:   Tue, 27 Nov 2018 16:00:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181127143451.27580-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/11/18 14:34, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message, fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Applied!
