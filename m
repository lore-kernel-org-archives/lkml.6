Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EB3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8639821A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOrhMi9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8639821A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbeHFXhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:37:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37177 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHFXhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:37:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so13703772wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z1/xRiopCH1JJLBp5FaA1uGwxByrV0iQVeuEGzSDLEA=;
        b=OOrhMi9dT2WoDV5btmeQAuo38GnJWaVRFVGT53J5FSB1cYP3i5LmYEJEKGIF+FS/Hp
         EfGf1g4h5YFkdQCZiHDjVHqzmSJT693p0SvYjMrFVSzqpUnm+QLwaklkbcHDxpb0sZJH
         t0f8uIjSPiabRuMmy4JYoi0qBdAr2zfO55dvQPwHVUNy7SPUBheLjzahXeniDa3w65pH
         Sfh0JffRRYwT/MXfd/+E0nbrswgHcR+kkoorrc90TCC3peBbA9MOhfQzQ/4n5kFaE4Ct
         KwhAXvp9XOtYF9oMEF5QhcnRQD6iUHvH8j0m6TB42b37OoQt5QsCFZuhYf68Mx90vNbr
         O4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z1/xRiopCH1JJLBp5FaA1uGwxByrV0iQVeuEGzSDLEA=;
        b=Woqerm4s9eKE8iX6NYTeSd+RScruYAbN8KezTfg7x1J33xn7DrCVEUFd6LQR2oJfdD
         6IHDtlQDzIuF2Vb/QmASfPFw3Z7stbuHdPgMZDBnN0ikuQY+0tj22q6ysohRuzzChBDV
         RfSXKVFmFlEG566/BaG2VCVOyU2EOPyqGhOYMEEogRW9XZACZ5juJzzA32/67QaHz2Tr
         ZEM+Lv0DlWMs0hCIHXa4K0/6TIiV6AB9YJ5bwVLlOCtyrMinBc8mkkU0gSn55pyOalo2
         Id9M4I94IOFylicK5+gMUH/vpSChEVUf8pQtHIBmVu+4+mO2JOv6sdwcLC47D90d1+gq
         yn2Q==
X-Gm-Message-State: AOUpUlEAMRp5yE71I0dQ7LXpwyaNKnD1hAYirj6UZHuBoJB+3aqJJ2m6
        7dXGB1FtC5fiwUr0O5Gk+zu3zucV
X-Google-Smtp-Source: AAOMgpe9ugA+MKqKRCFkOVoI6CbyV+PjNEZ6z72dBjRyiwsDatQv5jahFRBZM9AsMmsepM5x7C8j5g==
X-Received: by 2002:adf:9142:: with SMTP id j60-v6mr10259647wrj.180.1533590782310;
        Mon, 06 Aug 2018 14:26:22 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id r140-v6sm19913701wmd.7.2018.08.06.14.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 14:26:21 -0700 (PDT)
Subject: Re: [PATCH] spi-nor: add support for is25wp256d
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-mtd@lists.infradead.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, linux-kernel@vger.kernel.org,
        Wesley Terpstra <wesley@sifive.com>
References: <mhng-0f1dbb5d-9aa3-41c1-9cd6-c1f79b09ee4b@palmer-si-x1c4>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <e951a9b0-b365-5818-f66f-b48492d93eb2@gmail.com>
Date:   Mon, 6 Aug 2018 23:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <mhng-0f1dbb5d-9aa3-41c1-9cd6-c1f79b09ee4b@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 10:58 PM, Palmer Dabbelt wrote:
> On Sat, 04 Aug 2018 02:27:54 PDT (-0700), marek.vasut@gmail.com wrote:
>> On 08/04/2018 03:49 AM, Palmer Dabbelt wrote:
>>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>>
>>> This is used of the HiFive Unleashed development board.
>>>
>>> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>> ---
>>>  drivers/mtd/spi-nor/spi-nor.c | 47
>>> ++++++++++++++++++++++++++++++++++++++++++-
>>>  include/linux/mtd/spi-nor.h   |  2 ++
>>>  2 files changed, 48 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c
>>> b/drivers/mtd/spi-nor/spi-nor.c
>>> index d9c368c44194..e9a3557a3c23 100644
>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -1072,6 +1072,9 @@ static const struct flash_info spi_nor_ids[] = {
>>>              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>>      { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
>>>              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>> +    { "is25wp256d", INFO(0x9d7019, 0, 32 * 1024, 1024,
>>
>> Is there a reason for the trailing 'd' in is25wp256d ? I'd drop it.
> 
> I'm honestly not sure.  There are data sheets for both of them, but I
> don't see much of a difference
> 
>    http://www.issi.com/WW/pdf/IS25LP(WP)256D.pdf
>    http://www.issi.com/WW/pdf/25LP-WP256.pdf
> 
> Following the pattern, I'd expect to see
> 
>        { "is25wp256",  INFO(0x9d7019, 0, 64 * 1024, 512,
>                        SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> 
> versus
> 
>        { "is25wp256d", INFO(0x9d7019, 0, 32 * 1024, 1024,
>                        SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES)
>        },

They have the same ID ? Do we support the variant without the d already?

> So in other words: the d less sections that are larger, and also has the
> 4B opcodes flag set.  From the documentation in looks like the non-d
> version supports 3 and 4 byte opcodes, so I guess it's just a different
> physical layout?
> 
> In the data sheet for both I see
> 
>    "Pages can be erased in groups of 4Kbyte sectors, 32Kbyte blocks,
> 64Kbyte    blocks, and/or the entire chip"
> 
> which indicates to me that maybe we've just selected the larger section
> size?  If so then I'll change it to the first one in the new patch.
> 
>>> +                    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ
>>> | SPI_NOR_4B_OPCODES)
>>> +    },
>>>
>>>      /* Macronix */
>>>      { "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
>>> @@ -1515,6 +1518,45 @@ static int macronix_quad_enable(struct spi_nor
>>> *nor)
>>>      return 0;
>>>  }
>>>
>>> +/**
>>> + * issi_unlock() - clear BP[0123] write-protection.
>>> + * @nor:    pointer to a 'struct spi_nor'
>>> + *
>>> + * Bits [2345] of the Status Register are BP[0123].
>>> + * ISSI chips use a different block protection scheme than other chips.
>>> + * Just disable the write-protect unilaterally.
>>> + *
>>> + * Return: 0 on success, -errno otherwise.
>>> + */
>>> +static int issi_unlock(struct spi_nor *nor)
>>> +{
>>> +    int ret, val;
>>> +    u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
>>> +
>>> +    val = read_sr(nor);
>>> +    if (val < 0)
>>> +        return val;
>>> +    if (!(val & mask))
>>> +        return 0;
>>> +
>>> +    write_enable(nor);
>>> +
>>> +    write_sr(nor, val & ~mask);
>>> +
>>> +    ret = spi_nor_wait_till_ready(nor);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = read_sr(nor);
>>> +    if (ret > 0 && !(ret & mask)) {
>>> +        dev_info(nor->dev, "ISSI Block Protection Bits cleared\n");
>>> +        return 0;
>>
>> Is the dev_info() really needed ?
> 
> Nope.  I'll spin a v2 pending the above discussion.
> 
>>> +    } else {
>>> +        dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
>>> +        return -EINVAL;
>>> +    }
>>> +}
>>
>> [...]
> 
> Thanks!


-- 
Best regards,
Marek Vasut
