Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89517C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5636520844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnRtIPIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfBHNBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:01:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46410 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHNBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:01:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so2862765ljh.13;
        Fri, 08 Feb 2019 05:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WrYZskbMiZ2ayR/kvKhAJMY5IT3/ujUiaqqQ6VQh9fs=;
        b=GnRtIPINdbneZaerlySIT0G57YXYBQkM6AeZi1AmRiJXQK+uYQXjPuS9jDQ8slpi5Q
         DldMVYKTuQmcvIjbP58mvVxoXh5Sn6wWm0RCfCx0KdHXabEplQPLWrbpVWSFdLH8UxQu
         ysDs7YTL686fTP6qR8gY+LUak+BxSBWTaubVN535FJ2VMCPdpemfbkp6WtRLwpaowTTo
         v+jmZRCTPOcqcXB6Cq3K8Z18GP2XxOO7HTZmkmslsAJsbWpgIMBgAevOBIEQJsz3qtV2
         k28a8cR5DxegbIZ+vkEimo+54XgY314zflHOzGKGCvYjh+wU8sFMroyb/7gf3smMCOYs
         q1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WrYZskbMiZ2ayR/kvKhAJMY5IT3/ujUiaqqQ6VQh9fs=;
        b=Sh/GCic+ES9OkC9v/farXb6zfJZt3+aiZ9SLi1VyvYG0rRpiytJk+qz/pfUWe8LWuW
         xTngyX8Tg3Ix36x1IX/Gv7RuxH/PIPmj4EMpM2DGZqjL6j2Mi+gM5ndkBqJAyUP/Fnqz
         Q/JHJMIrsv66fqC2reF3gmLhUOGpKN/I07bPmPIevI/GGlEYaV9umAh07HF+5qrxU/ai
         EuXTVfgIJ71nmJDtRvGz17BPzCvEsnelCF98UL/gVt6NPmgLXJyoLIGpcrOpEGXUSgwN
         Fo807afXKrmwUZnrNmQy9n1E2KocZjlH/TGmLF/tKfr10elaE7+EirDFXepgW39Ksz8y
         cD9A==
X-Gm-Message-State: AHQUAubIfGFNrv09Na7pLvFW+e5c02zXW0GTG7B770D3++a5IdASjPma
        rPIxiv34Qiysu6uZMl1G/TQdpBpq
X-Google-Smtp-Source: AHgI3IZzkG4QSTcfhsMC7glJpk/rdsTQzGwUSoxnh4UExp103B0Nn+A3KrTt1VSFs+SrbPaxD6u6nA==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr13112625lja.44.1549630859118;
        Fri, 08 Feb 2019 05:00:59 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id v4-v6sm362231ljv.56.2019.02.08.05.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 05:00:58 -0800 (PST)
Subject: Re: [PATCH V15 6/6] i2c: tegra: add i2c interface timing support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-6-git-send-email-skomatineni@nvidia.com>
 <3824e7bd-e129-511a-358b-42391ccee0f9@gmail.com>
Message-ID: <e86e3e79-ba21-b833-b458-c833eded6e5a@gmail.com>
Date:   Fri, 8 Feb 2019 16:00:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <3824e7bd-e129-511a-358b-42391ccee0f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 15:53, Dmitry Osipenko пишет:
> 08.02.2019 0:47, Sowjanya Komatineni пишет:
>> This patch adds I2C interface timing registers support for
>> proper bus rate configuration along with meeting the I2C spec
>> setup and hold times based on the tuning performed on Tegra210,
>> Tegra186 and Tegra194 platforms.
>>
>> I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
>> and Tegra I2C controller design uses them as a part of internal
>> clock divisor.
>>
>> I2C_INTERFACE_TIMING_1 register contains the setup and hold times
>> for start and stop conditions.
>>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
> 
> [snip]
> 
>>  
>> +	if (i2c_dev->bus_clk_rate > I2C_STANDARD_MODE &&
>> +	    i2c_dev->bus_clk_rate <= I2C_FAST_PLUS_MODE) {
>> +		tlow = i2c_dev->hw->tlow_fast_fastplus_mode;
>> +		thigh = i2c_dev->hw->thigh_fast_fastplus_mode;
>> +		tsu_thd = i2c_dev->hw->setup_hold_time_fast_fast_plus_mode;
>> +	} else {
>> +		tlow = i2c_dev->hw->tlow_std_mode;
>> +		thigh = i2c_dev->hw->thigh_std_mode;
>> +		tsu_thd = i2c_dev->hw->setup_hold_time_std_mode;
>> +	}
>> +
>> +	if (i2c_dev->hw->has_interface_timing_reg && val) {
> 
> Shouldn't it be "&& tlow"?

Ah, there is "thigh" in use here.. so it all just doesn't make sense since "&& val" is always true. 

> 
>> +		val = (thigh << I2C_THIGH_SHIFT) | tlow;
>> +		i2c_writel(i2c_dev, val, I2C_INTERFACE_TIMING_0);
>> +	}
>> +
>> +	if (i2c_dev->hw->has_interface_timing_reg && tsu_thd)
>> +		i2c_writel(i2c_dev, tsu_thd, I2C_INTERFACE_TIMING_1);
> 
> Do we really need those "&& tlow" and "&& tsu_thd" at all? It looks to me that checking for "has_interface_timing_reg" should be enough.
> 

