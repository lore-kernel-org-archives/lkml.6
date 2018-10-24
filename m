Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413EAECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4C82082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4C82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJYHNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:13:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43040 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYHNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:13:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9OMh1YJ039206;
        Wed, 24 Oct 2018 17:43:01 -0500
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9OMh0mc018570
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Oct 2018 17:43:01 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 24
 Oct 2018 17:43:00 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 24 Oct 2018 17:43:00 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OMh0jL026227;
        Wed, 24 Oct 2018 17:43:00 -0500
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com>
 <20181024202048.7e3534f7@bbrezillon>
 <99a506e3-d9d5-0d3e-26e1-031447c14857@ti.com>
 <20181024230432.66dd71df@bbrezillon>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <380d73a8-2e54-3cee-2fdd-c6e891df93f7@ti.com>
Date:   Wed, 24 Oct 2018 17:43:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024230432.66dd71df@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/18 4:04 PM, Boris Brezillon wrote:
> On Wed, 24 Oct 2018 15:25:17 -0500
> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> 
>> On 10/24/18 1:20 PM, Boris Brezillon wrote:
>>> Hi Arnd,
>>>
>>> On Mon, 22 Oct 2018 15:34:01 +0200
>>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>>>
>>>    
>>>> +
>>>> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master *master,
>>>> +					    u8 *bytes, int nbytes)
>>>> +{
>>>> +	readsl(master->regs + RX_FIFO, bytes, nbytes / 4);
>>>
>>> Vitor reported a problem with readsl(): this function expects the 2nd
>>> argument to be aligned on 32-bit, which is not guaranteed here. Unless
>>> you see a better solution, I'll switch back to a loop doing:
>>>
>>> 	for (i = 0; i < nbytes; i += 4) {
>>> 		u32 tmp = __raw_readl(...);
>>
>> Pls, do not use __raw io.
> 
> Except this is exactly what I want here, unless you have a
> replacement for "readl() without a mem-barrier and without endianness
> conversion"
> 

Not sure why endianness is the problem. readl_relaxed?
Sry, I've missed that this is part of the driver not i3c core,
so minor/ignore.

-- 
regards,
-grygorii
