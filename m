Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68F2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC442147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWl3lIeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfBGWZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:25:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41046 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:25:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1-v6so1295739lja.8;
        Thu, 07 Feb 2019 14:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N/0KHLV4PdDoWFvlsA8pg6q7hWNQedtJTXYUsKKtuks=;
        b=YWl3lIeu5M7ku/RD7eNcABz3+1x5g/jE6xaILQCq2Y72n7yDPDctvna2R2OIVUjauB
         gB/DHTQEgwUQ1ezDo/dHExB76HnhPUX7IyAgb70t7b/lwR2IXGWBC8XIFGsbZdVWLojW
         oUGL7ITC+FKqie8FF5W1cjbnQk9zETZsxBvTAUCSXkqd8IBpwrAkmc8jX318ZYgtVyWH
         FtQMK9CwNjyPcAhvP47McwvDq5pArmLPHYZan4sXBmUXRXbB0je1ED6EeXsh1iZGLk8P
         kFsCixj+yN5jG+/JPsN/L6XGIcF8rpxXPXP+kdgHmz9oIV0LuGX6CCPw4EnS7BvI8l3Q
         9AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/0KHLV4PdDoWFvlsA8pg6q7hWNQedtJTXYUsKKtuks=;
        b=QRi4EhUR+DmE4fHAemVBSaTLMxX5S7ctPgye/IUTunEg7SjP4V8kyojAteaKU0X8mV
         BzP/urehw3y9O8Rku61vFi/vLU4lv6nG+GKLo5Xh4qNhGP99/o8s5aNxIwzdGDWRCt93
         JwytqeBGZ+OpusSR5ufg22XzgvzDODOJvGspFnP7Zjf6gGZoLbCxsNwcP7Fc03xq90m1
         eydeY4WLnlNl40T2mvKYuc5xhIP93V4DZOFmFeg+5bh+K6Vc1M/lfN13r21+HlPixpe7
         agDaoMvHiZD97FyMBGFPx0gjwissHDUYhz8w9iYKd/bIAYY6oOWES5zaHXabX41O8vq0
         sC4Q==
X-Gm-Message-State: AHQUAuZuhoYRTMFbB7DF0vqkJPi7Y4RWYXlrpPzlSwezkl1EHguUeIRI
        +hfJ5q1hhKWwRcCRVl7p0JLDWFYg
X-Google-Smtp-Source: AHgI3Iat4hAdu+/knknjnex1/B7mtvGZQYWL16JpjWcJZwnbLmcwBs89Yyn8wv7u2wgCYMmTK575ug==
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr11038476lji.196.1549578320049;
        Thu, 07 Feb 2019 14:25:20 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id q62sm33318lfg.67.2019.02.07.14.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 14:25:19 -0800 (PST)
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
Message-ID: <515cb722-c345-8dd6-dbe5-557dec0d1384@gmail.com>
Date:   Fri, 8 Feb 2019 01:25:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1202cc91-cacf-673e-c32b-b4d1c78b71f2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 08.02.2019 1:16, Sowjanya Komatineni пишет:> 
>>> This is wrong, 65535 = 64 * 1024 - 1.
>>>
>>> Let's just use size-constants provided by kernel:
>>>
>>> static const struct i2c_adapter_quirks tegra_i2c_quirks = {
>>> 	.flags = I2C_AQ_NO_ZERO_LEN,
>>> 	.max_read_len = SZ_4K,
>>> 	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE, };
>>>
>>> static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
>>> 	.flags = I2C_AQ_NO_ZERO_LEN,
>>> 	.max_read_len = SZ_64K,
>>> 	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE, };
>>>
>>>
>>> I'll take a look at other patches later today, no need to send out new version right now.
>>>
>>>
>> 
>> SIZE_64K is 0x00010000 (65536)
>> 
>> msg len is u16 and max that can be set to msg.len is 65535

Ah, okay. Then it looks about right, maybe it's time to change u16 to u32 in the I2C core.
