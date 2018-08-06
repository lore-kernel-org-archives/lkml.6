Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E6AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02B121A15
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GEj/hJ0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02B121A15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbeHFXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:09:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45814 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:09:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so7409360pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nWqCjc94t20FaiP/bOU7V56GwZ0dDzocNSoFjoinPOI=;
        b=GEj/hJ0lymKcBjW3yqw0ao7+Y34fFt7Kab6ldyz7Ydr1AbgdRO0aA1cwoxoxzgx5KT
         V31nn6C8+CMcAMku9lbG9nBPaXzYHgxYLe7V9nZl9E0LMOJbJLDSx6V9XUUNjyhp+t94
         8kH5Reyrluhz0ZoMBzzO0G8HaFHnGSqdJKKCBKo+w/QVVpLTpGWp2qGBAoa+w9RxdtzF
         vG3H2HwuHieIoWO6WoQ2Ba25Kp38uz6RKHaJebuJMVHOytKl1EWkYG/jrDvM3mbdfIl9
         Ee4GHG1KKkh+0f5VwUl9/KnAM00ZQ7qcfAZNalDUBVovsP0CLiixa/6Rle/itP/EYMPZ
         vNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nWqCjc94t20FaiP/bOU7V56GwZ0dDzocNSoFjoinPOI=;
        b=hKVVukWQdbr6x+VTJdHL+lc9zOppDLU/ALfcQyBZnl6Pgp7JmmcrYn2WjxRyHNGlh1
         RW6TBhiAucn6tZxnZOKACpt4tffoZYKQhqBX1hNKuCgefieLmToxPTzh93rHgP1rdZyI
         bch1pCnTqyOnGeT3iclCvekap2V79ZYfgsxGIE43UlQF0OL9HTLU8nsdprH3l5zrM2H1
         SegwQQCFu8awgjsUp903YtS3OedaF0UbfzuwzGXRow6HQHKzG3hM/X2JmFTXHP+cvOP6
         7UnAwajyQpMUzJfKGWbH5Y6BpnPWvK5nV14KoS2ZurJ5i6E5Mku+52fCkwnpDkFa/n9Y
         O/LQ==
X-Gm-Message-State: AOUpUlGJxi5kIwBifbtFObXz+s5suEmb0f5SwJ2IxD5ESN8OxUgvtECQ
        7JDgq0CplfyNGGCVgOE5p8J31w==
X-Google-Smtp-Source: AAOMgpfS9JBJprAmJhIWYiw7s4FjpZMa9LsNqq4muG718cziymgzQQ8FpSEIdp5kUwaWai3kFKAZRQ==
X-Received: by 2002:a65:5288:: with SMTP id y8-v6mr15729005pgp.284.1533589135641;
        Mon, 06 Aug 2018 13:58:55 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o3-v6sm11869389pgp.3.2018.08.06.13.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 13:58:54 -0700 (PDT)
Date:   Mon, 06 Aug 2018 13:58:54 -0700 (PDT)
X-Google-Original-Date: Mon, 06 Aug 2018 13:58:40 PDT (-0700)
Subject:     Re: [PATCH] spi-nor: add support for is25wp256d
In-Reply-To: <6acaba6b-b645-7098-45f6-e37abc3414a8@gmail.com>
CC:     linux-mtd@lists.infradead.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, linux-kernel@vger.kernel.org,
        Wesley Terpstra <wesley@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     marek.vasut@gmail.com
Message-ID: <mhng-0f1dbb5d-9aa3-41c1-9cd6-c1f79b09ee4b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Aug 2018 02:27:54 PDT (-0700), marek.vasut@gmail.com wrote:
> On 08/04/2018 03:49 AM, Palmer Dabbelt wrote:
>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>
>> This is used of the HiFive Unleashed development board.
>>
>> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/mtd/spi-nor.h   |  2 ++
>>  2 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index d9c368c44194..e9a3557a3c23 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -1072,6 +1072,9 @@ static const struct flash_info spi_nor_ids[] = {
>>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>  	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
>>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> +	{ "is25wp256d", INFO(0x9d7019, 0, 32 * 1024, 1024,
>
> Is there a reason for the trailing 'd' in is25wp256d ? I'd drop it.

I'm honestly not sure.  There are data sheets for both of them, but I don't see 
much of a difference

    http://www.issi.com/WW/pdf/IS25LP(WP)256D.pdf
    http://www.issi.com/WW/pdf/25LP-WP256.pdf

Following the pattern, I'd expect to see

        { "is25wp256",  INFO(0x9d7019, 0, 64 * 1024, 512,
                        SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },

versus

        { "is25wp256d", INFO(0x9d7019, 0, 32 * 1024, 1024,
                        SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
        },

So in other words: the d less sections that are larger, and also has the 4B 
opcodes flag set.  From the documentation in looks like the non-d version 
supports 3 and 4 byte opcodes, so I guess it's just a different physical 
layout?

In the data sheet for both I see

    "Pages can be erased in groups of 4Kbyte sectors, 32Kbyte blocks, 64Kbyte 
    blocks, and/or the entire chip"

which indicates to me that maybe we've just selected the larger section size?  If 
so then I'll change it to the first one in the new patch.

>> +	                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
>> +	},
>>
>>  	/* Macronix */
>>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
>> @@ -1515,6 +1518,45 @@ static int macronix_quad_enable(struct spi_nor *nor)
>>  	return 0;
>>  }
>>
>> +/**
>> + * issi_unlock() - clear BP[0123] write-protection.
>> + * @nor:	pointer to a 'struct spi_nor'
>> + *
>> + * Bits [2345] of the Status Register are BP[0123].
>> + * ISSI chips use a different block protection scheme than other chips.
>> + * Just disable the write-protect unilaterally.
>> + *
>> + * Return: 0 on success, -errno otherwise.
>> + */
>> +static int issi_unlock(struct spi_nor *nor)
>> +{
>> +	int ret, val;
>> +	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
>> +
>> +	val = read_sr(nor);
>> +	if (val < 0)
>> +		return val;
>> +	if (!(val & mask))
>> +		return 0;
>> +
>> +	write_enable(nor);
>> +
>> +	write_sr(nor, val & ~mask);
>> +
>> +	ret = spi_nor_wait_till_ready(nor);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = read_sr(nor);
>> +	if (ret > 0 && !(ret & mask)) {
>> +		dev_info(nor->dev, "ISSI Block Protection Bits cleared\n");
>> +		return 0;
>
> Is the dev_info() really needed ?

Nope.  I'll spin a v2 pending the above discussion.

>> +	} else {
>> +		dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
>> +		return -EINVAL;
>> +	}
>> +}
>
> [...]

Thanks!
