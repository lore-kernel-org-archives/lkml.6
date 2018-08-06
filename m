Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C653AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856D2219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856D2219EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeHFLaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:30:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44767 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeHFLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:30:22 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1fmbi9-0002UC-Hj; Mon, 06 Aug 2018 11:21:57 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jane Wan <Jane.Wan@nokia.com>,
        Jagdish Gediya <jagdish.gediya@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mtd: nand: fsl-ifc: fix SRAM initialization for newer controller
Date:   Mon,  6 Aug 2018 11:21:35 +0200
Message-Id: <20180806092137.9287-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the current way of initializing the internal SRAM of the IFC controller only
works for older controller versions. Newer versions require a different
method. So, adding support for it.

Thereby, the result of the SRAM initialization should be checked. If it's not
successful, further commands such as read won't work.

Tested on hardware.

Thanks,
Kurt

Kurt Kanzenbach (2):
  mtd: nand: fsl-ifc: check result of SRAM initialization
  mtd: nand: fsl-ifc: fixup SRAM init for newer ctrl versions

 drivers/mtd/nand/raw/fsl_ifc_nand.c | 35 +++++++++++++++++++++++++++++++----
 include/linux/fsl_ifc.h             |  2 ++
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.11.0

