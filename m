Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0BFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A97241DE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNKnLZQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A97241DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeFVMcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:32:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46222 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeFVMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:32:09 -0400
Received: by mail-wr0-f196.google.com with SMTP id l14-v6so1482239wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XEMEop3oVgXyvo7jCq+N0k3dPLeV11Lr5OnNy9+sqM0=;
        b=NNKnLZQ4+tdBGeSKsdG6cy9LD8kjUhPwA7wTWGEvUHyTY4U5+S27WZZLJ6Zz/Pf6Bl
         27/TjFWPWJMadQmiyX7rT6uk+2WRSETE12Ur0QZFoqtYwtUv8FGf7/eZKPVWj6Sy0Eof
         qWQPweePR1z7Y77s0PAXF/F9CbDg6B4C+P0tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XEMEop3oVgXyvo7jCq+N0k3dPLeV11Lr5OnNy9+sqM0=;
        b=f2MQCiegJB7ZHpGEIvwMa7CPMlo3dcGKCDvq9QL0ObvnctMq+liW5hWAec5E7fbcCu
         AmOus29QTouHa2Yj9ZW922WxtacKJHOn+nPaDu3JH3vJlX2sMpdqGVYS3OgtFIIsymJ4
         xriMxYoEUMwpFmnnljxa12PwR/tVjMkD97XYVDmue3GogHfA9/Rvl1TZEr6YIoerlpyZ
         fF1Lh2w+vtGSwGEATgpAI0osGqsN4at1E6VfFBV2g2I+Egqda6p0ABUqCGgyOCM10p5v
         scqZMGLRakglWXKp31yZEKWBCjfgCE7Mv9sl5RemcLMhfu2wKr7kOcuo9WZoBM1GjK1W
         IiFg==
X-Gm-Message-State: APt69E236V6tmQXk42TTTouy//P+tQAqESnAteAaSwDaR8CFRGXYmTb8
        XA3yu5WHvxuAeC8GHD5pt5wdmg==
X-Google-Smtp-Source: AAOMgpf5SRDQO8gxlCGVrDqOEFc3AgFbmrNz8qnxOj7TQoujz83QGhtbq6kZfxA2hHM15B8Dh6UuTA==
X-Received: by 2002:adf:8023:: with SMTP id 32-v6mr1503018wrk.243.1529670728259;
        Fri, 22 Jun 2018 05:32:08 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id d15-v6sm4397717wmb.0.2018.06.22.05.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 05:32:07 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: qcom: add sdm845 sound card
 support
To:     Rohit Kumar <rohitkr@codeaurora.org>, Vinod <vkoul@kernel.org>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
 <20180621123503.GD27187@vkoul-mobl>
 <46f1a6af-a180-2568-d203-87323379c2fd@linaro.org>
 <58db39ee-d2a7-1cdf-c7e2-eea020c8a2c6@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ba90c267-2bca-469e-f41f-df46ed4421b5@linaro.org>
Date:   Fri, 22 Jun 2018 13:32:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <58db39ee-d2a7-1cdf-c7e2-eea020c8a2c6@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/06/18 11:36, Rohit Kumar wrote:
>>
> Sure, I will add a new file, qcom_snd_common.c, which will have these 
> common functions and will update apq8096 and sdm845 machine driver to use
> APIs exposed by qcom_snd_common.c
Just name it as "common.c" no need to prefix this as is going to live in 
sound/soc/qcom anyway.

--srini
