Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA40C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493EF20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rijGVNO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493EF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406906AbeKWGfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438569AbeKWGfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:35:00 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DCC920865;
        Thu, 22 Nov 2018 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916448;
        bh=jbzllQEYNymsMfX2vnIAR7wuaoxJBbiPJJ9RJ4u4SXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rijGVNO52pvD2fWHh4mIzN4Cu5b8UvNSjG2f3BZlsGPU1FMXbjCXogbjZKC3cuXRD
         ci9VA03OJMUpx5g2VSVPhY72QnPM7y8wYEBpiZk7NwyhLBnwsN9Bdn7OT7U90sl5NZ
         hIzf3lRKc4GEOrg8vWOitGCoirTZCqOgbbqysMNA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 26/36] riscv: add missing vdso_install target
Date:   Thu, 22 Nov 2018 14:52:30 -0500
Message-Id: <20181122195240.13123-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Abdurachmanov <david.abdurachmanov@gmail.com>

[ Upstream commit f157d411a9eb170d2ee6b766da7a381962017cc9 ]

Building kernel 4.20 for Fedora as RPM fails, because riscv is missing
vdso_install target in arch/riscv/Makefile.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 61ec42405ec9..110be14e6122 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -82,4 +82,8 @@ core-y += arch/riscv/kernel/ arch/riscv/mm/
 
 libs-y += arch/riscv/lib/
 
+PHONY += vdso_install
+vdso_install:
+	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
+
 all: vmlinux
-- 
2.17.1

