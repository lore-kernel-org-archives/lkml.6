Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB070C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9712146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9712146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeIRTVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:21:20 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59063 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729656AbeIRTVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:21:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1115157|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CsTXxXN_1537278496;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CsTXxXN_1537278496)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 18 Sep 2018 21:48:16 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        robh@kernel.org, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] bugfix based on csky linux-next
Date:   Tue, 18 Sep 2018 21:48:12 +0800
Message-Id: <cover.1537276837.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because I've sent to Stephen Roth with the linux-4.19-rc3 git-tree for
linux-next, I shouldn't rebase any more.

 - Fixup smp.c irq mapping problem found by Marc Zyngier
 - Fixup dma_sync_for_cpu/device in dma-mapping.c

Guo Ren (2):
  csky/dma: bugfix dma_sync_for_cpu/device
  csky: remove irq_mapping from smp.c.

 arch/csky/include/asm/smp.h |  4 ++++
 arch/csky/kernel/smp.c      | 18 +++++++++++++-----
 arch/csky/mm/dma-mapping.c  |  5 +++--
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.7.4

