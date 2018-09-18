Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BB5ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4712821471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="s1coq/ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712821471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeIRQYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:24:18 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.132]:27847 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeIRQYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1537267933;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Xb7BJAVJCVyD+9ZBtAdAYXSfZem1NOoivnl0dp5tOxs=;
        b=s1coq/ib+yh41mXRzQeDXcdzlXvSJiW+9efY5STcLMO3bWD+dDW4dD2KIKT7aMdzjs
        AOxit4XhWDcy/KWzJwOu6lXJ4m7SfdYYzoyCSUyhHcQ/ohq7mxSQfGETZ5sZvYXyCUFx
        7NS5JJZgOZKceaEW49AuDuVV+8LjhGpCiCVkgdkhCSCyzMOVIswdWzkZv0NpkynFjQvj
        FoefAxahwXoBxh95+xZKHBmghhNLN3sVeSwC3L4vokWlPb3zy4R7hRfmAXhlt/qU35bD
        qgxpPW0SaYGaW5SYQ//XJMlZ5EJWhAMgAhGFOuZnYqzpDUIBeaFSSk3KZCT4jpsP5Dup
        xCbw==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 44.1 AUTH)
        with ESMTPSA id C0b243u8IAppEeT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 18 Sep 2018 12:51:51 +0200 (CEST)
Subject: Re: [PATCH] mtd: spi-nor: Support controllers with limited TX FIFO
 size
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, marek.vasut@gmail.com
Cc:     linux-mtd@lists.infradead.org, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        prabhakar.kushwaha@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
References: <1528870092-14526-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180709233427.1a714de7@bbrezillon>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <81e0653f-1e07-6ec9-f12a-d448e269c87a@exceet.de>
Date:   Tue, 18 Sep 2018 12:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180709233427.1a714de7@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek, hi Boris,

On 09.07.2018 23:34, Boris Brezillon wrote:
> +Fabio
> 
> Hi Yogesh,
> 
> On Wed, 13 Jun 2018 11:38:12 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>> Some SPI controllers can't write nor->page_size bytes in a single
>> step because their TX FIFO is too small.
>>
>> Allow nor->write() to return a size that is smaller than the requested
>> write size to gracefully handle this case.
> 
> There's been a discussion between Marek and I regarding this patch and
> patch "mtd: devices: m25p80: Make sure WRITE_EN is issued before each
> write". Marek would like to avoid letting drivers do non-aligned page
> writes when the MTD user requested full page writes.
> 
> So, the question is, is the FSL QSPI engine capable of handling that
> when the NOR page is being than the TX FIFO? According to the current
> implementation it's not [1], but it looks like we have a way to
> know when the TX FIFO is not full so we could potentially refill the
> FIFO either from the CPU or using DMA if that's possible (not sure the
> eDMA engine can fill the QSPI TX FIFO directly).
> 
> What I find worrisome with this solution is this particular statement
> in the datasheet:
> 
> "
> When the QuadSPI module tries to pull data out of an empty TX Buffer
> the TX Buffer underrun is signaled by the QSPI_FR[TBUF] flag. The
> current IP Command leading to the underrun condition is continued until
> the specified number of bytes has been sent to the serial flash device,
> in the underrun condition when QuadSPI module tries to pull out data of
> empty TX buffer, the data transferred is undefined i.e. once the
> underrun flag is set, it will return the garbage value until the
> required number of bytes are not sent.
> "
> 
> If we fail to fill the TX FIFO fast enough for any reasons (contention
> on the APB/AHB/AXI bus in case of DMA, task being scheduled out in
> case of PIO access), that means we transfer garbage to the NOR...
> Clearly something we should avoid at any cost.
> 
> Yogesh, Fabio, Han, any comment on this?

I want to revive the discussion about this patch. Meanwhile we have 
received confirmation from NXP, that the hardware can't handle writing 
data chunks bigger than the TX buffer size, even when we use DMA to 
refill the buffer [1].

This means, that this patch is required to get the FSL QSPI driver 
working with the SPI mem framework.

Could you please reconsider this patch?

Thanks,
Frieder

[1] 
http://lists.infradead.org/pipermail/linux-mtd/2018-September/083799.html

> 
> Thanks,
> 
> Boris
> 
> [1]https://elixir.bootlin.com/linux/v4.18-rc4/source/drivers/mtd/spi-nor/fsl-quadspi.c#L1117
> 
>>
>> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>> ---
>>   drivers/mtd/spi-nor/spi-nor.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 5bfa36e..3e63543 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>   			goto write_err;
>>   		*retlen += written;
>>   		i += written;
>> -		if (written != page_remain) {
>> -			dev_err(nor->dev,
>> -				"While writing %zu bytes written %zd bytes\n",
>> -				page_remain, written);
>> -			ret = -EIO;
>> -			goto write_err;
>> -		}
>>   	}
>>   
>>   write_err:
> 
