Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15528C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD94120883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="oUNyu7n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD94120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbeGLIUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:20:39 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.133]:26133 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeGLIUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1531383129;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:Subject:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2bs3zpjns6tXIG05XhZmPu7U7M/eqF2d2jEoMtxdrrA=;
        b=oUNyu7n3CA8A/jW3Frg9v0DUBUChS6XOzDTh2ClB806/7w7xcCQWzSolGSBsV8SFIe
        OG++is5HlToy3aoBhBFD0AjCs5GImJJQGI32sUbzTHfD9Y/usCgw+1/AIY6hu8zybvzF
        LBlRQdx2HIdyIrUdqXrC2TZ1enmo0YJqrmojMfZBtG3Azze5KJ/Q6qplXrUyH0yLTTb/
        MRCzD1srElQ97yTfqpvrfHJZE/tXjaME7Kx1eyJlAHQ3IJOMuGLg5oUubATj284sPuIU
        9Y9ZX52pSJeXlN+QdwLnUWurWAofdX2dtIXnKYX/rnkEZpx/RQS2nvRLCqoytTHQuPa9
        sGNw==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PCFd9YT6GX08QoC8ogb0FwvlNKlCnkzs3Qyd3v/"
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:24e2:5300:490d:5c5c:8c42:ccc2]
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id z029adu6C8BK3Wp
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 12 Jul 2018 10:11:20 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v2 04/12] dt-bindings: spi: Move the bindings for the FSL
 QSPI driver
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, broonie@kernel.org, david.wolfe@nxp.com,
        fabio.estevam@nxp.com, prabhakar.kushwaha@nxp.com,
        yogeshnarayan.gaur@nxp.com, han.xu@nxp.com, shawnguo@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-5-git-send-email-frieder.schrempf@exceet.de>
 <20180711155404.GA15363@rob-hp-laptop>
Message-ID: <6ea89c5c-0a50-fade-7d72-ca5b804da418@exceet.de>
Date:   Thu, 12 Jul 2018 10:11:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711155404.GA15363@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11.07.2018 17:54, Rob Herring wrote:
> On Thu, Jul 05, 2018 at 01:15:00PM +0200, Frieder Schrempf wrote:
>> Move the documentation of the old SPI NOR driver to the place of the new
>> SPI memory interface based driver.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>> Changes in v2:
>> ==============
>> * Split the moving and editing of the dt-bindings in two patches
>>
>>   .../devicetree/bindings/mtd/fsl-quadspi.txt     | 65 --------------------
>>   .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 65 ++++++++++++++++++++
>>   2 files changed, 65 insertions(+), 65 deletions(-)
> 
> Next time, use the -M option so the move shows any real diffs.

Ok, I'll keep that in mind.

Thanks,
Frieder

> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
