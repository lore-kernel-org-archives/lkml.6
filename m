Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40594C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E599B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuRAGmen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E599B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeFTMzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:55:46 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41049 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFTMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:55:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so3181744wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=14Nx3j97QC2nfoPtH0LPLyC3KhZqKx4QanebjVu6n1A=;
        b=NuRAGmenxrKWJ6HDkhtBejAewV3uDR6+NkJiZ+W66od8wrZyJ5aY7O4rwquLa9Hre6
         sJiLf5ndMzfbfD5YONhKcstZfqcPDaFUVHB+onh6BvTmEp8EinSgAUaG50BKFSY/r6Od
         0nNV2EfTYG9mxGi7/9GWZOT+Vx/slT5ysAiw/lw5BWxI8X43GmHFdbcx+i2ZyjPxNRgw
         PKIRoY6J4FZ1UHajmgTInNpvoZaajMiy9KGoZeRvx+DoH3Ch0GbtFiWQqNce707/aYHw
         +Y/7iM4CPed9ZELbz4C7QIpVOzk8/AgSqzp0RvWO38iipbjYpHxEDtEOu+z4I5Mg3L2G
         wV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=14Nx3j97QC2nfoPtH0LPLyC3KhZqKx4QanebjVu6n1A=;
        b=E0EjuMxx1FODhxTzx1FVLL1jhtIRtc46AoxgqbQEmgK5tjnoxN3tEI0OgIbCZ1ih+3
         cTCdpnPNTdWwITZNB7y7a8UA80Qr9bnJ7HYZvsj5SB3IAqPI+ft/nrOZLEWwuBc3d8cC
         eUffi/StVB7zR0BEmh8mR9Np+/rl8wX8uO06hl73R+aMq9VvfDUkdVE05eS9u2Sq0to/
         k0yTJKuE010MfLpq+nquAgUpS5v/VQnlJdpGpJ1ORKgf7JpI6igwbAmqdr3Pn2xQ4jtZ
         GjnjqLPccq3WzEbVVYbbdcyLP0zRbZoT8pXp7qkbECuP2Za+MzVBw6SfJWUapnXWrVt4
         VoFQ==
X-Gm-Message-State: APt69E3ZYcgRUOhFDcdWnBb+7hG+M6PFigE2Igj4CjQBuBgx94sti9Pf
        2NIr+CJCCGrVxqqroyeemWs=
X-Google-Smtp-Source: ADUXVKLxVrq2ZE1JhJ9IuuX3dkaHrG+1Tj3027WK/Aur0LraQs+XnzHh/5Kfmj6829+oHWrgCfW6Rw==
X-Received: by 2002:adf:dd8c:: with SMTP id x12-v6mr19437951wrl.212.1529499343576;
        Wed, 20 Jun 2018 05:55:43 -0700 (PDT)
Received: from dvyukov-z840.muc.corp.google.com ([2a00:79e0:15:10:8971:4ae9:dd1c:10e])
        by smtp.gmail.com with ESMTPSA id f24-v6sm1943833wmc.0.2018.06.20.05.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 05:55:42 -0700 (PDT)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, sergey.senozhatsky.work@gmail.com
Cc:     Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] arch/x86: get rid of KERN_CONT in show_fault_oops()
Date:   Wed, 20 Jun 2018 14:55:40 +0200
Message-Id: <20180620125540.228766-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
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
 arch/x86/mm/fault.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9a84a0d08727..2a2def636545 100644
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
+	printk(KERN_ALERT "BUG: unable to handle kernel %s at %px\n",
+		(address < PAGE_SIZE ? "NULL pointer dereference" :
+		"paging request"), (void *) address);
 
 	dump_pagetable(address);
 }
-- 
2.18.0.rc1.244.gcf134e6275-goog

