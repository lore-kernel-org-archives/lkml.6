Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45187C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABC526732
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="c9rDhbw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABC526732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933504AbeFZI7B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:59:01 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.136]:16782 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932210AbeFZI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530003534;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+HePdy1XXWWJh2AoQ6XGeX1+mgQ5My9brBKj+G1lBoo=;
        b=c9rDhbw/l3ylGORdZlO3Il27tzpUx1fdPTE1vKq9rG16lzn2u6gP/lIVlGdJ8l6xKh
        z+aFxLzzYh/zttTJCXYapJWKo+ZQvKJ3rhajD1KUmXBO+cdjl1Vc/A+AmDYjfjf99fiT
        UOy65Hj7bHXXip7bD+Vlkx/nhTBZ1Vmm1Yg4Ovr8w4kwTgeBN1TO02+Nr5B/77yIZIBi
        39vw0GDF7Bp5JlLyH+ugTl9TV/RsLzaNsj2REguUbJ+slw381cTIOeIK4tzsRGVG2GFw
        C9WPZrDd5ycRmMJxYngXkKFFiH/Y7sAprXS+xiZhkMPLYFWhDY1GTUH+3P0RCnfJipVL
        NUnQ==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 43.11 AUTH)
        with ESMTPSA id 608bdcu5Q8wOHQU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 26 Jun 2018 10:58:24 +0200 (CEST)
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <20180611121618.40f4b609@bbrezillon>
 <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180612091328.67734adb@bbrezillon>
 <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180615145019.734f23a9@bbrezillon>
 <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180615155541.4f43e9bb@bbrezillon>
 <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180618211536.0bf44f55@bbrezillon>
 <VI1PR0402MB2845767966A437E0D376219799700@VI1PR0402MB2845.eurprd04.prod.outlook.com>
 <20180619092832.3b6c8f22@bbrezillon>
 <DB6PR0402MB2838FAF5CF0B0883EFAA3A9B99700@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180619104627.31cfd22e@bbrezillon>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <bc772ef1-5f3b-518b-3a02-ffcf7143d36d@exceet.de>
Date:   Tue, 26 Jun 2018 10:58:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619104627.31cfd22e@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, hi Yogesh,

first, thank you for testing and debugging the new driver.

On 19.06.2018 10:46, Boris Brezillon wrote:
> On Tue, 19 Jun 2018 08:31:25 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>
[...]
>>>
>>> On Tue, 19 Jun 2018 07:10:37 +0000
>>> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>>>    
>>>> Let us take below layout of memory address space map.
>>>> QuadSPI Controller can access range from 0x2000_0000 -
>>>> 0x2FFF_FFFF i.e. 256
>>> MB address space reserved and it is having 4 slave devices
>>> connected.
>>>> These slave devices[of size 64MB, 64MB, 32MB and 64MB ] are
>>>> connected at below address 0x2000_0000, 0x2400_0000, 0x2A00_0000,
>>>> 0x2C00_0000 i.e. there is gap of 32MB from 0x2800_0000 to
>>>> 0x29FF_FFFF.
>>>
>>> Okay, I'm fine with pre-reserving 32MB per chip select.
>>>    
>>>>
>>>> As per my understanding of the controller, flash XX top address,
>>>> register should
>>> have below values:
>>>>    QUADSPI_SFA1AD - 0x0
>>>>    QUADSPI_SFA2AD - 0x400_0000
>>>>    QUADSPI_SFB1AD - 0xA00_0000
>>>>    QUADSPI_SFB2AD - 0xC00_0000
>>>> And Register QUADSPI_SFAR should point to the range for the flash
>>>> in which
>>> operation is happening.
>>
>> My mistake values of these register would be for said case are:
>> QUADSPI_SFA1AD - 0x400_0000
>> QUADSPI_SFA2AD - 0x800_0000
>> QUADSPI_SFB1AD - 0xC00_0000
>> QUADSPI_SFB2AD - 0x1000_0000
>>
>> i.e. as per controller each register is having the Top address for
>> serial flash connected at A1/A2/B1/B2 respectively.
> 
> This is still wrong ;-). I guess you mean:
> 
> QUADSPI_SFA1AD - 0x2400_0000
> QUADSPI_SFA2AD - 0x2800_0000
> QUADSPI_SFB1AD - 0x2C00_0000
> QUADSPI_SFB2AD - 0x3000_0000
> 
>>
>>>
>>> Wait, I thought it was supposed to be an absolute address, not one
>>> relative to the 0x20000000 offset.
>>>    
>>>>
>>>> Please check Table10-32, page 1657, in [1] for more details on
>>>> flash address
>>> assignment.
>>>
>>> Yes, I still don't see where it says that having one of the range
>>> with a zero size is forbidden, or anything mentioning a required
>>> alignment.
>>>>
>>>> But say if I assign address to register QUADSPI_SFA2AD as "0 + 2
>>>> * -
>>>> ahb_buf_size" then this address value is not correct as per the
>>>> value range
>>> explained in above mentioned table.
>>>
>>> Why? If the SFA1AD is set to zero, that should not, right?
>> What this table says that for TOP_ADDR_MEMA1 defines the top address
>> for flash connected at A1 and any address space between
>> TOP_ADDR_MEMA1 and QSPI_AMBA_BASE will be routed to Serial Flash A1.
>> In my example case TOP_ADDR_MEMA1 is 0x400_0000 If assign value to
>> SFAR register is "0 + 2 * ->ahb_buf_size", then this would lie in
>> access range of Serial Flash A1 and access happens to A1 flash
>> whereas we want access to A2 flash.
> 
> No, not if SFA1AD is 0x20000000, because then the address range for CS0
> would be 0x20000000 -> 0x20000000.
> 
> If you look at the code, you'll see that I adjust the CS mapping
> dynamically, making the one being access use the range
> 0x20000000 -> (0x20000000 + 2 * ->ahb_buf_size) and assigning a 0-size
> range for the other ones (either 0x20000000 -> 0x20000000 or
> (0x20000000 + 2 * ->ahb_buf_size) -> (0x20000000 + 2 * ->ahb_buf_size))
> 
>>
>> For access of serial flash A2, any address space access between
>> TOP_ADDR_MEMA2 and TOP_ADDR_MEMA1 would be routed to serial flash A2.
>> Thus to access A2 flash, SFAR would be in range from 0x400_0000 and
>> 0x800_0000
> 
> I understand what you're explaining, what I don't get is why the QSPI
> IP doesn't cope with a 0-size range. If you have SFA1AD set to
> 0x20000000 and SFA2AD set so 0x20000800, I would except any access to
> the 0x20000000 -> 0x20000800 range to be routed to CS1 not CS0. But
> apparently it's not working like that.

But it should definitely be possible to have 0-size ranges in the 
mapping. At least the RM for the i.MX6UL says:

"In case single die flash devices, TOP_ADDR_MEMA2 and
TOP_ADDR_MEMB2 should be initialized/programmed to
TOP_ADDR_MEMA1 and TOP_ADDR_MEMB1
respectively- in effect, setting the size of these devices to 0.
This would ensure that the complete memory map is assigned
to only one flash device."

Yogesh, can you test if it works with the fixed mapping proposed above, 
reserving a fixed range of 2 * ahb_buf_size for each chip?

Thanks,
Frieder
