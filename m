Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F0C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB1F2475E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGFs9ocn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB1F2475E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeF3Ryp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:54:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43353 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeF3Ryo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:54:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id c5-v6so11651309wrs.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d7yBsC8xiTu7Prf1zV0jH7gf4djJhP68DNCj0g4Bpdg=;
        b=UGFs9ocnhyKVi3ZwWftDg26ieGQYtfyYtVm69FHqxMtQVT3PjiV0x8vuEIjTb8Vr3J
         Y8td7xAL8QNXcAOs5nilGAyrpBmyJNuNL8vNbUfi05oI5HVN8eWMujI7ePFEkYBYY9+4
         HKNc2chvg4pbkfC2CtfhqwNdGo7Dd5XC5YgP7VVN248Lc/3+mUIAy+p4nJztairpuUlx
         uyfi86gN1d8rtPg7khB/YmLHlpkG6TuDNEvawWm9vmYcJWflUh3MML+YU2YbQhgGtui9
         yKkUUdTWAymD/7zseMEKB7WM4PCagpQMmfRY8hdkUPEntzZO7tEDDhnZW+752Cx4yLin
         4p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7yBsC8xiTu7Prf1zV0jH7gf4djJhP68DNCj0g4Bpdg=;
        b=YWJfl6DyCWW3d6pdvSNzpWDZFdLTqVaGacXZVrLf5X2+UxZ4pVRPuX3BOY72FVTuoD
         HOXrhg7m3qcphKJTj7VAx3hCA9XbrBIofp5BelajMP0uC9X/AbOzQ3rO9npFEAjAAgpx
         LP6B5N/97q7v82g2tRIz5sUo8x/U4kqypwbgoCwGEqGIElF8KDfSA5UqlIpi3E2zJBuB
         KvsGjWd6R1NR7Ktd3d+sLdYm2mW5xdNHSa099kzqhGt5D69Yzidt5PPhY8rKgOEjBRHR
         F6PhXm1/mvsBOsvRqP+mikO10fP3QPOqL5ILffzjE+7NNb/TrFh5H5ajc6loyXXGd3ae
         XUHQ==
X-Gm-Message-State: APt69E0fbzzsUPcvq+oqHMfLP0l+a5CycpIx37sWvG7tyvWKc5uVWcpx
        mx3QbYZpXCxIFIawKTQqVlk=
X-Google-Smtp-Source: AAOMgpfY1VZ9BKdk5L09GwHrdl6x2+dU2gs+19rKCKDGH5ABYe1qdcDsPodtxn7T2Bz8BQDqM18FEg==
X-Received: by 2002:adf:f74d:: with SMTP id z13-v6mr1335799wrp.85.1530381283032;
        Sat, 30 Jun 2018 10:54:43 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id q70-v6sm8362266wmd.45.2018.06.30.10.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 10:54:42 -0700 (PDT)
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: Fix direct mode write
 timeouts
To:     Vignesh R <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20180630105421.550-1-vigneshr@ti.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b029ab9a-782b-b2d8-a80e-ae8e5c5e511d@gmail.com>
Date:   Sat, 30 Jun 2018 15:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630105421.550-1-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/2018 12:54 PM, Vignesh R wrote:
> Sometimes when writing large size files to flash in direct/memory mapped
> mode, it is seen that flash write enable command times out with error:
> [  503.146293] cadence-qspi 47040000.ospi: Flash command execution timed out.
> 
> This is because, we need to make sure previous direct write operation
> is complete by polling for IDLE bit in CONFIG_REG before starting the
> next operation.
> 
> Fix this by polling for IDLE bit after memory mapped write.
> 
> Fixes: a27f2eaf2b27 ("mtd: spi-nor: cadence-quadspi: Add support for direct access mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index c3f7aaa5d18f..d7e10b36a0b9 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -926,10 +926,12 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>  	if (ret)
>  		return ret;
>  
> -	if (f_pdata->use_direct_mode)
> +	if (f_pdata->use_direct_mode) {
>  		memcpy_toio(cqspi->ahb_base + to, buf, len);
> -	else
> +		ret = cqspi_wait_idle(cqspi);
> +	} else {
>  		ret = cqspi_indirect_write_execute(nor, to, buf, len);
> +	}
>  	if (ret)
>  		return ret;
>  
> 


-- 
Best regards,
Marek Vasut
