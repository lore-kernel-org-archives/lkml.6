Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C5EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367DC205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="NOwvfxyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfANX5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:57:09 -0500
Received: from vern.gendns.com ([98.142.107.122]:52106 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfANX5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ETaBNaBq6+nrFaEi64tbRzDh+0WDaQNiIYNOeevOXQU=; b=NOwvfxyQigPCyNPEMN0uEL1JDC
        N5fua+xo0CQk75PBu9j8yCT0gyfBEtxalWTOCNG2bKOxTdym/HaUB5Fu6t6O0n2YTW1Syv3yQ65We
        06uJKuLnWnNokn5Ap0MWPp+ISH8xEv0Z2qITj3EZ6JSdP5R2YyaovTZgOEX7MTCVhfOlHLP7SwDBY
        m37/icax0KSI0TyIR/Xxps+VF2fAV3XVUljXez+OYuFgR9zTMZvsIvyZek4RkLALuP3lZAHFodoz7
        OZacnxGJDXd1cambrEWxeQ799HasnDqirHffBceBaf4rWs3ZlLf9ALXhaTXS6UcgxWLjM8RNZnl78
        UDv7LOdQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42952 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gjC3h-0004GO-D5; Mon, 14 Jan 2019 18:54:21 -0500
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Set FIFO DMA trigger level to
 word length"
To:     Vignesh R <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
References: <20190113204905.29795-1-david@lechnology.com>
 <829bdc72-cf96-6aee-28d8-a47d0430710d@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <bf29d3f6-69d1-2088-6533-76b94c80711b@lechnology.com>
Date:   Mon, 14 Jan 2019 17:57:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <829bdc72-cf96-6aee-28d8-a47d0430710d@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 6:30 AM, Vignesh R wrote:
> 
> On 14/01/19 2:19 AM, David Lechner wrote:
>> This reverts commit b682cffa3ac6d9d9e16e9b413c45caee3b391fab.
>>
>> That commit breaks displays using tinydrm drivers, such as ili9225.
>>
>> It causes corruption in the image that is displayed (it looks like only
>> 1/2 of the framebuffer data is sent, the other half of the display
>> remains blank.)
>>
>> The following error appears multiple times:
>>
>>      ili9225 spi1.0: EOW timed out
>>
>> Eventually, the system locks up without any additional errors.
>>
> Oops, that's unfortunate. I see ili9225 is using bits_per_word = 16.
> I believe commit b682cffa3ac6d9d broke spi_transfers where
> bits_per_word anything other than 8 bits.
> I don't have ili9225 HW but was able emulate this condition using a SPI
> flash as slave on AM335x and successfully reproduced the issue. Could
> you test if this diff[1] helps in fixing the regression without needing
> to revert commit b682cffa3ac6d9d?
> 
> If below diff does not help, then could you post logs of types of
> spi_transfers being queued by ili9225 driver? I guess you can dump them
> by enabling DEBUG option in tinydrm-helpers.c.
> Also which TI SoC are you using?
> 
> Sorry for the trouble!
> 
> [1]:
> 
> Adjust maxburst size of DMA xfer according to the DMA trigger level and word length
> instead of just word length
> 
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 2fd8881fcd65..6b7edcff0e6b 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -623,8 +623,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>          cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
>          cfg.src_addr_width = width;
>          cfg.dst_addr_width = width;
> -       cfg.src_maxburst = es;
> -       cfg.dst_maxburst = es;
> +       cfg.src_maxburst = width / es;
> +       cfg.dst_maxburst = width / es;

Just an observation... won't `width / es` always == 1 because width is always == es?


>   
>          rx = xfer->rx_buf;
>          tx = xfer->tx_buf;
> 

