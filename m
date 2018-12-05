Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102B5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70E62087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F48U4bzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70E62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeLEOSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:18:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55442 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeLEOSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:18:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so13377294wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gcg4+qT4V1BqcdQUzTzOiTjN5d+QF2mZqBCLWZyCnfs=;
        b=F48U4bzyXc9YR1LnX6r5f3vfnZPxTImmTFZq81juuUvigZJ5Q8Vp5pa0fpZfgrDlYU
         OoRJexaLDxkKN3jjD24MqQ/s+ChPLvEirf2fpRn0rhscU7oBFCiFfrsXqoXE/booJAwa
         kmvpzle23dSGvaMCI69t2I02rMW1Nz7qm+0fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gcg4+qT4V1BqcdQUzTzOiTjN5d+QF2mZqBCLWZyCnfs=;
        b=r661K8vGxzYLcoTRJVbEJW0Qk/LUlFMRvvgg6TTCXv0I9K2p0cPsEJCqhkyRajO+jt
         4w7lf4mNr5qdRpqRLeYD/NqaskOAuW2SQPK/T4+A0/cXxJ0LObW8vmCg+CJ7oyhPaKxm
         6RCVMqzxPU6JXF+pLccpefNOYDguxYG2n7dFAKr0ZMZDxGe6WwYU7fknjABNm46Cv5K8
         O/XZLWZmaAimRJKbpYodAoVW58jl40j1Y+WTON4h5AY/sG0H6rc3G/hlgRw2A+IyhTLD
         iQxrgvUvFa47L5kGRows4s7RKmixKlehX21/V3I47EPui889Ut83VOITrvmhscFiLIuX
         qKpg==
X-Gm-Message-State: AA+aEWbqSf6QkfHVWFnMlWqV6WUHp88jhEYO5LA+Nyreluq03GTCUC5B
        NbThf+BDsXdJDc73+SDwk/rcNg==
X-Google-Smtp-Source: AFSGD/UEbsHEVf4vAphNuawxk16h/av4Q8fUGQhShGxs0RnmKxjkcQ1GzffwR7DhhESMlyJ2ojkDGA==
X-Received: by 2002:a1c:48c1:: with SMTP id v184-v6mr16499972wma.26.1544019514135;
        Wed, 05 Dec 2018 06:18:34 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y9sm19081333wrq.55.2018.12.05.06.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:18:33 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v2 4/5] ASoC: sdm845: Add configuration for
 headset codec
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
References: <20181128090037.257359-1-cychiang@chromium.org>
 <20181128090037.257359-4-cychiang@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4c0f29c0-b9d7-506a-80dd-c5137cbf78d2@linaro.org>
Date:   Wed, 5 Dec 2018 14:18:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181128090037.257359-4-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/18 09:00, Cheng-Yi Chiang wrote:
> Set DAI format and sysclk for headset codec.
> 
> Signed-off-by: Cheng-Yi Chiang<cychiang@chromium.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
