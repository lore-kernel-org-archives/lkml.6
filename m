Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9DAC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC7720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrEfqbOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC7720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbeGXVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:55:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46694 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388805AbeGXVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:54:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so3681208pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UMJSLf5oEZSIEiZFYvpZwcAoq64+3JAfqPf+lINJbSw=;
        b=MrEfqbOvpWt0xYldMGS34jZIEij1IvekjfJ9FqMC8Z1EbWZMidayNl01FXU2Y+BOcF
         RSjZ97piJK2qH47sau6KbuOQ5qHe/dhOZYEaO/zthRXVACnDRK5ys78gNynmljYl9vd6
         RpDMG+BQ+iyrPUR9xxOGci5SywObz2jb2RpVUBtObYLRRURCO2iHM/Q1ny+WIrf1gV5m
         whNS458dqn1oDhqbEEgfV2G/1ibGt3/5hvNJ8vl58clsSia/rnX1QPmQgXTRmHQPH6Wp
         BdR+H0Fi1Q5HDUYixSxxMASGMRHBjnQMAuxJyP5dyN7HGyJrWEZ1vG5jSfjOlYgdPtt7
         J+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UMJSLf5oEZSIEiZFYvpZwcAoq64+3JAfqPf+lINJbSw=;
        b=C+KoGrwNtJuase5ZhiuvMkv4SRmG66JJWMdjJesugmIsCQlVtAP/h37ogH3BVZGmRV
         isSMNTDBAUJUPnb6mQAO6WFxKCNYuVALOGnNViAQe8xuEft6G2hgv/rbXKhzW2W72T8N
         dSxHvIaP4d7v2y8fpj03zLJh8nCw8wSEPTfJaXg0lVzfKxXTQrn7n/ButAXKm/scL4jL
         YiWHBW1QpY82wtulb669JPgFtSR/UZk0eeq/ufaBHCsOKFetOBcyrJBeF07c5oF3nI50
         zmQYbI3dJhNT1RumNCAjPvoYnVFJxflaxfb5+eA8XlIlr5Qn8w6HeqMZqwaY6XBAbAAA
         z9aQ==
X-Gm-Message-State: AOUpUlGGb3E0I6Iua88tMVjuTW1HqB02Skad9FbjKo6L7zcLwqB/uYGp
        JdHRTAtrAwc7qdUsCyA2wFaMwDpR
X-Google-Smtp-Source: AAOMgpde6HS7qqBuTwhj52Rs485G1qIPnFH2eaHN/2I/JBoY5icjDAIczTSSNxAIZnlchEc6Cwhvfg==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr17319812pgq.392.1532465191879;
        Tue, 24 Jul 2018 13:46:31 -0700 (PDT)
Received: from midway.home (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id t21-v6sm21536110pfi.73.2018.07.24.13.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 13:46:30 -0700 (PDT)
From:   Randy Dunlap <rd.dunlab@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Ofer Levi <oferle@mellanox.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 1/4] arc: fix some build issues in delay.h
Date:   Tue, 24 Jul 2018 13:46:19 -0700
Message-Id: <20180724204622.2366-2-rd.dunlab@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180724204622.2366-1-rd.dunlab@gmail.com>
References: <20180724204622.2366-1-rd.dunlab@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors in arch/arc/'s delay.h:
- add <linux/delay.h> for loops_per_jiffy
- add <asm-generic/types.h> for "u64"

In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:
../arch/arc/include/asm/delay.h: In function '__udelay':
../arch/arc/include/asm/delay.h:61:12: error: 'u64' undeclared (first use in this function)
  loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
            ^~~

In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:
../arch/arc/include/asm/delay.h: In function '__udelay':
../arch/arc/include/asm/delay.h:63:37: error: 'loops_per_jiffy' undeclared (first use in this function)
  loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
                                     ^~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Ofer Levi <oferle@mellanox.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/delay.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20180723.orig/arch/arc/include/asm/delay.h
+++ linux-next-20180723/arch/arc/include/asm/delay.h
@@ -17,6 +17,8 @@
 #ifndef __ASM_ARC_UDELAY_H
 #define __ASM_ARC_UDELAY_H
 
+#include <linux/delay.h>
+#include <asm-generic/types.h>
 #include <asm/param.h>		/* HZ */
 
 static inline void __delay(unsigned long loops)
