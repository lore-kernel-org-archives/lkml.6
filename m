Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A2C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F87217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeyLo+F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F87217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHDN2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:28:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54959 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHDN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:28:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so8911131wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L6/0M8y0x4jS8DTqA3HRbL/phMOOnkrC5T5csID/vtY=;
        b=QeyLo+F4fLJaK1TUVQgpB7CCGcxXN3U6ZJ2E8wLf3Fyxcr6SG6FDeyrCkFoloFpb5Q
         LF6V6NG2juayXdzI9y9WqZkp+lCerBTI4UmD+YVhxJ1CfhC9bwBxMWR4+Lg2blkBuf+/
         2H3YRe5V1fvHMqIzHwaVohYe5xGDLm+14vkX5V6hPtuQpEJVyhqwC1PFO0ClsnngVMBx
         1wcYdhLF3Gm4CcElzQ+NHIwD7+ldO2O0qG3v2In5ayXGMuzNk7cPEN+m9P9SX8P3M2Vr
         tKKvZNdLSFOWW+wg0XnGNKfvP8y1mG3QahFxie9v5bOpsYC5/2KYt+Hm3Q8BwJQPASM1
         fucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L6/0M8y0x4jS8DTqA3HRbL/phMOOnkrC5T5csID/vtY=;
        b=oF3ye+X1SezYvDyzx9xdWgsaGiluwTWoS7DImd2eoX4XHhncGdCR4I0CnSmlzrdTkP
         oBP8CTfW8lTpUMLcAR07Yw3SInsi7NcBitAiwU3XxMG5KSVoTPypnOKSHJ7TAaDtYTsk
         M+pyT+8ToHVuMRTc7miqygVXruWh6nNKb3wnN8ZRzbKFLFdk5DFj7SxJ6kNu+Smtydz2
         UW+dYyGA6HBp8wARnn1FER8SR1ZhMO0WRYhUF8PRg2lmCZDSAKVbB+n+w7FMpVrgxVbb
         k9EgYYg2lMp6RUZQKqusic0bgaT7+MHEE1SQiR2M7WuMR72QPG+0vOJgqu9Tf+3TsK7k
         o2iQ==
X-Gm-Message-State: AOUpUlGb+taikw9PuN658rFSygYl/9Qg/V9EmeJWsINVnxvUzstgMyNC
        5RpBG+975UL84wqyI11LwK0=
X-Google-Smtp-Source: AAOMgpfsUr0B00WCxz7imLHN4oR+YZqusdfDuXfyrWpCzOvmsZiHPHafh1KhSxXCG5+duz14VLII9g==
X-Received: by 2002:a1c:9acf:: with SMTP id c198-v6mr7317297wme.131.1533382090496;
        Sat, 04 Aug 2018 04:28:10 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id r16-v6sm8644100wru.59.2018.08.04.04.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 04:28:09 -0700 (PDT)
Subject: Re: [PATCH] spi-nor: add support for is25wp256d
To:     Palmer Dabbelt <palmer@sifive.com>, linux-mtd@lists.infradead.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at,
        linux-kernel@vger.kernel.org,
        "Wesley W. Terpstra" <wesley@sifive.com>
References: <20180804014947.24601-1-palmer@sifive.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <6acaba6b-b645-7098-45f6-e37abc3414a8@gmail.com>
Date:   Sat, 4 Aug 2018 11:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180804014947.24601-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2018 03:49 AM, Palmer Dabbelt wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
> 
> This is used of the HiFive Unleashed development board.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/spi-nor.h   |  2 ++
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d9c368c44194..e9a3557a3c23 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1072,6 +1072,9 @@ static const struct flash_info spi_nor_ids[] = {
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "is25wp256d", INFO(0x9d7019, 0, 32 * 1024, 1024,

Is there a reason for the trailing 'd' in is25wp256d ? I'd drop it.

> +	                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
> +	},
>  
>  	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> @@ -1515,6 +1518,45 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  	return 0;
>  }
>  
> +/**
> + * issi_unlock() - clear BP[0123] write-protection.
> + * @nor:	pointer to a 'struct spi_nor'
> + *
> + * Bits [2345] of the Status Register are BP[0123].
> + * ISSI chips use a different block protection scheme than other chips.
> + * Just disable the write-protect unilaterally.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int issi_unlock(struct spi_nor *nor)
> +{
> +	int ret, val;
> +	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
> +
> +	val = read_sr(nor);
> +	if (val < 0)
> +		return val;
> +	if (!(val & mask))
> +		return 0;
> +
> +	write_enable(nor);
> +
> +	write_sr(nor, val & ~mask);
> +
> +	ret = spi_nor_wait_till_ready(nor);
> +	if (ret)
> +		return ret;
> +
> +	ret = read_sr(nor);
> +	if (ret > 0 && !(ret & mask)) {
> +		dev_info(nor->dev, "ISSI Block Protection Bits cleared\n");
> +		return 0;

Is the dev_info() really needed ?

> +	} else {
> +		dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
> +		return -EINVAL;
> +	}
> +}

[...]
-- 
Best regards,
Marek Vasut
