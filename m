Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35612C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFC9240E3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFC9240E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753589AbeGEG7z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:59:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40198 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753401AbeGEG7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:59:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8E36A207D4; Thu,  5 Jul 2018 08:59:48 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 45388206FF;
        Thu,  5 Jul 2018 08:59:38 +0200 (CEST)
Date:   Thu, 5 Jul 2018 08:59:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next v3] mtd: spinand: fix missing unlock on error
Message-ID: <20180705085936.38f6c374@xps13>
In-Reply-To: <1530696627-84879-1-git-send-email-weiyongjun1@huawei.com>
References: <1530696061-76467-1-git-send-email-weiyongjun1@huawei.com>
        <1530696627-84879-1-git-send-email-weiyongjun1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Wei Yongjun <weiyongjun1@huawei.com> wrote on Wed, 4 Jul 2018 09:30:27
+0000:

> Add the missing unlock before return from function
> spinand_mtd_(read|write) in the error handling case.
> 
> Fixes: c898e0526fb6 ("mtd: nand: Add core infrastructure to support SPI NANDs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Thanks for the two fixes over the spinand work. As this code is not
yet upstream, do you mind if I fold those fixes directly with the
initial patch?

Thanks,
Miquèl
