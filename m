Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B2BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A712145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A712145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLCHwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:52:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48808 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbeLCHwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:52:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8E0C820CFC; Mon,  3 Dec 2018 08:51:54 +0100 (CET)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 43EA720786;
        Mon,  3 Dec 2018 08:51:54 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Huijin Park <huijin.park@samsung.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mtd@lists.infradead.org, bbanghj.park@gmail.com
Subject: Re: [v3] mtd: spi-nor: cast to u64 to avoid uint overflows
Date:   Mon,  3 Dec 2018 08:51:54 +0100
Message-Id: <20181203075154.28637-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 22f70ce85f209cf6e08a3b3aa7f923937d8893ce
In-Reply-To: <1543392134-1443-1-git-send-email-huijin.park@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-28 at 08:02:14 UTC, Huijin Park wrote:
> From: "huijin.park" <huijin.park@samsung.com>
> 
> The "params->size" is defined as "u64".
> And "info->sector_size" and "info->n_sectors" are defined as
> unsigned int and u16.
> Thus, u64 data might have strange data(loss data) if the result
> overflows an unsigned int.
> This patch casts "info->sector_size" to an u64.
> 
> Signed-off-by: huijin.park <huijin.park@samsung.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
