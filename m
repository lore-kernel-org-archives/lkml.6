Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1475620854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="nH/hop0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s5+L0462"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1475620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeIKNVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:21:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54301 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726407AbeIKNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:21:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0EEE321B4C;
        Tue, 11 Sep 2018 04:23:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Sep 2018 04:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7JRVLCbYuZTPpmC7G80sqmTuovZ06kuaEsa/B0KiTDs=; b=nH/hop0a
        3P4zS/zNjP1OjS/iOiP8t/qnUcCWfxiFiPEPsVMWfC50EFMzeOA361eXEeU/fNHF
        arqxsDVcUARaGbrG+4G12pEu5tDQmsPbNTwgJODbMlU88PqviZ3i2t6de9aijIVQ
        HS1VszSOkFCrG1qVwFfbbbLAipMuO0/bcDZVmGs11KcmGzXa5RAxR/etkfesI46T
        lWWoVKUcv6n9z0wKc50GqVIXRo9sYpb1bSdh1mu8y/86RePIAHcZiAE7gspnqshT
        S0ryvIn0bTrKjBmbzFVAtkekhUEI/U5Qu8lc/xN5tjtlHkKwNRKPaP/JzcVGaUh+
        /hgav34RKmuw+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=7JRVLCbYuZTPpmC7G80sqmTuovZ06
        kuaEsa/B0KiTDs=; b=s5+L0462yLbjJ7tTNgim4yC5/98uGBQ7apDta51RY3gOa
        ahM3lYa2hrq9odVGk08izIO4qNTGmxw/rUc1vAHvW6BIqcKpM9rUZzkB5y4cyp4R
        qxdMaFP6R9CtyIyxG3u0WiTuVUEol6v7oy07q3+SqOotReD7h+C26hSMpH3qzBLf
        LUGjgVkNhvlS0sZmb5yqMoiqqWnalcmaMZ/YaznrwyzoAeHaKeJqVNNS3mii51MQ
        GnsogRHehkxfHacOuurn0EEYEUPNqr/CSmGajA2aRnZmEpDDvPLtB6be+MDIDNmk
        vUR5Zo4dfCtCwvHG4D8BkJ585zWH1mLl/iGYszyrQ==
X-ME-Proxy: <xmx:fnuXW2IawQxiLYrh19rsbqBsGr9sU2GZy2MbaaS3JAkWXScFBl_3xw>
    <xmx:fnuXW8GQHmIsJNUHKQHHY2PeQxLbj0oww49StQTgRX4kwIyvqHam3Q>
    <xmx:fnuXW-SFw_Zr9Dnjh5C6l_DXRS3M6yVFcr1WhS346gn1QGKwaLHQaQ>
    <xmx:fnuXW4HFUn8tlrhxVBRpTUmLFN6NfP0jWQIXMJjKQRURQKwOtIGwEg>
    <xmx:fnuXW6-wMGA1oQ1qB83G_dwFL1nmG1h4zN8cX5oDTH1_HAYNUm9hog>
    <xmx:gHuXW-SRWoG6HxEG1f4ISQjPIzQQUW3VXXX6RrCp4exau_AZigwN9A>
X-ME-Sender: <xms:fnuXW8K56-nlVV62dUYLDerD3lD_h-L3ujj6xSaqFLSYORFOtn8Jjw>
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80A761028D;
        Tue, 11 Sep 2018 04:23:26 -0400 (EDT)
Date:   Tue, 11 Sep 2018 10:23:24 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <20180911082324.GC17267@kroah.com>
References: <20180911125857.5e5c34f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911125857.5e5c34f4@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:58:57PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the tty tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/mfd/at91-usart.c:51:34: error: array type has incomplete element type 'struct of_device_id'
>  static const struct of_device_id at91_usart_mode_of_match[] = {
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/at91-usart.c:52:4: error: field name not in record or union initializer
>   { .compatible = "atmel,at91rm9200-usart" },
>     ^
> drivers/mfd/at91-usart.c:52:4: note: (near initialization for 'at91_usart_mode_of_match')
> drivers/mfd/at91-usart.c:53:4: error: field name not in record or union initializer
>   { .compatible = "atmel,at91sam9260-usart" },
>     ^
> drivers/mfd/at91-usart.c:53:4: note: (near initialization for 'at91_usart_mode_of_match')
> drivers/mfd/at91-usart.c:51:34: warning: 'at91_usart_mode_of_match' defined but not used [-Wunused-variable]
>  static const struct of_device_id at91_usart_mode_of_match[] = {
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   7d3aa342cef7 ("mfd: at91-usart: Add MFD driver for USART")
> 
> Forgot to include <linux/mod_devicetable.h>?
> 
> I used the version of the tty tree from next-20180910 for today.

Very odd, I just pulled in the "Immutable" branch from Lee here.

Lee, is there something I am missing to get this to build properly?

thanks,

greg k-h
