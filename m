Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB62C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D8020858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IrNtw1Jb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c1dRZx75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D8020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeH2PPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:15:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeH2PPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:15:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F91460540; Wed, 29 Aug 2018 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535541569;
        bh=HnmWYoIqv2xH78u2lABpdlYpKPaRuhOEjaqaf9Lg4lw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IrNtw1JbA53aHlf3KMSr7+DGSRSG8th9PyUwHfpfx2KVfKiqYQHrUKEdK86vXyk0D
         GhN4/Kqk0osbcN/XvAvZh5XJZXbTj+0DUxtVtBGxhrnsBn5YNDwKS0qt9oPC2n9Jx5
         A2JPPa+pwD71KUF3YzyxJ07X//NteQgsnNZo8ycc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 44CF4602AE;
        Wed, 29 Aug 2018 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535541568;
        bh=HnmWYoIqv2xH78u2lABpdlYpKPaRuhOEjaqaf9Lg4lw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c1dRZx75OdBDAQ5s6aCXw2BNMXt27x1uN3kTBx8uh2PNkcDlpPCr8oKoyFox27G5j
         WuaVFKpUn3OcLdKLbRBEae/VFgfXPNj3jQf7fcbf4wRTklt8hwJBtF0Ti3Oz3O8PXa
         NTe6I2CP+kjfkDWFd/CYRg2Em4Mpex1UuHDCmP7Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Aug 2018 16:49:28 +0530
From:   dkota@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     swboyd@chromium.org, broonie@kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
In-Reply-To: <20180829002535.GA4224@bogus>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <20180829002535.GA4224@bogus>
Message-ID: <d751bc90ab1cfce84d6f419400790566@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-29 05:55, Rob Herring wrote:
> On Fri, Aug 24, 2018 at 04:12:15PM +0530, Dilip Kota wrote:
>> From: Girish Mahadevan <girishm@codeaurora.org>
>> 
>> This driver supports GENI based SPI Controller in the Qualcomm SOCs. 
>> The
>> Qualcomm Generic Interface (GENI) is a programmable module supporting 
>> a
>> wide range of serial interfaces including SPI. This driver supports 
>> SPI
>> operations using FIFO mode of transfer.
>> 
>> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
>> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
>> ---
>> Addressing all the reviewer commets given in Patchset1.
>> Summerizing all the comments below:
>> 
>> 	MAKEFILE: Arrange SPI-GENI driver in alphabetical order
>> 	Kconfig: Mark SPI_GENI driver dependent on QCOM_GENI_SE
>> 	Enable SPI core auto runtime pm, and remove runtime pm calls.
>> 	Remove spi_geni_unprepare_message(), 
>> spi_geni_unprepare_transfer_hardware()
>> 	Remove likely/unlikely keywords.
>> 	Remove get_spi_master() and use dev_get_drvdata()
>> 	Move request_irq to probe()
>> 	Mark bus number assignment to -1 as SPI core framework will assign 
>> dynamically
>> 	Use devm_spi_register_master()
>> 	Include platform_device.h instead of of_platform.h
>> 	Removing macros which are used only once:
>> 	        #define SPI_NUM_CHIPSELECT     4
>> 	        #define SPI_XFER_TIMEOUT_MS    250
>> 	Place Register field definitions next to respective Register 
>> definitions.
>> 	Replace int and u32 declerations to unsigned int.
>> 	Remove Hex numbers in debug prints.
>> 	Declare mode as u16 in spi_setup_word_len()
>> 	Remove the labels: setup_fifo_params_exit: 
>> exit_prepare_transfer_hardware:
>> 	Declaring struct spi_master as spi everywhere in the file.
>> 	Calling spi_finalize_current_transfer() for end of transfer.
>> 	Hard code the SPI controller max frequency instead of reading from 
>> DTSI node.
>> 	Spinlock not required, removed it.
>> 	Removed unrequired error prints.
>> 	Fix KASAN error in geni_spi_isr().
>> 	Remove spi-geni-qcom.h
>> 	Remove inter words delay and CS to Clock toggle delay logic in the 
>> driver, as of now no clients are using it.
>> 	Will submit this logic in the next patchset.
>> 	Use major, minor and step macros to read from hardware version 
>> register.
>> 
>>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   2 -
> 
> Please split to a separate patch and explain why you are removing
> spi-max-frequency?

Hi Rob Herring,

In this patch, added changes for Driver not to read the SPI controller 
Maximum frequency from the device tree. Accordingly I removed it in the 
device tree documentation file. As both the files need to updated so did 
in the same patch.
Could you please let me know the reason for making a separate patch.

--Dilip

> 
>>  drivers/spi/Kconfig                                |  12 +
>>  drivers/spi/Makefile                               |   1 +
>>  drivers/spi/spi-geni-qcom.c                        | 678 
>> +++++++++++++++++++++
>>  4 files changed, 691 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/spi/spi-geni-qcom.c
