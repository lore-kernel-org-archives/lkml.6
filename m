Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E974C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A22221779
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLzpsSTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A22221779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbeHGNkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:40:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53520 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeHGNkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:40:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so17040180wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yGyDqFg83fyT9zOduxwG93Rvdw7KtKF7RpsxnR7LJ24=;
        b=rLzpsSTP58Fkz6FjRJPY1Kme5G1+1Ih4pRhDSiw6p1v86gjx6bDilmEAvrgpwLEkgj
         DihMn2uWmKmokSWXbERl5T4B9tdnYqLP+7B/9+uyREhcP1KoPczja3ILkcv7gB14UVdg
         E+1j1eg/15ajZdyJxKbBtYGlOdqOkWsB3bPOwVN2JfntBptCUn0yJ9LdTJU0RIS4StXG
         x5EvoBHTOhOn7H6ADLTWMxBJTh7a8lrpCLdpmklxaGuuLdERPlHgq0pg2PfmXKM0GGjX
         I0ye66Ao4H2BEGCUGMXgG7tiLKusYtU1cNBQMpopZyQKsccEJaly8X2EoID6bHWjJvWj
         FAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yGyDqFg83fyT9zOduxwG93Rvdw7KtKF7RpsxnR7LJ24=;
        b=A9ZvqxuEQs7E7z4CMD+UIF8mEl4cTb6JZQUcERtk7fpfntfI1tN+ogYRL492HAMsS9
         7C07gVIV26RXDFvB226d9zZJMJdt6RZAGBGd0GhEjYgWS4YZZXofGJaXLI3/uly8W4ZA
         INU6cHYC1ZYeTuRiM7laQE5guYfwP74NbolT7oj1ZTuufciKFtCgxaMrBNiR+d/j4Byd
         6sgKEebkzzLCg8OiDc81F6OKBCZ/RO3ex6qwykU+S1dI3R3P3qhKag9CEOnOO1ubp/vf
         9c2r4AUm21Hq7W0WEvpzB8bah5qWg30oa4bJqUwPo955dnLrdDP0bzSE2n9/5VObRI8M
         MDXA==
X-Gm-Message-State: AOUpUlEZE9/fW5Zp+kttleqCLkT8Yvn+OYD0TXBsQur8eF6FAoXv+EEE
        DMj3pBBdBLVvH/mF/Suw7o0=
X-Google-Smtp-Source: AA+uWPy0wlcb5On6c0hgOVfNIGoM2Yz9MY+2BljbbEvwN4hqEvGBcA4C+PhT1rDjeUGaMUDj8xJ+Sg==
X-Received: by 2002:a1c:6354:: with SMTP id x81-v6mr1296015wmb.23.1533641185408;
        Tue, 07 Aug 2018 04:26:25 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id o14-v6sm2260295wmd.35.2018.08.07.04.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 04:26:24 -0700 (PDT)
Subject: Re: [PATCH] spi-nor: add support for is25wp256d
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-mtd@lists.infradead.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, linux-kernel@vger.kernel.org,
        Wesley Terpstra <wesley@sifive.com>
