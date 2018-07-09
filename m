Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AC6C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAB820854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOlnsW2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAB820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbeGIJGT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:06:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46921 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeGIJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:06:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id r17-v6so13328184edo.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O400IfTlEiWzAVlPR53SXkbGQGPiZA1GEyEQjnRS9UA=;
        b=NOlnsW2srQM4ltAzSgdlHIkr1MMDPj1LoraR+kIpbrZel3MyhOujRVhVxG25uKUeA8
         KntMEJL4X4CV1h5ygESJRTxzglpdK7jtmQH2K7MdLIl5bobQePHXmM6o+Cj6e0AZi0Ai
         G/C4sSYo5SODXXHYNkZ3EB+0pHhXrtN01/qro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O400IfTlEiWzAVlPR53SXkbGQGPiZA1GEyEQjnRS9UA=;
        b=dIBSxCoou08TcCGJZ09UqspgJLpApfNQ0T3/1x+jR0r6VUhej1+AqCrCxIxc3cR8Af
         aTQufdZ4pFqf6t5EMkVj3YU23JFfnqWShStvBJoytg8pqSATKSG0sfwd4sEEj3ag2AvZ
         LeydpMAZAfW8kspKZw5AscUKlEDCtTUEJC5FFCPlmx2s6XRC/ypinh4hDyjK+3hQWOKC
         iaddQTu/ZtE3BCbDxxz5DFYaBafIF7pMjBOE/q01OmVeeiILP++mjAf/GlLGU1XoTZaR
         UDWKWHDyEYr7BA04OqJ5C3rYzuv7+HBEcpj/gKTXxv8GyAlY4u2tbB9xsmIfF7ECOtT6
         ZatQ==
X-Gm-Message-State: APt69E2akyGUkIElZRavOvZJvM05y61he/2bq1itXt1k+1SCRyelhOui
        VpjyxRPMUtwqeKc8ablMBlYZO0PXlD0=
X-Google-Smtp-Source: AAOMgpdM5lQ5oybtGAbQITEeLfoRb/qh/3rvlfRctxPN1qDfz4Qaf78HfDfRnbfoi20hXmrBnowq8w==
X-Received: by 2002:a50:9943:: with SMTP id l3-v6mr21131391edb.272.1531127176300;
        Mon, 09 Jul 2018 02:06:16 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id e2-v6sm1038546edn.11.2018.07.09.02.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 02:06:15 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
To:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <39104e1f-d976-b51d-aa02-932c264070ba@linaro.org>
Date:   Mon, 9 Jul 2018 10:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor Nits...

On 06/07/18 10:43, Rohit kumar wrote:
> +struct sdm845_snd_data {
> +	struct snd_soc_card *card;
> +	struct regulator *vdd_supply;
> +	uint32_t pri_mi2s_clk_count;
> +	uint32_t quat_tdm_clk_count;
> +};
> +
> +
Unnecessary extra line..
> +static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
> +
> 
> +static struct platform_driver sdm845_snd_driver = {
> +	.probe = sdm845_snd_platform_probe,
> +	.remove = sdm845_snd_platform_remove,
> +	.driver = {
> +		.name = "msm-snd-sdm845",
> +		.pm = &sdm845_pm_ops,
> +		.owner = THIS_MODULE,
setting owner is not required here!

> +		.of_match_table = sdm845_snd_device_id,
> +	},
> +};
