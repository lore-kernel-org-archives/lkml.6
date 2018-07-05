Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D662C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B012924095
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="SQdi2w2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B012924095
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeGEMvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:51:41 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:31727 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbeGEMvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530795089;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TcP4AnQ2uX08iPKHm0Xs9abWiIfkP7gV5Iq85s4/1ew=;
        b=SQdi2w2WX3eJkx6geXSVarpVraKgC3UnjZVyke6dXFYK+Gy6S4AdsMmAXWYo2xs/Wf
        ynfunYSKvAGaUh4uPHWx+1cV2ZXyfExJSZeq1QEclunK09Csp7wKXldJwZ6OrvYGtGtk
        Iq5HJwLdsb+HF+29UGF5peXqXv24aKF2nMhRILiS9HPL1HsnuLFkEiQRDIjuepFWCKNw
        fMsFA/M5b/q2uHgR+basS+RnXzM7EsxdgcIylxJOEOkLPuNSMDI2QPViYLhXeamroMk+
        3k+KxBEK7qbDwW2SO3lDI1GIXjfSSpmoGBH1nGv2Jd8IpaiF647cV2hFMKlrKeoKbGMJ
        XfWA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PCFdNZH2BF76edXG8zA2WbJnpA0Nwl+86N2gwDA"
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:24e1:ab00:a194:de65:a5e4:e302]
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65Con5Cb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 14:50:49 +0200 (CEST)
Subject: Re: [PATCH v2 01/12] spi: spi-mem: Extend the SPI mem interface to
 set a custom memory name
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-2-git-send-email-frieder.schrempf@exceet.de>
 <20180705143948.2c864bf6@bbrezillon>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <b478c9a2-2c58-bbd7-1a9b-66d8c86ccc45@exceet.de>
Date:   Thu, 5 Jul 2018 14:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705143948.2c864bf6@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 05.07.2018 14:39, Boris Brezillon wrote:
> Hi Frieder,
> 
> On Thu,  5 Jul 2018 13:14:57 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
>> When porting (Q)SPI controller drivers from the MTD layer to the SPI
>> layer, the naming scheme for the memory devices changes. To be able
>> to keep compatibility with the old drivers naming scheme, a function
>> is added to the SPI mem interface to let controller drivers set a
>> custom name for the memory.
>>
>> Example for the FSL QSPI driver:
>>
>> Name with the old driver: 21e0000.qspi,
>> or with multiple devices: 21e0000.qspi-0, 21e0000.qspi-1, ...
>>
>> Name with the new driver without spi_mem_get_name: spi4.0
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>> Changes in v2:
>> ==============
>> * Add a name field to struct spi_mem and fill it while probing
>>
>>   drivers/spi/spi-mem.c       | 30 ++++++++++++++++++++++++++++++
>>   include/linux/spi/spi-mem.h |  7 ++++++-
>>   2 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 990770d..048101c 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -311,6 +311,26 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>   EXPORT_SYMBOL_GPL(spi_mem_exec_op);
>>   
>>   /**
>> + * spi_mem_get_name() - Let drivers using the SPI mem interface specify a
>> + *			custom name for the memory to avoid compatibility
>> + *			issues with ported drivers.
> 
> You're not describing what this function does, but why it was
> introduced. Not sure the spi-mem user/driver cares about that, these are
> just internal details. Probably something you should put in the
> ->get_name() hook doc.

Ok. You're right.

> 
>> + * @mem: the SPI memory
>> + *
>> + * When porting (Q)SPI controller drivers from the MTD layer to the SPI
>> + * layer, the naming scheme for the memory devices changes. To be able to
>> + * keep compatibility with the old drivers naming scheme, this function can
>> + * be used to get a custom name from the controller driver.
>> + * If no custom name is available, the name of the SPI device is returned.
> 
> Ditto. Just say that this function returns the spi-mem device name which
> can be used by the upper layer if they need to expose a user-friendly
> name.

Ok.

> 
>> + *
>> + * Return: a char array that contains the name for the flash memory
> 
> 	      ^ a string?
> 
>       Return: a string containing the name of the memory device to be
> 	     used by the spi-mem user

Ok.

> 
>> + */
>> +const char *spi_mem_get_name(struct spi_mem *mem)
>> +{
>> +	return mem->name;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_mem_get_name);
>> +
>> +/**
>>    * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
>>    *			      match controller limitations
>>    * @mem: the SPI memory
>> @@ -344,6 +364,7 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
>>   static int spi_mem_probe(struct spi_device *spi)
>>   {
>>   	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
>> +	struct spi_controller *ctlr = spi->controller;
>>   	struct spi_mem *mem;
>>   
>>   	mem = devm_kzalloc(&spi->dev, sizeof(*mem), GFP_KERNEL);
>> @@ -351,6 +372,15 @@ static int spi_mem_probe(struct spi_device *spi)
>>   		return -ENOMEM;
>>   
>>   	mem->spi = spi;
>> +
>> +	if (ctlr->mem_ops && ctlr->mem_ops->get_name)
>> +		mem->name = ctlr->mem_ops->get_name(mem);
>> +	else
>> +		mem->name = dev_name(&spi->dev);
>> +
>> +	if (IS_ERR_OR_NULL(mem->name))
>> +		return PTR_ERR(mem->name);
>> +
>>   	spi_set_drvdata(spi, mem);
>>   
>>   	return memdrv->probe(mem);
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index 4fa34a2..c3f82d1 100644
>> --- a/include/linux/spi/spi-mem.h
>> +++ b/include/linux/spi/spi-mem.h
>> @@ -124,7 +124,8 @@ struct spi_mem_op {
>>   /**
>>    * struct spi_mem - describes a SPI memory device
>>    * @spi: the underlying SPI device
>> - * @drvpriv: spi_mem_drviver private data
>> + * @drvpriv: spi_mem_driver private data
> 
> Can you fix this typo in a separate patch?

Ok. I'll move it to a separate patch.

> 
>> + * @name: name of the SPI memory device
>>    *
>>    * Extra information that describe the SPI memory device and may be needed by
>>    * the controller to properly handle this device should be placed here.
>> @@ -135,6 +136,7 @@ struct spi_mem_op {
>>   struct spi_mem {
>>   	struct spi_device *spi;
>>   	void *drvpriv;
>> +	char *name;
>>   };
>>   
>>   /**
>> @@ -178,6 +180,7 @@ struct spi_controller_mem_ops {
>>   			    const struct spi_mem_op *op);
>>   	int (*exec_op)(struct spi_mem *mem,
>>   		       const struct spi_mem_op *op);
>> +	const char *(*get_name)(struct spi_mem *mem);
> 
> You forgot to document this hook. Also, it's important to mention that
> if the name returned by this function is dynamically allocated, it
> should be allocated with devm_xxxx(), because we don't have a
> ->free_name() function.

Indeed. I'll add the documentation.

Thanks,
Frieder

> 
>>   };
>>   
>>   /**
>> @@ -236,6 +239,8 @@ bool spi_mem_supports_op(struct spi_mem *mem,
>>   int spi_mem_exec_op(struct spi_mem *mem,
>>   		    const struct spi_mem_op *op);
>>   
>> +const char *spi_mem_get_name(struct spi_mem *mem);
>> +
>>   int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>>   				       struct module *owner);
>>   
> 
> Thanks,
> 
> Boris
> 
