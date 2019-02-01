Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90342C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D67921872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INmzdSXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfBATmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:42:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32776 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfBATmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:42:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so6839931ljd.0;
        Fri, 01 Feb 2019 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nVvGqsY4ZDMc+Tssvbjo7lDpwmgLo0xJ9yijay/MMoc=;
        b=INmzdSXuDXiJ5aWdgeNzQTXBaBXx4rUwODwtKgM8gksXmFMSCwaQynnBawrn9sES96
         YczIxevzOH+umHLUaFhy0+U0t1jaWNB8ccrdom8nWEhOJ+7TH6F7xtlLb/zP2lgWYsUW
         euOAImuHHHpR1oNm8ugtgCaYri7H1Wa2jiik11bc4EPpxAhv1m5XU8gcpecliQKKXCOZ
         ZZOfUq3bXR9f4Az7g755AbxymC3Fn2re5ufxnZqbhIpnulJemPUlNOF+UMznw2oyGmoU
         Weog8YJXLN+XOk4gwvg55yzfi5J816QuqAZV+sw1HzteftPuhaxWsCnEcy5E2Ikxt4qv
         yQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nVvGqsY4ZDMc+Tssvbjo7lDpwmgLo0xJ9yijay/MMoc=;
        b=XEono4ziDrB4xKeUaV9ElidZgHJ1gAaAI2PrfovbpkRJ9x1ouVaYV8+RGerI1471jv
         aEjR1HS6eaN8m1UhpSOuMkNnzit6qAL0tcHERFkOY+ZJfdxLZFH0CfBa2IkvEwAo8rJo
         Yrz922dIpChnnCXNWRafe40fWOGNe5yzQ01+HVH6RVZoJaksz1n2nUVfY2x8sYtIeKNC
         4E6Zpiq9lolaGZQE+uYirVrnhLAz5/3Jnk8m11u/EmSCR9VlDR7rFF2YRgPL1mrae3aV
         GqnUN2FrS3Iku0dNiYzO7Q5hSslFGCGrkFAjCQjaWEa3zWW9XvW9Q2Vq71aXgG5qhr9o
         EzrA==
X-Gm-Message-State: AJcUukexajX4ZpXx9RdwYMFGZUC10qkwcfPxbOE61SJzc6v/L/21F/YM
        vOKDlwMyb292Om8e0tGY5wuWbXFL
X-Google-Smtp-Source: ALg8bN5bKZmIOwM4h+E8oMBP9enbKQ1ltniXHmArgZPvb2LW7s0JVQa4/u/kHLMsbmXq75lBlIpRrA==
X-Received: by 2002:a2e:8e8e:: with SMTP id z14-v6mr29014430ljk.84.1549050122834;
        Fri, 01 Feb 2019 11:42:02 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t19-v6sm1434603lje.23.2019.02.01.11.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:42:02 -0800 (PST)
Subject: Re: [PATCH V9 4/5] i2c: tegra: update transfer timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-4-git-send-email-skomatineni@nvidia.com>
 <53b3f00f-b3a8-e1ef-b04b-1bdd5f5473ce@gmail.com>
 <BYAPR12MB3398D89D631E65C484DC8267C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1f0a6315-8e38-236a-c16c-0b8699bba1b5@gmail.com>
Date:   Fri, 1 Feb 2019 22:41:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398D89D631E65C484DC8267C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 22:37, Sowjanya Komatineni пишет:
> 
>>> BYTES_PER_FIFO_WORD 4
>>>  
>>>  #define I2C_CNFG				0x000
>>> @@ -893,8 +892,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
>>>  		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
>>>  		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
>>>  
>>> -		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
>>> -							TEGRA_I2C_TIMEOUT);
>>> +		time_left = wait_for_completion_timeout(
>>> +						&i2c_dev->msg_complete,
>>> +						msecs_to_jiffies(1000));
>>
>> So potentially tegra_i2c_xfer_msg() could take more than 1 second and then fail with -EAGAIN, correct? In that case we should set adapter.timeout in probe to a larger value:
>>
> Bus clear pulse threshold we are setting is 9 (default as per spec) so bus clear should happen after finishing sending of 9 pulses.
> So 1sec is very long time for bus to get released and in case of ARB LOST whole transfer to return EAGAIN will be much less then 1sec

Okay, thank you very much for the clarification. What about to set the timeout to a shorter value then? Maybe 10ms.
