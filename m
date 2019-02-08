Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C197CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D852146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3RqK18L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfBHPoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:44:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35900 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbfBHPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:44:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id q11so2877461lfd.3;
        Fri, 08 Feb 2019 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uoHhKvSHrKUsk0auK2XUV6mGGwxaoQWRjZBIYdWMHjo=;
        b=h3RqK18LWdeFfpqh/00+JwmD2oE6d1C6+zy3rM17oBJa2ySXdQR2aAK1VTcl3KtuAA
         vzne71Lq2ZyaAmjcXsogJ/4C6UzcvRG8udJXMM9+2HqPJdRalxbhJpcXgUivlyr5mmN+
         urfuxde8ZQbApDPVPhDK6bsqEPwGc0hoPmUVAX6bHoXmTi7NHz+YqOnUhyFW4kaoiCh7
         hSaQMVksqQ+DPVx3D7KCJCqRlhhFcT16a2vMuFGvt5Bz2RwC8ml9yWgZS8Qq4UoIhKFu
         AfaEkdwNl9N36gyxX+AZk2KSW7xmNz6Zj/8r37o+qpGsfM2BR59gmUVB56MDH0XpOE3u
         5CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uoHhKvSHrKUsk0auK2XUV6mGGwxaoQWRjZBIYdWMHjo=;
        b=MA9JEtC+F+WsSSsRtYX7FBo10PvnZofQtKTft3cEFygDnXR/E1HXDVCM4MA4F6XdD8
         J/en7fHtStAcApr+4vGbBjOduf2e0u1NZkV4qrkQYQM6/KoU2WJ1g03oVAH24VBPLFFA
         nBDon5g10Vcdb6w2kE5sYz6fxuSpaoiWEXBV/RfVnwDV7c8IhDoUS0MBAiouhzXHAiY1
         CmukEryx2mshmE7US+tsGfpxG8VlWGCBQ4q/SY5XhAq3GMO8dF/Mfte5YWUlECprP4gw
         fd57DDNXJiN3he39pkC8qF84jFPfUBhz0hXe+fMjDu0n4ULz+fhg1u8uZ0QeUGH9xZMN
         9IjA==
X-Gm-Message-State: AHQUAuYsq7pXoTR4YhbwqJjKDWqzatmkuxfDL0lLauD4OKJGaHfH90UB
        nb8g/48NpGB5sKJOveuq1ykwPl9s
X-Google-Smtp-Source: AHgI3IYJcaYApEaDg/5vV6joPGZCrfavaQo14DR/FXHFC6/N0cC73zmzvNRLn8OYOcA1HV4Epzwp1Q==
X-Received: by 2002:a19:f80d:: with SMTP id a13mr2028029lff.148.1549640659226;
        Fri, 08 Feb 2019 07:44:19 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id h22-v6sm506231lji.45.2019.02.08.07.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 07:44:18 -0800 (PST)
Subject: Re: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Peter Rosin <peda@axentia.se>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-3-git-send-email-skomatineni@nvidia.com>
 <1202cc91-cacf-673e-c32b-b4d1c78b71f2@gmail.com>
 <515cb722-c345-8dd6-dbe5-557dec0d1384@gmail.com>
 <a57f0374-8468-f24a-1743-b446b8260a46@gmail.com>
 <9e8f26bb-2159-6ca4-783e-91a73dac0823@axentia.se>
 <96a3955f-ef4f-e4df-4907-6ec760fad3fe@gmail.com>
 <BYAPR12MB339837F9232FBB0767869564C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9fedf186-0522-d40f-3d8d-88d0462da0b1@gmail.com>
Date:   Fri, 8 Feb 2019 18:44:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339837F9232FBB0767869564C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 18:25, Sowjanya Komatineni пишет:
>> 08.02.2019 17:12, Peter Rosin пишет:
>>> On 2019-02-08 13:46, Dmitry Osipenko wrote:
>>>> 08.02.2019 1:25, Dmitry Osipenko пишет:
>>>>>> 08.02.2019 1:16, Sowjanya Komatineni пишет:>
>>>>>>>> This is wrong, 65535 = 64 * 1024 - 1.
>>>>>>>>
>>>>>>>> Let's just use size-constants provided by kernel:
>>>>>>>>
>>>>>>>> static const struct i2c_adapter_quirks tegra_i2c_quirks = {
>>>>>>>> 	.flags = I2C_AQ_NO_ZERO_LEN,
>>>>>>>> 	.max_read_len = SZ_4K,
>>>>>>>> 	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE, };
>>>>>>>>
>>>>>>>> static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
>>>>>>>> 	.flags = I2C_AQ_NO_ZERO_LEN,
>>>>>>>> 	.max_read_len = SZ_64K,
>>>>>>>> 	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE, };
>>>>>>>>
>>>>>>>>
>>>>>>>> I'll take a look at other patches later today, no need to send out new version right now.
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> SIZE_64K is 0x00010000 (65536)
>>>>>>>
>>>>>>> msg len is u16 and max that can be set to msg.len is 65535
>>>>>
>>>>> Ah, okay. Then it looks about right, maybe it's time to change u16 to u32 in the I2C core.
>>>>>
>>>>
>>>> Here is my suggestion:
>>>>
>>>> 1) Use SZ_4K / SZ_64K that I suggested above.
>>>>
>>>> 2) Squash this patch into the DMA-patch.
>>>>
>>>> 3) Add another patch (before the DMA-patch) that changes 
>>>> max_read_len/max_write_len types to u32 in the include/linux/i2c.h
>>>
>>> That is a bit naive and will not fly since the I2C core has a max 
>>> message size of 65535. Which is exposed to user space...
>>>
>>> Given the above, saying .max_read_len = 65535 a NOP (and is in fact 
>>> omitted in places where it would be needed if the type is changed). I 
>>> suggest that it is omitted here as well. But SZ_64K - 
>>> I2C_PACKET_HEADER_SIZE is still needed of course. At least if 
>>> I2C_PACKET_HEADER_SIZE is guaranteed to be non-zero?
>>
>> Ah, I missed that message len is also u16 and then we indeed could just drop the "max_read_len" for T194. Thank you Peter.
>>
>> Sowjanya, given the above, it probably better to define dma_buf max-size in the tegra_i2c_hw_feature.
>>
> 
> I2C_PACKET_HEADER_SIZE is always fixed 12. So in that case, we can just add max_write_len 
> If no max_read_len, max will be 65535 anyway right
> 
> static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
> 	.flags = I2C_AQ_NO_ZERO_LEN,
> 	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE, };

Yes, adding header size to the max_write_len for the dma_buf size also will be fine.
