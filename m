Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D459920652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D459920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965558AbeFRKAA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:00:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935380AbeFRITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 40812BAD;
        Mon, 18 Jun 2018 08:19:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 091/279] riscv: select DMA_DIRECT_OPS instead of redefining it
Date:   Mon, 18 Jun 2018 10:11:16 +0200
Message-Id: <20180618080612.571780044@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 86e11757d8b28d8266065beaa9d391d49426797b ]

DMA_DIRECT_OPS is defined in lib/Kconfig, so don't duplicate it in
arch/riscv/Kconfig.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/Kconfig |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -11,6 +11,7 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select DMA_DIRECT_OPS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_SHOW
@@ -88,9 +89,6 @@ config PGTABLE_LEVELS
 config HAVE_KPROBES
 	def_bool n
 
-config DMA_DIRECT_OPS
-	def_bool y
-
 menu "Platform type"
 
 choice


