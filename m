Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CE0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC01820854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="2CxCUcPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfAXLbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:31:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42823 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfAXLbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:31:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so4907338lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 03:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3q4le4/TDaFX3wPtwOqzOy+gn8GWmVxn53VsdlZ8AYw=;
        b=2CxCUcPFzUtq7TC3691irl0caDkDC9KSiLx/NjweWFQct6ORSaDO6gSd3rr5T56F7d
         bdKgophnUrcJGaebXSWwgpcz4q5VPburqn4vbEYEl56IPGuv/FgakePczI4yfXgX+3Rh
         BjSuD811gb/FXY2ZqAuVE47PTVvUZnYdJRmq8qX/BWY6MYcR3U64sRyvczvL2arP44EC
         La3WEgCeiO/Hcy2XWd5GdpHqXxfr5axxD1z5uW6LefyPZW5+keA4aGYMaFDc6m6lTeR5
         Q0zjc5clmgzKMn+Nl7AdwlNHePt2OpuNEZFBioYiCIXHNClNHsOlRheA5sTDHnaWgMRA
         +SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3q4le4/TDaFX3wPtwOqzOy+gn8GWmVxn53VsdlZ8AYw=;
        b=JhogoDB6z98fs8U+RG6TRkWu0aSFErhmZcpy85IDQyYaNiGpE/yK0WaQSMEwhgPgcJ
         cC9dmCXU2HoXFgqeDHpGQx+9mfwHAKD8/ch4R+lTBhZDuwKT/aQImha/EnBj/rUL8+yK
         ys7aFoZRbOuMsqNBjGtkLgrVut2C1+wZkli+AlDTa9li4Upw3O452gbtHU9+/k46X7XR
         57m3Qd6VlseV49Ns9hLoo7UkZhIc85P3SgyLR+5wOWa2KbFkU3sGmGTET1dtxi0RSnIJ
         L+YHV6Q5JL4sSvXX1QcEJFupXbFBJ7OzHG8UAPn1oi2VJR4wqOrL4euOg3jFqp4hMKOo
         I95Q==
X-Gm-Message-State: AJcUukeTf3Ol3SD8YRHihKKKIzjclhMCFQAo9/kCFEykDqc51Ko2MGmk
        1ZASPzouSVmVfueBy4l3Qv1BJQ==
X-Google-Smtp-Source: ALg8bN6SYyOvtXojOMfv2wWgLLdmOYKE106CRU/b70GYC7qoDBuclYQyv0neY+umecJ7r6onOKLhGg==
X-Received: by 2002:a2e:5dd9:: with SMTP id v86-v6mr5244148lje.86.1548329473782;
        Thu, 24 Jan 2019 03:31:13 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.179])
        by smtp.gmail.com with ESMTPSA id i13-v6sm942307ljg.82.2019.01.24.03.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 03:31:12 -0800 (PST)
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     masonccyang@mxic.com.tw, bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
 <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <93e1f97e-7afd-4a3e-b059-9f66390efa56@cogentembedded.com>
Date:   Thu, 24 Jan 2019 14:31:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/2019 05:23 AM, masonccyang@mxic.com.tw wrote:

>> [...]
>>
>> > +module_platform_driver(rpc_spi_driver);
>>
>> RPC is not a SPI controller, it's a SPI and HF controller.
>>
>> Also, how difficult will it be to add the HF support ?
> 
> One of my customers needs RPC SPI driver for our company's Octal-Flash,MX25UW51245G.
> We don't have HF product and hope you could understanding.

   I'm looking into the HF support (we have a driver internally).

> 
> thanks & best regards,
> Mason

MBR, Sergei
