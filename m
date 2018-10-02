Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD085C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9103420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJCSu1Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9103420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJBPlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:41:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35400 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeJBPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:41:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8-v6so655852plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KwSJ/ddsrLXBKVax3TPyV5fU4fUUHvzkXBSHRSHeQgk=;
        b=EJCSu1Zsm8bh3U8fH8akMthzApptr4z1KJm/EKR9LjzMRZnCi1BtebyWDVwcJZQQ5b
         vybpQsdhav/eZUsMtT9z0pmFUq2yqy57dsQDsRScts7ri9GsKMAp0BwaqSlOi+ZjZg5O
         rZBbe3SDgDlSYOZ5mKHA0B24TSlriTuOogMq6anq4lFKOOiQEcXQ8slRScv3AL0YZQpg
         1We17vaqDTx9XfM5ugeO5goWF8k/aG0vL5lLW/4OBWaMNdOaTkNNYuTjXbJ+5VujZTp7
         BO5H5/JDkC0JcqNOj22MVZYAbMkfXxoFUQIuOmEpz9Jd5ecZC+FfeFeEhVepcDH7oi13
         IowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KwSJ/ddsrLXBKVax3TPyV5fU4fUUHvzkXBSHRSHeQgk=;
        b=DJn4vrPg5uiXhCrGgTBuMe5K40/agw0j4xUYvZdlZ2dLuR7INaz2JCN+i+aBSe3jaz
         MsBqdqLMt1n5spLxxm5+++IT6jdFN8jmW2C6kofis3r9ziAgNMPcvjmjTvrMgik1PLnP
         PdR4L91Zqw2OEynKU02ZEiIAolepCifi3kwsI3zgnJ/ZHECKj4HclHld4zDV01Zxzxzq
         3EYLfVAPxoHm/R/Qi/PAYkSawRZ19G+qG9wtagf5a47XoJg70nldhdreRFqF7mAzSEH6
         kgjKA+omMJ13B0WFdJx6jbnxFxpaq/eCjrlX+L0vM7od43xBx4lOGLSh6/Dfv+xhcv6I
         9Y4A==
X-Gm-Message-State: ABuFfojo3L+ERFxI32czcKdBQvD1AGQleP9Bgkvl5uSbYfQeJHZI5yf1
        6FVPEd8D99yiXRItCBiCJ3Y=
X-Google-Smtp-Source: ACcGV62lO2XTJHH/+g7hZ+yDQKSgiVh0LlTkou/y/zod9fMSE5eHUeAEj1hnRCNskmErG9Stpww1uQ==
X-Received: by 2002:a63:6a86:: with SMTP id f128-v6mr13916830pgc.165.1538470769302;
        Tue, 02 Oct 2018 01:59:29 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id 62-v6sm5057927pgc.58.2018.10.02.01.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:59:28 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v3 4/5] RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
Date:   Tue,  2 Oct 2018 16:52:30 +0800
Message-Id: <3f1967e8be0c25910bf04181e84b46a788a156d7.1538470103.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538470103.git.zongbox@gmail.com>
References: <cover.1538470103.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit, it need to use __umoddi3 by some drivers.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980..dc262fa 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -108,6 +108,7 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
+	select GENERIC_LIB_UMODDI3
 
 config ARCH_RV64I
 	bool "RV64I"
-- 
2.7.4

