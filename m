Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3943AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFC521872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZ8B2Res"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfBAUbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:31:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36824 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBAUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:31:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so6049029lfg.3;
        Fri, 01 Feb 2019 12:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XjhtzoOPedDFeDtdSWEzfy5eZw1HSQ76VFYLdhgRR3M=;
        b=qZ8B2ResY0rTP3f/9jfkk3wauFM7UzHi6tGlBAY9wEoE/PYpt7kFQJW9hZUh8Q6jDL
         3eVMkrqgJPQxx/AMj6vxnOcGUec6LXKyPGPCpIXNqHw0yg7bJwd9Z4yYfTqsJbwW3+X4
         9sz/wcZG9fahGCUPtxR8UnB1MvOjYjN4o72yGvC9Yet0wQcgFXvR0eVcDQPB1OBLpHeK
         nHmKL5ytK5UbyVC7vVby54N47e4K1XDMooDe87KzHuXJ2lEG/zwQHMcebxX+nmHEhLtm
         Yatzyhe/0Jo5K5yqqHKZAGAjkzrziJ606CD/WT46jaFLwT2Vy6tOwQH0f30py2zCMxzO
         HQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XjhtzoOPedDFeDtdSWEzfy5eZw1HSQ76VFYLdhgRR3M=;
        b=rQYB9Yemj6MFOgc2W9VcpOKwQr+tG67B3wh4OOFN3ez+rkvh5PuD3v4frxEyxBvSA8
         3zsfMR1g5OtGv17H3wTdELZ7w/jH1NeCh01+uIZaPYHKxBDdtWOJeAkYf0aDAK1c8unu
         Z6Qv+erXlOl7DfpruLrDHuOSXp7R4l0tWlCLOiCKzflnLjpUrj47DqEP6w3jpW6QFmFl
         zb5Z387gOgZJ9QSixfu8LymoQJdMDTD/N7cyLK+x9pOGkacEyPgYY99CNJrjY7xa0cPR
         2gfR6UOWbF8pGgVBUeA4B/363FiW6W7Nero6pCuxWjYFhOijLS48qLCrKTRM5czPxGJ7
         +z/A==
X-Gm-Message-State: AHQUAuahNDWNRpwun2zP6YQngxWbWHzcK5srBlhGTPxoz0G32qMW205s
        jyxYFESn5XHtX45Slx+QnNh7O3TA
X-Google-Smtp-Source: AHgI3IbHzFQ1CeFu8laERB/8RfG2PcZQRaVc2itdGlH4ZGsdrjplDE0nN4kXOP3nZRet6+hDlsZ9Bg==
X-Received: by 2002:ac2:55b3:: with SMTP id y19mr4887303lfg.28.1549053058026;
        Fri, 01 Feb 2019 12:30:58 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id f16-v6sm1469062lji.88.2019.02.01.12.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 12:30:57 -0800 (PST)
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
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
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
 <BYAPR12MB339865C0876E1BF7278DC7C8C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f0c4cc1b-4e3d-3956-7ac4-de35073fbf94@gmail.com>
Date:   Fri, 1 Feb 2019 23:30:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339865C0876E1BF7278DC7C8C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 23:21, Sowjanya Komatineni пишет:
> 
>> 	rx_chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
>> 	if (IS_ERR(rx_chan))
>> 		return PTR_ERR(rx_chan);
>>
>>
>>> +
>>> +	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
>>> +	if (IS_ERR(dma_chan)) {
>>> +		err = PTR_ERR(dma_chan);
>>> +		goto error;
>>
>> It's a good practice to release resources in opposite order to the allocation. Hence better to write this as:
>>
>> 		goto err_release_rx;
>>
>>> +	}
>>> +
>>> +	i2c_dev->tx_dma_chan = dma_chan;
>>> +
>>> +	dma_buf = dma_alloc_coherent(i2c_dev->dev,
>>> +				     i2c_dev->dma_buf_size, &dma_phys,
>>> +				     GFP_KERNEL | __GFP_NOWARN);
>>> +
>>> +	if (!dma_buf) {
>>> +		dev_err(i2c_dev->dev, "failed to allocate the DMA buffer\n");
>>> +		err = -ENOMEM;
>>> +		goto error;
>>
>> 		goto err_release_tx;
>>
>>> +	}
>>> +
>>> +	i2c_dev->dma_buf = dma_buf;
>>> +	i2c_dev->dma_phys = dma_phys;	

	i2c_dev->rx_dma_chan = rx_chan;
>> 	i2c_dev->tx_dma_chan = tx_chan;
>>
>>> +	return 0;
>>> +
>>> +error:
>>> +	if (i2c_dev->tx_dma_chan)
>>> +		dma_release_channel(i2c_dev->tx_dma_chan);
>>> +
>>> +	if (i2c_dev->rx_dma_chan)
>>> +		dma_release_channel(i2c_dev->rx_dma_chan);
>>
>> error_release_tx:
>> 	dma_release_channel(tx_chan);
>> error_release_rx:
>> 	dma_release_channel(rx_chan);
>>
>>> +
>>> +	return err;
> 
> I am releasing resources in reverse order to allocation.
> Trying for rx allocation followed by tx allocation
> During release releasing tx and then rx.
> In case if tx allocation fails, doesn’t go thru release. If rx or buf allocation fails, releases tx first and then rx
> 


Okay. Anyway it's a good-n-common practice to write it in the way I'm suggesting.

And please set rx_chan and tx_chan after dma_buf allocation as I'm suggesting because you current variant will crash kernel since if dma_buf allocation fails, both rx and tx channels will be released and you're not setting them to NULL in that case.