References: <mhng-e542ffb6-757f-49a3-9fdd-6d1c1400dc52@palmer-si-x1c4>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a74c6e59-e496-4594-f505-4111eac9f2a1@gmail.com>
Date:   Tue, 7 Aug 2018 13:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <mhng-e542ffb6-757f-49a3-9fdd-6d1c1400dc52@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2018 02:11 AM, Palmer Dabbelt wrote:
> On Mon, 06 Aug 2018 14:05:11 PDT (-0700), marek.vasut@gmail.com wrote:
>> On 08/06/2018 10:58 PM, Palmer Dabbelt wrote:
>>> On Sat, 04 Aug 2018 02:27:54 PDT (-0700), marek.vasut@gmail.com wrote:
>>>> On 08/04/2018 03:49 AM, Palmer Dabbelt wrote:
>>>>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>>>>
>>>>> This is used of the HiFive Unleashed development board.
>>>>>
>>>>> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>>>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>>>> ---
>>>>>  drivers/mtd/spi-nor/spi-nor.c | 47
>>>>> ++++++++++++++++++++++++++++++++++++++++++-
>>>>>  include/linux/mtd/spi-nor.h   |  2 ++
>>>>>  2 files changed, 48 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c
>>>>> b/drivers/mtd/spi-nor/spi-nor.c
>>>>> index d9c368c44194..e9a3557a3c23 100644
>>>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>>>> @@ -1072,6 +1072,9 @@ static const struct flash_info spi_nor_ids[] = {
>>>>>              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>>>>      { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
>>>>>              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>>>> +    { "is25wp256d", INFO(0x9d7019, 0, 32 * 1024, 1024,
>>>>
>>>> Is there a reason for the trailing 'd' in is25wp256d ? I'd drop it.
>>>
>>> I'm honestly not sure.  There are data sheets for both of them, but I
>>> don't see much of a difference
>>>
>>>    http://www.issi.com/WW/pdf/IS25LP(WP)256D.pdf
>>>    http://www.issi.com/WW/pdf/25LP-WP256.pdf
>>>
>>> Following the pattern, I'd expect to see
>>>
>>>        { "is25wp256",  INFO(0x9d7019, 0, 64 * 1024, 512,
>>>                        SECT_4K | SPI_NOR_DUAL_READ |
>>> SPI_NOR_QUAD_READ) },
>>>
>>> versus
>>>
>>>        { "is25wp256d", INFO(0x9d7019, 0, 32 * 1024, 1024,
>>>                        SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>>> SPI_NOR_4B_OPCODES)
>>>        },
>>
>> They have the same ID ? Do we support the variant without the d already?
> 
> Sorry for being a bit vague there.  There is no is25wp256 in the list
> already, but if I follow the pattern from the other similar chips I get
> a different value for is25wp256 than what was proposed in the patch for
> an is25wp256d.  From my understanding the different values are just
> because we picked a different block size, which seems possible because
> the original version of this patch was written before the other is25wp
> devices were added to the list.

The erase block size of is25wp256(d) is 4k, it supports 32k bulk erase
and 64k bulk erase too. 32k blocks will simply be erased using 8 4k
erase operations.

What would really be useful here is to extract what are the erase block
properties of the flash from SFDP tables (if they are supported) and
then calculate the best way to erase the flash. But this might be a
micro optimization and it's something that can be done later. There's
even some patchset in the ML which tried adding this a few months ago.

> What I'm proposing is adding an is25wp256 with the same block size as
> the other similar entries in the list.  Looking at the data sheets they
> appear to have the same values for the "Read Product Identification"
> instruction.

I think that's a good start.

> The data sheets are shared with the is25lp256, which there is an entry
> for and matches my expected ID and block sizes.
> 
>>> So in other words: the d less sections that are larger, and also has the
>>> 4B opcodes flag set.  From the documentation in looks like the non-d
>>> version supports 3 and 4 byte opcodes, so I guess it's just a different
>>> physical layout?
>>>
>>> In the data sheet for both I see
>>>
>>>    "Pages can be erased in groups of 4Kbyte sectors, 32Kbyte blocks,
>>> 64Kbyte    blocks, and/or the entire chip"
>>>
>>> which indicates to me that maybe we've just selected the larger section
>>> size?  If so then I'll change it to the first one in the new patch.
>>>
>>>>> +                    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ
>>>>> | SPI_NOR_4B_OPCODES)
>>>>> +    },
>>>>>
>>>>>      /* Macronix */
>>>>>      { "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
>>>>> @@ -1515,6 +1518,45 @@ static int macronix_quad_enable(struct spi_nor
>>>>> *nor)
>>>>>      return 0;
>>>>>  }
>>>>>
>>>>> +/**
>>>>> + * issi_unlock() - clear BP[0123] write-protection.
>>>>> + * @nor:    pointer to a 'struct spi_nor'
>>>>> + *
>>>>> + * Bits [2345] of the Status Register are BP[0123].
>>>>> + * ISSI chips use a different block protection scheme than other
>>>>> chips.
>>>>> + * Just disable the write-protect unilaterally.
>>>>> + *
>>>>> + * Return: 0 on success, -errno otherwise.
>>>>> + */
>>>>> +static int issi_unlock(struct spi_nor *nor)
>>>>> +{
>>>>> +    int ret, val;
>>>>> +    u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
>>>>> +
>>>>> +    val = read_sr(nor);
>>>>> +    if (val < 0)
>>>>> +        return val;
>>>>> +    if (!(val & mask))
>>>>> +        return 0;
>>>>> +
>>>>> +    write_enable(nor);
>>>>> +
>>>>> +    write_sr(nor, val & ~mask);
>>>>> +
>>>>> +    ret = spi_nor_wait_till_ready(nor);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    ret = read_sr(nor);
>>>>> +    if (ret > 0 && !(ret & mask)) {
>>>>> +        dev_info(nor->dev, "ISSI Block Protection Bits cleared\n");
>>>>> +        return 0;
>>>>
>>>> Is the dev_info() really needed ?
>>>
>>> Nope.  I'll spin a v2 pending the above discussion.
>>>
>>>>> +    } else {
>>>>> +        dev_err(nor->dev, "ISSI Block Protection Bits not
>>>>> cleared\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +}
>>>>
>>>> [...]
>>>
>>> Thanks!


-- 
Best regards,
Marek Vasut
