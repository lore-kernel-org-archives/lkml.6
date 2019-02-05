Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E0BC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497FA2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfBETGr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:06:47 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43761 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBETGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:06:47 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1FA64240009;
        Tue,  5 Feb 2019 19:06:42 +0000 (UTC)
Date:   Tue, 5 Feb 2019 20:06:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit
 platforms
Message-ID: <20190205200641.1c97f9fe@xps13>
In-Reply-To: <20190129214657.5877-1-natechancellor@gmail.com>
References: <20190129214657.5877-1-natechancellor@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Nathan Chancellor <natechancellor@gmail.com> wrote on Tue, 29 Jan 2019
14:46:57 -0700:

> On arm little endian allyesconfig:
> 
>   ld.lld: error: undefined symbol: __aeabi_uldivmod
>   >>> referenced by meson_nand.c
>   >>> mtd/nand/raw/meson_nand.o:(meson_nfc_setup_data_interface) in archive drivers/built-in.a  
> 
> The dividend tBERS_max is u64, meaning we need to use DIV_ROUND_UP_ULL
> (which wraps do_div) to prevent the compiler from emitting
> __aebi_uldivmod.
> 
> Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Merged in nand/next with the original commit.


Thanks,
Miquèl
