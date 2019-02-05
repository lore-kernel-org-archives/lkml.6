Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095C8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211320844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McHa94gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfBEQy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:54:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37827 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbfBEQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:54:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so1625170pgb.4;
        Tue, 05 Feb 2019 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GHrO8T2WsqTF84LE5VYuII2AGlis8srs2qEo1PxPLUg=;
        b=McHa94gwyrN13yImDSL4jrAkGZu2XTGhsQj9yYqkrfPW60sTXQEAphY/ItZ3Dss8IF
         dumHJiIwGqUXf31wwBFavse89LvDTMuyJct65xo4CRTvvbTgLCyHdoe3vc9uMBQ9+iVj
         s2WC6sDZevyXu8ikig33jJmyavZaJ1qaNBs2dYTNn1c9IeJRlKnmuXRWHC61zid8tPAK
         a2mvtfGhgcRwFcXktjEO7xsNh1EFp52fVbhPV0rk2NVBvmRj6kcE/BHHtjJNkNPfSaTP
         bGCZNxY4PzrRuqoQK9lQVA3DtB6gWPeuWBOUOPasy2e2JyvovQiUT/53LXawPyuo2FBM
         rUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GHrO8T2WsqTF84LE5VYuII2AGlis8srs2qEo1PxPLUg=;
        b=XZ4LwI5gd2tumIdV08l3chZ6BiA73W9PCG66NslvxIPAeFs+M6uWMkfOaaJoCUa5PG
         2+5n9QjivHRnGz5EKGE527Rj3BLe6aFPd5Gnz1dZmyoavXCPhjxPPvL9j+H3vzbXMhl4
         aOwuBcyC9jncqrkkbza5KyaUSXigmdbPg4W9eJ8BHFjAaLD/mrN08c2PaNNTp7rAw+QZ
         FBn2S3hR9SsjrGuJfhv9lQXwq4ubrRwGjwBnKIg9BOZQVE/lxlz76x1ePopCaTdO8zLE
         3zNY4gMBTeE/ox0AESfG/+h9b3E5UV4jgmU4mkqS020a6Nj5X9OqrnKQfZBTFMqTMSgm
         5Nhg==
X-Gm-Message-State: AHQUAua3XFEutIrYvOOssrKpnT8LGJSun4wbnQXFBHMEGI/5vECg9S8l
        x3dfrCudyq3RumsygW2Txn9iynnj
X-Google-Smtp-Source: AHgI3IY88R9eengpbsodGKzCtZUsbfjTWYtcDMrtKtn8moqXtqWfuHleglz+FVUUyVhwpUr04zl8kg==
X-Received: by 2002:a62:22c9:: with SMTP id p70mr6021961pfj.114.1549385665508;
        Tue, 05 Feb 2019 08:54:25 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 186sm6691767pga.36.2019.02.05.08.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 08:54:24 -0800 (PST)
