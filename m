Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCAC20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCAC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeJDVQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:16:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41175 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeJDVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:16:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5AE7B207F3; Thu,  4 Oct 2018 16:22:32 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1756720726;
        Thu,  4 Oct 2018 16:22:32 +0200 (CEST)
Date:   Thu, 4 Oct 2018 16:22:32 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: ams-delta: use ->exec_op()
Message-ID: <20181004162232.5ac363be@bbrezillon>
In-Reply-To: <38470936.GRFaOSl3cF@z50>
References: <20180719081508.5dafebde@bbrezillon>
        <7546835.d2Xs8Qh0bZ@z50>
        <20181004155933.0a32c4ac@bbrezillon>
        <38470936.GRFaOSl3cF@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Oct 2018 16:11:42 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> 
> Legacy nand_wait_ready() uses a hardcoded timeout value of 400 ms.   Should we 
> follow the same approach in nand_gpio_waitrdy(), or should we rather let 
> drivers pass the timeout value, like in case of nand_soft_waitrdy()?

The latter.
