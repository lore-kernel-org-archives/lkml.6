Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeFEJeA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:34:00 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46188 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeFEJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:33:58 -0400
X-Google-Smtp-Source: ADUXVKIF8V2QdNnrmXm/7hrvHIrbtIIpObvlI0dEI4LQq5ytbU2Gp7HGEZYMa1HEx0bxBiIjlSNaKw==
From: Jun Yao <yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 0/3] arm64/mm: migrate swapper_pg_dir
Date: Tue,  5 Jun 2018 17:33:47 +0800
Message-Id: <20180605093350.24504-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 changes:
	* Move __pa_swapper_pg_dir to mmuoff.data.read section[1]
	* Fix problem with CONFIG_ARM64_SW_TTBR0_PAN[2]
	* Update comment about __enable_mmu()

[v1] https://www.spinics.net/lists/kernel/msg2819351.html

[1] https://www.spinics.net/lists/kernel/msg2819594.html
[2] https://www.spinics.net/lists/kernel/msg2819455.html

Jun Yao (3):
  arm64/mm: pass swapper_pg_dir as an argument to __enable_mmu()
  arm64/mm: introduce variable to save new swapper_pg_dir address
  arm64/mm: migrate swapper_pg_dir and tramp_pg_dir

 arch/arm64/include/asm/mmu_context.h |  6 +-
 arch/arm64/include/asm/pgtable.h     |  2 +
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/head.S             |  6 +-
 arch/arm64/kernel/hibernate.c        |  2 +-
 arch/arm64/kernel/sleep.S            |  1 +
 arch/arm64/mm/kasan_init.c           |  6 +-
 arch/arm64/mm/mmu.c                  | 83 ++++++++++++++++++----------
 8 files changed, 69 insertions(+), 39 deletions(-)

-- 
2.17.0
