Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9936AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5840B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="G/cJk7Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5840B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeJaPoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:44:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33356 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:44:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id a15-v6so7146150pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 23:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Fbt1DrvQ5WLpCxOHM0qCKLv5iGK/kb8b9uOh/P5ZQg=;
        b=G/cJk7WikN8Jxaj2TMSNLJDR23Db8rkhdwuz/k6aCXGFo4rJbKhLrzgNQCJ54GW6JK
         E/RUc66YxFf3Fik67aUvbzRzIqwc9sNeqfEq329jo4NRXic3LeMp7OnXiftm1nEEo1p0
         J553lRpV7peDL17dABbHRockRmtuUIPnDPRx6boVJckAJ1mdpQvl1FbV3/9u8P4Wis+3
         be3f0ysl8PiKrvuDKwnwxvRY6l39/XXoHwBW8y/abS0lp25x3X33b8cMzNq6kTrR5RxD
         V381rl/lE3lbnvjjn5CFVo6Xdngw8IolmPHrASPGCexe7+MoG42iPDnuMfiPTafWn8OV
         zFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Fbt1DrvQ5WLpCxOHM0qCKLv5iGK/kb8b9uOh/P5ZQg=;
        b=Zsk4tJ7+ooyY2N5rV4urMCMs9XvhvQ91B0bmy7zAfNF7SkDhnnk5XyAQ7ZTlhFvF7G
         LJZnrgTy9YX6M2m+BGwBklrP1u279mMJKx0rOHbJMSKKSeCZVz+2ZKlCPx773FyXark7
         q64dOdHpk9QlEdUde4sY4ah3h9/KAFVJZCnt0i2d1qH6o+mHFz4cMyeqVFX3SQW5jYRy
         K2GSGygR4Qq6hK77dMl6S8+b6wg6JCaguebHZIbNGvXG8Ysnd70qIBDU0P49CwexpS6p
         d1x1GWcxL6ebo5zq5ipFUoBTqQsOKgA/mwfRbZIz9B2Yjqo7EkNT2IPtQ9BiCuzeRBR9
         6pMQ==
X-Gm-Message-State: AGRZ1gJASTUwA1PjieEiIbUqY/IhusRJvjrriXfFEmbzZMs56AtW1SQ8
        10zBISKz7ER1KadSgHZnIRO+1w==
X-Google-Smtp-Source: AJdET5d3dTC4bp/a8/aQ/XeMhAEVV4k1e+W0RUHKocTGRsln23wbEkpveOOmQVD/QnCtJj/j2KAC3g==
X-Received: by 2002:a63:6b08:: with SMTP id g8mr1910867pgc.119.1540968441269;
        Tue, 30 Oct 2018 23:47:21 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id z7-v6sm12127306pgi.42.2018.10.30.23.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 23:47:19 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/3] RISC-V: lib: Fix build error for 64-bit
Date:   Tue, 30 Oct 2018 23:47:07 -0700
Message-Id: <20181031064709.30981-2-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181031064709.30981-1-olof@lixom.net>
References: <20181031064709.30981-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following build error from tinyconfig:

riscv64-unknown-linux-gnu-ld: kernel/sched/fair.o: in function `.L8':
fair.c:(.text+0x70): undefined reference to `__lshrti3'
riscv64-unknown-linux-gnu-ld: kernel/time/clocksource.o: in function `.L0 ':
clocksource.c:(.text+0x334): undefined reference to `__lshrti3'

Fixes: 7f47c73b355f ("RISC-V: Build tishift only on 64-bit")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 5739bd05d289..4e2e600f7d53 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -3,6 +3,6 @@ lib-y	+= memcpy.o
 lib-y	+= memset.o
 lib-y	+= uaccess.o
 
-lib-(CONFIG_64BIT) += tishift.o
+lib-$(CONFIG_64BIT) += tishift.o
 
 lib-$(CONFIG_32BIT) += udivdi3.o
-- 
2.11.0

