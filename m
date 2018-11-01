Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA89DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978DC2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="wp3OC5Lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978DC2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeKAOMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:12:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45212 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeKAOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:12:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id v5-v6so3821619pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 22:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UNjlZwzEibKT0pjzTMJaaD3o9L1rvct5mj+DCG0u1zI=;
        b=wp3OC5LtDEozgoLARjfS3jV8khWnfrYQepVydRRB17NtexCv5VCgGr05DVg766ne4u
         QrP21bD4fpWPmPRwyycMUg0npyi+9EgiXf/ujWaB5UqXeYIWfIVtQYv0SGFt9JyOjVhV
         b7o2rGPUxvxyMX9kc2X1fXtzQWQpFXOdleRC3o1iKw+rOTeUxsyySZc7bkK9VpAhCaXQ
         KrqJcEkKqqXNsPqHlXMRPSdig+Tb79k0QMOb29Mlgf+aK9TM165foD4mzTlmLZb59GcD
         QjRHg3eHQuEK3owu5FMqmSWLkLKSZzs4j62JtN4dogXhQG+Bsx/AbmUHu3H3wRIGWNwh
         bLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UNjlZwzEibKT0pjzTMJaaD3o9L1rvct5mj+DCG0u1zI=;
        b=lUkiFd8a/wtzh7g+KjOMUEtKRw1OlwyhgLqueofsC9Vca1GlyRJYr29CoqbgH8e3DM
         TjFjgSl2auoSUh35d2nSnEkthWxvzmjibHJboJJvgZ4lG+fVrD2gudJUcGFe/QNHdasV
         kuPDK7JcR6A9C7oUL6CWMceZRYJg1y1w1QyvG9HhWo82j/ieFPvjCA3RgBKqjQncxeaS
         Yqb3rr3cvCnAIXzQ9A2yA1b1Q2+BBJM90RtYQoLfQYO/fqKYuR8g5MePmkVuPXLhT1c1
         F2KmN3aTA2+2EB93QaY3EprFCRN+Fu4/2oiC4Gu2n88VpU5mV0uZAothu/2552EQ4fRk
         HwGA==
X-Gm-Message-State: AGRZ1gIU5l89IXoucefUtopIZKxs8pS3v/xJiVC9Qwst87wXZpjiMlu3
        NcaNIsb+7Qe4lmCVnMRcqnTdfQ==
X-Google-Smtp-Source: AJdET5eGQjhXo9+RKEK+roGDOD/OGxppBe4TmuezY8XulQ7sz8nfKktMdCrIl1I+/dSD+YQBBKORzA==
X-Received: by 2002:a63:84c7:: with SMTP id k190mr5879310pgd.333.1541049048515;
        Wed, 31 Oct 2018 22:10:48 -0700 (PDT)
Received: from anup-ubuntu64.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id d65-v6sm40439166pfm.100.2018.10.31.22.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 22:10:47 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Olof Johansson <olof@lixom.net>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 1/2] RISC-V: refresh defconfig
Date:   Thu,  1 Nov 2018 10:40:32 +0530
Message-Id: <20181101051033.10089-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates defconfig using savedefconfig on Linux-4.19.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/configs/defconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 36473d7dbaac..07fa9ea75fea 100644
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
@@ -72,8 +75,5 @@ CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
-# CONFIG_RCU_TRACE is not set
 CONFIG_CRYPTO_USER_API_HASH=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_SIFIVE_PLIC=y
+# CONFIG_RCU_TRACE is not set
-- 
2.17.1

