Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D47C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05F920989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UECzgACu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05F920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbeKUT4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:56:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43363 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUT4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:56:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so4830563wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=I8lFzQ3rLFHjEcQyoMIxfUjvyyNZX5Hy/mdr9ilIH6w=;
        b=UECzgACuRaDAqc3FDgR1DuNNGKKjIGouhEHtPKVT7ylPTUF+UdhrAGQNdv3jGdU4qN
         VATChHoJsjuYd7Z2GLuwXaa+fqn/t0AelCZbNdLPqFz/K6LMfgIVafo1jKDANqIOBcLV
         itAFXr+qUbYF4H8JflFFQKu0BLHzgaMA4fOng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I8lFzQ3rLFHjEcQyoMIxfUjvyyNZX5Hy/mdr9ilIH6w=;
        b=kmDFZIZFzx5yPa7ibOYWPYWsv3q8rL3gSLFr1S6HbRr9+iqTpqA77eT13VxDr2aM+o
         ajeOAYwMsLLbl0O/J6aq8I6FPUztfpfwu8RUnomQP+NsXxkEs4AsjpFCMQFY2G+++Xo8
         ngsPjxSeh88pqfFrbQtKQczfLnKZOcWIrbXywx3oZzdcU67dR4PAHc4Af5INheI1CvdU
         Xh42otH+XO8lf/z2cBxLRVgrEUQ6Cr1sTbRVsMqt+OBWLEm6jROkQd//pJpahWSl0Qly
         QTN4oDl1v631DAFLb5cMgUWobyvA2zZzfZU1ILUjf7ZYb4jMumy/MoJpcMlRDMMJcNlm
         1c9w==
X-Gm-Message-State: AA+aEWbUhbeMjNSpWvyMBi1BJOqHjQ08VE3/68xhNS28pcO3p2QJb4vG
        xZhap5+6f/XHXTfmNdMerGQ+fQ==
X-Google-Smtp-Source: AFSGD/XEN+EaGSsIM+1xI3J7T45Coc/GO9L7QputjrGv1wcnEj0pmOqrKkZNitUCmOzC7MiiAybjeA==
X-Received: by 2002:adf:9d4a:: with SMTP id o10-v6mr4639699wre.94.1542792139508;
        Wed, 21 Nov 2018 01:22:19 -0800 (PST)
Received: from [192.168.0.19] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a125-v6sm451563wmf.8.2018.11.21.01.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:22:18 -0800 (PST)
Subject: Re: [PATCH 2/2] ASoC: sdm845: Add support for Secondary MI2S
 interface
To:     Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com
References: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
 <1542354118-23360-3-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <97e02d38-046b-eef2-82ce-51d231312372@linaro.org>
Date:   Wed, 21 Nov 2018 09:22:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1542354118-23360-3-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/18 07:41, Rohit kumar wrote:
> Add support to configure bit clock for secondary MI2S
> TX interface.
> 
> Signed-off-by: Rohit kumar<rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/sdm845.c | 18 ++++++++++++++++++

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
