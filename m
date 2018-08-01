Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA97C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838F8208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838F8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbeHAPlY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:41:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46582 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389315AbeHAPlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:41:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E387020756; Wed,  1 Aug 2018 15:55:29 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9D3B220730;
        Wed,  1 Aug 2018 15:55:29 +0200 (CEST)
Date:   Wed, 1 Aug 2018 15:55:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jheng-Jhong Wu <goodwater.wu@gmail.com>,
        Palle Christensen <palle.christensen@microsemi.com>,
        devel@driverdev.osuosl.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arun Nagendran <arunrasppi@gmail.com>
Subject: Re: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit
 arguments and variables used for addressing.
Message-ID: <20180801155530.6e824927@xps13>
In-Reply-To: <20180801120551.ju6zhxhoef6w5zim@mwanda>
References: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
        <20180801120551.ju6zhxhoef6w5zim@mwanda>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Dan Carpenter <dan.carpenter@oracle.com> wrote on Wed, 1 Aug 2018
15:05:51 +0300:

> On Wed, Aug 01, 2018 at 11:24:19AM +0800, Jheng-Jhong Wu wrote:
> > For NAND flash chips with more than 1Gbit (e.g. MT29F2G) more than 16 bits
> > are necessary to address the correct page. The driver sets the address for
> > more than 16 bits, but it uses 16-bit arguments and variables (these are
> > page_id, block_id, row) to do address operations. Obviously, these
> > arguments and variables cannot deal with more than 16-bit address.
> > 
> > Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>  
> 
> This seems reasonable...  It would be needed to make commit 6efb21d6d0e7
> ("staging:mt29f_spinand: MT29F2G failing as only 16 bits used for
> addressing.") work.  It also fixes a static checker warning.
> 
> My only concern is that the mtd/nand code seems to use -1 as a magical
> page_id.  For example:

I guess you missed Boris' comment: this driver is very likely to be
removed. A SPI-NAND framework has been added. It does not use the raw
NAND framework anymore, which was wrong anyway.

Thanks,
Miquèl
