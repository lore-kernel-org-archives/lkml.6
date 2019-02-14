Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6E0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4074C222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDjnHQu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406760AbfBNKwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:52:30 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34429 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387932AbfBNKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:52:29 -0500
Received: by mail-wr1-f49.google.com with SMTP id f14so5975013wrg.1;
        Thu, 14 Feb 2019 02:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8MGEOkp3CKKQ4Y/lKtdp9ntcnCekqC3jqFbG8lyNeDw=;
        b=BDjnHQu85ptFY5yKeuQOCo3cJXhqHvpvIpRt44A67SbAn6Xj+QiqQ/8Fh5hWzRgW4B
         kJIfu0Dnd4mBMJxSWOEzOqGcpkbDFWnm7QyBd9t17Bl2mT7D1RL4S6YAYJAEp4PUujtl
         aoIhrAiDUyn25pV/YldSvVlpEg1UbSFJemILWEFN4JNcA3oco0FLsiEaAaqpH62TDpUe
         qoK1rIAWqplWdVVw82S2zaq7C/Fc7R/cyjnlAVHRlVwBgMx5vVcjlqoUUmSkymPzIVsq
         cz5ckLlZxR6NV/AWDAsYrENew/dinTauA7fIUOPwhViBohXMMT/NGmu7l+xhlAyRIH/t
         SWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8MGEOkp3CKKQ4Y/lKtdp9ntcnCekqC3jqFbG8lyNeDw=;
        b=hHHWMWmXE1PgvV0EITXnfePCkbbUlIeEPpk+2yo7LFUSqF2OUviLRzSCMsEmyW4eXz
         sQ5DQ0Aeu990WwjnXow9qMtS5yiE6qShUQFRQAy5CcWMi92Y2IYw4j/I+L0uv+hS6yuH
         +VPFc1hIy2CqgonE5FoR0OH8CPOaBNE52vRFmLZuKGUFSe4NU0ft3RdL0jYQWaYRvB5M
         oNslxJCrZ3dXlca5JT4K78SVSbpmktdP5xNao1NPaDz2Z/2pENtvkk2k5E+B0C0Barlo
         jvNCjJQFS8ReXHmxf8x2aXbQdcF0eCtMVpBK5t9ZJ+ZM1gyb69438u9svtlOSlkymPHt
         +hug==
X-Gm-Message-State: AHQUAuYYLD+sLbWCPHfkTPyyVP84uwD87jl7S818fPRtlOGmSWQOFSn6
        JTyBStSo9TOc1Scov5eq1AlYphK8
X-Google-Smtp-Source: AHgI3IYWCBEe3dMv1ZO/mxfUdikFGWqOa6ZCkjzEjtLrVZwGyeKhLxYi3XnHbXVQ0THS79+Yiuovtg==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr2445223wrv.251.1550141547144;
        Thu, 14 Feb 2019 02:52:27 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id z16sm1105342wrr.66.2019.02.14.02.52.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:52:26 -0800 (PST)
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
To:     masonccyang@mxic.com.tw, Mark Brown <broonie@kernel.org>
Cc:     bbrezillon@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
 <20190212144359.GD20635@sirena.org.uk> <20190212164940.GI20635@sirena.org.uk>
 <OF9C8DA179.15D69C0A-ON482583A0.00283EB5-482583A0.002E45C8@mxic.com.tw>
 <20190213121635.GD7540@sirena.org.uk>
 <acb7940e-df38-97a7-8500-4825fb0f6604@gmail.com>
 <OF9B3A3A20.C0BF34B8-ON482583A1.002D5F3B-482583A1.00329653@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <0f26ffa5-e517-742f-ebd3-0093eda27145@gmail.com>
Date:   Thu, 14 Feb 2019 11:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <OF9B3A3A20.C0BF34B8-ON482583A1.002D5F3B-482583A1.00329653@mxic.com.tw>
Content-Type: text/plain; charset=big5
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 10:12 AM, masonccyang@mxic.com.tw wrote:
> Hi,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/02/13 ¤U¤È 08:37
>>
>> On 2/13/19 1:16 PM, Mark Brown wrote:
>> > On Wed, Feb 13, 2019 at 04:25:32PM +0800, masonccyang@mxic.com.tw wrote:
>> >
>> >> From current mainline branch, MFD seems support the device which is on
>> >> the same hardware bus(i.e, I2C, SPI, MMIO and SPMI)for multi-function
>> >> by Read/Write the common same registers.
>> >
>> > That's most MFDs but there are some that do some level of enumeration
>> > (even if it's just looking at the device ID that got registered) to
>> > decide what subdevices get registered, that's what people are suggesting
>> > here I think.
>>
>> Right. Although I think some of the code could be shared between the SPI
>> and HF modes.
> 
> If it is right that MFD is based on the same hardware bus for multi
> function
> device,i.e,. based on SPI/I2C/PCI bus to register device by
> mfd_add_devices().
> 
> For a multi function device works on different hardware bus, it has nothing
> to do with mfd-core.c(MFD framework) even though their driver are in
> drivers/mfd directory, i.e,. mcp-core.x, sm501.c.
> 
> Since RPC-IF works on different hardware bus for SPI bus or CFI
> HyperFlash bus,
> is it a good idea to implement MFD framework for RPC-IF ?
> Or we just separate RPC-IF driver by spi mode and cfi mode ?
> 
> any comments/opinions on RPC-IF/MFD-framework is welcome!

Mark mentioned it before, you can use the MFD for MMIO too.
The goal here is to have some common code which is shared by the SPI and
HF part of the driver, and then a separate SPI handling code and HF
handling code. The common code should determine which part to activate
based on the DT.

-- 
Best regards,
Marek Vasut
