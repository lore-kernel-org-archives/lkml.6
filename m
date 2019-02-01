Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1662C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E70A20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llD3h1i/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfBAVpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:45:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34861 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAVpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:45:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so7092230ljb.2;
        Fri, 01 Feb 2019 13:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cci4jnYoPV5crbSBOQGylkkEZu9NWokyzJOL9Ze715U=;
        b=llD3h1i/P+Wqnw8NvGkLuR0QQgoLPe2Ja9vyu12JJfMSTkF4ZsbJsZCzqiV0UfE13y
         aCJyAymiXL5arwVlpzCiQJh4Sbj3YIT00czY2F1LlrPFf3AA4sBgq2ZFtMQpjulR+ReX
         FWDH9S9Vtrmw4w2quHAUf5xMDivzlBaXuNuDNYMSUXOkFURswilK7yxeXo0XZ9mOpMhD
         yjNAN9lYYsQwfVYbJYLLu96Yy5vna52vd2ipTNukaIKVG1h84oA4ugFO7lVQJ5LyTw9u
         ubnL4KdYRV58ZCWX1qBAOz8bksNr8cck/PxMYblBTLK+y1YY7QuLrvwHc8hBOc4sZ/lZ
         B4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cci4jnYoPV5crbSBOQGylkkEZu9NWokyzJOL9Ze715U=;
        b=IyHbhoPc21yPuC2s1XVFji8mg8ZuOstHI1M9ttrnt6j0NwAjX8T+ixwmOZkSOs7RFM
         BBftxPPNpHawDrq+PFA/kw6wSa2tB+VYmkB1KKdH+vbJwZAaJuLcIfvvXhmb5L5Ma+eS
         fmXQXVvYySbEZAKGjrojGpE2WXnABZvgHeDVhKUqCooVslV3wSrdkV8qa2LAluAZQDO0
         /WMzlQiJLwY40ZBb8Znp4xDY/9/seSpVXzZozmlI7NYJf56l8EikhKybXX1Q5sWYkPQg
         Wrh5uJdzhfNrx+y6Wrfj8DG4mdUr2bGcGMBEfsIrfIGUXq21UMnIZcAWPgJrPRqBD+ez
         0Shg==
X-Gm-Message-State: AHQUAuZWpmKcH4RGPJ82ojjs96kt1tQOTIZ8mR3SV5aTX3sDtOAGwMu9
        moEkvwqOE3PnwDUX1+U4h9IkF9O4
X-Google-Smtp-Source: AHgI3IZ5v4dCfvk0Oewj+hZQv7WoqjcZEzSU+iIanjxu9k+fT4DMOW8EUbiVyWTO2ODvY68UaoyCXA==
X-Received: by 2002:a2e:7f04:: with SMTP id a4-v6mr11359712ljd.156.1549057551168;
        Fri, 01 Feb 2019 13:45:51 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id g11sm737101lfg.31.2019.02.01.13.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 13:45:50 -0800 (PST)
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
 <f0c4cc1b-4e3d-3956-7ac4-de35073fbf94@gmail.com>
 <BYAPR12MB339835E59C2D4DCDFC93BEF4C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3490a279-3584-161b-cbd4-c7ef2b5288e1@gmail.com>
Date:   Sat, 2 Feb 2019 00:45:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339835E59C2D4DCDFC93BEF4C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.02.2019 0:36, Sowjanya Komatineni пишет:
> 
>>>
>>>> 	rx_chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
>>>> 	if (IS_ERR(rx_chan))
>>>> 		return PTR_ERR(rx_chan); 
>>>>
>>>>
>>>>> +
>>>>> +	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
>>>>> +	if (IS_ERR(dma_chan)) {
>>>>> +		err = PTR_ERR(dma_chan);
>>>>> +		goto error;
>>>>
>>>> It's a good practice to release resources in opposite order to the allocation. Hence better to write this as:
>>>>
>>>> 		goto err_release_rx;
>>>>
>>>>> +	}
>>>>> +
>>>>> +	i2c_dev->tx_dma_chan = dma_chan;
>>>>> +
>>>>> +	dma_buf = dma_alloc_coherent(i2c_dev->dev,
>>>>> +				     i2c_dev->dma_buf_size, &dma_phys,
>>>>> +				     GFP_KERNEL | __GFP_NOWARN);
>>>>> +
>>>>> +	if (!dma_buf) {
>>>>> +		dev_err(i2c_dev->dev, "failed to allocate the DMA buffer\n");
>>>>> +		err = -ENOMEM;
>>>>> +		goto error;
>>>>
>>>> 		goto err_release_tx;
>>>>
>>>>> +	}
>>>>> +
>>>>> +	i2c_dev->dma_buf = dma_buf;
>>>>> +	i2c_dev->dma_phys = dma_phys;	
>>
>> 	i2c_dev->rx_dma_chan = rx_chan;
>>>> 	i2c_dev->tx_dma_chan = tx_chan;
>>>>
>>>>> +	return 0;
>>>>> +
>>>>> +error:
>>>>> +	if (i2c_dev->tx_dma_chan)
>>>>> +		dma_release_channel(i2c_dev->tx_dma_chan);
>>>>> +
>>>>> +	if (i2c_dev->rx_dma_chan)
>>>>> +		dma_release_channel(i2c_dev->rx_dma_chan); 
>>>>
>>>> error_release_tx:
>>>> 	dma_release_channel(tx_chan);
>>>> error_release_rx:
>>>> 	dma_release_channel(rx_chan);
>>>>
>>>>> +
>>>>> +	return err;
>>>
>>> I am releasing resources in reverse order to allocation.
>>> Trying for rx allocation followed by tx allocation During release 
>>> releasing tx and then rx.
>>> In case if tx allocation fails, doesn’t go thru release. If rx or buf 
>>> allocation fails, releases tx first and then rx
>>>
>>
>>
>> Okay. Anyway it's a good-n-common practice to write it in the way I'm suggesting.
>>
>> And please set rx_chan and tx_chan after dma_buf allocation as I'm suggesting because you current variant will crash kernel since if dma_buf allocation fails, both rx and tx channels will be released and you're not setting them to NULL in that case.
> 
> OK, my wrong assumption. Thought dma_release_channel will NULL chan after its freed
> Will update and send V10
> 

There is no need to rush, you may wait at least for the testing feedback for now. Also maybe Thierry or somebody else will have something to say as well.
