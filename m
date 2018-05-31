Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754472AbeEaKbC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:31:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35882 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754439AbeEaKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:30:57 -0400
X-Google-Smtp-Source: ADUXVKJo4saoUIbmABJLcn/5yVIlohUW47xxguDpZclKEFrYSKhCltxC0lez1+/ZODYxPosHoPPwEg==
From: Jun Yao <yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 0/2] mark tramp_pg_dir read-only
Date: Thu, 31 May 2018 18:30:49 +0800
Message-Id: <20180531103049.31690-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 changes:
	split tramp_pg_dir off from the data segment and create
	a dedicated pgdir segment for it.

Jun Yao (2):
  arm64/mm: split tramp_pg_dir off from the data segment
  arm64/mm: make tramp_pg_dir read-only

 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   |  3 +++
 arch/arm64/mm/mmu.c               | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)

-- 
2.17.0
