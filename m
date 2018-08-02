Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB93C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2392720895
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="PrsAWzEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2392720895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbeHBMh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:37:29 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.135]:26395 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeHBMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533206809;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Dwuepp3Kz8OY7lkVU6bYf0lR1ZRzlSASh5OstA1ZZwo=;
        b=PrsAWzEdzKBhjZ6kcGJbKPkqrl2pMaq/5NCBI/cKlzZCvEmG+lFcjqT+BoB/oDG+fN
        H92pQ13Dp32jqIQhvVDo/bmtDPj27yaVyjvMskzDfdpjC6vvXWSWUy3FsvLQUlJjkd5o
        FZrOzjbY2viQTdnVo8t0p0o3R1HYjZorLIdP8bjFrdyrOrwGv1SHuR5cHmrFVp+tbEQH
        eUgsMZgdxNSXaOIerwjqC21DhKS8ev/okeDvn+p/Nyp1B6EElEwtRAuiSO5gU9D94uSc
        DeyjBK41Ewd7Uv//eL0lqYDBD7M7WwFoXkmdToFhswpzjARj9MUSLOtdYoywcouPwdLh
        faSA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PCGcNaCZVo5Ii+ho54367TWBV/lW2wDTBEfJgEO"
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:24f5:3a00:953c:3d9b:ce66:61a3]
        by smtp.strato.de (RZmta 43.14 AUTH)
        with ESMTPSA id Z0998bu72Aka6n7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 2 Aug 2018 12:46:36 +0200 (CEST)
Subject: Re: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
To:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Piotr Bugalski <pbu@cryptera.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
 <20180801172747.GJ5509@sirena.org.uk> <20180801215733.4dfa3a95@bbrezillon>
 <20180802101742.GF9117@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <6f9ca4f1-6809-2d7d-4d64-6869a4e413cb@exceet.de>
Date:   Thu, 2 Aug 2018 12:46:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802101742.GF9117@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 02.08.2018 12:17, Mark Brown wrote:
> On Wed, Aug 01, 2018 at 09:57:33PM +0200, Boris Brezillon wrote:
>> Mark Brown <broonie@kernel.org> wrote:
> 
>> 2/ Getting this patch [1] merged and implementing the ->get_name() hook
>>     in this driver so that SPI NOR devs declared to the MTD layer keep
>>     the same name after the transition to spi-mem and mtdparts= passed on
>>     the cmdline keep working. Without this in place we're likely to
>>     break a few setups :-/.
> 
>> [1]https://patchwork.kernel.org/patch/10508693/
> 
> I don't seem to have a copy of this patch...  not sure it was sent to
> me?

When I sent the patch I put you in cc. So if nothing went wrong you 
should have it.
It is part of the SPI MEM conversion series for the FSL QSPI driver [1].

Boris made some remarks on documentation in v2, that I have fixed, but 
not sent out yet, as we have some blocking issues with the driver itself.

So if you want I could send the patch separately so it can be applied 
with the Atmel driver.

Regards,
Frieder

[1] https://patchwork.ozlabs.org/cover/939864/
