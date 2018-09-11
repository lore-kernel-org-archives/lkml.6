Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3E4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D5720865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHyTRUWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D5720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeILACT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:02:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37701 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeILACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:02:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so2098862wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RcJNaqxwZea9uwDYmwE+bUzlZgXKGvWd45HN57loAjw=;
        b=GHyTRUWPbOCK6Qu6IeXXl+QSb1n0ymooAvuXNK3z9EP2RwvrMDTXCs1J7iCE4v/HLo
         otbBReIIVrTfXFDo9V9wCRKUdgtIPw6VQuOBZd7LUb2Dg/ZfaC/Zkm4Cjjj6gamKGP0x
         nSA0AAzWP4eHqoqQmbuL9pm0Jva4FszXj5c/ayE8N2RqyTmoemT5NqxezzwICk0MVrnS
         Yyju452qy6eUnuoUnw+Osgi7YZ+K5Zvan4pI9Uitl2N/oVeSvOa6RCV79pUWayQ2/4+T
         Q4b01b19/T5MYQg/yWJNiZwM1LkbN2QNjsD6L7xAIl2VBlvNIiNasi+Stg7Ai9d0gDpc
         z1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RcJNaqxwZea9uwDYmwE+bUzlZgXKGvWd45HN57loAjw=;
        b=T8KPETMlJsyZJsPidLFWAqmDey20TslzeasTwFbRxZdobdhC11gWwKs0S8s7pnJEGi
         jt4IFrKokkS94MdOPzhbHk83GXvek2itoFsxbpUqSfuDMTXMOIyx9GNUxjNLy0xtjizP
         hCTmuzMIpJj1IKtr2FfDZi9lxolhgzbwybjEa7PkI/o52cS/NWipyDWcxOQY8AepHVGv
         ni+9ucmvB6efNwNV8epgWhXd2KMJ5iL80AQr3O/XrqzL4NxIid6unti2jd+oJKLr0BjC
         liCssKK+7Ht8asyDSBCTy+T5AtNo7UBKx4WeJ46/B5kjf5gMesSzCD/zSj0mtNHeX7V8
         1d1Q==
X-Gm-Message-State: APzg51DMsE4pwzSRAARjRu/Ed1bS5/ZbQn0wNgLW4OCUd33cISDtXSmK
        iUOxaKwjioDEbUSS1ca4+fY=
X-Google-Smtp-Source: ANB0VdYleJGG+Z/9uOYlfjFJWVa0D4beD6J/IF86g2j4RNEL714bTOlmT+wQ4vGKeslrWdUU3lQ4gw==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr2373554wma.41.1536692498242;
        Tue, 11 Sep 2018 12:01:38 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id j133-v6sm2965078wmd.12.2018.09.11.12.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 12:01:37 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cyrille.pitchen@microchip.com, nicolas.ferre@microchip.com,
        Cristian.Birsan@microchip.com
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a62a8dc2-796d-8560-22d9-9377f39cbf52@gmail.com>
Date:   Tue, 11 Sep 2018 20:55:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180911154007.17195-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 05:40 PM, Tudor Ambarus wrote:
> Based on Cyrille Pitchen's patch https://lkml.org/lkml/2017/3/22/935.
> 
> This patch is a transitional patch in introducing  the support of
> SFDP SPI memories with non-uniform erase sizes like Spansion s25fs512s.
> Non-uniform erase maps will be used later when initialized based on the
> SFDP data.
> 
> Introduce the memory erase map which splits the memory array into one
> or many erase regions. Each erase region supports up to 4 erase types,
> as defined by the JEDEC JESD216B (SFDP) specification.
> 
> To be backward compatible, the erase map of uniform SPI NOR flash memories
> is initialized so it contains only one erase region and this erase region
> supports only one erase command. Hence a single size is used to erase any
> sector/block of the memory.
> 
> Besides, since the algorithm used to erase sectors on non-uniform SPI NOR
> flash memories is quite expensive, when possible, the erase map is tuned
> to come back to the uniform case.
> 
> The 'erase with the best command, move forward and repeat' approach was
> suggested by Cristian Birsan in a brainstorm session, so:
> 
> Suggested-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut
