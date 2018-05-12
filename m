Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeELRnM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 13:43:12 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51596 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeELRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 13:43:11 -0400
Date: Sat, 12 May 2018 19:42:49 +0200
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mtd: nand: Add support for reading ooblayout from device
 tree
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@bolin.com>,
        Marek Vasut <marek.vasut@gmail.com>
Message-Id: <1526146969.1594.0@smtp.crapouillou.net>
In-Reply-To: <20180512170034.12779313@bbrezillon>
References: <20180512115551.56C6E20787@mail.bootlin.com>
        <20180512154223.3b81c7f7@bbrezillon>
        <1526135906.4971.0@smtp.crapouillou.net>
        <20180512170034.12779313@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>  >>  My motivation is to get rid of this (move it to devicetree):
>>  >>
>>  >> 
>> https://elixir.bootlin.com/linux/latest/source/arch/mips/jz4740/board-qi_lb60.c#L93
>>  >>  And enable the support of other boards with custom OOB layouts.
>>  >
>>  > Can you list the different layouts you have? I'm pretty sure 
>> there's a
>>  > pattern. Maybe we can even deduce the layout from the page size 
>> or OOB
>>  > size.
>> 
>>  This is the other layout I have for another ingenic device:
>>  
>> http://projects.qi-hardware.com/index.php/p/qi-kernel/source/tree/od-2011-09-18/arch/mips/jz4740/board-a320.c#L125
>> 
>>  Page size and OOB size are the same between these two devices.
> 
> Indeed. Do you know if there are other kind of layouts in the wild?

I'm getting a new board in a few weeks, I'll be able to check that out.

> Note that <layout-id> can be a string, so if each each board is
> defining its own layout, you could specify the board name here.
> Otherwise, if you just have those 2 patterns, you can just name them
> "contiguous" and "interleaved".

I don't like the idea of adding board-specific data inside the driver...
I'd prefer to use the method I used in this patch, but inside the
jz4740-nand driver, if you're OK with it.

Thanks,
-Paul