Subject: Re: [PATCH V11 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
 <1549356985-25726-3-git-send-email-skomatineni@nvidia.com>
 <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com>
 <BYAPR12MB339828E77EB4D67906A5F0AEC26E0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fe894f51-b8fe-cd31-d0dc-feed8fb106cf@gmail.com>
Date:   Tue, 5 Feb 2019 19:54:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339828E77EB4D67906A5F0AEC26E0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2019 19:41, Sowjanya Komatineni пишет:
>> Please use "./scripts/checkpatch.pl --strict *.patch" and fix all its complains, but only those that really make sense. For example ignore the "CHECK: Lines should not end with a '('" warnings. 
>>
>> Here checkpatch recommends to use the BIT() macro:
>>
>> CHECK: Prefer using the BIT macro
>> #394: FILE: drivers/i2c/busses/i2c-tegra.c:136:
>> +#define DATA_DMA_DIR_TX                                (1 << 0)
>>
>> CHECK: Prefer using the BIT macro
>> #395: FILE: drivers/i2c/busses/i2c-tegra.c:137:
>> +#define DATA_DMA_DIR_RX                                (1 << 1)
> 
> I used checkpatch script, and it didn’t showed these errors. Probably checkpatch script versions are different. I am using the one from 5.0-rc4

Please notice the "--strict" flag, it makes checkpatch to report some extra warnings. 

>> +static int tegra_i2c_dma_submit(struct tegra_i2c_dev *i2c_dev, size_t 
>> +len) {
>> +	struct dma_async_tx_descriptor *dma_desc;
>> +	enum dma_transfer_direction dir;
>> +	struct dma_chan *chan;
>> +
>> +	dev_dbg(i2c_dev->dev, "starting DMA for length: %zu\n", len);
>> +	reinit_completion(&i2c_dev->dma_complete);
>> +	dir = i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
>> +	chan = i2c_dev->msg_read ? i2c_dev->rx_dma_chan : i2c_dev->tx_dma_chan;
>> +	dma_desc = dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
>> +					       len, dir, DMA_PREP_INTERRUPT |
>> +					       DMA_CTRL_ACK);
>> +	if (!dma_desc) {
>> +		dev_err(i2c_dev->dev, "failed to get DMA descriptor\n");
>> +		return -EIO;
>>
>> Returning the -EIO is technically incorrect because there is no hardware failure here. The dmaengine_prep_slave_single() merely allocates the DMA descriptor, hence it should be either -EINVAL (preferably) or at least -ENOMEM.
>>
>> Oh, another important moment is that physically contiguous dma_buf allocation isn't guaranteed by the DMA API. This may become a problem for T186+ that can transfer up to 64K. We need to enforce the contiguous-allocation requirement by using > dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) instead of the dma_alloc_coherent(), please see my other comment below.
> 
> Failure returned from dma submit will be returned by i2c xfer message and using EIO here as dmaengine_prep_slave_single can result in multiple failures (invalid segment length,  failing dma desc allocation, dma length/memory check, no available dma sg-reg)
> As per I2C fault codes, EIO can be used indicating when something went wrong during performing IO operation.

Sounds wrong, IO failure means that error comes from hardware. In this case it comes from software.

> Using EINVAL doesn’t suit if failure is from allocation and using ENOMEM doesn’t suit if failure is due to length/memory, segment length check.

-EINVAL is the universal error code, suitable for such cases. We are expecting that dma_desc is not NULL, and it is the invalid value from our perspective if dma_desc is NULL. 

> Will use FORCE_CONTIGUOUS.
> 
> 
> 
>>> +	dma_buf = dma_alloc_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
>>> +				     &dma_phys, GFP_KERNEL | __GFP_NOWARN);
>>
>> Please use dma_alloc_attrs() instead of dma_alloc_coherent() because it could return a sparse allocation. This is especially troublesome > for ARM64 platforms because IOMMU_DOMAIN_DMA is used by default there. We need to explicitly ask for the contiguous allocation:
>>
>>
>> 	dma_buf = dma_alloc_attrs(i2c_dev->dev, i2c_dev->dma_buf_size,
>> 				  &dma_phys, GFP_KERNEL,
>> 				  DMA_ATTR_FORCE_CONTIGUOUS |
>> 				  DMA_ATTR_NO_WARN);
>>
> Will switch to use dma_alloc_attrs with CONTIGUOUS
>>
>>
>>
>>
>> CHECK: multiple assignments should be avoided
>> #763: FILE: drivers/i2c/busses/i2c-tegra.c:993:
>> +               i2c_dev->is_curr_dma_xfer = dma = false
>>
>> CHECK: Unnecessary parentheses around 'i2c_dev->msg_err == I2C_ERR_NONE'
>> #877: FILE: drivers/i2c/busses/i2c-tegra.c:1105:
>> +               if (i2c_dev->msg_read && (i2c_dev->msg_err == 
>> + I2C_ERR_NONE)) {
>> CHECK: Alignment should match open parenthesis
>> #883: FILE: drivers/i2c/busses/i2c-tegra.c:1111:
>>
>>
> Somehow Checkscript didn’t showed this either when I ran. Probably due to diff script versions. I am using the one from 5.0-rc4.
> 

Please use the "--strict" flag for checkpatch, it will show this warning.
