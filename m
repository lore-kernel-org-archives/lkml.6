Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A65C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3EB20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ogsNzlSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3EB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJ3Vay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:30:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46906 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJ3Vay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:30:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id m9-v6so2876987pgl.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yVaQod+fi2xINGG2j9rDMMFEZAk6lbYu2uDKW0xsB5M=;
        b=ogsNzlSYarf8GOyoaCSXAzEmdU9SP+rm4tTlJfdZk8seWSFOoN848gYG8rX/bQv8f+
         djgp3OEfoNrtKc+bY79vXofXnmNi7hjeg7bjM0Yn409WDP1gcCLsfo1bz4M39rs5faIr
         g1vXWEeAIAs2mKY3+F2xgDC8mWcbdtdG/ay44sGBjJqxmXnXKGB4IHJyy8O0OAmKTu70
         ksIYFaJ1OV2U+9BdmVjlSRT/xGCKws/rQ8Y3PdGFhuoRKywqGDaZlxTg7uVhOXRvyjC8
         rf8GpQMQwua+zuMplEcYoOPEeJ/RSlPyWGO8P6XZKYSZuOEOuoP0opL4s7Z0vIDyBOke
         MyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yVaQod+fi2xINGG2j9rDMMFEZAk6lbYu2uDKW0xsB5M=;
        b=lKE32ufMekxx+/6tktYexNv1Vb7AfxtbLKlxuMbpm7tsO7Sqpxfpo2DEtoyD+Br0do
         bRcq6A6fsK78RGi+fokpmS1WEQp0JR9PZza3WanzcVLJBD4G7rlvnzWwEPwl2vy/4rQq
         Qdc4UIiZKHAWaHq9t2V7zwVzeHDidNZDJJmjnCBx1uKuJ0rcG+tzXRQ5NKVN45TU8eay
         nWPFW39Y0ADUlUqILAU/mzJFUSWyliaimk42vstx0CLbv6NLRF+w0H2myWOxQKVAOmQv
         fs+u8l9uNkwL0gMSS2GA0PDE5mSBmS5L1aFkU/VLsF2XFdF2gHyeAUFLZBs4kGFYNK4B
         1+6Q==
X-Gm-Message-State: AGRZ1gK5YksiXYMpE1fDaeLccffAsb+ux9vseYjmTMmO1WYbsZ5fHgqB
        yePZ1UGQ4oMmXDPcNhKcjjrIqQ==
X-Google-Smtp-Source: AJdET5cmuSn0QKBHKAKDZdLdcyyWKmai7cMssQnjrCVPiiVUxVt8X9aTRdJWuUeQoB/cn2CLW7PiWQ==
X-Received: by 2002:a63:b04f:: with SMTP id z15-v6mr17927913pgo.442.1540903056507;
        Tue, 30 Oct 2018 05:37:36 -0700 (PDT)
Received: from anup-ubuntu64.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id l16-v6sm34819958pfb.75.2018.10.30.05.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 05:37:35 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH] RISC-V: defconfig: Enable printk timestamps
Date:   Tue, 30 Oct 2018 18:07:20 +0530
Message-Id: <20181030123720.3273-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk timestamps are very useful information to visually see
where kernel is spending time during boot. It also helps us see
the timing of hotplug events at runtime.

This patch enables printk timestamps in RISC-V defconfig so that
we have it enabled by default (similar to other architectures
such as x86_64, arm64, etc).

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/configs/defconfig | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 36473d7dbaac..ef4f15df9adf 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -1,6 +1,3 @@
-CONFIG_SMP=y
-CONFIG_PCI=y
-CONFIG_PCIE_XILINX=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_IKCONFIG=y
@@ -11,10 +8,15 @@ CONFIG_CFS_BANDWIDTH=y
 CONFIG_CGROUP_BPF=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BPF_SYSCALL=y
+CONFIG_SMP=y
+CONFIG_PCI=y
+CONFIG_PCIE_XILINX=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -59,6 +61,7 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_SIFIVE_PLIC=y
 CONFIG_RAS=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
@@ -72,8 +75,6 @@ CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
-# CONFIG_RCU_TRACE is not set
 CONFIG_CRYPTO_USER_API_HASH=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_SIFIVE_PLIC=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_RCU_TRACE is not set
-- 
2.17.1

