Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32404ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38D120858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38D120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeGMKKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:10:02 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:29025 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbeGMKKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:10:02 -0400
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="16197490"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Jul 2018 02:56:06 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Fri, 13 Jul 2018 02:56:05 -0700
Subject: Re: [PATCH 2/3] mtd: atmel nand: fix build warning on 64-bit
To:     Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>,
        Josh Wu <rainyfeeling@outlook.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Rosin <peda@axentia.se>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180709155730.2422841-1-arnd@arndb.de>
 <20180709155730.2422841-2-arnd@arndb.de>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <0b4ee469-8c37-9002-9067-f37f8dde869e@microchip.com>
Date:   Fri, 13 Jul 2018 12:56:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180709155730.2422841-2-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd,

On 07/09/2018 06:57 PM, Arnd Bergmann wrote:
> +	nc->ebi_csa_offs = (uintptr_t)match->data;

I guess we should declare ebi_csa_offs as size_t, right?

Best,
ta
