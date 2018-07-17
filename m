Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B14ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBA920693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBA920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeGQVjy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56823 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731753AbeGQVjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 17BEA20884; Tue, 17 Jul 2018 23:05:25 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 34AE7207AD;
        Tue, 17 Jul 2018 23:05:24 +0200 (CEST)
Date:   Tue, 17 Jul 2018 23:05:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Josh Wu <rainyfeeling@outlook.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] mtd: atmel nand: fix build warning on 64-bit
Message-ID: <20180717230523.7005ca91@xps13>
In-Reply-To: <CAK8P3a3NbrRVC-7HW8NiNQw+E3n_-r746AFTc2dftagTYLYDtw@mail.gmail.com>
References: <20180709155730.2422841-1-arnd@arndb.de>
        <20180709155730.2422841-2-arnd@arndb.de>
        <0b4ee469-8c37-9002-9067-f37f8dde869e@microchip.com>
        <CAK8P3a3NbrRVC-7HW8NiNQw+E3n_-r746AFTc2dftagTYLYDtw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Fri, 13 Jul 2018 12:16:09 +0200:

> On Fri, Jul 13, 2018 at 11:56 AM, Tudor Ambarus
> <tudor.ambarus@microchip.com> wrote:
> > Hi, Arnd,
> >
> > On 07/09/2018 06:57 PM, Arnd Bergmann wrote:  
> >> +     nc->ebi_csa_offs = (uintptr_t)match->data;  
> >
> > I guess we should declare ebi_csa_offs as size_t, right?  
> 
> Yes, that would make sense, though it doesn't change the behavior.
> 

Do you plan to send a new version? I don't want to mess with
improvised casts :)

Thanks,
Miquèl
