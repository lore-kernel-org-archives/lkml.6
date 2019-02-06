Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC58C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8F218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hXdIP7ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBFTlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:41:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33664 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfBFTlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:41:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so2619201wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 11:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g0SOurmC/1hWbZf3RZ1yC2YreX5i3l8fOWg+TNn51ec=;
        b=hXdIP7zevKZeWBzz3ovYsZWIBdRegy4rL2qvQiPcHj2V8xMubq0cJS6EPD8mF6KEHo
         JSKZeaTf9+1eopGEjEKN6xfhAZHErNQftS3CYOgYWkKr07Sy/B+Lv2e7tt8fuLWC+bd9
         iQtEwkM50gjKcMhkqAAMvpsbt0jiIsvkXR7mYew+IgR4xK3R+3a4jM3Nmp0dNNh5ALV5
         ZO8JUePCLLutzpAZC9jBnYUz7BwsGBB5Hv9CPNo+rU3YJM4YJZH9VRlybkFz5g3ko2rl
         GpQZwaDh6gTpqOZPDcf3vIOEoK6LHUghFNaOtSTt+wQJhZEZ7M60ua+9rmV6FsSuApow
         pmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g0SOurmC/1hWbZf3RZ1yC2YreX5i3l8fOWg+TNn51ec=;
        b=QdjEmvvtZuLhEApXnh9h4FJFs1zsMcto9nEeqCq7uUJi1UUjDm0+apiwr2hr5v7phU
         cqBvRpP5Jb5XT4cK8Qcof1KWW3JsJ7fEo3abyekR0yDRDzSNATJ4uErNQvzADqNhhghN
         ssWti8RPiE5q5UQiCcm2e7hJWwbWBIwABhqwMkVU0lWLEGRwxsWdRgCFKhDp7pSaAJE9
         Oo5fBI8aKM0CP2hWzb9Hu81O6gqtNaxUlDk+Yam9ad+koXkGC7BzE9MSorM+rfFAJyk1
         ke1uQGYoq2i3H41L9XIIWktVEIejcq/jKzT3dBP/4u7TXWIXF3mL2a6oVhnMIJY9AdGC
         RhUg==
X-Gm-Message-State: AHQUAuYm4thYUnbRy95oGSnW6aQtlMRYPB4NvXkAcxxEcWRD5ioYjjRH
        u7dJ9lZHFpBzIjwRhL8DrmZLIGjh0eGjzg==
X-Google-Smtp-Source: AHgI3IbjhHgL+IcQBXfpM0N+GBFZjy0aFHdVdvdM1NoE5c+Qs73KhTZXrl8Fc2MVpp5ufVYIzrOV9Q==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr1104229wme.84.1549482074771;
        Wed, 06 Feb 2019 11:41:14 -0800 (PST)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a12sm29037322wrm.45.2019.02.06.11.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 11:41:14 -0800 (PST)
Subject: Re: [PATCH 2/2] clk: meson: Add G12A AO Clock + Reset Controller
To:     Stephen Boyd <sboyd@kernel.org>, jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190204091331.9298-1-narmstrong@baylibre.com>
 <20190204091331.9298-3-narmstrong@baylibre.com>
 <154940510132.169292.12584338453129084603@swboyd.mtv.corp.google.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c93fb858-27e1-47b5-a7da-849d02fd7a38@baylibre.com>
Date:   Wed, 6 Feb 2019 20:41:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154940510132.169292.12584338453129084603@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/02/2019 23:18, Stephen Boyd wrote:
> Quoting Neil Armstrong (2019-02-04 01:13:30)
>> + * Register offsets from the data sheet must be multiplied by 4.
>> + */
>> +#define AO_RTI_STATUS_REG3     0x0C
>> +#define AO_RTI_PWR_CNTL_REG0   0x10
>> +#define AO_RTI_GEN_CNTL_REG0   0x40
>> +#define AO_CLK_GATE0           0x4c
>> +#define AO_CLK_GATE0_SP                0x50
>> +#define AO_OSCIN_CNTL          0x58
>> +#define AO_CEC_CLK_CNTL_REG0   0x74
>> +#define AO_CEC_CLK_CNTL_REG1   0x78
>> +#define AO_SAR_CLK             0x90
>> +#define AO_RTC_ALT_CLK_CNTL0   0x94
>> +#define AO_RTC_ALT_CLK_CNTL1   0x98
>> +
>> +#define AXG_AO_GATE(_name, _reg, _bit)                                 \
>> +static struct clk_regmap g12a_aoclk_##_name = {                                \
>> +       .data = &(struct clk_regmap_gate_data) {                        \
>> +               .offset = (_reg),                                       \
>> +               .bit_idx = (_bit),                                      \
>> +       },                                                              \
>> +       .hw.init = &(struct clk_init_data) {                            \
>> +               .name =  "g12a_ao_" #_name,                             \
>> +               .ops = &clk_regmap_gate_ops,                            \
>> +               .parent_names = (const char *[]){ IN_PREFIX "mpeg-clk" }, \
>> +               .num_parents = 1,                                       \
>> +               .flags = CLK_IGNORE_UNUSED,                             \
> 
> Can you please add a comment explaining why CLK_IGNORE_UNUSED is here?
> It will help future readers know what's going on with this special flag.
> 

Sure, I'll add it.

Neil
