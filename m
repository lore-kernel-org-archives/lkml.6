Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E9BECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C42720853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KvkQ4RMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C42720853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIODLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:11:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23763 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeIODLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536962097; x=1568498097;
  h=from:to:cc:subject:date:message-id;
  bh=Ojmwpmu9foJtEU4LbB0DgEPFG5+RRM0+sZdKjQkzykw=;
  b=KvkQ4RMxkaGF/X2+dfcqSaC8MmFDt7znLUJFj4NNC3CppWq6HMB+bbGa
   WlcrUiLzX9AHp51NtNEHYkJwHQaMaNjXpqoDTyq37kPbn4HxYCdwCNTV5
   13r7b21NmcjRT++F68pxJbvUoNojnuLNmrm7UgB3NuW1oDIgV/CmfHmLO
   ohD8akzOLfA+n9IyqI6S7QB+1rtHK9zFTcoEUFn6vQqRZGT/Du52cbfQJ
   Si96yA21VAbrsaGR9XDONKirnROu/Zzh18yDv/o5kT8bJyaycp0/VW98s
   gjxy0oGaG19qwfyRCCIiA8aH6uf0dZL+GhU7pI4PVlM3pG5ZogNB0OKh/
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,374,1531756800"; 
   d="scan'208";a="89803039"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2018 05:54:57 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Sep 2018 14:41:22 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Sep 2018 14:54:57 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org
Cc:     anup@brainfault.org, atish.patra@wdc.com, mark.rutland@arm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Damien.LeMoal@wdc.com, marc.zyngier@arm.com, robh@kernel.org
Subject: [RFC 0/3] Timer code cleanup 
Date:   Fri, 14 Sep 2018 14:54:53 -0700
Message-Id: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series address some required timer cleanups in RISC-V.

Atish Patra (2):
  RISC-V:Support per-hart timebase-frequency
  RISC-V: Remove per cpu clocksource

Palmer Dabbelt (1):
  dt-bindings: Correct RISC-V's timebase-frequency

 Documentation/devicetree/bindings/riscv/cpus.txt |  4 +++-
 arch/riscv/kernel/time.c                         |  9 +--------
 drivers/clocksource/riscv_timer.c                | 22 ++++++++++++++++++----
 3 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.7.4

