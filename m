Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965565AbeEIQkI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:40:08 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:46876 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934647AbeEIQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:40:06 -0400
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="13756570"
Subject: Re: support for non-uniform SPI NOR flash memories
To: Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
References: <5bc6ab91-9ae3-28b1-2110-452f58fee8c7@microchip.com>
 <e9218dcf-dce6-a009-70ec-33d0cac5bc4d@gmail.com>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <b7cbad40-8340-0a8f-e539-932b777757d8@microchip.com>
Date: Wed, 9 May 2018 19:40:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <e9218dcf-dce6-a009-70ec-33d0cac5bc4d@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/07/2018 08:14 PM, Marek Vasut wrote:
> But indeed there are -- to my knowledge -- no flashes with interleaved
> erase blocks. And yes, there could be improvement in erasing exactly the
> required chunk of flash with a fitting opcode:)

Thanks Marek.

Other improvement would be to minimize the amount of erase() calls by
using the best sequence of erase type commands depending on alignment.
But this will increase the number of queries.

I've read again the Sector Map section of the JEDECB standard and it
looks like "overlaid" regions are possible. Here's an example that I
found there:

Bottom: 8x 4KB sectors at bottom (only 4KB erase supported),
         1x overlaid 64KB sector at bottom (only 64KB erase supported),
         511 uniform 64KB sectors (only 64KB erase supported)

That's interesting, when one wants to erase the overlaid 64KB sector, I
guess that the 8x 4KB sectors will be erased too.

I'm still studying this, I'll try to come with a proposal in the next
few days.

Cheers,
ta
