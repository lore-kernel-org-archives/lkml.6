Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC7FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2547218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx5K7w83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfBKNWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:22:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43378 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfBKNWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:22:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id o1-v6so2875652ljc.10;
        Mon, 11 Feb 2019 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MvHNTL3mkxm95o6n2taJNzImGRVEYHWdgif7muYEhsA=;
        b=Gx5K7w831rYdlGp1Q0v/i7c1Oa3SzPitUEXbyx93GVOXf3hzpWeyEalwWGQrHvTae/
         42seutZxmcstxwq54Sea3ng8SbA/pMaTIKGHowBe6BdWeebrCl3VusowccS5NeGvEucl
         bw0aTlGSEa8YfnTmYbFFllctppXjdXl3uYujCCqHdriJ5ZGD0qJRqqrVfqv01d71ypkg
         w3i6JMh+PBh4mbDhZKnvMpvnHdoVjnGUCDHSaSuyQYtZmAH041nMoHGklhbK5BAz9kf0
         No5tA2Wjfzrjeasvud46bfoq8A9D46pogv7bUqAfls78s5WJtmvA09gMqax4T9rer/Gk
         hqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MvHNTL3mkxm95o6n2taJNzImGRVEYHWdgif7muYEhsA=;
        b=JcJuR9aInO6vBuEE+iUJV1cnYrryoRvrFcv6mIc6ohWXBCPELRaA7qeXlHueLnm1tT
         HPCUJqqZ+gWys3BqC6+MfhbDp6F71t/nG2a5iO2VIfz+HpG1lNTrbfp2ain8oAcgyKfS
         ihkobBrLxtHKcHgsIcJq/IROTRwMG5rAlYX2A4tIPuKHxK2sxaQogivgUZy3mo9UjMTI
         p9wmGnxQS+CXpGWOlFbRpJkWvJw8lk/kQRZ27PoGfoRtQQGRNSF85hwqKuQsKXgTvFNC
         W2+qvx2rwX+kdjyso0HB0sWvu8r3zuJPYhQlr7QAuxCLRttzycXINvbf+Iz3sNP4aSsS
         l8rw==
X-Gm-Message-State: AHQUAuYXPUklMjVg7h3tiZlJrB5iPPpsRhlBIyh2DIllbQMhPYFGRCBh
        N0+EoIhN/va3Xm9Dr/j+PoyPTX7s
X-Google-Smtp-Source: AHgI3IYJ8dfNJUfrtn5rkCTHi/onGBaj+QyXnInvZMQVZQ768nqKcrwCHZVlgByRTaNQAFEjfEVgxg==
X-Received: by 2002:a2e:3319:: with SMTP id d25-v6mr12106876ljc.187.1549891328120;
        Mon, 11 Feb 2019 05:22:08 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id l124sm2321269lfb.2.2019.02.11.05.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 05:22:07 -0800 (PST)
Subject: Re: [PATCH V18 4/6] i2c: tegra: Add DMA support
To:     Wolfram Sang <wsa@the-dreams.de>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
 <1549652382-5476-4-git-send-email-skomatineni@nvidia.com>
 <20190211125509.tnsgfl3yoobdpnmj@ninjato>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ed92df42-459e-26fd-ce4e-f4530bf30783@gmail.com>
Date:   Mon, 11 Feb 2019 16:22:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211125509.tnsgfl3yoobdpnmj@ninjato>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.02.2019 15:55, Wolfram Sang пишет:
> On Fri, Feb 08, 2019 at 10:59:40AM -0800, Sowjanya Komatineni wrote:
>> This patch adds DMA support for Tegra I2C.
>>
>> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
>> transfer size of the max FIFO depth and DMA mode is used for
>> transfer size higher than max FIFO depth to save CPU overhead.
>>
>> PIO mode needs full intervention of CPU to fill or empty FIFO's
>> and also need to service multiple data requests interrupt for the
>> same transaction. This adds delay between data bytes of the same
>> transfer when CPU is fully loaded and some slave devices has
>> internal timeout for no bus activity and stops transaction to
>> avoid bus hang. DMA mode is helpful in such cases.
>>
>> DMA mode is also helpful for Large transfers during downloading or
>> uploading FW over I2C to some external devices.
>>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> 
> I am not sure if you are aware of this document, so I mention it:
> 
> Documentation/i2c/DMA-considerations
> 
> I am not pushing you to use the i2c_get_dma_safe_msg_buf() helpers, just
> wanted to make sure you know about them. I am also fine with an
> incremental patch on top of this if you want to add usage of those
> helpers somewhen later.

At least I was not aware of those helpers. It looks to me that the approach of having a statically allocated buffer is more optimal than having to allocate and map the buffer on each transfer. 

> That all being said, I'd accept the patch as is, except for:
> 
>> +static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
>> +	.has_continue_xfer_support = true,
>> +	.has_per_pkt_xfer_complete_irq = true,
>> +	.has_single_clk_source = true,
>> +	.clk_divisor_hs_mode = 1,
>> +	.clk_divisor_std_fast_mode = 0x19,
>> +	.clk_divisor_fast_plus_mode = 0x10,
>> +	.has_config_load_reg = true,
>> +	.has_multi_master_mode = true,
>> +	.has_slcg_override_reg = true,
>> +	.has_mst_fifo = true,
>> +	.quirks = &tegra_i2c_quirks,
>> +	.supports_bus_clear = true,
>> +	.has_apb_dma = false,
>>  };
>>  
>>  /* Match table for of_platform binding */
>>  static const struct of_device_id tegra_i2c_of_match[] = {
>>  	{ .compatible = "nvidia,tegra194-i2c", .data = &tegra194_i2c_hw, },
>> +	{ .compatible = "nvidia,tegra186-i2c", .data = &tegra186_i2c_hw, },
>>  	{ .compatible = "nvidia,tegra210-i2c", .data = &tegra210_i2c_hw, },
>>  	{ .compatible = "nvidia,tegra124-i2c", .data = &tegra124_i2c_hw, },
>>  	{ .compatible = "nvidia,tegra114-i2c", .data = &tegra114_i2c_hw, },
> 
> Shouldn't this be a seperate patch?

I asked for this change and no, it shouldn't be a separate patch as it adds "has_apb_dma = false" property for T186 that older Tegra's have as "true". Without this change T186 uses tegra_i2c_hw_feature of T210, see [0]. Hence this change is absolutely correct and appropriate for this patch.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/nvidia/tegra186.dtsi?#n138

>> -static int __init tegra_i2c_init_driver(void)
>> -{
>> -	return platform_driver_register(&tegra_i2c_driver);
>> -}
>> -
>> -static void __exit tegra_i2c_exit_driver(void)
>> -{
>> -	platform_driver_unregister(&tegra_i2c_driver);
>> -}
>> -
>> -subsys_initcall(tegra_i2c_init_driver);
>> -module_exit(tegra_i2c_exit_driver);
>> +module_platform_driver(tegra_i2c_driver);
> 
> This should definately be a seperate patch. While I am all for taking
> it, are you sure it does not regress on older Tegra platforms?
> 

All the patches are tested on older Tegra's (T20/T30 specifically by me) and we fixed several bugs that were regressing them over the few versions of the patchset. I specifically asked for this change for older Tegra's because the APBDMA driver (T20-T210) is getting registered from the module-init level and hence I2C driver probe is always getting deferred. I'm not sure that it's worth to factor out this hunk into a separate patch as it's directly related to the DMA support addition, maybe worth to mention why this is needed in the commit message.
