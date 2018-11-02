Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8F0C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D7A2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ud2XVeMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D7A2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeKBVnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:43:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33540 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBVnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:43:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id q5-v6so958239pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9BPTQwptUsw4iTw2FV8ABJx9albf6k52rbTAOCHG2Qg=;
        b=ud2XVeMgaK+1IzYMiZOT9eGEYtvSzQOGUR4FbSlw7sUZi5xQ7jHAyAk5qVvH1fP59I
         ZzM/WnSP4k7yFkXtV85WSQAbFJ7A6887I8QPT0EyUkzNOilMvx3K422uOSbS9LbJ0Gr3
         dxa477EDMtZzgZS2lraVxyKlnMelVXn4LLLJL0nzDAN4kIPBEjxnbyFO5V9P2bnJz6IW
         6D95xfIS20zpocyTf5YpXeD4PqspGsr1U/Flh/M7Rh7G+TDJeqcg1Xni2NXTJ/sT7pLY
         xKE6KbYRt2bvAi00U7g17DrCRNIzXAckSmTZLMmghQ4nniyxQ7a1G/czvoR6/kcetsF7
         r4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9BPTQwptUsw4iTw2FV8ABJx9albf6k52rbTAOCHG2Qg=;
        b=d02Wfx/UvjuHc3ZbAsg3GTaF7HuMpFYYeBmgJeM1mO59orZ1dSyKPnoAzlZK648lF+
         Ngz4E20yG+766HH7WMjR3xAq17JKtMwjcpDr2cBUyaYcDpll0+xdNRbtWMNBE8mZXacm
         ZCIpUXrPHicWeR4k/Mc06Sd4YB7mriDUPeo1nsBu4OyrT1qel0zJQrQ9l3Ue3pHugMQj
         gEGj2s+8UIKKJImrRFZJd6qOh1MtKMwWMKDdhREsCWlmoHCBJiRLD/SV+QvwySfQ4JeC
         DewIeFhLUfbqtjXwuLyrDjZ7T6xB4nalYHGKWERZg8eZUpt3PWXt3a7x0mX0vrNNLA5a
         zcEg==
X-Gm-Message-State: AGRZ1gKQWePwE7Hlq6j9lCT7dPhfnwGVlMEyJtdZvCqlfg1S+VpV8cVn
        h0cvLvF1v6HBMvSnxGVu2XpU5806NtY=
X-Google-Smtp-Source: AJdET5dYKTgVFelp0QSt6tvhrrlkugxtdcKJJvkIVaGj5JrnPh7LhEe+f0LcU/KCSa/Uoc1i7B/uzg==
X-Received: by 2002:a62:1c1:: with SMTP id 184-v6mr11757185pfb.242.1541162202092;
        Fri, 02 Nov 2018 05:36:42 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v1-v6sm18210248pfn.94.2018.11.02.05.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:36:41 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] arm64: kdump: fix small typo
Date:   Fri,  2 Nov 2018 08:36:19 -0400
Message-Id: <20181102123619.24199-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings the kernel doc in line with the function signature.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-add commit message
---
 arch/arm64/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index f46d57c31443..6b5037ed15b2 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -58,7 +58,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 /**
  * elfcorehdr_read - read from ELF core header
  * @buf: buffer where the data is placed
- * @csize: number of bytes to read
+ * @count: number of bytes to read
  * @ppos: address in the memory
  *
  * This function reads @count bytes from elf core header which exists
-- 
2.17.0

