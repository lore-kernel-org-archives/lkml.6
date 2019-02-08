Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D595C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2702146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoUC7gYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfBHMq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:46:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38183 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfBHMqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:46:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id j15so2435756lfh.5;
        Fri, 08 Feb 2019 04:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uYHZ+Rt5dpflb+tnnp3fAkxqv4ddwXn8bPZxHQ5o6hs=;
        b=SoUC7gYOty4ojBEWIfocGffjVc9AK0CeiJjtXXAobWa9y2FaMGyp98hWLid2TZ5mkI
         qCVbUKm0v3TvXwstGi0t6ZNR2QXjpD3OwLNULDaivbE9r+LxjhhRKl2IIGf01S7d0Z+w
         Ymd4NX0bEXngeTV32ctgwbbDdE43DgfJKUD+y81xBe+rvBVT6N+btsG0NsUKI+f372XF
         Z/GmvYaEsHFLwX+dy/XW6yevl5v3f6bdTXANl5FPt6ndphN5OQbmZ03cRdeh2gn58mut
         PEz0Tk60cz1N0PQKkXRj43O5XbPOMzB5aS3qYwONzz/0kSmrG4fk4S+iYey6nkuQOr+e
         Xwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uYHZ+Rt5dpflb+tnnp3fAkxqv4ddwXn8bPZxHQ5o6hs=;
        b=GdaT10oAeDYZ7My1XWsIcdvJWJ4w+xLiUdSsToxlNQED6ljuLbXYawdSHPabdUsp8/
         buhgTt7RyIiU9sTRA1qh6Ebs8Bhu81kPIl3PCd663rofFjOxIc1kkZr/BQZvQyNogFYY
         so6R7bI7mE4AwvCyhxdg0ICyfu1sWZXhiU90X6f9auTZgqa1vU++GMfJxiFxdzvyZ+Nd
         5PB6I69F8/IXmM2kcUdaXrVIjcCgjthwvLJ8a787B30NxOC5o/7Bc5DWrdJHEZJQQ/Ey
         Sc36wkYunhQy3GS2vxgqPT+GdsygPoal5xu/B5cVud4VCOi+mqIzWIVOZsyEzmz2uOt8
         2WsA==
X-Gm-Message-State: AHQUAuamKnWSl36uctdDpHHPSygyw7PeOJsKftDh78dvVlMxZxsgOVU9
        JOngGIaseTxDSPGAzDRkxHZ8FXTB
X-Google-Smtp-Source: AHgI3Ia3yovktwouu3aqUMMKe1owFqrzJaSNS+A8jYI4Ft9XK9LqCyFl5B9M3fScXQvsZQhj1eETuQ==
X-Received: by 2002:a19:760a:: with SMTP id c10mr13609846lff.53.1549630012941;
        Fri, 08 Feb 2019 04:46:52 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id n9sm349127lfb.29.2019.02.08.04.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:46:52 -0800 (PST)
Subject: Re: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-3-git-send-email-skomatineni@nvidia.com>
 <1202cc91-cacf-673e-c32b-b4d1c78b71f2@gmail.com>
 <515cb722-c345-8dd6-dbe5-557dec0d1384@gmail.com>
Message-ID: <a57f0374-8468-f24a-1743-b446b8260a46@gmail.com>
Date:   Fri, 8 Feb 2019 15:46:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <515cb722-c345-8dd6-dbe5-557dec0d1384@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 1:25, Dmitry Osipenko пишет:
>> 08.02.2019 1:16, Sowjanya Komatineni пишет:> 
>>>> This is wrong, 65535 = 64 * 1024 - 1.
>>>>
>>>> Let's just use size-constants provided by kernel:
>>>>
>>>> static const struct i2c_adapter_quirks tegra_i2c_quirks = {
>>>> 	.flags = I2C_AQ_NO_ZERO_LEN,
>>>> 	.max_read_len = SZ_4K,
>>>> 	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE, };
>>>>
>>>> static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
>>>> 	.flags = I2C_AQ_NO_ZERO_LEN,
>>>> 	.max_read_len = SZ_64K,
>>>> 	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE, };
>>>>
>>>>
>>>> I'll take a look at other patches later today, no need to send out new version right now.
>>>>
>>>>
>>>
>>> SIZE_64K is 0x00010000 (65536)
>>>
>>> msg len is u16 and max that can be set to msg.len is 65535
> 
> Ah, okay. Then it looks about right, maybe it's time to change u16 to u32 in the I2C core.
> 

Here is my suggestion:

1) Use SZ_4K / SZ_64K that I suggested above.

2) Squash this patch into the DMA-patch.

3) Add another patch (before the DMA-patch) that changes max_read_len/max_write_len types to u32 in the include/linux/i2c.h
