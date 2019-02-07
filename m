Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F431C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEDC21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbv79Jep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfBGUW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:22:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37175 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfBGUWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:22:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id r10-v6so1047091ljj.4;
        Thu, 07 Feb 2019 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+B67LYoqXEZgeZGgkzwc/fnxIm1aheEgyK7zgsFPlSk=;
        b=Nbv79JepX9P39OgKZXa82WGuwgp9S0yD/qGwigDlj1gI+IGCS6dvpog/oEJPiuOcR0
         xrhoRA+SACVHU7+IO6jUdk0ordykJhjP02WLPJfjbV/gQ+aD8r9EnpTW7sumdz4Z9ue+
         lxNic4jfaoBiPsLiXq/K5FUkLQV0ZxbycbITlPslICTmC+eyhGJsWXZSzOFP1lv06Swm
         nzlJhdlVVTdFm/ZVEkWo+rkUJj/jcerDmM82fYcQWk8FwjROJE9jDoYrqy2tZiINByeX
         FD6+8mRh3HbEyBwqovSua0gXNcW4MphFQbYzfx+MtmZl68h7j5fFqb5b/2uFP42PS4Yi
         Cyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+B67LYoqXEZgeZGgkzwc/fnxIm1aheEgyK7zgsFPlSk=;
        b=tTScjyf6Fo0AGvsGftAet96eq9pD53HWdBTcMr3d9FQxjUUOcMcAblwGDYdzx1SN7R
         flnGSPcsKuHUdBvig/dh07ZndtXokn4WYUsehX3zjK1G7RWkrK8LDv3dN54F/YeCC8Qf
         POonVFXOr9Almg4EQWzFGht5GPmMAhBUPGoXeRH8ptSx1XbzdqF7eGeyv+w56AhMYUux
         /hSWijoPSOEgg1qVghLgybEq5g5qWtO4aqi3iOe52WCywKBTJ34GzoV8GNHhdnoY88nU
         pwhvPcX4S484MawG6k/5rE80SISGkaXkqOUnuKk5airLDxPRMbWxXxZv49mlQyQQF6Bh
         M57Q==
X-Gm-Message-State: AHQUAuZDjcqAY+4SuHSTR/qirpcI0IoyFuVepm/J3NwAdX0M2GKGzc5S
        0MJf8W5OlCvqu+VvA4wra9ptAoB6
X-Google-Smtp-Source: AHgI3IaWiduf7cnU91f8jUMv54pQiiiUmU3PspRBiE9nemC7JYwiTY3G5CjnMffoLMnS4BH2+W61Yg==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr9875024ljj.49.1549570973211;
        Thu, 07 Feb 2019 12:22:53 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id v9sm5052567lfg.15.2019.02.07.12.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 12:22:52 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <c6484ae8-65c7-885a-fe37-0666182cff29@gmail.com>
Message-ID: <b72f8946-f921-f098-de36-e7f6203d6391@gmail.com>
Date:   Thu, 7 Feb 2019 23:22:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c6484ae8-65c7-885a-fe37-0666182cff29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2019 22:14, Dmitry Osipenko пишет:
> 06.02.2019 22:16, Sowjanya Komatineni пишет:
>> +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
>> +				       size_t len)
>> +{
>> +	u32 val = 0, reg;
>> +	u8 dma_burst = 0;

There is no need to set dma_burst to zero as well. In general you only need to initialize variables if code uses the uninitialized variable.

>> +	struct dma_slave_config slv_config = {0};
>> +	struct dma_chan *chan;
>> +	int ret;
>> +	unsigned long reg_offset;
>> +
>> +	if (i2c_dev->hw->has_mst_fifo)
>> +		reg = I2C_MST_FIFO_CONTROL;
>> +	else
>> +		reg = I2C_FIFO_CONTROL;
>> +
>> +	if (i2c_dev->is_curr_dma_xfer) {
>> +		if (len & 0xF)
>> +			dma_burst = 1;
>> +		else if (len & 0x10)
>> +			dma_burst = 4;
>> +		else
>> +			dma_burst = 8;

In this case compiler just ignores the first initialization because it is explicitly initialized later on in the code path that actually uses the dma_burst variable. Avoiding unnecessary initialization helps to keep code a bit more clean.
