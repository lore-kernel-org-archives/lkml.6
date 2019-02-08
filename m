Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CD3C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582D22086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjCDw6Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfBHMxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:53:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36017 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBHMxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:53:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so2923159ljk.3;
        Fri, 08 Feb 2019 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RS8RXRLCCkRTsbSyvhj6eHDiWxn674lyrxsU7sTrvZg=;
        b=TjCDw6KeDB3v+98/3f0al4fmZj4T3v6WVywx4Yez0CVGKnbRUSYyFlyPhjWJhiOpP1
         Az505JmLHgVLCYyRmi8bD+eDFGoKNJEZnOmocxOxVYmTE03HQIBK7hf3+/ulGGi3K6UO
         ynqufbcoH8Jgz6OX6xe5dAVvhF9xsRsg7x4W3F6/uDtW1IVQ+PFDqxUExv9QHkN4rm0N
         qX+guSmv9lFMs0GI+fOHA2lDH4R1ndNfJm9zR0BEAWjctbepAl4BGrgR3mVK4pXc5rBX
         Sr8g3K/a7xC2+qY9mkcb0sgBDNHEHobo8lCy4VggPtVjamLDISQh0xIbCYp5OOkbQDF+
         Xx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RS8RXRLCCkRTsbSyvhj6eHDiWxn674lyrxsU7sTrvZg=;
        b=qfNcqK6k8Far8QesxjLnD83eibwfiXOs4h3hKFNDUOE4RLZX5viQ5RV3julh+HPOED
         BPK7PiopA5sxHfYfVw7+orGKN/PbQd5PXJw4tKUAdHOuCOzM0LRrf/VkeVquo/beH15x
         PGkoQt5iTa35SnmE2n7fvdZw/dF049drLCqg+2i+RfeTJlwtzcBxIq9dm1mkw87m0jar
         DOJkSIx491/cxntdjl7febMTJlhTvTYbrfsfShXsAcSPn+Q/ll5ySIKzNB5Ct1//DNBx
         MX6o70LgSOinDeseV7lfFG+v02MVwSNvJt2aNuIGyum6ZdiNzd58FWU5W3YE8YJqAR6K
         2rqg==
X-Gm-Message-State: AHQUAuYu9z7v1MPW+mWPwzWcMYMhc4k1oK4Pio7i9becQ8jPRu6+OvnS
        5xuD5blHW3C5LJiahkC7ioWy+iOg
X-Google-Smtp-Source: AHgI3Ia0T7ZD8VptWRngd26Dp4HbIBpcD3YVigB4Nw9ryp8klgnBENjpk32A/KyXs1tr01yGsSrOvw==
X-Received: by 2002:a2e:8006:: with SMTP id j6-v6mr13231245ljg.186.1549630418949;
        Fri, 08 Feb 2019 04:53:38 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id f18sm387889lfk.18.2019.02.08.04.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:53:38 -0800 (PST)
Subject: Re: [PATCH V15 6/6] i2c: tegra: add i2c interface timing support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-6-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3824e7bd-e129-511a-358b-42391ccee0f9@gmail.com>
Date:   Fri, 8 Feb 2019 15:53:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549576040-15907-6-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 0:47, Sowjanya Komatineni пишет:
> This patch adds I2C interface timing registers support for
> proper bus rate configuration along with meeting the I2C spec
> setup and hold times based on the tuning performed on Tegra210,
> Tegra186 and Tegra194 platforms.
> 
> I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
> and Tegra I2C controller design uses them as a part of internal
> clock divisor.
> 
> I2C_INTERFACE_TIMING_1 register contains the setup and hold times
> for start and stop conditions.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

[snip]

>  
> +	if (i2c_dev->bus_clk_rate > I2C_STANDARD_MODE &&
> +	    i2c_dev->bus_clk_rate <= I2C_FAST_PLUS_MODE) {
> +		tlow = i2c_dev->hw->tlow_fast_fastplus_mode;
> +		thigh = i2c_dev->hw->thigh_fast_fastplus_mode;
> +		tsu_thd = i2c_dev->hw->setup_hold_time_fast_fast_plus_mode;
> +	} else {
> +		tlow = i2c_dev->hw->tlow_std_mode;
> +		thigh = i2c_dev->hw->thigh_std_mode;
> +		tsu_thd = i2c_dev->hw->setup_hold_time_std_mode;
> +	}
> +
> +	if (i2c_dev->hw->has_interface_timing_reg && val) {

Shouldn't it be "&& tlow"?

> +		val = (thigh << I2C_THIGH_SHIFT) | tlow;
> +		i2c_writel(i2c_dev, val, I2C_INTERFACE_TIMING_0);
> +	}
> +
> +	if (i2c_dev->hw->has_interface_timing_reg && tsu_thd)
> +		i2c_writel(i2c_dev, tsu_thd, I2C_INTERFACE_TIMING_1);

Do we really need those "&& tlow" and "&& tsu_thd" at all? It looks to me that checking for "has_interface_timing_reg" should be enough.
