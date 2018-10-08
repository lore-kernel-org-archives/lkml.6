Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDE4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D303120652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WS7nJHXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D303120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJHWry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:47:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47288 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJHWrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:47:53 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98FZD0C049781;
        Mon, 8 Oct 2018 10:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539012913;
        bh=sAGCdweilGU63fcAfGKalTLbeQCgJyxx3b/sEKRd5bk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WS7nJHXKtAWLjtRrwcJqvbklbH/JrVxOxZRyL1VJN6HHVuPKvQPYGxmNJAfbZs2fl
         lvl/9xJHoCSMdgVftm7RzcHguI76q9P4TYZ/2APPJDQ92EnztQS+CH/xa8cV76Qay0
         c6CJsrkNfr7Z39RuWMi5nwr1ebS10bEqvnga8pik=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98FZDLl023966;
        Mon, 8 Oct 2018 10:35:13 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 10:35:12 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 10:35:12 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98FZ8Vf030679;
        Mon, 8 Oct 2018 10:35:09 -0500
Subject: Re: [PATCH 0/3] spi-nor: Add Octal SPI support
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003212017.653e739f@bbrezillon>
 <1074d503-71ef-2998-7096-de6135bb965d@ti.com>
 <20181004131732.4c9e2ae9@bbrezillon>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <e4af1014-2008-440c-a017-bb8e7e960d3b@ti.com>
Date:   Mon, 8 Oct 2018 21:06:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004131732.4c9e2ae9@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Sorry I missed this mail.

On Thursday 04 October 2018 04:47 PM, Boris Brezillon wrote:
> On Thu, 4 Oct 2018 16:05:36 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>>>>
>>>>  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
>>>>  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++  
>>>
>>> On a slightly different topic, do you plan to convert the Cadence
>>> driver to spi-mem? And if you don't, is it because you don't have time
>>> or because some features are missing in spi-mem (I remember you
>>> mentioned a few things back when you were reviewing the spi-mem series)?
>>>   
>>
>> I do not have plans to convert cadence QSPI driver to spi-mem yet,
>> mainly due to lack of time. Also, not sure if original author Marek and
>> other altera people are okay with that.
>>
>> I see couple of issues in the way of conversion:
>> 1. I would wait to know what direction would direct mapping APIs[1] go
>> before starting spi-mem conversion for Cadence QSPI driver. Else, we
>> have may to re write again if direct mapping APIs are merged.
> 
> I'd suggest reviewing the proposal I posted so that you can influence
> the design of this new API ;-).
> 

I did take a look and proposal seems fine. Will try to prototype and
test cadence QSPI driver with these. Thanks for the patches!


>> 2. New Cadence OSPI IP has an integrated PHY to support high throughput
>> OSPI flashes operating up 200MHz in Octal DDR mode. In order to work
>> with such flashes, PHY DLLs need to be calibrated. Highly simplified
>> calibration sequence is as below(See [2] for actual sequence):
>> -Read flash ID at low speed and store it.
>> -Enable PHY and set DLLs to a defined initial value
>> -Increment RX DLL value
>> -Read flash ID and check for correctness of data read
>> -repeat above two steps until a band of passing values is obtained for
>> RX DLL where flash ID is correctly read.
>> -DLL needs to set to middle of the passing band.
> 
> Is the Read ID operation hardcoded or do you just use it as a way to
> trigger predictable transfers on the IO bus?
> 

Just a way to trigger predictable data reads.

>>
>> I am trying to figure out how to fit this into the spi-mem framework as
>> controller would to need to store READ ID opcode and expected JEDEC ID
>> before starting calibration sequence.
> 
> I think this should be split in 2:
> 
> - the SPI NOR framework passing the operation to use to do the
>   calibration (here a READ ID)
> - the SPI controller framework replaying the same operation with
>   different DLL configs until it finds the best match
> 
> So, it would basically be added as a new hook:
> 
> 	int (*calibrate)(struct spi_mem *mem,
> 			 const struct spi_mem_op *tmpl);
> 
> and a new function provided by the spi-mem API
> 
> int spi_mem_calibrate(struct spi_mem *mem,
> 		      const struct spi_mem_op *tmpl);
> 
> and calibration outcome would be somehow attached to the spi_mem
> object.
> 
> This way we stay memory agnostic but still provide the necessary blocks
> at the spi-mem level to do such callibrations.
> 
> Would that work?
> 

That would work and hopefully is not intrusive to spi-mem framework.

-- 
Regards
Vignesh
