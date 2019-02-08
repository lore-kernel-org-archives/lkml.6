Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C854C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DB921924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBHV5i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:57:38 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:34137 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBHV5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:57:38 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B2AB5100006;
        Fri,  8 Feb 2019 21:57:34 +0000 (UTC)
Date:   Fri, 8 Feb 2019 22:57:33 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 05/11] mtd: rawnand: denali: rename irq_status to
 irq_stat
Message-ID: <20190208225733.2c8779b9@xps13>
In-Reply-To: <1549613335-30319-6-git-send-email-yamada.masahiro@socionext.com>
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
        <1549613335-30319-6-git-send-email-yamada.masahiro@socionext.com>
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

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri,  8 Feb
2019 17:08:49 +0900:

> I will add the third argument to denali_wait_for_irq() in the
> following commit. Then, some lines will exceed 80 columns.
> 
> Rename 'irq_status' to 'irq_stat'. Saving two characters will avoid
> line-wrapping in some places, and keep the code clean.

I had a look at the changes and I don't think this is worth the
trouble. I don't find irq_stat meaningful enough compared to
irq_status. If you want, you may break lines between arguments of a
function instead.

> 
> I replaced uint32_t with u32 in the touched lines. This will reduce
> the reports from 'scripts/checkpatch.pl --strict'.

While you are at it, it might be interesting to convert the whole
driver in one go to using u8, u16 and u32?

Thanks,
Miquèl
