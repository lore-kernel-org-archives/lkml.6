Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4A4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E3A2404A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="me5DDL8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E3A2404A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeGDVME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:12:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41975 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeGDVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:12:03 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so243502ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=pW6CCI/YfnJcDC6O6LneLRSkur+rW1ZZUjdb3pA0dI8=;
        b=me5DDL8dnAuhVZ52BEb46MxWtcJxivLrbEpGDy7VO0ziMa8BscZNx9SeVUrFbxiDgq
         i1MfHmn5hInExV5VPE8RkoUSMYeQnHYnEEsLIwpW9H4TITB2Kult0rjhb1tv3kdUsHB9
         t2dxoqMLMwka3EAuEzsBl6FbbxfLLxyX5kym/K06+VO2R52SUQoU2sb6Yu9O55LIia59
         eVMUeKo7gRG3EfHD1Gx4CokVvX8rmTJT9ut1FouLN1tmbh7rWl03CHoja8oFwlvYuCxg
         N/MWnZVqCs33lGTTdcGRzx6ke5pVL2cURuNSWeM0unaky1svVnsIfjVd2NozVpiymjV/
         185A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=pW6CCI/YfnJcDC6O6LneLRSkur+rW1ZZUjdb3pA0dI8=;
        b=CZq8pRRetl/3oCbOUjG4+8YQJyjvL+uBGZqpXUUnT7rl2EzE7/ItY+ayuKweEqLNZK
         h+J6Em+DTanNHedipQcfhAQsrnqHth5VYKq0JttCvexyxN4MiA6pIbAewhl4pYM2JmjM
         YP0h9xsdBHhXD2SZ6eWanlxu3T2fAuE2RAj8bFu1U7ardhcFNA8W3ijWoW4opF9g/ITM
         9R6cuLU/oPm1cAp+KjMhlpMSvkl1oas3xDAV6H8M4F7vqp3HcIJRtGe24pZvAH37t6eM
         NZWIC80ZqShCuxjyK3dZjkA9Q0imolYpDjkqDMHdXyNhoWwVVrLhoy48wRMH/zVPCgZX
         equg==
X-Gm-Message-State: APt69E01UqhsYun37hHl7bZoU3li5da2MAGahCU8wElSM12D1ztjxs/J
        PxWVD9YQzAaf3SVh7A0rek1YjQ==
X-Google-Smtp-Source: AAOMgpeCSM/0Ynq9yt7zAp9jayAkwJhhWicwE0imsA6w47mdrhPodb6SoJuvYFWISevcnilsoO0S3w==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4-v6mr3480169plt.19.1530738723119;
        Wed, 04 Jul 2018 14:12:03 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id g11-v6sm6067537pfh.63.2018.07.04.14.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 14:12:02 -0700 (PDT)
Subject: [PATCH] RISC-V: Use KBUILD_CFLAGS instead of KCFLAGS when building the vDSO
Date:   Wed,  4 Jul 2018 14:10:56 -0700
Message-Id: <20180704211056.1885-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Andrew Waterman <andrew@sifive.com>, aurelien@aurel32.net,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     zongbox@gmail.com, linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you use a 64-bit compiler to build a 32-bit kernel then you'll get an
error when building the vDSO due to a library mismatch.  The happens
because the relevant "-march" argument isn't supplied to the GCC run
that generates one of the vDSO intermediate files.

I'm not actually sure what the right thing to do here is as I'm not
particularly familiar with the kernel build system.  I poked the
documentation and it appears that KCFLAGS is the correct thing to do
(it's suggested that should be used when building modules), but we set
KBUILD_CFLAGS in arch/riscv/Makefile.

This does at least fix the build error.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f6561b783b61..eed1c137f618 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -52,8 +52,8 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 # Add -lgcc so rv32 gets static muldi3 and lshrdi3 definitions.
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdsold = VDSOLD  $@
-      cmd_vdsold = $(CC) $(KCFLAGS) $(call cc-option, -no-pie) -nostdlib $(SYSCFLAGS_$(@F)) \
-                           -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp -lgcc && \
+      cmd_vdsold = $(CC) $(KBUILD_CFLAGS) $(call cc-option, -no-pie) -nostdlib -nostartfiles $(SYSCFLAGS_$(@F)) \
+                           -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp && \
                    $(CROSS_COMPILE)objcopy \
                            $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@
 
-- 
2.16.4

