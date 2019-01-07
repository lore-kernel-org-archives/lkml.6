Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE26C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80132089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864499;
	bh=0+xSFy4Fg5xUW/+nty1lSo7ONqOoJiZOT7UFOOkFuD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lUNL/XKqm/j/MBRloMQKKyw2E1AxMQmr5T2t/ezrJB7L6A2yGucVL2B9J7jWbpy5u
	 SAfL1d92TIi1xmV6I6wonZ5G9pKc+EUUkbCvzHcsydGcOqKzzLbdXe3S9KmrMp+ejV
	 Z21mjWdYG/6OTN5Dt+0m9izjgZ8vFEdc712pk8Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfAGMe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfAGMeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E19820859;
        Mon,  7 Jan 2019 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864489;
        bh=0+xSFy4Fg5xUW/+nty1lSo7ONqOoJiZOT7UFOOkFuD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOZFUfm5o0lXysJFlp9VmwNiXb19+2xhB7YKVbsaNsj9nk+TS7Y0UpBV9lRqlJc2X
         7XHm0shCllSlsLRvwsoOgdc25dI/7SrANzd4CeWwSlPRYqSTajaBqFCsNQcZXxDvEf
         x8ucuov3rvw4ZZ9Kk5wBBba4Dlf154tdAm0IYOYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.20 029/145] mtd: rawnand: omap2: Pass the parent of pdev to dma_request_chan()
Date:   Mon,  7 Jan 2019 13:31:06 +0100
Message-Id: <20190107104441.115077343@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 9b432630e0150b777c423fdef6a7b8d17dfa70b6 upstream.

Commit e1e6255c311b ("mtd: rawnand: omap2: convert driver to
nand_scan()") moved part of the init code in the ->attach_chip hook
and at the same time changed the struct device object passed to
dma_request_chan() (&pdev->dev instead of pdev->dev.parent).

Fixes: e1e6255c311b ("mtd: rawnand: omap2: convert driver to nand_scan()")
Reported-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/omap2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1944,7 +1944,7 @@ static int omap_nand_attach_chip(struct
 	case NAND_OMAP_PREFETCH_DMA:
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
-		info->dma = dma_request_chan(dev, "rxtx");
+		info->dma = dma_request_chan(dev->parent, "rxtx");
 
 		if (IS_ERR(info->dma)) {
 			dev_err(dev, "DMA engine request failed\n");


