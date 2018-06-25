Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29884C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D883E25931
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXHeYBO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D883E25931
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeFYMiO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:38:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38284 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932246AbeFYMiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:38:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so9812133wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wgIH8PdUl/HVoojcQE/mTChqZCGnvafYX8gGSbuBM1c=;
        b=pXHeYBO8jihvg9RFBR7fs+RlxrbbWjyRW8rybnWzMmLTVEDR/0xd7459E6nhg1jBCW
         vMtu5z7Sle7DOu8A2aKmlZaHw0bsEURnJn2TywcvM95fiPCnr9IL9hMGxxAsnHLMa0yV
         BZcg570bCmPn02LYURsyBsKrNAt9s4xRasj3qGBcL3P3FbbG+Xm+XVixD0X1Gk0cBRaR
         Ip9boZ77jlhBTewEdOGWTzXd34WiRAPHN+R5z4tvwxs9sP0gEDODCDICCp40mq6i07Ke
         6EQWr+AWTX/uy0Q9wMnjWssdqxqts1pjSXiLxO69Hh6lhLBdasmQqke+whAKTj+OCNGY
         781A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wgIH8PdUl/HVoojcQE/mTChqZCGnvafYX8gGSbuBM1c=;
        b=IrAbp8RzstlOcNZACN1OG3jmmq6l3o6n6MKFmdT9AkGQ024EEcgJaHkqt38FXXekdO
         wit/H3N+wvCN36Ny0r52Xw4wsP/mtf+HQx/JVu9uZOw2p0VkMLnz8GnSK9kgFYdAlcSk
         Sg1wUoIRNWtOzSYfV5GbgruX9rAoL4q9GpyJQfdsVUmgLHZvV+T0P4e9Gjcg1vBlXIiK
         gBg3IV0DlIH686JAMfpGOFY5/bRUye8KKub8TTmqPVrNgWrtA3lPs3NvCwPERflweJQQ
         8tuCTNHTJwPxRa1fveMJgJnwI87GgRHuJAkG5ocZHrS18KejQpG9TGxkIEvpr8ZaaN0V
         wysw==
X-Gm-Message-State: APt69E38xB0+U7PFmSw/cZoiMVPq59jRGkYRyTU0b8zYJMztSTJcXc6b
        7OM9O2N6Yiad3vYSkO0TrN4=
X-Google-Smtp-Source: AAOMgpdofQQm4SIs8unlNWP+baHU/vhLQ8B553BZyYK56V7OBMzQXKoCS04zAU5wMIAmpahhJW6Rjw==
X-Received: by 2002:a1c:afc3:: with SMTP id y186-v6mr848335wme.87.1529930291796;
        Mon, 25 Jun 2018 05:38:11 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([2a00:79e0:15:10:8971:4ae9:dd1c:10e])
        by smtp.gmail.com with ESMTPSA id b6-v6sm9752534wro.52.2018.06.25.05.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 05:38:10 -0700 (PDT)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, sergey.senozhatsky.work@gmail.com
Cc:     Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2] arch/x86: get rid of KERN_CONT in show_fault_oops()
Date:   Mon, 25 Jun 2018 14:38:08 +0200
Message-Id: <20180625123808.227417-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

KERN_CONT leads to split lines in kernel output
and complicates useful changes to printk like
printing context before each line.

Only acceptable use of continuations is basically
boot-time testing.

Get rid of it.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

---

Changes since v1:
 - use pr_alert() instead of printk(KERN_ALERT)
---
 arch/x86/mm/fault.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9a84a0d08727..b9ceeaadde48 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -671,13 +671,9 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 			printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
 	}
 
-	printk(KERN_ALERT "BUG: unable to handle kernel ");
-	if (address < PAGE_SIZE)
-		printk(KERN_CONT "NULL pointer dereference");
-	else
-		printk(KERN_CONT "paging request");
-
-	printk(KERN_CONT " at %px\n", (void *) address);
+	pr_alert("BUG: unable to handle kernel %s at %px\n",
+		(address < PAGE_SIZE ? "NULL pointer dereference" :
+		"paging request"), (void *) address);
 
 	dump_pagetable(address);
 }
-- 
2.18.0.rc2.346.g013aa6912e-goog

