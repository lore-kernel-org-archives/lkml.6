Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A183C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A162086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm3Ulm6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfAaR0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:26:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39739 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfAaR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:26:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so1634413pgp.6;
        Thu, 31 Jan 2019 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vGk1wr7ICvriZT5ahnG4mao19lhk37zlfNSNhhsBdW0=;
        b=Dm3Ulm6JnWpLocBcaaWGJ7o234bIQODlgTAzL9m2g3lavbUxYT9/CJWawO4oBQ5NPR
         OOSfCS76GlINLHcAYP9ebjyZch19YhUwJY3xYykBVFAXWleEl6NeWOi+Y9AR6NBMA3qK
         OAACLBhMYH0U6mShAOzD6C0l1zVl99Dj7aa3QDnm2BuVHj2ba7NxKPksTBad50X4TnOT
         IC0at8r5L90ZaRzmbS0Vc/ntGZxz1Bb1OvJoqcfpok815yR92MAOfXIJdXngt8aqpZEm
         +U738IBAqnnHGDZvztRjYzASk9NCfeWF8nVTN6Pi4obEeYbcDADNTOFUSQbxe1xjosjK
         d1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vGk1wr7ICvriZT5ahnG4mao19lhk37zlfNSNhhsBdW0=;
        b=bgqxc2jfqy+g8byY5WvPWr5mbp4GVxXOA6YmLqTkHLzcOPpCX/XZrBctjY/n8SmzZy
         rNup6lV6kgG3ldEBgR+i8Vtz6HvfK6TbGEnCRpA8sr0sC7cQX6kU870IbiJdVswZ39dd
         nMIeK7VP3ZadUOnrFZVhHB7F9BFGVF+MRJGqyXlyO2rxaX/yuMs3YmYCgYNJrqf8MQg3
         BtueMyMv3Mbd9+N1rlNmJ1Kr/u0BtMOb4FnVOaCC6UnvEq5HqFALCSTrvT45PHpyX5lt
         nba9dqyTArJ3/SH7Z2wAn7SC0TQZtYTKMuhmdf13Td049WorvWI3CayUVknq21a0565H
         oAdw==
X-Gm-Message-State: AJcUukfAalNc5oLgJ+Vp91w7fAH8Il/Flqzkp8CBDktB4c69kmiEqw6K
        uoeJggUQjNc/VdhhuxFfVeHPUYqY
X-Google-Smtp-Source: ALg8bN7KSBDuDPzcjGWtrh+swoF2J0ktm+oyealvImteVJqmHvng87u2/FxU7H9OjansTcDl0nx6Iw==
X-Received: by 2002:a63:193:: with SMTP id 141mr32481829pgb.136.1548955563118;
        Thu, 31 Jan 2019 09:26:03 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id o189sm7961197pfg.117.2019.01.31.09.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:26:02 -0800 (PST)
Subject: Re: [PATCH V8 3/5] i2c: tegra: Add DMA Support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
 <4663c7b9-d306-1cd4-1bdc-f7be84af0667@gmail.com>
 <8a88f8ee-24d3-00ac-f1fa-c43b576ed82c@gmail.com>
 <BYAPR12MB3398CFEE7E912513AE48DD2FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
 <e50a353c-94c4-1a47-92a4-5f41f4f64aa7@gmail.com>
Message-ID: <c2676c08-83d7-2ac9-ce34-c7c7f86d798e@gmail.com>
Date:   Thu, 31 Jan 2019 20:25:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e50a353c-94c4-1a47-92a4-5f41f4f64aa7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 20:11, Dmitry Osipenko пишет:
> 31.01.2019 19:56, Sowjanya Komatineni пишет:
>>
>>>>>  drivers/i2c/busses/Kconfig     |   2 +-
>>>>>  drivers/i2c/busses/i2c-tegra.c | 362 
>>>>> ++++++++++++++++++++++++++++++++++++++---
>>>>>  2 files changed, 339 insertions(+), 25 deletions(-)
>>>>
>>>> Tegra20 crashes because of this patch:
>>>>
>>> [snip]
>>>> <4>[    3.395915] ------------[ cut here ]------------
>>>> <2>[    3.395919] kernel BUG at drivers/i2c/busses/i2c-tegra.c:810!
>>> The BUG line is from:
>>>
>>> 	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
>>> 		if (i2c_dev->is_curr_dma_xfer)
>>> 			i2c_dev->msg_buf_remaining = 0;
>>> 		BUG_ON(i2c_dev->msg_buf_remaining);
>>> 		complete(&i2c_dev->msg_complete);
>>> 	}
>>>
>> BUG_ON line is not part of this change. It was already there in existing driver.
>> Based on log, I see DMA transfer is done for 224 bytes followed by 1 successful PIO transfer and then on next PIO transfer it received packet xfer complete interrupt with incomplete transfer bytes and that where it hit BUG_ON condition.
>>
>>
> 
> Yes, that BUG_ON is caused by the DMA transferring. Everything works fine be setting dma=false in the code, hence it's likely not a bug in the code (at least for now it looks fine), but likely that HW is not programmed correctly.
> 

It works with this change:

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index fe5b89abc576..8e059e94b94e 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1170,10 +1170,11 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
                time_left, completion_done(&i2c_dev->msg_complete),
                i2c_dev->msg_err);
 
+       tegra_i2c_init(i2c_dev, true);
+
        if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
                return 0;
 
-       tegra_i2c_init(i2c_dev, true);
        /* start recovery upon arbitration loss in single master mode */
        if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
                if (!i2c_dev->is_multimaster_mode)


Which means that HW state is kept dirty after DMA transfer. Please check everything carefully.
