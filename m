Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1505C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B20218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfAYMhK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:37:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49254 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAYMhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:37:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 542BD209BF; Fri, 25 Jan 2019 13:37:08 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 15B4A207B0;
        Fri, 25 Jan 2019 13:36:58 +0100 (CET)
Date:   Fri, 25 Jan 2019 13:36:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: rawnand: denali: remove ->erase hook
Message-ID: <20190125133658.540b19fa@xps13>
In-Reply-To: <1548046326-26776-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548046326-26776-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Mon, 21 Jan
2019 13:52:06 +0900:

> Commit f9ebd1bb4103 ("mtd: rawnand: Deprecate ->erase()") discouraged
> the use of this hook, so I am happy to follow the suggestion.
> 
> Although the Denali IP provides a special MAP10 command for erasing,
> using it would not buy us much. The Denali IP actually works with the
> generic erasing by single_erase() + ->cmdfunc hook (nand_command_lp)
> + ->cmd_ctrl hook (denali_cmd_ctrl).
> 
> This method is also deprecated, but denali_erase() can go away
> irrespective of ->exec_op conversion.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to nand/next.

Thanks!
Miquèl

