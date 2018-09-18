Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAB0ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F78420652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgmzmcQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F78420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeIROwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:52:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44160 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIROwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:52:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id ba4-v6so690901plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AZwxoxy6a/kBuhlw38QYEabFPt7ZdMTs0e9M26wWkB0=;
        b=WgmzmcQTT5FGJE7sG5mzlyCgwU7J80FhSPdA2rUg2fdLOje5NRAjs4nQPb8namZRp0
         wARweuXAsSqCIzkVMlIhOXaf7p8I7arssftTwBQ0/o4pL/tjd74bCx+1sNIPvjo/jlmF
         FIrozYulIFR3xLbatu1mxtjWbn9dvg1VUvfPJlmXPbw+1PSiK5j/EcMoWRJ3mTg6/x7A
         qy+YjFklPlWt7v5l0ZVA+gUNAJSzeQsWF5ycHYS4p2rB6Emblg7rrMzXdMAm2yBrn9gQ
         3pLLhIR5qC+81+PzAoccZCf5U28W+fBKDCXlh1RV3Ns7EAJS+f2kB1V2+f4+K5AXi5nf
         FjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AZwxoxy6a/kBuhlw38QYEabFPt7ZdMTs0e9M26wWkB0=;
        b=BuWwPey0mGpXy0KrqCQNcnPvFhC1LsSC5Vu74JaTiyidtF2dkTmrnsqkx7hKdntx7w
         m2mUXN1kzJk1OC9jCKSd6EYXRR4EfdVafZ66oFgSAZJVFVqiZa1ZccuG9WUME5ba9oGL
         XlY58curNoWThZD04hzWXod7sxZonJ1cGt3t9zddYygM5fD6Yova1OP6s01DzzVHdsLO
         b1xL5XZ0ztAc4Ebmk6KU1j3pJ8wfkgEVHLm1olFLxpQVl8r/d2qbQBMYSsFkhPL+44jS
         gTvmXOjYHI33lDybW7LouJfMGYGHaEe0mLnne1UL9G1AMzwwfdKPmYZaTnO2FbV6+kHn
         YIBQ==
X-Gm-Message-State: APzg51A8/RO9g3H7abBn4sIF8xmgAd1E3tGnq2JOx4vCgHQ9+kJSMoqx
        MUrLM3pV3HKAGwwKnheBZejmHY74W1Y=
X-Google-Smtp-Source: ANB0VdZTcJAqXGENXy3IMURt88NzNDm/dSLo5Yv8CRO/CjSdwhnCu0SQ/Q5FCY5PHRnZXjrBXDhzvg==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12-v6mr28595777plb.339.1537262448413;
        Tue, 18 Sep 2018 02:20:48 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id 1-v6sm29932877pfm.145.2018.09.18.02.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 02:20:47 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     vincentc@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH 0/5] Fix some bugs on RV32 build fail and issue.
Date:   Tue, 18 Sep 2018 17:19:12 +0800
Message-Id: <cover.1537260207.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches fix up the building fail, less function and other issue on RV32.

Vincent Chen (1):
  RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap

Zong Li (4):
  RISC-V: Build tishift only on 64-bit
  RISC-V: Use swiotlb on RV64 only
  lib: Add umoddi3 and udivmoddi4 of GCC library routines
  RISC-V: Select GENERIC_LIB_UMODDI3 on RV32

 arch/riscv/Kconfig        |   1 +
 arch/riscv/kernel/setup.c |   3 +
 arch/riscv/lib/Makefile   |   3 +-
 arch/riscv/mm/ioremap.c   |   2 +-
 lib/Kconfig               |   3 +
 lib/Makefile              |   1 +
 lib/udivmoddi4.c          | 291 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/umoddi3.c             |  16 +++
 8 files changed, 318 insertions(+), 2 deletions(-)
 create mode 100644 lib/udivmoddi4.c
 create mode 100644 lib/umoddi3.c

-- 
2.7.4

