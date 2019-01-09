Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEBAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B32206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfAIUjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:39:18 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60384 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfAIUjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:39:17 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ghKd9-0005yg-US; Wed, 09 Jan 2019 13:39:16 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ghKd9-00023x-Ai; Wed, 09 Jan 2019 13:39:15 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed,  9 Jan 2019 13:39:09 -0700
Message-Id: <20190109203911.7887-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sbates@raithlin.com, palmer@sifive.com, hch@lst.de, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 0/2] [PATCH v2 0/6] sparsemem support for RISC-V
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements sparsemem on RISC-V. The first couple patches
from the previous version have been merged into v4.20 and the ARM patches
have been sent separately to the ARM maintainers. These are the RISC-V
patches only.

This is the first small step in supporting P2P on RISC-V.

--

Changes in v4:
* Rebased onto v5.0-rc1
* Changed the SECTION_SIZE_BITS to 27, per Nick Kossifidis

Changes in v3 (only sent the common patches):
* Rebased on v4.20-rc1
* Minor fixups
* Collected Ack from Will Deacon

Changes in v2:

* Rebase on v4.19-rc8
* Move the STRUCT_PAGE_MAX_SHIFT define into a common header (near
  the definition of struct page). As suggested by Christoph.
* Clean up the unnecessary nid variable in the memblocks_present()
  function, per Christoph.
* Collected tags from Palmer and Catalin.

--

Logan Gunthorpe (2):
  sh: mm: make use of new memblocks_present() helper
  RISC-V: Implement sparsemem

 arch/riscv/Kconfig                 | 23 +++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h   | 21 +++++++++++++++++----
 arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
 arch/riscv/kernel/setup.c          |  4 +++-
 arch/riscv/mm/init.c               |  8 ++++++++
 arch/sh/mm/init.c                  |  7 +------
 6 files changed, 63 insertions(+), 11 deletions(-)
 create mode 100644 arch/riscv/include/asm/sparsemem.h

--
2.19.0
