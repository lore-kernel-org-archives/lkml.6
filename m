Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AA8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A6C20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+lLjpdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A6C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeIZOox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:44:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37626 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbeIZOow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:44:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id az3-v6so135566plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KwSJ/ddsrLXBKVax3TPyV5fU4fUUHvzkXBSHRSHeQgk=;
        b=j+lLjpdwiyxfa245manTZRXRQ1kMi/7QyKlaqYcEd7ZlCwqZ814wUnEDycsMKaNWXD
         fAe6gm3TUsabDHiVV+swr/KqKYNgD5HP3iYpaF/LOs4j86wyXd56jAZD8hUAPP5Bc4NT
         29FVfSSvTPDGrA0DkBdTd1pgsgSnIOBPU9CU3rCzUb7I+TFle881t+uC5NW+V/95/k4q
         nyfhoTKHtTn+ZFfmOm/Ae0rG4iMQmyzMFWMwIIO7C2oUKqAoRI+p/I1GK4TyDHHDc3i1
         mdcsfKjSO9yV/DzLnby986fvefkHekbzscYnLdybJlI3dH+QKjZ/ntR1SQin+ur2Mr/I
         4FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KwSJ/ddsrLXBKVax3TPyV5fU4fUUHvzkXBSHRSHeQgk=;
        b=VWlioMAwQwI5JzenFprq7wfUnindRDgBhZpTbB67ys29JFEzSZmFHwgxbO9HWyEBAX
         jgBtFY32EFsWqfLz5an2Qp/IQrO+FA63K0L1UBA+rBoc2e/J9z60wbXWzjCtD15aYyCB
         CwlJr7ASrBcIvKRYiGpxS3Mx//1Q5Q+YJA4kPDvw1lBaupGBFRu6spFhynEvTSGvqRSk
         PP3GdIqW9zEkONHru4kzB6mC4lFYdb/3qPHBMOmhGa5UwTDYNBi9MXR8AIGtCWbrkU7e
         xEzNPdjytzNr5YI8fFs/pGAHw5hAT81oDwlqPJ6KefacP5FS2mdfED34rDBfU75Xdn/y
         Czvw==
X-Gm-Message-State: ABuFfoh8PHRBUV6/GeNFuZ0Zyx62wighGNELRtVtXUCswzbTkjZaNwNL
        lCSTgXAg+A24h7Up3vj/RMg=
X-Google-Smtp-Source: ACcGV63LwVQVqcZR4OgBItA6zz5VxtSpnnPGKn7Ajj31mpJEQhr4iPHhd3gnCtNtnv2Cx+x0R2O+BQ==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19-v6mr4879438plo.263.1537950785140;
        Wed, 26 Sep 2018 01:33:05 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id f15-v6sm5530764pgv.66.2018.09.26.01.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:33:04 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v2 4/5] RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
Date:   Wed, 26 Sep 2018 16:31:13 +0800
Message-Id: <8dd79f009f4a8a4785fd88ddbe94d0a114d5bc36.1537949825.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537949825.git.zongbox@gmail.com>
References: <cover.1537949825.git.zongbox@gmail.com>
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

