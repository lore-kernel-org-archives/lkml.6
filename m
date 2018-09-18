Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC6521471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="MzREjuOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC6521471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeIROGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:06:00 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.133]:9499 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbeIROGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1537259665;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=uboZHCVQpMfFzFtYlDbCzyyXBtvtmc9S/VEaWpa7HBU=;
        b=MzREjuOEWm6wKgn7x+FAWWnr9BRSRI9OOgdSGQ85nwrWX+ZvIDJen0nWf8KfjJFRHa
        d89kKG/IIptMDSnisnx9X9rH37/JgT4bijpCaM6TdXnj+y8E6SPPcxVA4N4hCZraZcSj
        Jh/a2kvsnSG8435svVrA36UuwL98VL9Vzww2AXRaS8rH39dFnALSa96bK8J6N3IGN/PR
        CHEBc9OsMWRV+EwC+2cRAesvMsdPXxM+0B9hxwPOCdHDocutGjbbn6hWroEwuZhTbuPG
        XwDdFf3vz/cmBJyQoMCgFNA9958KBj9feo7rOMHUfJ3A9rtsunvmR35AR4Qa9WG6QCjk
        r7nA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 44.1 AUTH)
        with ESMTPSA id C0b243u8I8MHDaz
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 18 Sep 2018 10:22:17 +0200 (CEST)
Subject: Re: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        linux-kernel@vger.kernel.org
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180917133751.453ea6ed@bbrezillon>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <9529c765-cb3b-02f9-df15-4f79cfa48e47@exceet.de>
Date:   Tue, 18 Sep 2018 10:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917133751.453ea6ed@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, Yogesh,

On 17.09.2018 13:37, Boris Brezillon wrote:
> Hi Yogesh,
> 
> On Mon, 17 Sep 2018 15:18:26 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>> +
>> +	/*
>> +	 * R/W functions for big- or little-endian registers:
>> +	 * The FSPI controller's endianness is independent of
>> +	 * the CPU core's endianness. So far, although the CPU
>> +	 * core is little-endian the FSPI controller can use
>> +	 * big-endian or little-endian.
>> +	 */
>> +	if (of_property_read_bool(np, "big-endian")) {
>> +		f->write = fspi_writel_be;
>> +		f->read = fspi_readl_be;
>> +	} else {
>> +		f->write = fspi_writel;
>> +		f->read = fspi_readl;
>> +	}
> 
> Hm, isn't it something you can extract from the compatible string? I'd
> rather not allow users to set that in their DT if it's not something
> you can change.

This was copied from the QSPI driver, but I think Boris is right. This 
seems to be a fixed SOC-specific setting and we shouldn't set it in the 
DT. This applies to QSPI and FSPI alike.

Regards,
Frieder

> 
> Regards,
> 
> Boris
> 
