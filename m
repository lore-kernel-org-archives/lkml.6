Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02EFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA10220873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwidiE+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA10220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeK0UOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:14:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44087 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbeK0UOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:14:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so17532803wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4hLd/YZOhBHGeRM1odD7WiGR03qRbtKTGVwyvu+NDqc=;
        b=fwidiE+d+XjYlDLcrpqPSLazX+ymyUx69CXKzO4Wfpv7dHSCTxFxxK2goOnFUENxZq
         yKRASyHFBW3ct/L9g047vdjQQ5L/FBTfTPQZt6CDW6CUHQRaCKA/6UVz18ou2brJ7Gh8
         uLU4Il059SN7j4CrAtCo2i+oTCmrhn2oOm2SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4hLd/YZOhBHGeRM1odD7WiGR03qRbtKTGVwyvu+NDqc=;
        b=Mrlul58cGHmvJVxpxmC+BN9LzjnFU4fzBHXxKbntXiJj06UcWK7TEsFWMHXpatISVb
         QfZKi5FQv7ElGsMAbcRZWf3e1qkOkc72br6khRlZ2er6P4ZEyPG9GlB1L5ktWyw12SXN
         cgxy61P0Vsx7hTLbk9cZLe9x7LDajI06RSEUum70eKicNovIk8UdCS1tv5J0eB47thaP
         4nC8h8bElEt5M0lfcHTw/y6+SUod1uIKRUnscVIX9VFAy/wS/tSuLkc7tdIEry/0wNhf
         2WateWm9XflQJmCJwcwvTF5iq523mQ2UQbxdSDzNX1YBqF+Nor+2iDR9xp6d2Ai8HffW
         BrVQ==
X-Gm-Message-State: AA+aEWZD27pnNEw+Yz2IafOfBjm5DZSb+3vFX3a5s7GotOAASzo50Jd4
        A6SB9s+mPgn2j9Cld0M+KdDYkQ==
X-Google-Smtp-Source: AFSGD/XiNCd5tAskL2Jd0OeM+hXlfVQDsbFg5qpdJOqiOqkYA7HPR3xVZzmos106NKPMou4DdeC7Uw==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr18155097wrg.230.1543310248256;
        Tue, 27 Nov 2018 01:17:28 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 6sm4174247wmk.26.2018.11.27.01.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:17:27 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: qcom: Kconfig: select config for
 codec
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
References: <20181124110948.209019-1-cychiang@chromium.org>
 <20181124110948.209019-4-cychiang@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4a59167e-1219-dc0a-61e8-4c1fde0e4c0c@linaro.org>
Date:   Tue, 27 Nov 2018 09:17:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181124110948.209019-4-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> Select SND_SOC_RT5663 and SND_SOC_MAX98927 for SND_SOC_SDM845.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 2a4c912d1e484..3528c4279cbae 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -100,6 +100,8 @@ config SND_SOC_SDM845
>   	depends on QCOM_APR
>   	select SND_SOC_QDSP6
>   	select SND_SOC_QCOM_COMMON
> +	select SND_SOC_RT5663
> +	select SND_SOC_MAX98927
>   	help
>   	  To add support for audio on Qualcomm Technologies Inc.
>   	  SDM845 SoC-based systems.
> 
