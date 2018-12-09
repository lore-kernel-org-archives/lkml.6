Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA20C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6848F20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ov0RTIeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6848F20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLIPh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 10:37:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLIPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 10:37:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so7408957ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xn9zHfMRU5cEXBfv2PSCQh6l4r6br9EzowxeGbDyQvI=;
        b=ov0RTIegm5dJFOK4OSu62jigja4q6QIc3lffU6ZOcrrw//1DRFXBJiXofN0RBBS5sS
         Os//kepWechFhNWqtXoYbP0e0A2LkGOMHjIvCTZVWIY+inXO4a3A0x5Pch0WHpA9oZFQ
         rQLcOfbZOOQRlsEfrHXNwCUBgHDq7dZ2zOWTP5YvOU1T+FuH6/UIVuIxCEPpHoKNfSoB
         5vAE+cPzvQCIL/uSEm4tlJ3ipcIKD0L6OiIGrVavCm5BiC2j5tnUyYAmE3UFEWOJiC5H
         pIX1CL2y4FvqsZEGvGP9UQGtHUF1j//oTRLfem3+XX+yteS1Tr1jA2QB0W5yqpm8I+Hw
         Uebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xn9zHfMRU5cEXBfv2PSCQh6l4r6br9EzowxeGbDyQvI=;
        b=aLViVCPl4s5QosmAJZcduTcIv7Vg1frIx/mAya23pbfeVk8LOkotJZf3svGW+zBVHC
         lfVEZP25z0WVFGXA7QbrOTDjBQSKOuKtajkzyRIgpN3fUOm+5HAXP2k3iOBBeSUqAu1g
         BKONl3vznd40MtCpzBZqjNNTvkhzj5zkPnPkir9GjgmbRyMB39RQelHFLCLXMx5v69vA
         vRDoREnXNAgRW2ujoh156Qodf8FLlZ14fTWdQ0MymQ1QDpb3HuBKutnoiB5cRG7zvX7h
         9w3F14MoD9Cs3PhUx7RCq/Y3Djq2qgzriWmHGV0yCe/Ne8gUdNBm9lL2fplvzKiS/PXN
         7rOg==
X-Gm-Message-State: AA+aEWawndAkhfANCUxZuCxOTquCQuaWE6+K/7FWUQXYAPINYIWKwyky
        3IQofwNUSvRK6HqoS6blP1/JLw==
X-Google-Smtp-Source: AFSGD/WEYy35mmkuK1AcT7LOh3dzsdaMLVLYmeZ8eCl+hgNtCuc/1kEo1LcdMlOpiCZgdMh2uEJ2iw==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr5287150lje.28.1544369874344;
        Sun, 09 Dec 2018 07:37:54 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.60])
        by smtp.gmail.com with ESMTPSA id e5-v6sm1646274ljj.91.2018.12.09.07.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 07:37:53 -0800 (PST)
Subject: Re: [PATCH v3 0/2] spi: Add Renesas R-Car Gen3 RPC SPI driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1148d04d-96b1-ef91-e3d9-2603e9a5c6fc@cogentembedded.com>
Date:   Sun, 9 Dec 2018 18:37:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2018 02:13 PM, Mason Yang wrote:

> This Renesas R-Car Gen3 RPC SPI driver is based on Boris's new
> spi-mem direct mapping read/write mode [1][2].
> 
> v3 patch is according to Marek and Geert's comments including:
> 1) soc_device_mach() to set up RPC_PHYCNT_STRTIM.
> 2) get_unaligned()
> 3) rpc-mode for rpi-spi-flash or rpc-hyperflash.
> 4) coding style and so on.
> 
> 
> v2 patch including:
> 1) remove RPC clock enable/dis-able control,
> 2) patch run time PM, 
> 3) add RPC module software reset, 
> 4) add regmap,
> 5) other coding style and so on.
> 
> thanks for your review.
> 
> best regards,
> Mason
> 
> [1] https://patchwork.kernel.org/patch/10670753
> [2] https://patchwork.kernel.org/patch/10670747
> 
> 
> Mason Yang (2):
>   spi: Add Renesas R-Car Gen3 RPC SPI controller driver
>   dt-binding: spi: Document Renesas R-Car Gen3 RPC controller bindings

   Probably a stupid question: how did you test this driver (especially
the dirmap related parts)?

MBR, Sergei
