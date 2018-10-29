Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E643C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E952820824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iAmk3zUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E952820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeJ3ERA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:17:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40015 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJ3EQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:16:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9-v6so4284656pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=pkstlzjOSZ4fucbTr95yWc/rdxg9PHy2rBXqPF9UZVk=;
        b=iAmk3zUdrqtu5z71roW0mzLDU61Bag7JVrRwfB6UrJ/gXnwTzbMrLF8nln/LlMFDoC
         sdyto9XNnoLwot0dzQ4Pncaq43HRjzFcBngGEeSNWSHGKucWQ95EXFmmS31DB2L8GWyQ
         KtB93GhCJf32lxXSFq/0HIcrE1cgvxIGD/LUJkhvL8WZxbkJVyA8RofbXd9hLgyhMcqw
         8aarX9UKCmbMO39Z77Ndu5jKPrWLyMQipOQrmbxe2IcoOqi9HKDTuApIMBA11BU2hZ/y
         VXr7x+jD+jazW3GAkKa5RjjJMKVM6N5xi9SQ6tlPYLKC5u2yO3N/f4HON9lw5SI99r08
         atbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=pkstlzjOSZ4fucbTr95yWc/rdxg9PHy2rBXqPF9UZVk=;
        b=R62mvKlId6DvOnnXL+Th/UqK9vBnOs9wN4YUMZB7Q1EfUSSL2MJ4ETTdYPXjiQ3ZMa
         f1KemU9DV0qU61rrHWYjfwFccdBYj2zuXf0uAjrWIYuIocWvVkW/I0m7S7l4Od0a+XNS
         OEPBYpfdvX37mNB2XY9Y4kSNkzSMoR5PUSnAa2897aGnq9VOHp89j9SAMtsyWkMQ6F/m
         H4kCLk87r/Ibu+8c+wrgDhbfgTxBA/KWHBDHqYj7n+vdZnJL6APTwWiS1k/YBPmgJ3Sb
         Phm4n6rd5TF0kty6m7gDU44+J5bZashIYkI3nILWIMf/cPVK4df1dJgrSJRdcrwKUNs6
         HOOg==
X-Gm-Message-State: AGRZ1gLLCpXUzKHBgAhyFFRboLHq1htyTDHkzV2gw6AhreR80G2j95L7
        B1pBl4RyVdJg69xZb+JoSx/N4g==
X-Google-Smtp-Source: AJdET5cSrwgYX54x2/ixsdzTwj8APPIUhFNisPVhh0jpv8/RdrkJWFSKpiDY6RL8Ur8uU/MgAVqJtQ==
X-Received: by 2002:a17:902:4222:: with SMTP id g31-v6mr15444295pld.236.1540841215226;
        Mon, 29 Oct 2018 12:26:55 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p1-v6sm28923492pfj.72.2018.10.29.12.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:26:54 -0700 (PDT)
Subject: [PATCH 1/2] Revert "RISC-V: Select GENERIC_LIB_UMODDI3 on RV32"
Date:   Mon, 29 Oct 2018 12:26:33 -0700
Message-Id: <20181029192634.30078-2-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181029192634.30078-1-palmer@sifive.com>
References: <20181029192634.30078-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        khandual@linux.vnet.ibm.com, colyli@suse.de,
        andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org,
        willy@infradead.org, yuanzhichang@hisilicon.com,
        matt.redfearn@mips.com, robh@kernel.org,
        boris.brezillon@bootlin.com, Greg KH <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com, ynorov@caviumnetworks.com,
        keescook@chromium.org, bigeasy@linutronix.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org, zongbox@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm removing the generic 64-bit divide support, which means this will no
longer work.

This reverts commit 757331db921428295948fed5e7377a436e66d34e.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fe451348ae57..4198759f6798 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -109,7 +109,6 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
-	select GENERIC_LIB_UMODDI3
 
 config ARCH_RV64I
 	bool "RV64I"
-- 
2.18.1

