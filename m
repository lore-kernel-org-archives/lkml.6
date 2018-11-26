Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03963C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D59E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="gR1x7zwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D59E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeKZRF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:05:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43898 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:05:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so13352427plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ycwWr1lGERMQyqh6jY/uTIb5bXXqYhTnWn45u5xzpto=;
        b=gR1x7zwOUka48kMUoO0lfnRmyUbvphK9tetPQ+uxr7ajAcn46xrYZoHIR4gP7mau3x
         Aux78GvhwmG30DMxiRiRvvuk+HZVOKv+wv5Srw5YRtUawFBv1HhuQrrGHTynaw2Zy2rU
         x+oNnn3rZaOJwoG/EF3ZuF0ehUH7m3f4cwscrcMP8QU9MDOaoM4Qt5czmsNiqewLd2+k
         7Gmm9COTzsMkgO4BMcuJsTDR6GtdnMixIsUSZTmLQRUKPqlnvzAgh39Zzt9lIqlfVo3l
         7vAT/yQGk8F0ZOrDz2QYH2VdMt13VqjzZnXa/ySwYxxgGzQsiRvdc57H3USsmnL3Z4BE
         1coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ycwWr1lGERMQyqh6jY/uTIb5bXXqYhTnWn45u5xzpto=;
        b=dBOVqSFm+sF8C26cY0gbgoJMEgEMUjCemNacp1jjIyHa1vPHvlxA1/ARIRs+OygU8K
         fjRq9FRIh57ZpFHKoVkvAam9fkLUKHuLpPp8KaHB7Y8mF6+boDiOiQpDvZdii3b3y77t
         Tst3iRue2BBFiBY5C1x30heDai6pofrmEHgQ8BnGHK7z+HT92aqAYDP9+f9smblDK4hB
         hqsThhBnfIloUZHpDkt7TN4jnqtrpZJDztqfQ4HeyRI/wwLM2o3jyumwTgZ02+ocZmej
         cl1gqAQGgX/AYbb/h8aazMU3pwEBtT+M6+/RSHRwi8gy7bDaQvIZpWu7hoVaDEw1PfPy
         oEdA==
X-Gm-Message-State: AA+aEWZU2Hm+7/1+LoUmUSuRLJTEALodcZ/RSlbcPJfIUlxRMJJjXPmL
        kN23oT5g+WDm0fgafEJL1SolTg==
X-Google-Smtp-Source: AFSGD/UVVBaYMKKGo9A0o/8nMAV0AgvBTa0FHw8QvJ0KRI6uOLgmmdwg6Gd6exJfFoV2unR+fcX3rw==
X-Received: by 2002:a17:902:b60a:: with SMTP id b10mr24826817pls.303.1543212743665;
        Sun, 25 Nov 2018 22:12:23 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([106.51.18.229])
        by smtp.googlemail.com with ESMTPSA id y6sm5966790pfd.104.2018.11.25.22.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 22:12:22 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH] RISC-V: Make BSS section as the last section in vmlinux.lds.S
Date:   Mon, 26 Nov 2018 11:38:02 +0530
Message-Id: <20181126060802.19314-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objcopy only emits loadable sections when creating flat kernel
Image. To have minimal possible size of flat kernel Image, we should
have all non-loadable sections after loadable sections.

Currently, execption table section (loadable section) is after BSS
section (non-loadable section) in the RISC-V vmlinux.lds.S. This
is not optimal for having minimal flat kernel Image size hence this
patch makes BSS section as the last section in RISC-V vmlinux.lds.S.

In addition, we make BSS section aligned to 16byte instead of PAGE
aligned which further reduces flat kernel Image size by few KBs.

The flat kernel Image size of Linux-4.20-rc4 using GCC 8.2.0 is
8819980 bytes with current RISC-V vmlinux.lds.S and it reduces to
7991740 bytes with this patch applied using GCC 8.2.0. In summary,
this patch reduces Linux-4.20-rc4 flat kernel Image size by 809 KB.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 65df1dfdc303..cc99eed44931 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -74,8 +74,6 @@ SECTIONS
 		*(.sbss*)
 	}
 
-	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
-
 	EXCEPTION_TABLE(0x10)
 	NOTES
 
@@ -83,6 +81,8 @@ SECTIONS
 		*(.rel.dyn*)
 	}
 
+	BSS_SECTION(0x10, 0x10, 0x10)
+
 	_end = .;
 
 	STABS_DEBUG
-- 
2.17.1

