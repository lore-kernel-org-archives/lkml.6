Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD832C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABB320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxAxczSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbfAOR6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:58:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfAOR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:58:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so4017070wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZ+YAExMztIgT/WKhWmPD88o/8xhNwUJG4ImCb5jYQw=;
        b=jxAxczSEpRQTbzkfVxtLq5TasBupobu62auE4qkUmpJzw+pmaYzYK1mBl1Kdu1NKOb
         HPimmNk8nisJ8RorSGvgK33gCP/ermZ05PiJV9WWI2sVnQJ8F2g3BjVBWIWi/qlAZpgZ
         7ErjXRIaVbxhuH10wNpdRz5B4Tx7g5O7wNV/5i8ZJnR49nj7XQPGFBwRijZSs2GrC3gT
         hTQUqsP285UGjRpHTKTUy2koo3HLyzXUKXFWnda4hOJjExaDmZ7OaksdTmLRWGKUtZ6y
         Bww8XNb6PCl3k7ZAqDieZe8x5SMbiq6WWGpZsLbHJ7olgjGx0GNrRFdTpZKS2orH9nyA
         mnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZ+YAExMztIgT/WKhWmPD88o/8xhNwUJG4ImCb5jYQw=;
        b=gtnv2rV+TcU/lTi7CWd+DDwW0Z3ikUJSIHZVPSkatM9I8xr9SR17Mxhpxhl5IbTXQL
         v+RH8a6pizvCtnRsW1mMAs//WnmC1SLOFWw1aDlXk4+u2TYq4RFM7+2SqGjqwHuqtbEE
         jYyn/plrNuJ+qOcTfXAz7a/qETPmXXnGBIsYXR0oLhD5UDvnjhVSYedeCbganCIJQ+nb
         XRVwMKX6Gj/eVltBN4NvaGULjs/ovlZSuFNHvmEHw+9gNMl6hkkSs1rKua86vgmOydJ6
         P4tT6qkWRw0Box0MDEztcyYcklzWtv2EFw94brfax85y6YxVtwfyioOaL0GWpjhaYw4S
         XPEQ==
X-Gm-Message-State: AJcUukdcfHTjBpV2uDFj6MlikBnHvXPXuGCxjLehvTd1KeQCZQWwDJUM
        59p9AhVlDSWh3aDhsg662K2HtwL2
X-Google-Smtp-Source: ALg8bN7H0NmW6k6JEqynjLEqS6AGIsNquBxsKp6KSy/W39HdzuDgdvYpMRGipjl+qwcol5sxKpojGQ==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr4365670wrt.141.1547575109942;
        Tue, 15 Jan 2019 09:58:29 -0800 (PST)
Received: from [192.168.43.97] (cst-prg-29-189.cust.vodafone.cz. [46.135.29.189])
        by smtp.gmail.com with ESMTPSA id f18sm63054109wrs.92.2019.01.15.09.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 09:58:29 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: add myself as SPI NOR co-maintainer
To:     Tudor.Ambarus@microchip.com, boris.brezillon@bootlin.co,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190115165740.32450-1-tudor.ambarus@microchip.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <df26353e-a40f-811a-b9d7-7c40777b889a@gmail.com>
Date:   Tue, 15 Jan 2019 18:54:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115165740.32450-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 5:57 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> I have been reviewing and contributing to the SPI NOR subsystem
> for the last few months and I'm willing to continue doing so.
> Volunteer as a maintainer for the SPI NOR part of the MTD subsystem.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Marek Vasut <marek.vasut@gmail.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6682420421c1..7deb0e91e3ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14081,6 +14081,7 @@ F:	arch/arm/mach-spear/
>  
>  SPI NOR SUBSYSTEM
>  M:	Marek Vasut <marek.vasut@gmail.com>
> +M:	Tudor Ambarus <tudor.ambarus@microchip.com>
>  L:	linux-mtd@lists.infradead.org
>  W:	http://www.linux-mtd.infradead.org/
>  Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
> 


-- 
Best regards,
Marek Vasut
