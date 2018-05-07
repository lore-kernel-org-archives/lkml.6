Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeEGRPB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:15:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40540 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeEGRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:15:00 -0400
X-Google-Smtp-Source: AB8JxZoeAkMmmr62IdCI0KIhbOjbC2SKWRsE2wgbdlt/Rf/vStWJ9fR1jW/LiZ21fu7+CHJ6V8P4ow==
Subject: Re: support for non-uniform SPI NOR flash memories
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc: linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
References: <5bc6ab91-9ae3-28b1-2110-452f58fee8c7@microchip.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <e9218dcf-dce6-a009-70ec-33d0cac5bc4d@gmail.com>
Date: Mon, 7 May 2018 19:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5bc6ab91-9ae3-28b1-2110-452f58fee8c7@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 07:11 PM, Tudor Ambarus wrote:
> Hi, Marek, all,
> 
> I'm studying Cyrille's patch for non-uniform SPI NOR flash memories:
> https://lkml.org/lkml/2017/4/15/70.
> 
> It's not clear to me whether interleaved regions are possible or not. I
> read the JEDEC Standard No. 216B and it looks like each region is well
> delimited, there is no such thing as interleaved regions (see section
> 6.5):
> 
> "When there is more than one sector size in a device, each contiguous
> group of sectors, that are of the same size, and support the same erase
> types, is called a region."
> 
> If interleaved regions are not possible, the code can be simplified. Do
> I miss something, is there anything else that I should read in this
> regard?
> 
> Apart of how we represent the regions, there is some improvement that we
> can do. When in a region, I see that is preferred the biggest possible
> erase type that meets all the conditions. If so, we can iterate from the
> biggest erase type to the smallest, and when find one that meets all the
> conditions, break the loop.

There are flashes which have larger erase blocks at the beginning/end
and then there are flashes with multiple dies, which support die-wide
erase and chip-wide erase . Not all flashes support everything though.

But indeed there are -- to my knowledge -- no flashes with interleaved
erase blocks. And yes, there could be improvement in erasing exactly the
required chunk of flash with a fitting opcode :)

-- 
Best regards,
Marek Vasut
