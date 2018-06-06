Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2rZLsjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0C5860555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeFFEjc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 00:39:32 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35553 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeFFEjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 00:39:31 -0400
X-Google-Smtp-Source: ADUXVKJs7YTFzvt8wkxeyLYfds1Murcxdytj5d/fjjjwk5NfFWrOcm7SoS7ZRLmFHW31mhKI6HEuMw==
From: Jun Yao <yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        robin.murphy@arm.com, labbott@redhat.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH v3 0/3] arm64/mm: migrate swapper_pg_dir
Date: Wed,  6 Jun 2018 12:39:18 +0800
Message-Id: <20180606043921.19851-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 3 changes:
	* Fix memory leak problem with CONFIG_ARM64_SW_TTBR0_PAN
	* add comment explaining why the flush is needed and also why
	  __pa_swapper_pg_dir gets placed in the .mmuoff.data.read
	  section.

[v2] https://www.spinics.net/lists/arm-kernel/msg657549.html
[v1] https://www.spinics.net/lists/kernel/msg2819351.html

Jun Yao (3):
  arm64/mm: pass swapper_pg_dir as an argument to __enable_mmu()
  arm64/mm: introduce variable to save new swapper_pg_dir address
  arm64/mm: migrate swapper_pg_dir and tramp_pg_dir

 arch/arm64/include/asm/mmu_context.h |  6 +-
 arch/arm64/include/asm/pgtable.h     |  3 +
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/head.S             |  6 +-
 arch/arm64/kernel/hibernate.c        |  2 +-
 arch/arm64/kernel/sleep.S            |  1 +
 arch/arm64/mm/kasan_init.c           |  6 +-
 arch/arm64/mm/mmu.c                  | 97 ++++++++++++++++++++--------
 8 files changed, 84 insertions(+), 39 deletions(-)

-- 
2.17.0
