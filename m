Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE830C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CA520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO4uvPpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CA520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeGYJnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:43:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43664 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeGYJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:43:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so4819747pgr.10;
        Wed, 25 Jul 2018 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rj+UF/Kt1DiytsI62ALlP9pSFqblTTsClk8ZrsGloSs=;
        b=eO4uvPpTEr93GNMaaQXQ7c1evCAOSpdDytyJQxwdm1JWo4gIBf/Pk+iTJ6QgCYPVhZ
         lS0HtHFlfTRNQAE7mXJ6ZaFd+SQ/jtWCBAoRzVkbM2Gc9kmkFhNfUulojD7zpXdcTJvW
         GHTHEg93tmX5WIFqmNle9A6NFVrjvsYCP6wTg8uNS1VZZoQASyxdoFw/3WbIfzQuOHs8
         w1XgCwhTqxd1ld7NhPq1dKcJBVtA/B4mZwPx4RNgRip5/TMHjkJwoR2wKV+DTPMSY0a5
         arhkZLLfwuh9Zb5LR/9cl1XWHV08E6WaP27Pc+ndZUjR0m55i+w+PnGcI7D1wdkIxMa5
         CArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rj+UF/Kt1DiytsI62ALlP9pSFqblTTsClk8ZrsGloSs=;
        b=EbdjOs3zTYZte5sC4XJZKbcdmO7Pue5QFgkut9Wxjn4Ox9EezxtQMlyRHpvVa/mnEH
         S68fs4e4QwOrlJfEQ/UsF5Tz6KwjK3auqfout6B3veDKcwEJ4zG1p0NzWEjBZkkQg/A+
         3QL8GvYHqmkQ/MAFxNavWywV+Ri9hiTRjL+K/803WfVPcg6SWDtSsXfmV3mzGr3816F0
         jSzyiA32jtCXYKw4Ni6lCP1aZlNdwfIB4QRXI66AcfFz/QG79t9nMRfCAJfKQTCUVj/c
         AnKXUBc6qw+szn21iNTbUSPq/7p78sPUhGxBr6DMCCgFlEKsgHY/7k61smpBKoclH/EL
         3AEg==
X-Gm-Message-State: AOUpUlHRP+Y3KeiBKlgXCxb9zr/tqYjy1uk7NWqKoOGgI9ZZR3KXnMS1
        GkX6ysZLEpN2PhhWf7CVkow=
X-Google-Smtp-Source: AAOMgpdq3dbcUBxz6ywMPf+vv3NOa2AwqBSMN5AfKFAJLMecZwGTUbYMIjS4VxaU1wgZVK42NGWe7g==
X-Received: by 2002:a63:d54e:: with SMTP id v14-v6mr9103229pgi.264.1532507583940;
        Wed, 25 Jul 2018 01:33:03 -0700 (PDT)
Received: from localhost.localdomain ([173.254.200.131])
        by smtp.googlemail.com with ESMTPSA id v22-v6sm32587225pfi.60.2018.07.25.01.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 01:33:03 -0700 (PDT)
From:   Liang Chen <liangchen.linux@gmail.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liang Chen <liangchen.linux@gmail.com>
Subject: [PATCH] KVM: x86: Skip pae_root shadow allocation if tdp enabled
Date:   Wed, 25 Jul 2018 16:32:14 +0800
Message-Id: <20180725083214.7703-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the fact that the pae_root shadow is not needed when
tdp is in use, skip the pae_root shadow page allocation to allow
mmu creation even not being able to obtain memory from DMA32
zone when particular cgroup cpuset.mems or mempolicy control is
applied.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 arch/x86/kvm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690..af8cc1e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5029,6 +5029,9 @@ static int alloc_mmu_pages(struct kvm_vcpu *vcpu)
 	struct page *page;
 	int i;
 
+	if (tdp_enabled)
+		return 0;
+
 	/*
 	 * When emulating 32-bit mode, cr3 is only 32 bits even on x86_64.
 	 * Therefore we need to allocate shadow page tables in the first
-- 
1.8.3.1

