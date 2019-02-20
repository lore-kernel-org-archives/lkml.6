Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B190DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7953120645
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="NntYocm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfBTBs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:48:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32867 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:48:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so11109895pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WTiAOWPo3As+BxCsENGKTc5FEsRax8ixzSAnD7O8mgw=;
        b=NntYocm2DH7AX9FMvoBYfOx33urb0j17TVzFvFRfjU/a7wq9DolIC4qQUHDpXuDJzX
         Wl+xnQZmkod1B4bdLgsp10ThHtZfjl8c7mXplxSr3Ey8VXyBcaeOr9Y+v0NQnCh/gMJa
         8uRWoCH4bS/JcvmG5BnjBI91UolGCNLolnP/ONM8IpBEa/2+CRDVjfzONAcOJQCwCrKB
         lHG2Z27HUSuK7TW79ykhlP9tGYWzKijRAcmIEIIlz0uGfO6Q91Dpeb/loSdcP3oSOgMO
         PXp6OgW6ezKmeUXJsKOf21CMzeaDnLiJoyIYoDc1WiDOQFvFDsoO2HwQ06imqJTUQ1yp
         GilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WTiAOWPo3As+BxCsENGKTc5FEsRax8ixzSAnD7O8mgw=;
        b=Ab/GCKI0ks0B6BQvUsYp3x/DmxeP9LPooHycYbja2aahUJT77vUJJm9zxXFAzlQW4B
         pYMovy5SQkofdTlIeWgwvOx8eK+CpNsn6KAhC1Em4rWw8Jg+0dQaa2OKhp60H6XRJXqv
         8qyusm/gYdRmSOxdSTejURs4wEdMnDJG9FSrK+ouIMJfJOCVgYNUo899C6Ul+PeIFsQV
         BoV3vxxILr7047f0Z1PIa+oOav2AqTcEwxKsxM6lOfB2NVPqEUtbgY9JUe5JmK4uE9Qu
         GFeWzxcPzp9Nduqna9ubrUX/3RtOgWo3DwUok9STEn3IcGnp1cGwtAE2gAB7w/dd0ha2
         EJWg==
X-Gm-Message-State: AHQUAuZtee548urCmLC3j3GxzYHylsYod4YYbLCkjId+FIIm5pgdWqrs
        DTZL2jamcWv7HCEIkPWFTu/f8A==
X-Google-Smtp-Source: AHgI3IZmF7RZk2M5d0sKlfzMKdOBWcLzS+YBpYHA4rdd/4kigj+easneqyTACBLHcUBO/UcVVyimKw==
X-Received: by 2002:a65:6549:: with SMTP id a9mr26043227pgw.21.1550627335063;
        Tue, 19 Feb 2019 17:48:55 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id g80sm6984540pfd.72.2019.02.19.17.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:48:54 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] x86/nmi: ratelimit unknown nmi logs
Date:   Tue, 19 Feb 2019 17:48:36 -0800
Message-Id: <20190220014836.20510-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting notified of unknown NMIs is obviously important, but getting
notified on every single one, especially on larger systems with slow
(serial) console causes more harm than good when it's a known noisy
non-relevant event.

So, let's ratelimit to avoid locking up the system.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/x86/kernel/nmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 18bc9b51ac9b9..44050cbfee136 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -292,14 +292,14 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 
 	__this_cpu_add(nmi_stats.unknown, 1);
 
-	pr_emerg("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
+	pr_emerg_ratelimited("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
 		 reason, smp_processor_id());
 
-	pr_emerg("Do you have a strange power saving mode enabled?\n");
+	pr_emerg_ratelimited("Do you have a strange power saving mode enabled?\n");
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
 		nmi_panic(regs, "NMI: Not continuing");
 
-	pr_emerg("Dazed and confused, but trying to continue\n");
+	pr_emerg_ratelimited("Dazed and confused, but trying to continue\n");
 }
 NOKPROBE_SYMBOL(unknown_nmi_error);
 
-- 
2.11.0

