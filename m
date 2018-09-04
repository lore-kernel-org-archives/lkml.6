Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15729C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC362086D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KT6eRwk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC362086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIECQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:16:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIECQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YddFwEys5trcLExcj16l/63cq+AJA56IvPK1GGgzlqQ=; b=KT6eRwk+fQzu2H91xSOz1jqtz
        1R5DmcQo8LfyIR4XYQ9qsEIo0a7GWdOYl/CKHYUbic+vXOWbsZ7cvlf1RZtjIr8hBJJH1AhbfA42Y
        Bqp0EiMP+SJthNZYEbyCIICKsmakAgUF6ZZ1hCssMp0UnwhUH/Z+ZQy2lE9E9JyQf1QHwWOuIA44U
        jc9s7KXvcow4QY1zaf4igxssL158weq6ed5WOIWaMCHoPmzFMN5D7ZkWTpRfBOYKEdx0haSIzXaNz
        KdIFO6QWGaX1iAxJ56u4ocRBDZ5XNt5wbVeluK9daNkoMwQV5NIyuxrhO70zIzK6NWtNviAjTyfI4
        /0OnDpg/Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxJC3-0005x2-H2; Tue, 04 Sep 2018 21:49:03 +0000
Subject: Re: [PATCH] mtd: onenand: fix parameter list build warning
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Adrian Bunk <bunk@debian.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <03e45afe-c4f8-e69b-9cba-6a8863296ad4@infradead.org>
 <20180904233449.32e41787@xps13>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <561f2078-92e8-290f-626c-ff936b7285c1@infradead.org>
Date:   Tue, 4 Sep 2018 14:49:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904233449.32e41787@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 02:34 PM, Miquel Raynal wrote:
> Hi Randy,
> 
> Randy Dunlap <rdunlap@infradead.org> wrote on Mon, 3 Sep 2018 12:32:04
> -0700:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build warning in <linux/mtd/onenand.h> by adding a "stub" struct
>> for mtd_oob_ops:
>>
>> include/linux/mtd/onenand.h: warning: 'struct mtd_oob_ops' declared inside parameter list [enabled by default]
>> include/linux/mtd/onenand.h: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
>>
>> Fixes: 607d1cb10426 ("[MTD] [OneNAND] proper onenand_bbt_read_oob() prototype")
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: linux-mtd@lists.infradead.org
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Brian Norris <computersforpeace@gmail.com>
>> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
>> Cc: Marek Vasut <marek.vasut@gmail.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Adrian Bunk <bunk@kernel.org>
>> Cc: Adrian Bunk <bunk@debian.org>
>> ---
>>  include/linux/mtd/onenand.h |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- lnx-419-rc2.orig/include/linux/mtd/onenand.h
>> +++ lnx-419-rc2/include/linux/mtd/onenand.h
>> @@ -221,6 +221,7 @@ struct onenand_manufacturers {
>>          char *name;
>>  };
>>  
>> +struct mtd_oob_ops;
>>  int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,
>>  			 struct mtd_oob_ops *ops);
>>  unsigned onenand_block(struct onenand_chip *this, loff_t addr);
> 
> That's indeed a working solution, but there are a lot of other
> structures in this file that come (like mtd_oob_ops) from
> linux/mtd/mtd.h so I wonder if it would not make more sense to include
> this header here?
> 
> Thanks,
> Miquèl


Hi,
Have you see this from Linus?

https://lore.kernel.org/lkml/CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com/


thanks,
-- 
~Randy
