Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34437C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1ED20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsouMWaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1ED20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbeHAOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:10:08 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35989 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbeHAOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:10:07 -0400
Received: by mail-wr1-f49.google.com with SMTP id h9-v6so19925272wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QEGjg0jOBRpXxmiHfyWEbrWVCIGEkyX51S3UpBt29co=;
        b=fsouMWaHczkGeFrIgkeu7WdFJNv+5HvKuk2EGH8luhqZZWBQFq9JSGZxlBePO+MEIj
         MZbqlVQRf//T5Hth2Q+JWYOPJ3K/TKYTx79bAohQdiouEcJOKE4MpxX/+lkqo7K7Omo2
         d+ka320vGKmqcO7IlW1/jksuvKQ2DtJb1GL3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QEGjg0jOBRpXxmiHfyWEbrWVCIGEkyX51S3UpBt29co=;
        b=k2ULtE+B3C4G14qTrbSHcvPOg9dKKClQbM/Sd5ik04gPm7G/8zc8RjSDlmlHAwHOFa
         1x7ikTfbERaXeEWDCsXKUOHXQoa/ayErMulRAo82w675cAQTjhKB5aSuvanMCmmNu9b+
         5dvnBiHNSdL9qzVzCCU3C87UaFOwrwsRwttVYsDD6lZoiDBfsO9T3JDWn7EmQezIpVxH
         zaruyM8LsvMaimaiw6EJvpMaNqvR3Q07Op/J1Z8eNyjDOVPNWWuXm2PfPUWWm3NGPF1Q
         rDX6fUXjk/h1sKWPIXeqp5vEBrfHj6ZKcli3H6Fj8UQawaMsBr9TgbtzLEEChP6+wEJB
         Bq6A==
X-Gm-Message-State: AOUpUlE26oSO4B8jaKYNboghbnqty1yO6PC/J14taxE+Rj87ivxggSO2
        7/pHPy3UzvipHGuvER7VVnI8kQ==
X-Google-Smtp-Source: AAOMgpc4wR3wBbpSxn2STUL1kuebZ6uVxXG1H7vGO36HGFrKaEMQ82/fuoSXxYSzHjM/plb0btxwzg==
X-Received: by 2002:a5d:5043:: with SMTP id h3-v6mr23057874wrt.186.1533126273711;
        Wed, 01 Aug 2018 05:24:33 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id w185-v6sm6664184wmw.6.2018.08.01.05.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 05:24:33 -0700 (PDT)
Subject: Re: Applied "ASoC: wcd9335: add support to wcd9335 codec" to the asoc
 tree
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20180801112011.33C511124241@debutante.sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2b90faa5-6fd9-f769-183e-23cb59bf460e@linaro.org>
Date:   Wed, 1 Aug 2018 13:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180801112011.33C511124241@debutante.sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 01/08/18 12:20, Mark Brown wrote:
> +#include <sound/soc.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/tlv.h>
> +#include <sound/info.h>
> +#include <dt-bindings/mfd/wcd9335.h>
> +#include <linux/mfd/wcd9335/wcd9335.h>
> +#include <linux/mfd/wcd9335/registers.h>

Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" 
It would break the build.

--srini
