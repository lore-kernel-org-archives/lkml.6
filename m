Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A31C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428022151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="kqjkVUqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428022151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbeHBPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:31:24 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.183]:8907 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbeHBPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533217207;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=XoBHanx106dBm+xMdZmpFt30YQy4RxYwe0FGS+sQkD4=;
        b=kqjkVUqFbPIL9VBEF7sT43/yDBKL1r5DNQ9oL5i3cSQR8waHvYqEevoD7LRH3TlpCU
        v31Qm+chEt+0AQFMBfPfI9SGpPFKy3zuhtQzUqlfNuC0AjWbRgxiqk0l4STMYVwHldzc
        2QfTuMYe3NDefJzkIG1iDjsPSx7J+9NLTPmJ5T/7J8oEadkO8N/ol0GkHTl8soCbKF3w
        neo55YeCEXBWxztA6VAq2BHVRwoo1K4UepK0CzvtMnO4RDcFjQ7zwmLWHTk5RzZoGhJz
        FwmnGVLdz3+o+DuyA8HbxvKXhCXVrko61vGcVnRGnqnKq/3a1Eq7C+IerbQ5JzzxKI9o
        gZkA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PCGcNaCZVo5Ii+ho54367TWBV/lW2wDTBEfJgEO"
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:24f5:3a00:953c:3d9b:ce66:61a3]
        by smtp.strato.de (RZmta 43.14 AUTH)
        with ESMTPSA id Z0998bu72DdI7eU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 2 Aug 2018 15:39:18 +0200 (CEST)
Subject: Re: [PATCH v3 1/3] spi: spi-mem: Fix a typo in the documentation of
 struct spi_mem
To:     Boris Brezillon <boris.brezillon@bootlin.com>, broonie@kernel.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, pp@emlix.com, Zhiqiang.Hou@nxp.com,
        linux-kernel@vger.kernel.org
References: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
 <1533214434-28761-2-git-send-email-frieder.schrempf@exceet.de>
 <20180802150945.44cc8328@bbrezillon>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <8a365fb9-ab9b-b8f1-6dbe-587c6b9b8ad2@exceet.de>
Date:   Thu, 2 Aug 2018 15:39:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802150945.44cc8328@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, hi Mark,

On 02.08.2018 15:09, Boris Brezillon wrote:
> On Thu,  2 Aug 2018 14:53:52 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
> We usually try to avoid empty commit message, even if this one is
> pretty obvious, I'd suggest adding something here.
> 
> "
> Fix a typo in the @drvpriv description.
> "
> 
> ?

Forgot the commit message, sorry.

Mark, can you add it when you apply the patch or should I send a new 
version?

Thanks,
Frieder

> 
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> 
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
>> ---
>>   include/linux/spi/spi-mem.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index 4fa34a2..72cc9bc 100644
>> --- a/include/linux/spi/spi-mem.h
>> +++ b/include/linux/spi/spi-mem.h
>> @@ -124,7 +124,7 @@ struct spi_mem_op {
>>   /**
>>    * struct spi_mem - describes a SPI memory device
>>    * @spi: the underlying SPI device
>> - * @drvpriv: spi_mem_drviver private data
>> + * @drvpriv: spi_mem_driver private data
>>    *
>>    * Extra information that describe the SPI memory device and may be needed by
>>    * the controller to properly handle this device should be placed here.
> 
