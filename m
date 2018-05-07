Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeEGRLF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:11:05 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14059 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeEGRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:11:04 -0400
X-IronPort-AV: E=Sophos;i="5.49,374,1520924400";
   d="scan'208";a="11274103"
To: <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: support for non-uniform SPI NOR flash memories
CC: <linux-mtd@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Message-ID: <5bc6ab91-9ae3-28b1-2110-452f58fee8c7@microchip.com>
Date: Mon, 7 May 2018 20:11:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marek, all,

I'm studying Cyrille's patch for non-uniform SPI NOR flash memories:
https://lkml.org/lkml/2017/4/15/70.

It's not clear to me whether interleaved regions are possible or not. I
read the JEDEC Standard No. 216B and it looks like each region is well
delimited, there is no such thing as interleaved regions (see section
6.5):

"When there is more than one sector size in a device, each contiguous
group of sectors, that are of the same size, and support the same erase
types, is called a region."

If interleaved regions are not possible, the code can be simplified. Do
I miss something, is there anything else that I should read in this
regard?

Apart of how we represent the regions, there is some improvement that we
can do. When in a region, I see that is preferred the biggest possible
erase type that meets all the conditions. If so, we can iterate from the
biggest erase type to the smallest, and when find one that meets all the
conditions, break the loop.

Thanks,
ta
