Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D3EC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92B22087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9BJzS4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfAaRLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:11:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33476 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfAaRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:11:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so1770494pfb.0;
        Thu, 31 Jan 2019 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RsHTPDHzIpvQpPhcbjNfALgqq+QZ4bcuxaUfCA5XN7s=;
        b=O9BJzS4bEZPZ+6+UkFYbxOLPVS3fV0NMRWNbsNCJtIYrwfdcxU+dvUprdicnGS87GY
         m0g4WopUQmRvbhQKT43BH2BMfICQJJHlteZT4X4Ntse2Fg1rgw5v+mNbhhycHXXqripi
         q1zI4rXtnWPAyVBRk3+etoLock/PMS2EJDtAyFmqTrnsrmCCV0SuIxmF4EJnvh9zu+tO
         cwxpIyKtjB74sag8msD1D+eM2KjkKyA7haNuRRzCS0YeKdvgZB57J1OOyDEkCqz7Y1Ot
         VQQ4Y+R1m5rFeC/1dVQBZYa5a1eiGQrFSBsq0dnpF9Asiftxz0dJlNudewooFloXXA5l
         U+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RsHTPDHzIpvQpPhcbjNfALgqq+QZ4bcuxaUfCA5XN7s=;
        b=CK4Ve+4vwFvAw6QjutDZFi8ldDZVy2eeOuelODiaWF9wt+bDBG+b/GR4RHafHG8jog
         RoCd5TLXyL05/5DdhEgS7ulFrQQCDJtQytR+7Zsov2lNn6Avtx2gb82DUOsNJcDt8afu
         3NTOYod1QvDYu+/3wGYD9ansJw9cW3S51KIyPq3N7HCKmZBfXrlJb/LlSB+G3fkIqrem
         iotBne4AJ+YHVyqpEINXmwnDM2wC+7CiCb029ksvsarhKTbFpysZwMIFCbrVsINsA/nE
         US1IHDDHvgV90Sx8PoCAP6VYrRVWg5EdCCUv52D1GaUuY+/CeFe/xPqH28cwJRGiL/n5
         rT9A==
X-Gm-Message-State: AJcUukfNfdOr2heIpRWDreShLIsSKR8oPmbcv7ynuy/JXpytn5qY9wP2
        EcpaKxs51tzfUTOqTlvrCg9lLG/1
X-Google-Smtp-Source: ALg8bN6JVLrW0qGY7o3MfnEuCYW5ayhRCKzpA6v+DwtjMFCKTT5TDgocXDilhIo4hXSJr3ULIYXX4Q==
X-Received: by 2002:a62:5301:: with SMTP id h1mr35304971pfb.17.1548954698521;
        Thu, 31 Jan 2019 09:11:38 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t67sm8048768pfd.90.2019.01.31.09.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:11:37 -0800 (PST)
Subject: Re: [PATCH V8 3/5] i2c: tegra: Add DMA Support
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e50a353c-94c4-1a47-92a4-5f41f4f64aa7@gmail.com>
Date:   Thu, 31 Jan 2019 20:11:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398CFEE7E912513AE48DD2FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 19:56, Sowjanya Komatineni пишет:
> 
>>>>  drivers/i2c/busses/Kconfig     |   2 +-
>>>>  drivers/i2c/busses/i2c-tegra.c | 362 
>>>> ++++++++++++++++++++++++++++++++++++++---
>>>>  2 files changed, 339 insertions(+), 25 deletions(-)
>>>
>>> Tegra20 crashes because of this patch:
>>>
>> [snip]
>>> <4>[    3.395915] ------------[ cut here ]------------
>>> <2>[    3.395919] kernel BUG at drivers/i2c/busses/i2c-tegra.c:810!
>> The BUG line is from:
>>
>> 	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
>> 		if (i2c_dev->is_curr_dma_xfer)
>> 			i2c_dev->msg_buf_remaining = 0;
>> 		BUG_ON(i2c_dev->msg_buf_remaining);
>> 		complete(&i2c_dev->msg_complete);
>> 	}
>>
> BUG_ON line is not part of this change. It was already there in existing driver.
> Based on log, I see DMA transfer is done for 224 bytes followed by 1 successful PIO transfer and then on next PIO transfer it received packet xfer complete interrupt with incomplete transfer bytes and that where it hit BUG_ON condition.
> 
> 

Yes, that BUG_ON is caused by the DMA transferring. Everything works fine be setting dma=false in the code, hence it's likely not a bug in the code (at least for now it looks fine), but likely that HW is not programmed correctly.
