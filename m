Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1220C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9381B2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfBFIfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:35:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFIfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:35:44 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 53BD827D9D7;
        Wed,  6 Feb 2019 08:35:42 +0000 (GMT)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        han.xu@nxp.com, bbrezillon@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org
Cc:     Your Name <patch-notifications@your-domain.com>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [v2] mtd: rawnand: gpmi: fix MX28 bus master lockup problem
Date:   Wed,  6 Feb 2019 09:35:33 +0100
Message-Id: <20190206083533.14104-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205155251.18733-1-martin.kepplinger@ginzinger.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 803f4316fb74bf46a268d53bd1d95e7bf20e7350
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Your Name <patch-notifications@your-domain.com>

On Tue, 2019-02-05 at 15:52:51 UTC, Martin Kepplinger wrote:
> Disable BCH soft reset according to MX23 erratum #2847 ("BCH soft
> reset may cause bus master lock up") for MX28 too. It has the same
> problem.
> 
> Observed problem: once per 100,000+ MX28 reboots NAND read failed on
> DMA timeout errors:
> [    1.770823] UBI: attaching mtd3 to ubi0
> [    2.768088] gpmi_nand: DMA timeout, last DMA :1
> [    3.958087] gpmi_nand: BCH timeout, last DMA :1
> [    4.156033] gpmi_nand: Error in ECC-based read: -110
> [    4.161136] UBI warning: ubi_io_read: error -110 while reading 64
> bytes from PEB 0:0, read only 0 bytes, retry
> [    4.171283] step 1 error
> [    4.173846] gpmi_nand: Chip: 0, Error -1
> 
> Without BCH soft reset we successfully executed 1,000,000 MX28 reboots.
> 
> I have a quote from NXP regarding this problem, from July 18th 2016:
> 
> "As the i.MX23 and i.MX28 are of the same generation, they share many
> characteristics. Unfortunately, also the erratas may be shared.
> In case of the documented erratas and the workarounds, you can also
> apply the workaround solution of one device on the other one. This have
> been reported, but I’m afraid that there are not an estimated date for
> updating the Errata documents.
> Please accept our apologies for any inconveniences this may cause."
> 
> Fixes: 6f2a6a52560a ("mtd: nand: gpmi: reset BCH earlier, too, to avoid
> NAND startup problems")
> Cc: stable@vger.kernel.org
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Han Xu <han.xu@nxp.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/fixes, thanks.

y'all come back now!
