Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB21C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036E624090
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="Z48lpZ/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036E624090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeGENG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:06:57 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:11331 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeGENGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530796013;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mbyFrjZWSsX3YQapzc40Bgl6MdJT8Jc+gvJKB1WOK5w=;
        b=Z48lpZ/LYrl2+8juxx/32LZ96vABgEla7rJUvmU4pQJ1Q6aXZZJDmAj9ok0Ub2o/PO
        J4Qe+JnzXVwHZWnd4gxkwdnnpkxhEZosCYke47JhGgv2NGRydJinR28Q3IgTCa6sb4HQ
        eYCVIdNaUJs4r1TCmOcAwdMVZNtVxUTAX9QqI4QeZUvMTn39E30h6PbNVyWla0xJcJHD
        eIBnodSHX3PPO3Ivcofnxr97Wl23YxG1fB5bpjnPgiWjbOqdtXL9EsH1xDOmuZ2l366L
        E+O5Xp6j4T3oBA2sqsyr0+Ht/JYmXvs+hmz2YZAjCaLqsHF1E7ocpULkvdTboyFORV2U
        uVjw==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PCFdNZH2BF76edXG8zA2WbJnpA0Nwl+86N2gwDA"
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:24e1:ab00:a194:de65:a5e4:e302]
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65D615I1
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 15:06:01 +0200 (CEST)
Subject: Re: [PATCH v2 02/12] mtd: m25p80: Call spi_mem_get_name() to let
 controller set a custom name
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Philipp Puschmann <pp@emlix.com>, linux-kernel@vger.kernel.org
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-3-git-send-email-frieder.schrempf@exceet.de>
 <20180705145628.57a48e87@bbrezillon>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <abcd1bc3-9ce7-0402-86f6-d43dacad0fb5@exceet.de>
Date:   Thu, 5 Jul 2018 15:06:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705145628.57a48e87@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 05.07.2018 14:56, Boris Brezillon wrote:
> On Thu,  5 Jul 2018 13:14:58 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
>> By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
>> set a custom name for the memory device if necessary.
>> This is useful to keep mtdparts compatible when controller drivers are
>> ported from the MTD to the SPI layer.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>>   drivers/mtd/devices/m25p80.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index e84563d..482f0ef 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -199,8 +199,7 @@ static int m25p_probe(struct spi_mem *spimem)
>>   			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>>   	}
>>   
>> -	if (data && data->name)
>> -		nor->mtd.name = data->name;
>> +	nor->mtd.name = spi_mem_get_name(spimem);
> 
> Hm, not sure you can do that without breaking setup that pass a
> flash_platform_data object with a name.
> 
> Also, you should keep the name extracted from the label property if any
> (this is done earlier, when spi_nor_set_flash_node() is called).
> 
> 	if (data && data->name)
> 		nor->mtd.name = data->name;
> 
> 	if (!nor->mtd.name)
> 		nor->mtd.name = spi_mem_get_name(spimem);

I missed both facts, that data could be passed with a name assigned 
already and that spi_nor_set_flash_node() might assign a name from dt.
I should have looked at the code more closely.

Thanks for pointing that out. I'll fix it.

Frieder

> 
>>   
>>   	/* For some (historical?) reason many platforms provide two different
>>   	 * names in flash_platform_data: "name" and "type". Quite often name is
> 
