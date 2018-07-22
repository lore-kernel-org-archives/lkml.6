Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB4C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5425620671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpOXEXyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5425620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeGVSWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:22:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeGVSWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cGorUSEktgbQnK9D/09bSTRV7t4di2d1RlUMgWkoDZQ=; b=WpOXEXyyH8fsRKz+zPO2j5Tm+
        RKb79nQ3Q9rtTD+10BB1lQt6w/WxpVeNusigRksuDL3dDtDeyGFkEZU61fL4cnppJe9Bu5NgNzyXP
        qt3F/o/iiYjjkQQd5vQWWyFS+w68kLzlBBu/MJ8tFEuD9zJqn8Q1LIMz25OaLi+kTlBgZ48z4UsD5
        WA+H9xP3e06MRWltwbe9xiHlUkfraEQUbWcmEd3TlviS2gagfst7bvq0NwW5Lylhs6FsM4qOTxz/B
        c9+yoxicGpw/qSzvGvjZLGH1yBEu2s8RyLZjRQGpUwtbm+50OvKc/knh1uYxeQsJ3uNFIIxO63Zsv
        jsgxGBDpQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhI6O-0005QP-Ea; Sun, 22 Jul 2018 17:25:00 +0000
Subject: Re: [PATCH] arch/h8300: fix kernel/dma.c build warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Kuo <rkuo@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
 <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <24723dd8-9d9f-24b7-6fe9-71a776c5d444@infradead.org>
Date:   Sun, 22 Jul 2018 10:24:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/2018 02:25 AM, Geert Uytterhoeven wrote:
> CC hexagon
> 
> hexagon != H8/300 != SuperH

argh.  Thanks.

> On Sat, Jul 21, 2018 at 5:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
>> to unsigned long to match the function parameter type.
>>
>> ../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
>> ../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
>> ../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> ---
>>  arch/hexagon/kernel/dma.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20180717.orig/arch/hexagon/kernel/dma.c
>> +++ linux-next-20180717/arch/hexagon/kernel/dma.c
>> @@ -47,7 +47,7 @@ void *arch_dma_alloc(struct device *dev,
>>                         panic("Can't create %s() memory pool!", __func__);
>>                 else
>>                         gen_pool_add(coherent_pool,
>> -                               pfn_to_virt(max_low_pfn),
>> +                               (unsigned long)pfn_to_virt(max_low_pfn),
>>                                 hexagon_coherent_pool_size, -1);
>>         }
>>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
~Randy
