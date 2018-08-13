Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1863EC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C349321834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C349321834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeHMKAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:00:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37218 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:00:33 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1fp78F-00012F-NQ; Mon, 13 Aug 2018 09:19:15 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Jagdish Gediya <jagdish.gediya@nxp.com>,
        Jane Wan <Jane.Wan@nokia.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mtd: rawnand: fsl_ifc: fix SRAM initialization for newer controller
Date:   Mon, 13 Aug 2018 09:18:44 +0200
Message-Id: <20180813071846.9433-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is version two of

 lkml.kernel.org/r/20180806092137.9287-1-kurt@linutronix.de

Changes since v1:

 - Addressed comments from Miquel Raynal
   - Changed subject
   - Coding style
   - Using timeout constants
   - Moving version check completely into fsl_ifc_sram_init()

Thanks,
Kurt

Kurt Kanzenbach (2):
  mtd: rawnand: fsl_ifc: check result of SRAM initialization
  mtd: rawnand: fsl_ifc: fixup SRAM init for newer ctrl versions

 drivers/mtd/nand/raw/fsl_ifc_nand.c | 36 ++++++++++++++++++++++++++++++++----
 include/linux/fsl_ifc.h             |  2 ++
 2 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.11.0

