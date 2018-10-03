Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75083C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1438820878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt6qTJEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1438820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeJCJ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:59:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41594 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeJCJ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:59:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so936312pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 20:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nEVDmBbxfh6xO+hh75zn5eGRCfiidmomaGOCEIOQa7M=;
        b=Zt6qTJEpuMAYmyFCdxXwjBcK9NxMRUvIOlf0L3MHC8ATWd2oAbcumac2zSELI52CUq
         UKco2vxnJ0ZbHk/ADZYcULmVI/qbwRMyyVrxkhNopj5dx4Cbcv0vwSTAH5JBrE166WCb
         +FkNagsprBEgFse62L1Bc6PEfAVy5JwOvCOoQOSegvu0JIclFR7Q3uELVfKw/k2whFne
         ptHQxUvwysZh0diU1ISEu8iaDCXeXrPLB1xmAnnRnX1r2HJrET4Mcm4MmPfTX1ZT9iXB
         U825neixL8nPlOetoxFY6d5s7KDEaLuzpFQSCyntIpsqGymq7S+2S22EHjiLk9I88zFt
         9oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nEVDmBbxfh6xO+hh75zn5eGRCfiidmomaGOCEIOQa7M=;
        b=aMbMEort+XQC2tsmbDecLuWE0/0l4xYG+D2WaMhpuvfeIFf9Z8aBqVZdOd/9VwS5lq
         FoJXOlN2n83BBQUGbwRTplMlJhYA8EqGX1ac/f7hP9zC0pc3CLqZd5afjkHSBCEp/jKr
         qyueu1cNveik7KgIZAguF9U5c502NUGMiyNAQWJ0Y06QOjqObQyVxn3WyCm9dWbulfYD
         cP2XE3QP+L+DKXNv50oWYZLGXrXY86z9anHOVqylFnUvq1XDg+R0o9x1EHobuP4fbdLL
         Xt9z780Zr20E5Mgn/oUF6U3gPD9VWiSyJYM6mIp0rUk5cWEbqol4iWOc55kJ11T5UxQw
         ++Uw==
X-Gm-Message-State: ABuFfohHNx/dAnW0OiCr7Ez9L6PffYzB/neiocADMh+RIUPTf44oMGjo
        DLT5/ZeLOFP2nrsmOKNivFk=
X-Google-Smtp-Source: ACcGV6104aFcCl70X28KtsuX3W+/X9gvYyPw3zHVyXUhzd0xiKTxH8USlIK1f/F+lQvVA8msDWe6fw==
X-Received: by 2002:a63:4c4e:: with SMTP id m14-v6mr16990363pgl.173.1538536359605;
        Tue, 02 Oct 2018 20:12:39 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id v23-v6sm21777747pfm.80.2018.10.02.20.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 20:12:38 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v4 0/5] Fix some bugs on RV32 build fail and issue
Date:   Wed,  3 Oct 2018 11:09:57 +0800
Message-Id: <cover.1538535527.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches contain the modificaion as follows:
1. Fix up the building fail on RV32.
2. Add umoddi3 and udivmoddi4 functions for RV32.
3. Fix ioremap problem on RV32.

Thanks all for review these code and modify the copyright description.

Changes in v4:
 - Retain the complete copyright description.
 - Modify commit message.
 - Rebase upstream code.

Changes in v3:
 - Change the copyright notices to GPLv2 from  gcc 4.2.1.

Changes in v2:
 - Retain the copyright notices from libgcc in umoddi3.c and udivmoddi4.c.

Vincent Chen (1):
  RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap

Zong Li (4):
  RISC-V: Build tishift only on 64-bit
  RISC-V: Add preprocessor directive for swiotlb
  lib: Add umoddi3 and udivmoddi4 of GCC library routines
  RISC-V: Select GENERIC_LIB_UMODDI3 on RV32

 arch/riscv/Kconfig        |   1 +
 arch/riscv/kernel/setup.c |   3 +
 arch/riscv/lib/Makefile   |   3 +-
 arch/riscv/mm/ioremap.c   |   2 +-
 lib/Kconfig               |   3 +
 lib/Makefile              |   1 +
 lib/udivmoddi4.c          | 326 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/umoddi3.c             |  48 +++++++
 8 files changed, 385 insertions(+), 2 deletions(-)
 create mode 100644 lib/udivmoddi4.c
 create mode 100644 lib/umoddi3.c

-- 
2.7.4

