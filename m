Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757076AbeEJLdw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:33:52 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:39250 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756891AbeEJLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:33:51 -0400
X-Google-Smtp-Source: AB8JxZrwB6WCUdvB37S41Mcj5xNdgy9VLDFghOr+5KyMYFQy3FL1Cb82kvrWk2w8NYRbxigyUpPozA==
Subject: Re: support for non-uniform SPI NOR flash memories
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc: linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
References: <5bc6ab91-9ae3-28b1-2110-452f58fee8c7@microchip.com>
 <e9218dcf-dce6-a009-70ec-33d0cac5bc4d@gmail.com>
 <b7cbad40-8340-0a8f-e539-932b777757d8@microchip.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <825117a7-0412-0558-f7e0-37e026b45db2@gmail.com>
Date: Thu, 10 May 2018 12:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b7cbad40-8340-0a8f-e539-932b777757d8@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2018 06:40 PM, Tudor Ambarus wrote:
> 
> On 05/07/2018 08:14 PM, Marek Vasut wrote:
>> But indeed there are -- to my knowledge -- no flashes with interleaved
>> erase blocks. And yes, there could be improvement in erasing exactly the
>> required chunk of flash with a fitting opcode:)
> 
> Thanks Marek.
> 
> Other improvement would be to minimize the amount of erase() calls by
> using the best sequence of erase type commands depending on alignment.
> But this will increase the number of queries.
> 
> I've read again the Sector Map section of the JEDECB standard and it
> looks like "overlaid" regions are possible. Here's an example that I
> found there:
> 
> Bottom: 8x 4KB sectors at bottom (only 4KB erase supported),
>         1x overlaid 64KB sector at bottom (only 64KB erase supported),
>         511 uniform 64KB sectors (only 64KB erase supported)
> 
> That's interesting, when one wants to erase the overlaid 64KB sector, I
> guess that the 8x 4KB sectors will be erased too.

Ah yes, some old flashes had these few 64 kiB erase blocks at the
beginning/end, which could either be erased as one 64 kiB block or as
smaller 8k/4k blocks .

> I'm still studying this, I'll try to come with a proposal in the next
> few days.

Cool!

-- 
Best regards,
Marek Vasut
